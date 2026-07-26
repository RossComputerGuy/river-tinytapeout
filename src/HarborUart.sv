module HarborUart (
input logic clk,
input logic reset,
input logic rx,
input logic bus_CYC,
input logic bus_STB,
input logic bus_WE,
input logic [31:0] bus_ADR,
input logic [31:0] bus_DAT_MOSI,
input logic [3:0] bus_SEL,
output logic tx,
output logic interrupt,
output logic bus_ACK,
output logic [31:0] bus_DAT_MISO
);
logic _in0__rx_ready_and__subset_0_0_ier;
logic [15:0] _in0__swizzled;
logic _in1__tx_holding_full_b_and__subset_1_1_ier;
logic [3:0] _in31__tx_count_add_const_1;
logic [3:0] _in59__rx_bits_add_const_1;
logic _rx_bits_add_const_1_carry;
logic [7:0] _shiftAmount_const_5;
logic [7:0] _shiftAmount_const_6;
logic [7:0] _shiftAmount_const_6_0;
logic _subset_7_7_lcr;
logic _tx_count_add_const_1_carry;
logic [15:0] baud_count;
logic baud_tick;
logic bus_ack_out;
logic [31:0] bus_dat_out;
logic [7:0] computed_iir;
logic [7:0] dll;
logic [7:0] dlm;
logic [7:0] fcr;
logic [7:0] ier;
logic [7:0] lcr;
logic [7:0] lsr;
logic [7:0] mcr;
logic [15:0] rx_baud;
logic [3:0] rx_bits;
logic rx_busy;
logic [7:0] rx_data;
logic rx_ready;
logic [7:0] rx_shift;
logic rx_sync_a;
logic rx_sync_b;
logic [7:0] scr;
logic tx_busy;
logic [3:0] tx_count;
logic [7:0] tx_holding;
logic tx_holding_full;
logic [9:0] tx_shift;
logic [7:0] uart_dat_in;
logic [31:0] uart_dat_out;
logic [1:0] uart_wr_lane;
assign bus_ACK = bus_ack_out;
assign bus_dat_out = uart_dat_out;
assign bus_DAT_MISO = bus_dat_out;
assign _shiftAmount_const_6 = 8'h6;
assign _shiftAmount_const_6_0 = 8'h6;
assign _shiftAmount_const_5 = 8'h5;
//  combinational
always_comb begin
  if(tx_busy) begin
      tx = (tx_shift[0]);
  end   else begin
      tx = 1'h1;
  end 

end

