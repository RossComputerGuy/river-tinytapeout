// QSPI PSRAM controller (APS6404 / LY68L6400 compatible).
//
// Wishbone slave that serves as the SoC's main RAM (slave_0), talking to an
// external PSRAM on the Tiny Tapeout QSPI Pmod. Defaults to QUAD mode:
//     0xEB  FAST READ QUAD : cmd(1-bit) + addr(quad) + 6 dummy + data(quad)
//     0x38  QUAD WRITE     : cmd(1-bit) + addr(quad) + data(quad)
// Set QUAD_MODE=0 for plain single-SPI (0x03 read / 0x02 write, no dummy).
//
// The command byte is always shifted out single-bit on IO0; address and data
// use all four IO lines in quad mode. SCK runs at clk/2.
//
// FSM and byte/endianness handling are ported from Hirosh Dabui's KianV
// `qqspi.v` (itself derived from Lone Dynamics' qqspi), reworked for this
// SoC's Wishbone interface and split IO (out/oe/in) instead of inout.

`default_nettype none

module HarborPsramController #(
    parameter [0:0] QUAD_MODE = 1'b1
) (
    input  wire        clk,
    input  wire        reset,         // active-high synchronous reset
    // Wishbone slave
    input  wire        bus_CYC,
    input  wire        bus_STB,
    input  wire        bus_WE,
    input  wire [31:0] bus_ADR,
    input  wire [31:0] bus_DAT_MOSI,
    input  wire [3:0]  bus_SEL,
    output reg         bus_ACK,
    output reg  [31:0] bus_DAT_MISO,
    // SPI bus (IO0=MOSI/SD0 .. IO3=SD3)
    output reg         spi_clk,
    output wire        spi_cs_n,
    output reg  [3:0]  spi_io_out,
    output reg  [3:0]  spi_io_oe,     // per-line output enable
    input  wire [3:0]  spi_io_in
);

  localparam [7:0] CMD_QUAD_WRITE     = 8'h38;
  localparam [7:0] CMD_FAST_READ_QUAD = 8'hEB;
  localparam [7:0] CMD_WRITE          = 8'h02;
  localparam [7:0] CMD_READ           = 8'h03;

  wire        valid     = bus_CYC & bus_STB;
  wire        write     = bus_WE;
  wire        read      = ~write;
  wire [20:0] word_addr = bus_ADR[22:2];   // word index into the 8 MB bank

  // ---- write-data alignment (selected bytes -> MSB, byte offset, cycle count) ----
  reg  [1:0]  byte_offset;
  reg  [5:0]  wr_cycles;
  reg  [31:0] wr_buffer;
  always @* begin
    wr_buffer   = bus_DAT_MOSI;
    byte_offset = 2'd0;
    wr_cycles   = 6'd32;
    case (bus_SEL)
      4'b0001: begin byte_offset = 2'd3; wr_buffer[31:24] = bus_DAT_MOSI[7:0];   wr_cycles = 6'd8;  end
      4'b0010: begin byte_offset = 2'd2; wr_buffer[31:24] = bus_DAT_MOSI[15:8];  wr_cycles = 6'd8;  end
      4'b0100: begin byte_offset = 2'd1; wr_buffer[31:24] = bus_DAT_MOSI[23:16]; wr_cycles = 6'd8;  end
      4'b1000: begin byte_offset = 2'd0; wr_buffer[31:24] = bus_DAT_MOSI[31:24]; wr_cycles = 6'd8;  end
      4'b0011: begin byte_offset = 2'd2; wr_buffer[31:16] = bus_DAT_MOSI[15:0];  wr_cycles = 6'd16; end
      4'b1100: begin byte_offset = 2'd0; wr_buffer[31:16] = bus_DAT_MOSI[31:16]; wr_cycles = 6'd16; end
      4'b1111: begin byte_offset = 2'd0; wr_buffer       = bus_DAT_MOSI;         wr_cycles = 6'd32; end
      default: begin byte_offset = 2'd0; wr_buffer       = bus_DAT_MOSI;         wr_cycles = 6'd32; end
    endcase
  end

  localparam [2:0] S_IDLE = 3'd0, S_SELECT = 3'd1, S_CMD = 3'd2, S_ADDR = 3'd3,
                   S_WAIT = 3'd4, S_XFER = 3'd5, S_DONE = 3'd6;

  reg  [2:0]  state, next_state;
  reg  [31:0] spi_buf, spi_buf_next;
  reg  [5:0]  xfer_cycles, xfer_cycles_next;
  reg         is_quad, is_quad_next;
  reg         ce, ce_next;
  reg         sclk_next;
  reg  [3:0]  sio_oe_next, sio_out_next;
  reg  [31:0] rdata_next;
  reg         ready_next;

  assign spi_cs_n = ce;   // active-low chip select (ce=1 idle, 0 selected)

  always @(posedge clk) begin
    if (reset) begin
      state        <= S_IDLE;
      ce           <= 1'b1;
      spi_clk      <= 1'b0;
      spi_io_oe    <= 4'b0000;
      spi_io_out   <= 4'b0000;
      spi_buf      <= 32'b0;
      is_quad      <= 1'b0;
      xfer_cycles  <= 6'b0;
      bus_ACK      <= 1'b0;
      bus_DAT_MISO <= 32'b0;
    end else begin
      state        <= next_state;
      ce           <= ce_next;
      spi_clk      <= sclk_next;
      spi_io_oe    <= sio_oe_next;
      spi_io_out   <= sio_out_next;
      spi_buf      <= spi_buf_next;
      is_quad      <= is_quad_next;
      xfer_cycles  <= xfer_cycles_next;
      bus_ACK      <= ready_next;
      bus_DAT_MISO <= rdata_next;
    end
  end

  always @* begin
    next_state       = state;
    ce_next          = ce;
    sclk_next        = spi_clk;
    sio_oe_next      = spi_io_oe;
    sio_out_next     = spi_io_out;
    spi_buf_next     = spi_buf;
    is_quad_next     = is_quad;
    xfer_cycles_next = xfer_cycles;
    ready_next       = bus_ACK;
    rdata_next       = bus_DAT_MISO;

    if (|xfer_cycles) begin
      // Bit engine: MSB-first, 1 bit/cycle (single) or 4 bits/cycle (quad).
      sio_out_next = is_quad ? spi_buf[31:28] : {3'b0, spi_buf[31]};
      if (spi_clk) begin
        sclk_next = 1'b0;                 // falling edge
      end else begin
        sclk_next        = 1'b1;          // rising edge: sample + advance
        spi_buf_next     = is_quad ? {spi_buf[27:0], spi_io_in[3:0]}
                                   : {spi_buf[30:0], spi_io_in[1]};
        xfer_cycles_next = is_quad ? xfer_cycles - 6'd4 : xfer_cycles - 6'd1;
      end
    end else begin
      case (state)
        S_IDLE: begin
          sio_oe_next  = 4'b0001;         // only IO0 driven for the command
          is_quad_next = 1'b0;
          if (valid && !bus_ACK) begin
            next_state       = S_SELECT;
            xfer_cycles_next = 6'd0;
          end else if (!valid && bus_ACK) begin
            ready_next = 1'b0;
            ce_next    = 1'b1;
          end else begin
            ce_next = 1'b1;
          end
        end
        S_SELECT: begin
          ce_next    = 1'b0;              // assert CS
          next_state = S_CMD;
        end
        S_CMD: begin
          if (QUAD_MODE)
            spi_buf_next[31:24] = write ? CMD_QUAD_WRITE : CMD_FAST_READ_QUAD;
          else
            spi_buf_next[31:24] = write ? CMD_WRITE : CMD_READ;
          xfer_cycles_next = 6'd8;        // command: 8 single-bit cycles
          next_state       = S_ADDR;
        end
        S_ADDR: begin
          spi_buf_next[31:8] = {1'b0, word_addr, write ? byte_offset : 2'b00};
          sio_oe_next        = QUAD_MODE ? 4'b1111 : 4'b0001;
          xfer_cycles_next   = 6'd24;     // 24-bit address
          is_quad_next       = QUAD_MODE;
          next_state         = (QUAD_MODE && read) ? S_WAIT : S_XFER;
        end
        S_WAIT: begin
          sio_oe_next      = 4'b0000;     // dummy cycles for quad fast read
          xfer_cycles_next = 6'd6;
          is_quad_next     = 1'b0;
          next_state       = S_XFER;
        end
        S_XFER: begin
          is_quad_next = QUAD_MODE;
          if (write) begin
            sio_oe_next  = QUAD_MODE ? 4'b1111 : 4'b0001;
            spi_buf_next = wr_buffer;
          end else begin
            sio_oe_next  = QUAD_MODE ? 4'b0000 : 4'b0001;
          end
          xfer_cycles_next = write ? wr_cycles : 6'd32;
          next_state       = S_DONE;
        end
        S_DONE: begin
          rdata_next = spi_buf;           // read data (self-consistent byte order)
          ready_next = 1'b1;
          next_state = S_IDLE;
        end
        default: next_state = S_IDLE;
      endcase
    end
  end

endmodule

`default_nettype wire
