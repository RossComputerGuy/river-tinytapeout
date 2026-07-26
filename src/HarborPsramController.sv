// SPI PSRAM controller (single-SPI, APS6404 / LY68L6400 compatible).
//
// Wishbone slave that replaces the on-chip SRAM as the SoC's main RAM
// (slave_0). Talks to an external PSRAM over the shared QSPI bus using the
// basic SPI command set:
//     0x03  READ   : cmd + 24-bit address + N data bytes (MISO)
//     0x02  WRITE  : cmd + 24-bit address + N data bytes (MOSI)
// SCK runs at clk/2. IO2 (/WP) and IO3 (/HOLD) are held high; IO0 is MOSI and
// IO1 is MISO, matching the Tiny Tapeout QSPI Pmod wiring.
//
// NOTE: byte-enable (bus_SEL) writes assume the selected lanes are contiguous,
// which is always true for RISC-V byte/half/word stores.

`default_nettype none

module HarborPsramController (
    input  wire        clk,
    input  wire        reset,        // active-high synchronous reset
    // Wishbone slave
    input  wire        bus_CYC,
    input  wire        bus_STB,
    input  wire        bus_WE,
    input  wire [31:0] bus_ADR,
    input  wire [31:0] bus_DAT_MOSI,
    input  wire [3:0]  bus_SEL,
    output wire        bus_ACK,
    output wire [31:0] bus_DAT_MISO,
    // Shared SPI bus (single-SPI: io[0]=MOSI, io[1]=MISO; io[3:2] held high)
    output wire        spi_clk,
    output wire        spi_cs_n,
    output wire [3:0]  spi_io_out,
    output wire        spi_io_oe,    // 1 = drive io lines (cmd/addr/write phases)
    input  wire [3:0]  spi_io_in
);

  localparam [1:0] S_IDLE = 2'd0, S_XFER = 2'd1, S_DONE = 2'd2;

  reg  [1:0]  state;
  reg         sck;
  reg         cs_n;
  reg         ack;
  reg  [63:0] tx_shift;     // {cmd, addr[23:0], write-data}, shifted MSB-first
  reg  [31:0] rx_shift;     // read data, MSB-first
  reg  [6:0]  bit_idx;      // bits transferred so far (rising edges)
  reg  [6:0]  out_bits;     // number of bits we drive (cmd + addr [+ wdata])
  reg  [6:0]  total_bits;   // total bits in the frame

  // ---- byte-enable decode for writes (contiguous lanes) ----
  reg  [1:0]  start_lane;
  reg  [2:0]  num_bytes;
  reg  [31:0] wdata_packed; // selected bytes, MSB-first, lowest lane first
  integer     k;
  always @* begin
    if      (bus_SEL[0]) start_lane = 2'd0;
    else if (bus_SEL[1]) start_lane = 2'd1;
    else if (bus_SEL[2]) start_lane = 2'd2;
    else                 start_lane = 2'd3;
    num_bytes = {2'b0, bus_SEL[0]} + {2'b0, bus_SEL[1]}
              + {2'b0, bus_SEL[2]} + {2'b0, bus_SEL[3]};
    wdata_packed = 32'h0;
    for (k = 0; k < 4; k = k + 1)
      if (k[2:0] < num_bytes)
        wdata_packed[(3-k)*8 +: 8] = bus_DAT_MOSI[(start_lane + k[1:0])*8 +: 8];
  end

  wire [23:0] word_addr = {bus_ADR[23:2], 2'b00};
  wire [23:0] byte_addr = word_addr + {22'h0, start_lane};
  wire [6:0]  wr_bits   = 7'd32 + {1'b0, num_bytes, 3'b000}; // 32 + N*8
  wire        start     = (state == S_IDLE) & bus_CYC & bus_STB & ~ack;

  always @(posedge clk) begin
    if (reset) begin
      state   <= S_IDLE;
      sck     <= 1'b0;
      cs_n    <= 1'b1;
      ack     <= 1'b0;
      bit_idx <= 7'd0;
    end else begin
      ack <= 1'b0;
      case (state)
        S_IDLE: begin
          sck  <= 1'b0;
          cs_n <= 1'b1;
          if (start) begin
            cs_n    <= 1'b0;
            bit_idx <= 7'd0;
            if (bus_WE) begin
              tx_shift   <= {8'h02, byte_addr, wdata_packed};
              out_bits   <= wr_bits;
              total_bits <= wr_bits;
            end else begin
              tx_shift   <= {8'h03, word_addr, 32'h0};
              out_bits   <= 7'd32;
              total_bits <= 7'd64;
            end
            state <= S_XFER;
          end
        end
        S_XFER: begin
          sck <= ~sck;
          if (~sck) begin
            // rising edge: sample MISO during the read-data phase
            if (bit_idx >= out_bits)
              rx_shift <= {rx_shift[30:0], spi_io_in[1]};
          end else begin
            // falling edge: advance one bit
            tx_shift <= {tx_shift[62:0], 1'b0};
            bit_idx  <= bit_idx + 7'd1;
            if (bit_idx + 7'd1 == total_bits) begin
              sck   <= 1'b0;
              cs_n  <= 1'b1;
              state <= S_DONE;
            end
          end
        end
        S_DONE: begin
          ack   <= 1'b1;   // single-cycle Wishbone ACK, data valid in rx_shift
          state <= S_IDLE;
        end
        default: state <= S_IDLE;
      endcase
    end
  end

  assign spi_clk      = sck;
  assign spi_cs_n     = cs_n;
  assign spi_io_oe    = (state == S_XFER) & (bit_idx < out_bits);
  assign spi_io_out   = {1'b1, 1'b1, 1'b0, tx_shift[63]};
  assign bus_ACK      = ack;
  // received bytes are big-endian on the wire; swap to little-endian word
  assign bus_DAT_MISO = {rx_shift[7:0], rx_shift[15:8], rx_shift[23:16], rx_shift[31:24]};

endmodule

`default_nettype wire