assign lsr = (({
7'h0, /* 7:1 */
rx_ready  /*   0 */
}) | (({
7'h0, /* 7:1 */
(~tx_holding_full)  /*   0 */
}) << _shiftAmount_const_5)) | (({
7'h0, /* 7:1 */
((~tx_holding_full) & (~tx_busy))  /*   0 */
}) << _shiftAmount_const_6);  // or_
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      dll <= 8'h1;
      dlm <= 8'h0;
      ier <= 8'h0;
      fcr <= 8'h0;
      lcr <= 8'h3;
      mcr <= 8'h0;
      scr <= 8'h0;
      tx_busy <= 1'h0;
      tx_shift <= 10'h3ff;
      tx_count <= 4'h0;
      tx_holding <= 8'h0;
      tx_holding_full <= 1'h0;
      rx_data <= 8'h0;
      rx_ready <= 1'h0;
      rx_sync_a <= 1'h1;
      rx_sync_b <= 1'h1;
      rx_busy <= 1'h0;
      rx_bits <= 4'h0;
      rx_baud <= 16'h0;
      rx_shift <= 8'h0;
      baud_count <= 16'h0;
      bus_ack_out <= 1'h0;
      uart_dat_out <= 32'h0;
  end   else begin
      if((baud_count == 16'h0)) begin
          baud_count <= (_in0__swizzled - 16'h1);
      end       else begin
          baud_count <= (baud_count - 16'h1);
      end 

      if((tx_busy & baud_tick)) begin
          tx_shift <= ({$signed(tx_shift) >>> 10'h1});
          tx_count <= _in31__tx_count_add_const_1;
          if((tx_count == 4'h9)) begin
              tx_busy <= 1'h0;
              tx_count <= 4'h0;
          end 

      end 

      if(((~tx_busy) & tx_holding_full)) begin
          tx_shift <= ({
1'h1, /*   9 */
tx_holding, /* 8:1 */
1'h0  /*   0 */
});
          tx_busy <= 1'h1;
          tx_count <= 4'h0;
          tx_holding_full <= 1'h0;
          baud_count <= (_in0__swizzled - 16'h1);
      end 

      rx_sync_a <= rx;
      rx_sync_b <= rx_sync_a;
      if((~rx_busy)) begin
          if(((~rx_sync_b) & (_in0__swizzled != 16'h0))) begin
              rx_busy <= 1'h1;
              rx_bits <= 4'h0;
              rx_baud <= ({
1'h0, /*   15 */
(_in0__swizzled[15:1])  /* 14:0 */
});
          end 

      end       else begin
          if((rx_baud == 16'h0)) begin
              rx_baud <= (_in0__swizzled - 16'h1);
              if((rx_bits == 4'h0)) begin
                  if((~rx_sync_b)) begin
                      rx_bits <= 4'h1;
                  end                   else begin
                      rx_busy <= 1'h0;
                  end 

              end               else begin
                  if((rx_bits <= 4'h8)) begin
                      rx_shift <= ({
rx_sync_b, /*   7 */
(rx_shift[7:1])  /* 6:0 */
});
                      rx_bits <= _in59__rx_bits_add_const_1;
                  end                   else begin
                      if(rx_sync_b) begin
                          rx_data <= rx_shift;
                          rx_ready <= 1'h1;
                      end 

                      rx_busy <= 1'h0;
                  end 

              end 

          end           else begin
              rx_baud <= (rx_baud - 16'h1);
          end 

      end 

      bus_ack_out <= 1'h0;
      uart_dat_out <= 32'h0;
      if(((bus_CYC & bus_STB) & (~bus_ack_out))) begin
          bus_ack_out <= 1'h1;
          if(bus_WE) begin
              case (({
(bus_ADR[2]), /*   2 */
uart_wr_lane  /* 1:0 */
})) 
                  3'h0 : begin
                      if(_subset_7_7_lcr) begin
                          dll <= uart_dat_in;
                      end                       else begin
                          tx_holding <= uart_dat_in;
                          tx_holding_full <= 1'h1;
                      end 

                  end
                  3'h1 : begin
                      if(_subset_7_7_lcr) begin
                          dlm <= uart_dat_in;
                      end                       else begin
                          ier <= uart_dat_in;
                      end 

                  end
                  3'h2 : begin
                      fcr <= uart_dat_in;
                  end
                  3'h3 : begin
                      lcr <= uart_dat_in;
                  end
                  3'h4 : begin
                      mcr <= uart_dat_in;
                  end
                  3'h7 : begin
                      scr <= uart_dat_in;
                  end
              endcase

          end           else begin
              if((bus_ADR[2])) begin
                  uart_dat_out <= (({
scr, /* 31:24 */
8'h0, /* 23:16 */
lsr, /* 15: 8 */
mcr  /*  7: 0 */
}));
              end               else begin
                  uart_dat_out <= (({
lcr, /* 31:24 */
computed_iir, /* 23:16 */
(_subset_7_7_lcr ? dlm : ier), /* 15: 8 */
(_subset_7_7_lcr ? dll : rx_data)  /*  7: 0 */
}));
                  if((~_subset_7_7_lcr)) begin
                      rx_ready <= 1'h0;
                  end 

              end 

          end 

      end 

  end 

end

assign _in0__swizzled = {
dlm, /* 15:8 */
dll  /*  7:0 */
};  // swizzle_2
assign baud_tick = (baud_count == 16'h0) & (_in0__swizzled != 16'h0);  // and__0
assign _subset_7_7_lcr = lcr[7];  // bussubset_1
//  combinational_0
always_comb begin
  computed_iir = (({
6'h0, /* 7:2 */
(fcr[7:6])  /* 1:0 */
}) << _shiftAmount_const_6_0);
  if(_in0__rx_ready_and__subset_0_0_ier) begin
      computed_iir = (computed_iir | 8'h4);
  end   else begin
      if(_in1__tx_holding_full_b_and__subset_1_1_ier) begin
          computed_iir = (computed_iir | 8'h2);
      end       else begin
          computed_iir = (computed_iir | 8'h1);
      end 

  end 

end

assign _in0__rx_ready_and__subset_0_0_ier = rx_ready & (ier[0]);  // and__3
assign _in1__tx_holding_full_b_and__subset_1_1_ier = (~tx_holding_full) & (ier[1]);  // and__4
assign interrupt = _in0__rx_ready_and__subset_0_0_ier | _in1__tx_holding_full_b_and__subset_1_1_ier;  // or__2
assign {_tx_count_add_const_1_carry, _in31__tx_count_add_const_1} = tx_count + 4'h1;
assign {_rx_bits_add_const_1_carry, _in59__rx_bits_add_const_1} = rx_bits + 4'h1;
//  combinational_1
always_comb begin
  uart_dat_in = 8'h0;
  if((uart_wr_lane == 2'h0)) begin
      uart_dat_in = (bus_DAT_MOSI[7:0]);
  end 

  if((uart_wr_lane == 2'h1)) begin
      uart_dat_in = (bus_DAT_MOSI[15:8]);
  end 

  if((uart_wr_lane == 2'h2)) begin
      uart_dat_in = (bus_DAT_MOSI[23:16]);
  end 

  if((uart_wr_lane == 2'h3)) begin
      uart_dat_in = (bus_DAT_MOSI[31:24]);
  end 

end

//  combinational_2
always_comb begin
  uart_wr_lane = 2'h0;
  if((bus_SEL[1])) begin
      uart_wr_lane = 2'h1;
  end 

  if((bus_SEL[2])) begin
      uart_wr_lane = 2'h2;
  end 

  if((bus_SEL[3])) begin
      uart_wr_lane = 2'h3;
  end 

end

endmodule : HarborUart