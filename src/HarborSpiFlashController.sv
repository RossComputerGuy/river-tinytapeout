module HarborSpiFlashController (
input logic clk,
input logic reset,
input logic [3:0] spi_io_in,
input logic bus_CYC,
input logic bus_STB,
input logic bus_WE,
input logic [31:0] bus_ADR,
input logic [31:0] bus_DAT_MOSI,
input logic [3:0] bus_SEL,
input logic wr_req,
input logic wr_op,
input logic [23:0] wr_addr,
input logic [8:0] wr_len,
input logic [7:0] wr_data,
output logic spi_clk,
output logic spi_cs_n,
output logic [3:0] spi_io_out,
output logic [3:0] spi_io_oe,
output logic bus_ACK,
output logic [31:0] bus_DAT_MISO,
output logic [8:0] wr_data_index,
output logic wr_busy,
output logic wr_done,
output logic wr_err
);
logic _bit_count_add_const_1_carry;
logic _bit_count_add_const_1_carry_0;
logic _bit_count_add_const_1_carry_1;
logic _bit_count_add_const_1_carry_2;
logic [9:0] _in0__swizzled_add__swizzled;
logic [8:0] _in0__wr_byte_idx_add_const_1;
logic [7:0] _in103__wr_bit_count_add_const_1;
logic [7:0] _in111__wr_bit_count_add_const_1;
logic [7:0] _in36__bit_count_add_const_1;
logic [7:0] _in42__wr_bit_count_add_const_1;
logic [7:0] _in44__bit_count_add_const_1;
logic [7:0] _in52__bit_count_add_const_1;
logic [7:0] _in55__wr_bit_count_add_const_1;
logic [7:0] _in60__bit_count_add_const_1;
logic [7:0] _in63__wr_bit_count_add_const_1;
logic [7:0] _in68__word_idx_add_const_1;
logic [7:0] _in76__wr_bit_count_add_const_1;
logic [8:0] _in79__wr_byte_idx_add_const_1;
logic [20:0] _in98__wr_poll_count_add_const_1;
logic [31:0] _shiftAmount_const_1;
logic [31:0] _shiftAmount_const_1_0;
logic [31:0] _shiftAmount_const_1_1;
logic [31:0] _shiftAmount_const_1_2;
logic [31:0] _shiftAmount_const_1_3;
logic [31:0] _shiftAmount_const_1_4;
logic [31:0] _shiftAmount_const_1_5;
logic [7:0] _shiftAmount_const_1_6;
logic [31:0] _shiftAmount_const_24;
logic [31:0] _shiftAmount_const_4;
logic [31:0] _shiftAmount_const_8;
logic [31:0] _shiftAmount_const_8_0;
logic _swizzled_add__swizzled_carry;
logic _word_idx_add_const_1_carry;
logic _wr_bit_count_add_const_1_carry;
logic _wr_bit_count_add_const_1_carry_0;
logic _wr_bit_count_add_const_1_carry_1;
logic _wr_bit_count_add_const_1_carry_2;
logic _wr_bit_count_add_const_1_carry_3;
logic _wr_bit_count_add_const_1_carry_4;
logic _wr_byte_idx_add_const_1_carry;
logic _wr_byte_idx_add_const_1_carry_0;
logic _wr_poll_count_add_const_1_carry;
logic [31:0] addr32;
logic [7:0] bit_count;
logic bus_ack_out;
logic [31:0] bus_dat_out;
logic [31:0] dat_out_internal;
logic io_dir;
logic [31:0] line_buf_0;
logic line_hit;
logic [31:0] line_tag;
logic line_valid;
logic [31:0] next_shift;
logic rd_spi_clk;
logic rd_spi_cs_n;
logic rd_stb_gated;
logic [31:0] req_line_base;
logic [31:0] shift_reg;
logic spi_clk_pin;
logic spi_cs_n_pin;
logic spi_drive_out;
logic [3:0] spi_io_in_0;
logic spi_mosi_bit;
logic [2:0] spi_state;
logic [7:0] word_idx;
logic [23:0] wr_addr_l;
logic [7:0] wr_bit_count;
logic [8:0] wr_byte_idx;
logic wr_done_reg;
logic wr_drive_out;
logic wr_err_reg;
logic [8:0] wr_len_l;
logic wr_op_l;
logic [20:0] wr_poll_count;
logic [31:0] wr_shift;
logic wr_spi_clk;
logic wr_spi_cs_n;
logic wr_stat_bit;
logic [3:0] wr_state;
logic [7:0] wr_status;
assign spi_clk = spi_clk_pin;
assign spi_cs_n = spi_cs_n_pin;
assign wr_data_index = wr_byte_idx;
assign wr_done = wr_done_reg;
assign wr_err = wr_err_reg;
assign bus_ACK = bus_ack_out;
assign bus_dat_out = dat_out_internal;
assign bus_DAT_MISO = bus_dat_out;
assign addr32 = bus_ADR;
assign spi_io_in_0 = spi_io_in;
assign _shiftAmount_const_1 = 32'h1;
assign _shiftAmount_const_1_0 = 32'h1;
assign _shiftAmount_const_1_1 = 32'h1;
assign _shiftAmount_const_1_2 = 32'h1;
assign _shiftAmount_const_1_3 = 32'h1;
assign _shiftAmount_const_4 = 32'h4;
assign _shiftAmount_const_8 = 32'h8;
assign _shiftAmount_const_1_4 = 32'h1;
assign _shiftAmount_const_1_5 = 32'h1;
assign _shiftAmount_const_8_0 = 32'h8;
assign _shiftAmount_const_1_6 = 8'h1;
assign _shiftAmount_const_24 = 32'h18;
assign spi_clk_pin = wr_busy ? wr_spi_clk : rd_spi_clk;  // mux
assign wr_busy = ~(wr_state == 4'h0);  // not_
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      wr_state <= 4'h0;
      wr_shift <= 32'h0;
      wr_bit_count <= 8'h0;
      wr_byte_idx <= 9'h0;
      wr_spi_clk <= 1'h0;
      wr_spi_cs_n <= 1'h1;
      wr_drive_out <= 1'h0;
      wr_done_reg <= 1'h0;
      wr_err_reg <= 1'h0;
      wr_op_l <= 1'h0;
      wr_addr_l <= 24'h0;
      wr_len_l <= 9'h0;
      wr_status <= 8'h0;
      wr_poll_count <= 21'h0;
  end   else begin
      wr_done_reg <= 1'h0;
      case (wr_state) 
          4'h0 : begin
              wr_spi_clk <= 1'h0;
              wr_spi_cs_n <= 1'h1;
              if((wr_req & (spi_state == 3'h0))) begin
                  wr_op_l <= wr_op;
                  wr_addr_l <= wr_addr;
                  wr_len_l <= wr_len;
                  wr_byte_idx <= 9'h0;
                  wr_err_reg <= 1'h0;
                  wr_poll_count <= 21'h0;
                  if((wr_op & ((wr_len == 9'h0) | (_in0__swizzled_add__swizzled > 10'h100)))) begin
                      wr_err_reg <= 1'h1;
                      wr_done_reg <= 1'h1;
                      wr_spi_cs_n <= 1'h1;
                  end                   else begin
                      wr_spi_cs_n <= 1'h0;
                      wr_drive_out <= 1'h1;
                      wr_shift <= 32'h6000000;
                      wr_bit_count <= 8'h0;
                      wr_state <= 4'h2;
                  end 

              end 

          end
          4'h2 : begin
              wr_spi_clk <= (~wr_spi_clk);
              if(wr_spi_clk) begin
                  wr_shift <= (wr_shift << _shiftAmount_const_1);
                  wr_bit_count <= _in42__wr_bit_count_add_const_1;
                  if((wr_bit_count == 8'h7)) begin
                      wr_spi_cs_n <= 1'h1;
                      wr_spi_clk <= 1'h0;
                      wr_state <= 4'h3;
                  end 

              end 

          end
          4'h3 : begin
              wr_spi_cs_n <= 1'h0;
              wr_bit_count <= 8'h0;
              wr_shift <= (wr_op_l ? 32'h2000000 : 32'h20000000);
              wr_state <= 4'h5;
          end
          4'h5 : begin
              wr_spi_clk <= (~wr_spi_clk);
              if(wr_spi_clk) begin
                  wr_shift <= (wr_shift << _shiftAmount_const_1_0);
                  wr_bit_count <= _in55__wr_bit_count_add_const_1;
                  if((wr_bit_count == 8'h7)) begin
                      wr_shift <= (({
8'h0, /* 31:24 */
wr_addr_l  /* 23: 0 */
}) << _shiftAmount_const_8_0);
                      wr_bit_count <= 8'h0;
                      wr_state <= 4'h6;
                  end 

              end 

          end
          4'h6 : begin
              wr_spi_clk <= (~wr_spi_clk);
              if(wr_spi_clk) begin
                  wr_shift <= (wr_shift << _shiftAmount_const_1_1);
                  wr_bit_count <= _in63__wr_bit_count_add_const_1;
                  if((wr_bit_count == 8'h17)) begin
                      wr_bit_count <= 8'h0;
                      if(wr_op_l) begin
                          wr_shift <= (({
24'h0, /* 31:8 */
wr_data  /*  7:0 */
}) << _shiftAmount_const_24);
                          wr_state <= 4'h7;
                      end                       else begin
                          wr_spi_cs_n <= 1'h1;
                          wr_spi_clk <= 1'h0;
                          wr_state <= 4'h8;
                      end 

                  end 

              end 

          end
          4'h7 : begin
              wr_spi_clk <= (~wr_spi_clk);
              if(wr_spi_clk) begin
                  wr_shift <= (wr_shift << _shiftAmount_const_1_2);
                  wr_bit_count <= _in76__wr_bit_count_add_const_1;
                  if((wr_bit_count == 8'h7)) begin
                      wr_bit_count <= 8'h0;
                      wr_byte_idx <= _in79__wr_byte_idx_add_const_1;
                      if((_in0__wr_byte_idx_add_const_1 >= wr_len_l)) begin
                          wr_spi_cs_n <= 1'h1;
                          wr_spi_clk <= 1'h0;
                          wr_state <= 4'h8;
                      end                       else begin
                          wr_state <= 4'he;
                      end 

                  end 

              end 

          end
          4'he : begin
              wr_spi_clk <= 1'h0;
              wr_shift <= (({
24'h0, /* 31:8 */
wr_data  /*  7:0 */
}) << _shiftAmount_const_24);
              wr_state <= 4'h7;
          end
          4'h8 : begin
              wr_spi_cs_n <= 1'h1;
              wr_state <= 4'h9;
          end
          4'h9 : begin
              wr_spi_cs_n <= 1'h0;
              wr_drive_out <= 1'h1;
              wr_shift <= 32'h5000000;
              wr_bit_count <= 8'h0;
              wr_status <= 8'h0;
              wr_poll_count <= _in98__wr_poll_count_add_const_1;
              wr_state <= 4'ha;
          end
          4'ha : begin
              wr_spi_clk <= (~wr_spi_clk);
              if(wr_spi_clk) begin
                  wr_shift <= (wr_shift << _shiftAmount_const_1_3);
                  wr_bit_count <= _in103__wr_bit_count_add_const_1;
                  if((wr_bit_count == 8'h7)) begin
                      wr_bit_count <= 8'h0;
                      wr_drive_out <= 1'h0;
                      wr_state <= 4'hb;
                  end 

              end 

          end
          4'hb : begin
              wr_spi_clk <= (~wr_spi_clk);
              if(wr_spi_clk) begin
                  wr_status <= ((wr_status << _shiftAmount_const_1_6) | ({
7'h0, /* 7:1 */
wr_stat_bit  /*   0 */
}));
                  wr_bit_count <= _in111__wr_bit_count_add_const_1;
                  if((wr_bit_count == 8'h7)) begin
                      wr_spi_cs_n <= 1'h1;
                      wr_spi_clk <= 1'h0;
                      wr_state <= 4'hc;
                  end 

              end 

          end
          4'hc : begin
              wr_spi_cs_n <= 1'h1;
              if((wr_status[0])) begin
                  if((wr_poll_count >= 21'hfffff)) begin
                      wr_err_reg <= 1'h1;
                      wr_state <= 4'hd;
                  end                   else begin
                      wr_state <= 4'h9;
                  end 

              end               else begin
                  wr_state <= 4'hd;
              end 

          end
          4'hd : begin
              wr_done_reg <= 1'h1;
              wr_spi_cs_n <= 1'h1;
              wr_spi_clk <= 1'h0;
              wr_state <= 4'h0;
          end
      endcase

  end 

end

assign spi_mosi_bit = wr_busy ? (wr_shift[31]) : (shift_reg[31]);  // mux_0
assign spi_io_out = {
1'h1, /* 3 */
1'h1, /* 2 */
1'h0, /* 1 */
spi_mosi_bit  /* 0 */
};  // swizzle
assign next_shift = (shift_reg << _shiftAmount_const_4) | ({
28'h0, /* 31:4 */
spi_io_in_0  /*  3:0 */
});  // or_
//  sequential_0
always_ff @(posedge clk) begin
  if(reset) begin
      rd_spi_cs_n <= 1'h1;
      rd_spi_clk <= 1'h0;
      shift_reg <= 32'h0;
      bit_count <= 8'h0;
      spi_state <= 3'h0;
      io_dir <= 1'h0;
      bus_ack_out <= 1'h0;
      dat_out_internal <= 32'h0;
      line_valid <= 1'h0;
      line_tag <= 32'h0;
      word_idx <= 8'h0;
      line_buf_0 <= 32'h0;
  end   else begin
      bus_ack_out <= 1'h0;
      if(wr_busy) begin
          line_valid <= 1'h0;
      end 

      if((~wr_busy)) begin
          case (spi_state) 
              3'h0 : begin
                  if((rd_stb_gated & (~bus_ack_out))) begin
                      if(line_hit) begin
                          if((8'h0 == 8'h0)) begin
                              dat_out_internal <= line_buf_0;
                          end 

                          bus_ack_out <= 1'h1;
                      end                       else begin
                          rd_spi_cs_n <= 1'h0;
                          shift_reg <= 32'h6b000000;
                          bit_count <= 8'h0;
                          word_idx <= 8'h0;
                          io_dir <= 1'h0;
                          spi_state <= 3'h1;
                      end 

                  end 

              end
              3'h1 : begin
                  rd_spi_clk <= (~rd_spi_clk);
                  if(rd_spi_clk) begin
                      shift_reg <= (shift_reg << _shiftAmount_const_1_4);
                      bit_count <= _in36__bit_count_add_const_1;
                      if((bit_count == 8'h7)) begin
                          shift_reg <= (((addr32 & 32'h9ffffc)) << _shiftAmount_const_8);
                          bit_count <= 8'h0;
                          spi_state <= 3'h2;
                      end 

                  end 

              end
              3'h2 : begin
                  rd_spi_clk <= (~rd_spi_clk);
                  if(rd_spi_clk) begin
                      shift_reg <= (shift_reg << _shiftAmount_const_1_5);
                      bit_count <= _in44__bit_count_add_const_1;
                      if((bit_count == 8'h17)) begin
                          bit_count <= 8'h0;
                          io_dir <= 1'h1;
                          shift_reg <= 32'h0;
                          spi_state <= 3'h3;
                      end 

                  end 

              end
              3'h3 : begin
                  rd_spi_clk <= (~rd_spi_clk);
                  if(rd_spi_clk) begin
                      bit_count <= _in52__bit_count_add_const_1;
                      if((bit_count == 8'h7)) begin
                          bit_count <= 8'h0;
                          shift_reg <= 32'h0;
                          spi_state <= 3'h4;
                      end 

                  end 

              end
              3'h4 : begin
                  rd_spi_clk <= (~rd_spi_clk);
                  if(rd_spi_clk) begin
                      shift_reg <= next_shift;
                      bit_count <= _in60__bit_count_add_const_1;
                      if((bit_count == 8'h7)) begin
                          if((word_idx == 8'h0)) begin
                              line_buf_0 <= ({
(next_shift[7:0]), /* 31:24 */
(next_shift[15:8]), /* 23:16 */
(next_shift[23:16]), /* 15: 8 */
(next_shift[31:24])  /*  7: 0 */
});
                          end 

                          bit_count <= 8'h0;
                          if((word_idx == 8'h0)) begin
                              spi_state <= 3'h5;
                          end                           else begin
                              word_idx <= _in68__word_idx_add_const_1;
                          end 

                      end 

                  end 

              end
              3'h5 : begin
                  if((8'h0 == 8'h0)) begin
                      dat_out_internal <= line_buf_0;
                  end 

                  line_valid <= 1'h1;
                  line_tag <= req_line_base;
                  bus_ack_out <= 1'h1;
                  rd_spi_cs_n <= 1'h1;
                  rd_spi_clk <= 1'h0;
                  io_dir <= 1'h0;
                  spi_state <= 3'h0;
              end
          endcase

      end 

  end 

end

assign spi_cs_n_pin = wr_busy ? wr_spi_cs_n : rd_spi_cs_n;  // mux_1
assign {_bit_count_add_const_1_carry, _in36__bit_count_add_const_1} = bit_count + 8'h1;
assign {_bit_count_add_const_1_carry_0, _in44__bit_count_add_const_1} = bit_count + 8'h1;
assign {_bit_count_add_const_1_carry_1, _in52__bit_count_add_const_1} = bit_count + 8'h1;
assign {_bit_count_add_const_1_carry_2, _in60__bit_count_add_const_1} = bit_count + 8'h1;
assign spi_drive_out = wr_busy ? wr_drive_out : (~io_dir);  // mux_2
assign spi_io_oe = {4{spi_drive_out}};  // unnamed_module
assign rd_stb_gated = (bus_CYC & bus_STB) & (~wr_busy);  // and__1
assign line_hit = line_valid & (req_line_base == line_tag);  // and__3
assign req_line_base = addr32 & 32'h9ffffc;  // and__4
assign {_word_idx_add_const_1_carry, _in68__word_idx_add_const_1} = word_idx + 8'h1;
assign {_wr_bit_count_add_const_1_carry, _in42__wr_bit_count_add_const_1} = wr_bit_count + 8'h1;
assign {_wr_bit_count_add_const_1_carry_0, _in55__wr_bit_count_add_const_1} = wr_bit_count + 8'h1;
assign {_wr_bit_count_add_const_1_carry_1, _in63__wr_bit_count_add_const_1} = wr_bit_count + 8'h1;
assign {_wr_bit_count_add_const_1_carry_2, _in76__wr_bit_count_add_const_1} = wr_bit_count + 8'h1;
assign {_wr_bit_count_add_const_1_carry_3, _in103__wr_bit_count_add_const_1} = wr_bit_count + 8'h1;
assign {_wr_bit_count_add_const_1_carry_4, _in111__wr_bit_count_add_const_1} = wr_bit_count + 8'h1;
assign {_wr_byte_idx_add_const_1_carry, _in79__wr_byte_idx_add_const_1} = wr_byte_idx + 9'h1;
assign {_wr_byte_idx_add_const_1_carry_0, _in0__wr_byte_idx_add_const_1} = wr_byte_idx + 9'h1;
assign wr_stat_bit = spi_io_in[1];  // bussubset_5
assign {_wr_poll_count_add_const_1_carry, _in98__wr_poll_count_add_const_1} = wr_poll_count + 21'h1;
assign {_swizzled_add__swizzled_carry, _in0__swizzled_add__swizzled} = ({
2'h0, /* 9:8 */
(wr_addr[7:0])  /* 7:0 */
}) + ({
1'h0, /*   9 */
wr_len  /* 8:0 */
});
endmodule : HarborSpiFlashController