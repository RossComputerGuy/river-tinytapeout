module RiverCore (
input logic clk,
input logic reset,
input logic dataBus_ACK,
input logic [31:0] dataBus_DAT_MISO,
output logic dataBus_CYC,
output logic dataBus_STB,
output logic dataBus_WE,
output logic [31:0] dataBus_ADR,
output logic [31:0] dataBus_DAT_MOSI,
output logic [3:0] dataBus_SEL
);
logic [6:0] _original__subset_38_32_data;
logic [31:0] addr;
logic [38:0] data;
logic [74:0] data_0;
logic done;
logic dport_done;
logic dport_valid;
logic dport_we;
logic en;
logic fence;
logic icFlush;
logic [31:0] ifetch_addr;
logic ifetch_en;
logic interruptHold;
logic interruptHold_0;
logic isReturn;
logic [31:0] memExecRead_data;
logic [31:0] memFetchRead_data;
logic memFetchRead_done;
logic memFetchRead_valid;
logic [31:0] memWrite_addr;
logic [140:0] microcodeDecodeDataReg;
logic microcodeDecodeHsReg;
logic [74:0] microcodeExecDataReg;
logic microcodeExecHsReg;
logic [8:0] microcodeExecRead_addr;
logic mmuTlbFlush;
logic [2:0] mode;
logic [2:0] nextMode;
logic [31:0] nextPc;
logic [31:0] nextSp;
logic [31:0] pc;
logic pipelineEnable;
logic [4:0] rd0_addr;
logic [31:0] rd0_data;
logic [4:0] rd1_addr;
logic [31:0] rd1_data;
logic [6:0] rd_addr_0;
logic [140:0] rd_data_0;
logic rd_en_0;
logic rs1Read_valid;
logic rs2Read_valid;
logic [31:0] sp;
logic valid;
logic wbAckExt;
logic [31:0] wbDatMisoExt;
logic [4:0] wr_addr;
logic [31:0] wr_data;
logic wr_en;
assign mmuTlbFlush = icFlush;
assign wbAckExt = dataBus_ACK;
assign wbDatMisoExt = dataBus_DAT_MISO;
RiverMmu  river_mmu(.clk(clk),.reset(reset),.ifetch_en(ifetch_en),.ifetch_addr(ifetch_addr),.dport_en((dport_we ? 1'h1 : en)),.dport_addr((dport_we ? memWrite_addr : addr)),.dport_we(dport_we),.dport_wdata((dport_we ? ((data[31:0])) : 32'h0)),.dport_size((dport_we ? ((_original__subset_38_32_data[0]) ? 3'h0 : ((_original__subset_38_32_data[1]) ? 3'h1 : ((_original__subset_38_32_data[2]) ? 3'h2 : ((_original__subset_38_32_data[3]) ? 3'h3 : 3'h2)))) : 3'h2)),.dataBus_ACK(wbAckExt),.dataBus_DAT_MISO(wbDatMisoExt),.ifetch_done(memFetchRead_done),.ifetch_valid(memFetchRead_valid),.ifetch_rdata(memFetchRead_data),.dport_done(dport_done),.dport_valid(dport_valid),.dport_rdata(memExecRead_data),.dport_fault(),.dport_fault_guest(),.ifetch_fault(),.dataBus_CYC(dataBus_CYC),.dataBus_STB(dataBus_STB),.dataBus_WE(dataBus_WE),.dataBus_ADR(dataBus_ADR),.dataBus_DAT_MOSI(dataBus_DAT_MOSI),.dataBus_SEL(dataBus_SEL));
RiverPipeline  river_pipeline(.clk(clk),.reset(reset),.enable(pipelineEnable),.currentSp(sp),.currentPc(pc),.currentMode(mode),.memFetchRead_data(memFetchRead_data),.memFetchRead_done(memFetchRead_done),.memFetchRead_valid(memFetchRead_valid),.memExecRead_data(memExecRead_data),.memExecRead_done((dport_done & (~dport_we))),.memExecRead_valid((dport_valid & (~dport_we))),.memWrite_done((dport_done & dport_we)),.memWrite_valid((dport_valid & dport_we)),.rs1Read_data((rs1Read_valid ? rd0_data : 32'h0)),.rs1Read_done(rs1Read_valid),.rs1Read_valid(rs1Read_valid),.rs2Read_data((rs2Read_valid ? rd1_data : 32'h0)),.rs2Read_done(rs2Read_valid),.rs2Read_valid(rs2Read_valid),.rdWrite_done(wr_en),.rdWrite_valid(wr_en),.microcodeDecodeRead_data(microcodeDecodeDataReg),.microcodeDecodeRead_done((rd_en_0 & microcodeDecodeHsReg)),.microcodeDecodeRead_valid((rd_en_0 & microcodeDecodeHsReg)),.microcodeExecRead_data(microcodeExecDataReg),.microcodeExecRead_done((valid & microcodeExecHsReg)),.microcodeExecRead_valid((valid & microcodeExecHsReg)),.memFetchRead_en(ifetch_en),.memFetchRead_addr(ifetch_addr),.memExecRead_en(en),.memExecRead_addr(addr),.memWrite_en(dport_we),.memWrite_addr(memWrite_addr),.memWrite_data(data),.rs1Read_en(rs1Read_valid),.rs1Read_addr(rd0_addr),.rs2Read_en(rs2Read_valid),.rs2Read_addr(rd1_addr),.rdWrite_en(wr_en),.rdWrite_addr(wr_addr),.rdWrite_data(wr_data),.microcodeDecodeRead_en(rd_en_0),.microcodeDecodeRead_addr(rd_addr_0),.microcodeExecRead_en(valid),.microcodeExecRead_addr(microcodeExecRead_addr),.done(done),.valid(),.nextSp(nextSp),.nextPc(nextPc),.nextMode(nextMode),.trap(),.trapCause(),.trapTval(),.trapEpc(),.isReturn(isReturn),.returnLevel(),.memGuest(),.fence(icFlush),.interruptHold(interruptHold_0),.counter());
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      pipelineEnable <= 1'h0;
      pc <= 32'h8000000;
      sp <= 32'h0;
      mode <= 3'h3;
      fence <= 1'h0;
      interruptHold <= 1'h0;
  end   else begin
      if((interruptHold & 1'h0)) begin
          interruptHold <= 1'h0;
          pipelineEnable <= 1'h1;
          fence <= 1'h0;
      end 

      if((~interruptHold)) begin
          if((done & pipelineEnable)) begin
              if(isReturn) begin
                  pc <= nextPc;
                  mode <= nextMode;
              end               else begin
                  pc <= nextPc;
                  mode <= nextMode;
              end 

              sp <= nextSp;
              interruptHold <= interruptHold_0;
              fence <= icFlush;
              pipelineEnable <= 1'h0;
          end 

          if((~done)) begin
              pipelineEnable <= 1'h1;
              fence <= 1'h0;
          end 

      end       else begin
          pipelineEnable <= 1'h0;
          fence <= 1'h0;
      end 

  end 

end

assign _original__subset_38_32_data = data[38:32];  // bussubset_0
HarborRegisterFile_E32_W32_R2_W1_B1  riscv_regfile(.clk(clk),.reset(reset),.rd0_addr(rd0_addr),.rd1_addr(rd1_addr),.wr_en(wr_en),.wr_addr(wr_addr),.wr_data(wr_data),.rd0_data(rd0_data),.rd1_data(rd1_data),.wr_ready());
//  sequential_0
always_ff @(posedge clk) begin
  microcodeDecodeDataReg <= rd_data_0;
end

RiverMicrocodeLookup  rf(.clk(clk),.reset(reset),.rd_en_0(rd_en_0),.rd_addr_0(rd_addr_0),.rd_data_0(rd_data_0));
//  sequential_1
always_ff @(posedge clk) begin
  if(reset) begin
      microcodeDecodeHsReg <= 1'h0;
  end   else begin
      microcodeDecodeHsReg <= rd_en_0;
  end 

end

//  sequential_2
always_ff @(posedge clk) begin
  microcodeExecDataReg <= data_0;
end

RiverMicrocodeOperations  rf_0(.clk(clk),.reset(reset),.rd_en_0(valid),.rd_addr_0(microcodeExecRead_addr),.rd_data_0(data_0));
//  sequential_3
always_ff @(posedge clk) begin
  if(reset) begin
      microcodeExecHsReg <= 1'h0;
  end   else begin
      microcodeExecHsReg <= valid;
  end 

end

endmodule : RiverCore