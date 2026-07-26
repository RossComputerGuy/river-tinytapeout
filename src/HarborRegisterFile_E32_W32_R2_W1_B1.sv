module HarborRegisterFile_E32_W32_R2_W1_B1 (
input logic clk,
input logic reset,
input logic [4:0] rd0_addr,
input logic [4:0] rd1_addr,
input logic wr_en,
input logic [4:0] wr_addr,
input logic [31:0] wr_data,
output logic [31:0] rd0_data,
output logic [31:0] rd1_data,
output logic wr_ready
);
logic [4:0] bankWinAddr_0;
logic [31:0] bankWinData_0;
logic bankWinEn_0;
logic [31:0] rdComb_0;
logic [31:0] rdComb_1;
logic [31:0] reg_0;
logic [31:0] reg_1;
logic [31:0] reg_10;
logic [31:0] reg_11;
logic [31:0] reg_12;
logic [31:0] reg_13;
logic [31:0] reg_14;
logic [31:0] reg_15;
logic [31:0] reg_16;
logic [31:0] reg_17;
logic [31:0] reg_18;
logic [31:0] reg_19;
logic [31:0] reg_2;
logic [31:0] reg_20;
logic [31:0] reg_21;
logic [31:0] reg_22;
logic [31:0] reg_23;
logic [31:0] reg_24;
logic [31:0] reg_25;
logic [31:0] reg_26;
logic [31:0] reg_27;
logic [31:0] reg_28;
logic [31:0] reg_29;
logic [31:0] reg_3;
logic [31:0] reg_30;
logic [31:0] reg_31;
logic [31:0] reg_4;
logic [31:0] reg_5;
logic [31:0] reg_6;
logic [31:0] reg_7;
logic [31:0] reg_8;
logic [31:0] reg_9;
logic winsel_w0_b0;
logic wrReady_0;
assign rd0_data = rdComb_0;
assign rd1_data = rdComb_1;
assign wr_ready = wrReady_0;
assign bankWinEn_0 = wr_en;
//  combinational
always_comb begin
  case (rd0_addr) 
      5'h1 : begin
          rdComb_0 = reg_1;
      end
      5'h2 : begin
          rdComb_0 = reg_2;
      end
      5'h3 : begin
          rdComb_0 = reg_3;
      end
      5'h4 : begin
          rdComb_0 = reg_4;
      end
      5'h5 : begin
          rdComb_0 = reg_5;
      end
      5'h6 : begin
          rdComb_0 = reg_6;
      end
      5'h7 : begin
          rdComb_0 = reg_7;
      end
      5'h8 : begin
          rdComb_0 = reg_8;
      end
      5'h9 : begin
          rdComb_0 = reg_9;
      end
      5'ha : begin
          rdComb_0 = reg_10;
      end
      5'hb : begin
          rdComb_0 = reg_11;
      end
      5'hc : begin
          rdComb_0 = reg_12;
      end
      5'hd : begin
          rdComb_0 = reg_13;
      end
      5'he : begin
          rdComb_0 = reg_14;
      end
      5'hf : begin
          rdComb_0 = reg_15;
      end
      5'h10 : begin
          rdComb_0 = reg_16;
      end
      5'h11 : begin
          rdComb_0 = reg_17;
      end
      5'h12 : begin
          rdComb_0 = reg_18;
      end
      5'h13 : begin
          rdComb_0 = reg_19;
      end
      5'h14 : begin
          rdComb_0 = reg_20;
      end
      5'h15 : begin
          rdComb_0 = reg_21;
      end
      5'h16 : begin
          rdComb_0 = reg_22;
      end
      5'h17 : begin
          rdComb_0 = reg_23;
      end
      5'h18 : begin
          rdComb_0 = reg_24;
      end
      5'h19 : begin
          rdComb_0 = reg_25;
      end
      5'h1a : begin
          rdComb_0 = reg_26;
      end
      5'h1b : begin
          rdComb_0 = reg_27;
      end
      5'h1c : begin
          rdComb_0 = reg_28;
      end
      5'h1d : begin
          rdComb_0 = reg_29;
      end
      5'h1e : begin
          rdComb_0 = reg_30;
      end
      5'h1f : begin
          rdComb_0 = reg_31;
      end
      default : begin
          rdComb_0 = 32'h0;
      end
  endcase

  case (rd1_addr) 
      5'h1 : begin
          rdComb_1 = reg_1;
      end
      5'h2 : begin
          rdComb_1 = reg_2;
      end
      5'h3 : begin
          rdComb_1 = reg_3;
      end
      5'h4 : begin
          rdComb_1 = reg_4;
      end
      5'h5 : begin
          rdComb_1 = reg_5;
      end
      5'h6 : begin
          rdComb_1 = reg_6;
      end
      5'h7 : begin
          rdComb_1 = reg_7;
      end
      5'h8 : begin
          rdComb_1 = reg_8;
      end
      5'h9 : begin
          rdComb_1 = reg_9;
      end
      5'ha : begin
          rdComb_1 = reg_10;
      end
      5'hb : begin
          rdComb_1 = reg_11;
      end
      5'hc : begin
          rdComb_1 = reg_12;
      end
      5'hd : begin
          rdComb_1 = reg_13;
      end
      5'he : begin
          rdComb_1 = reg_14;
      end
      5'hf : begin
          rdComb_1 = reg_15;
      end
      5'h10 : begin
          rdComb_1 = reg_16;
      end
      5'h11 : begin
          rdComb_1 = reg_17;
      end
      5'h12 : begin
          rdComb_1 = reg_18;
      end
      5'h13 : begin
          rdComb_1 = reg_19;
      end
      5'h14 : begin
          rdComb_1 = reg_20;
      end
      5'h15 : begin
          rdComb_1 = reg_21;
      end
      5'h16 : begin
          rdComb_1 = reg_22;
      end
      5'h17 : begin
          rdComb_1 = reg_23;
      end
      5'h18 : begin
          rdComb_1 = reg_24;
      end
      5'h19 : begin
          rdComb_1 = reg_25;
      end
      5'h1a : begin
          rdComb_1 = reg_26;
      end
      5'h1b : begin
          rdComb_1 = reg_27;
      end
      5'h1c : begin
          rdComb_1 = reg_28;
      end
      5'h1d : begin
          rdComb_1 = reg_29;
      end
      5'h1e : begin
          rdComb_1 = reg_30;
      end
      5'h1f : begin
          rdComb_1 = reg_31;
      end
      default : begin
          rdComb_1 = 32'h0;
      end
  endcase

