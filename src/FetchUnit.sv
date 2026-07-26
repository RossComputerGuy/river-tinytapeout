module FetchUnit (
input logic clk,
input logic reset,
input logic enable,
input logic [31:0] pc,
input logic advance,
input logic redirect,
input logic [31:0] redirect_pc,
input logic fault,
input logic [31:0] memRead_data,
input logic memRead_done,
input logic memRead_valid,
output logic memRead_en,
output logic [31:0] memRead_addr,
output logic done,
output logic valid,
output logic compressed,
output logic [31:0] result,
output logic [31:0] pc_out,
output logic fetch_fault
);
logic [15:0] _d1__subset_31_16_readData;
logic [31:0] _in46__pcLatch_and_const__4_add_const_4;
logic [31:0] _in62__pcLatch_and_const__4_add_const_4;
logic [31:0] _in76__pcLatch_and_const__4_add_const_4;
logic [15:0] _original__out;
logic [15:0] _out;
logic _pcLatch_add_instrSizeBytes_carry;
logic _pcLatch_and_const__4_add_const_4_carry;
logic _pcLatch_and_const__4_add_const_4_carry_0;
logic _pcLatch_and_const__4_add_const_4_carry_1;
logic complete;
logic discardResp;
logic enableRead;
logic faulted;
logic [15:0] hiHalf;
logic [15:0] hiSameWord;
logic hwOff;
logic [31:0] instrResult;
logic [31:0] instrSizeBytes;
logic isComp;
logic [15:0] loHalf;
logic [31:0] nextLatch;
logic [31:0] pcLatch;
logic phase2;
logic [31:0] readData;
logic [31:0] secondData;
logic straddle;
logic straddleFresh;
assign memRead_en = enableRead;
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      pcLatch <= 32'h0;
      enableRead <= 1'h0;
      memRead_addr <= 32'h0;
      done <= 1'h0;
      valid <= 1'h0;
      result <= 32'h0;
      pc_out <= 32'h0;
      complete <= 1'h0;
      phase2 <= 1'h0;
      discardResp <= 1'h0;
      readData <= 32'h0;
      secondData <= 32'h0;
      faulted <= 1'h0;
      compressed <= 1'h0;
  end   else begin
      done <= 1'h0;
      valid <= 1'h0;
      result <= 32'h0;
      if(redirect) begin
          pcLatch <= redirect_pc;
          complete <= 1'h0;
          phase2 <= 1'h0;
          faulted <= 1'h0;
          discardResp <= 1'h1;
          enableRead <= 1'h1;
          memRead_addr <= (redirect_pc & 32'hfffffffc);
      end       else if((discardResp & memRead_done)) begin
          discardResp <= 1'h0;
          complete <= 1'h0;
          phase2 <= 1'h0;
          enableRead <= 1'h1;
          memRead_addr <= (pcLatch & 32'hfffffffc);
      end       else if((((enable & (~complete)) & (~phase2)) & (~enableRead))) begin
          pcLatch <= pc;
          enableRead <= 1'h1;
          memRead_addr <= (pc & 32'hfffffffc);
      end       else if(((((enable & (~complete)) & (~phase2)) & enableRead) & (~memRead_done))) begin
          enableRead <= 1'h1;
          memRead_addr <= (pcLatch & 32'hfffffffc);
      end       else if((((((enable & (~complete)) & (~phase2)) & enableRead) & memRead_done) & memRead_valid)) begin
          readData <= memRead_data;
          pc_out <= pcLatch;
          if(straddleFresh) begin
              phase2 <= 1'h1;
              enableRead <= 1'h1;
              memRead_addr <= _in46__pcLatch_and_const__4_add_const_4;
          end           else begin
              complete <= 1'h1;
              enableRead <= 1'h1;
              memRead_addr <= (pcLatch & 32'hfffffffc);
          end 

      end       else if((((((enable & (~complete)) & (~phase2)) & enableRead) & memRead_done) & (~memRead_valid))) begin
          if(fault) begin
              complete <= 1'h1;
              faulted <= 1'h1;
              pc_out <= pcLatch;
              enableRead <= 1'h1;
              memRead_addr <= (pcLatch & 32'hfffffffc);
          end           else begin
              enableRead <= 1'h1;
              memRead_addr <= (pcLatch & 32'hfffffffc);
          end 

      end       else if((((enable & (~complete)) & phase2) & (~memRead_done))) begin
          enableRead <= 1'h1;
          memRead_addr <= _in62__pcLatch_and_const__4_add_const_4;
      end       else if(((((enable & (~complete)) & phase2) & memRead_done) & memRead_valid)) begin
          secondData <= memRead_data;
          complete <= 1'h1;
          phase2 <= 1'h0;
          enableRead <= 1'h1;
          memRead_addr <= (pcLatch & 32'hfffffffc);
      end       else if(((((enable & (~complete)) & phase2) & memRead_done) & (~memRead_valid))) begin
          if(fault) begin
              complete <= 1'h1;
              faulted <= 1'h1;
              phase2 <= 1'h0;
              pc_out <= pcLatch;
              enableRead <= 1'h1;
              memRead_addr <= (pcLatch & 32'hfffffffc);
          end           else begin
              enableRead <= 1'h1;
              memRead_addr <= _in76__pcLatch_and_const__4_add_const_4;
          end 

      end       else if(((enable & complete) & advance)) begin
          pcLatch <= nextLatch;
          complete <= 1'h0;
          phase2 <= 1'h0;
          faulted <= 1'h0;
          enableRead <= 1'h1;
          memRead_addr <= (nextLatch & 32'hfffffffc);
      end       else if((enable & complete)) begin
          done <= 1'h1;
          valid <= 1'h1;
          enableRead <= 1'h0;
          memRead_addr <= (pcLatch & 32'hfffffffc);
          result <= instrResult;
          compressed <= isComp;
      end       else if((~enable)) begin
          complete <= 1'h0;
          phase2 <= 1'h0;
          pcLatch <= pc;
          compressed <= 1'h0;
          enableRead <= 1'h0;
          memRead_addr <= 32'h0;
      end 

  end 

end

assign hwOff = pcLatch[1];  // bussubset
assign loHalf = (hwOff == 1'h1) ? (readData[31:16]) : (readData[15:0]);  // mux
assign instrResult = isComp ? ({
16'h0, /* 31:16 */
loHalf  /* 15: 0 */
}) : ({
hiHalf, /* 31:16 */
loHalf  /* 15: 0 */
});  // mux_0
assign straddle = (~isComp) & (hwOff == 1'h1);  // and__0
assign hiHalf = straddle ? (secondData[15:0]) : hiSameWord;  // mux_1
assign hiSameWord = (hwOff == 1'h1) ? _d1__subset_31_16_readData : _d1__subset_31_16_readData;  // mux_2
assign _d1__subset_31_16_readData = readData[31:16];  // bussubset_0
assign _original__out = (hwOff == 1'h1) ? (readData[31:16]) : (readData[15:0]);  // mux_3
assign isComp = (_original__out[1:0]) != 2'h3;  // notEquals
assign instrSizeBytes = isComp ? 32'h2 : 32'h4;  // mux_4
assign {_pcLatch_add_instrSizeBytes_carry, nextLatch} = pcLatch + instrSizeBytes;
assign {_pcLatch_and_const__4_add_const_4_carry, _in46__pcLatch_and_const__4_add_const_4} = (pcLatch & 32'hfffffffc) + 32'h4;
assign {_pcLatch_and_const__4_add_const_4_carry_0, _in62__pcLatch_and_const__4_add_const_4} = (pcLatch & 32'hfffffffc) + 32'h4;
assign {_pcLatch_and_const__4_add_const_4_carry_1, _in76__pcLatch_and_const__4_add_const_4} = (pcLatch & 32'hfffffffc) + 32'h4;
assign _out = (hwOff == 1'h1) ? (memRead_data[31:16]) : (memRead_data[15:0]);  // mux_5
assign straddleFresh = (~((_out[1:0]) != 2'h3)) & (hwOff == 1'h1);  // and__15
assign fetch_fault = done & faulted;  // and__47
endmodule : FetchUnit