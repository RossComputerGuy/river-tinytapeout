module HarborPsramController (
input logic clk,
input logic reset,
input logic [3:0] spi_io_in,
input logic bus_CYC,
input logic bus_STB,
input logic bus_WE,
input logic [31:0] bus_ADR,
input logic [31:0] bus_DAT_MOSI,
input logic [3:0] bus_SEL,
output logic spi_clk,
output logic spi_cs_n,
output logic [3:0] spi_io_out,
output logic [3:0] spi_io_oe,
output logic bus_ACK,
output logic [31:0] bus_DAT_MISO
);
logic bus_ack_out;
logic bus_ack_r;
logic [31:0] bus_dat_out;
logic [31:0] bus_miso_r;
logic [1:0] byte_offset;
logic ce;
logic is_quad;
logic psram_read;
logic psram_valid;
logic [20:0] psram_word_addr;
logic psram_write;
logic sclk;
logic [3:0] sio_oe;
logic [3:0] sio_out;
logic [31:0] spi_buf;
logic [2:0] state;
logic [31:0] wr_buffer;
logic [5:0] wr_cycles;
logic [5:0] xfer_cycles;
assign spi_clk = sclk;
assign spi_cs_n = ce;
assign spi_io_out = sio_out;
assign spi_io_oe = sio_oe;
assign bus_ack_out = bus_ack_r;
assign bus_ACK = bus_ack_out;
assign bus_dat_out = bus_miso_r;
assign bus_DAT_MISO = bus_dat_out;
assign psram_write = bus_WE;
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      state <= 3'h0;
      ce <= 1'h1;
      sclk <= 1'h0;
      sio_oe <= 4'h0;
      sio_out <= 4'h0;
      spi_buf <= 32'h0;
      is_quad <= 1'h0;
      xfer_cycles <= 6'h0;
      bus_ack_r <= 1'h0;
      bus_miso_r <= 32'h0;
  end   else begin
      if((xfer_cycles != 6'h0)) begin
          sio_out <= (is_quad ? (spi_buf[31:28]) : ({
3'h0, /* 3:1 */
(spi_buf[31])  /*   0 */
}));
          if(sclk) begin
              sclk <= 1'h0;
          end           else begin
              sclk <= 1'h1;
              spi_buf <= (is_quad ? ({
(spi_buf[27:0]), /* 31:4 */
spi_io_in  /*  3:0 */
}) : ({
(spi_buf[30:0]), /* 31:1 */
(spi_io_in[1])  /*    0 */
}));
              xfer_cycles <= (is_quad ? (xfer_cycles - 6'h4) : (xfer_cycles - 6'h1));
          end 

      end       else begin
          case (state) 
              3'h0 : begin
                  sio_oe <= 4'h1;
                  is_quad <= 1'h0;
                  if((psram_valid & (~bus_ack_r))) begin
                      state <= 3'h1;
                      xfer_cycles <= 6'h0;
                  end                   else begin
                      if(((~psram_valid) & bus_ack_r)) begin
                          bus_ack_r <= 1'h0;
                          ce <= 1'h1;
                      end                       else begin
                          ce <= 1'h1;
                      end 

                  end 

              end
              3'h1 : begin
                  ce <= 1'h0;
                  state <= 3'h2;
              end
              3'h2 : begin
                  spi_buf <= ({
(1'h1 ? (psram_write ? 8'h38 : 8'heb) : (psram_write ? 8'h2 : 8'h3)), /* 31:24 */
24'h0  /* 23: 0 */
});
                  xfer_cycles <= 6'h8;
                  state <= 3'h3;
              end
              3'h3 : begin
                  spi_buf <= ({
({
1'h0, /*   23 */
psram_word_addr, /* 22:2 */
(psram_write ? byte_offset : 2'h0)  /*  1:0 */
}), /* 31:8 */
8'h0  /*  7:0 */
});
                  sio_oe <= 4'hf;
                  xfer_cycles <= 6'h18;
                  is_quad <= 1'h1;
                  state <= ((1'h1 & psram_read) ? 3'h4 : 3'h5);
              end
              3'h4 : begin
                  sio_oe <= 4'h0;
                  xfer_cycles <= 6'h6;
                  is_quad <= 1'h0;
                  state <= 3'h5;
              end
              3'h5 : begin
                  is_quad <= 1'h1;
                  if(psram_write) begin
                      sio_oe <= 4'hf;
                      spi_buf <= wr_buffer;
                  end                   else begin
                      sio_oe <= 4'h0;
                  end 

                  xfer_cycles <= (psram_write ? wr_cycles : 6'h20);
                  state <= 3'h6;
              end
              3'h6 : begin
                  bus_miso_r <= spi_buf;
                  bus_ack_r <= 1'h1;
                  state <= 3'h0;
              end
              default : begin
                  state <= 3'h0;
              end
          endcase

      end 

  end 

end

assign psram_valid = bus_CYC & bus_STB;  // and__1
assign psram_read = ~psram_write;  // not__1
assign psram_word_addr = bus_ADR[22:2];  // bussubset_4
//  combinational
always_comb begin
  byte_offset = 2'h0;
  wr_cycles = 6'h20;
  wr_buffer = bus_DAT_MOSI;
  case (bus_SEL) 
      4'h1 : begin
          byte_offset = 2'h3;
          wr_buffer = ({
(bus_DAT_MOSI[7:0]), /* 31:24 */
24'h0  /* 23: 0 */
});
          wr_cycles = 6'h8;
      end
      4'h2 : begin
          byte_offset = 2'h2;
          wr_buffer = ({
(bus_DAT_MOSI[15:8]), /* 31:24 */
24'h0  /* 23: 0 */
});
          wr_cycles = 6'h8;
      end
      4'h4 : begin
          byte_offset = 2'h1;
          wr_buffer = ({
(bus_DAT_MOSI[23:16]), /* 31:24 */
24'h0  /* 23: 0 */
});
          wr_cycles = 6'h8;
      end
      4'h8 : begin
          byte_offset = 2'h0;
          wr_buffer = ({
(bus_DAT_MOSI[31:24]), /* 31:24 */
24'h0  /* 23: 0 */
});
          wr_cycles = 6'h8;
      end
      4'h3 : begin
          byte_offset = 2'h2;
          wr_buffer = ({
(bus_DAT_MOSI[15:0]), /* 31:16 */
16'h0  /* 15: 0 */
});
          wr_cycles = 6'h10;
      end
      4'hc : begin
          byte_offset = 2'h0;
          wr_buffer = ({
(bus_DAT_MOSI[31:16]), /* 31:16 */
16'h0  /* 15: 0 */
});
          wr_cycles = 6'h10;
      end
      4'hf : begin
          byte_offset = 2'h0;
          wr_buffer = bus_DAT_MOSI;
          wr_cycles = 6'h20;
      end
      default : begin
          byte_offset = 2'h0;
          wr_buffer = bus_DAT_MOSI;
          wr_cycles = 6'h20;
      end
  endcase

end

endmodule : HarborPsramController