end

//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      reg_0 <= 32'h0;
      reg_1 <= 32'h0;
      reg_2 <= 32'h0;
      reg_3 <= 32'h0;
      reg_4 <= 32'h0;
      reg_5 <= 32'h0;
      reg_6 <= 32'h0;
      reg_7 <= 32'h0;
      reg_8 <= 32'h0;
      reg_9 <= 32'h0;
      reg_10 <= 32'h0;
      reg_11 <= 32'h0;
      reg_12 <= 32'h0;
      reg_13 <= 32'h0;
      reg_14 <= 32'h0;
      reg_15 <= 32'h0;
      reg_16 <= 32'h0;
      reg_17 <= 32'h0;
      reg_18 <= 32'h0;
      reg_19 <= 32'h0;
      reg_20 <= 32'h0;
      reg_21 <= 32'h0;
      reg_22 <= 32'h0;
      reg_23 <= 32'h0;
      reg_24 <= 32'h0;
      reg_25 <= 32'h0;
      reg_26 <= 32'h0;
      reg_27 <= 32'h0;
      reg_28 <= 32'h0;
      reg_29 <= 32'h0;
      reg_30 <= 32'h0;
      reg_31 <= 32'h0;
  end   else begin
      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1))) begin
          reg_1 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h2))) begin
          reg_2 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h3))) begin
          reg_3 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h4))) begin
          reg_4 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h5))) begin
          reg_5 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h6))) begin
          reg_6 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h7))) begin
          reg_7 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h8))) begin
          reg_8 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h9))) begin
          reg_9 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'ha))) begin
          reg_10 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'hb))) begin
          reg_11 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'hc))) begin
          reg_12 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'hd))) begin
          reg_13 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'he))) begin
          reg_14 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'hf))) begin
          reg_15 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h10))) begin
          reg_16 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h11))) begin
          reg_17 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h12))) begin
          reg_18 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h13))) begin
          reg_19 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h14))) begin
          reg_20 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h15))) begin
          reg_21 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h16))) begin
          reg_22 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h17))) begin
          reg_23 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h18))) begin
          reg_24 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h19))) begin
          reg_25 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1a))) begin
          reg_26 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1b))) begin
          reg_27 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1c))) begin
          reg_28 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1d))) begin
          reg_29 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1e))) begin
          reg_30 <= bankWinData_0;
      end 

      if((bankWinEn_0 & (bankWinAddr_0 == 5'h1f))) begin
          reg_31 <= bankWinData_0;
      end 

  end 

end

assign bankWinData_0 = winsel_w0_b0 ? wr_data : 32'h0;  // mux
assign winsel_w0_b0 = wr_en & (wr_addr == bankWinAddr_0);  // and_
assign wrReady_0 = (~wr_en) | (wr_addr == bankWinAddr_0);  // or_
assign bankWinAddr_0 = wr_en ? wr_addr : 5'h0;  // mux_0
endmodule : HarborRegisterFile_E32_W32_R2_W1_B1