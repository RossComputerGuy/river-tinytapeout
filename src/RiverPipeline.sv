module RiverPipeline (
input logic clk,
input logic reset,
input logic enable,
input logic [31:0] currentSp,
input logic [31:0] currentPc,
input logic [2:0] currentMode,
input logic [31:0] memFetchRead_data,
input logic memFetchRead_done,
input logic memFetchRead_valid,
input logic [31:0] memExecRead_data,
input logic memExecRead_done,
input logic memExecRead_valid,
input logic memWrite_done,
input logic memWrite_valid,
input logic [31:0] rs1Read_data,
input logic rs1Read_done,
input logic rs1Read_valid,
input logic [31:0] rs2Read_data,
input logic rs2Read_done,
input logic rs2Read_valid,
input logic rdWrite_done,
input logic rdWrite_valid,
input logic [140:0] microcodeDecodeRead_data,
input logic microcodeDecodeRead_done,
input logic microcodeDecodeRead_valid,
input logic [74:0] microcodeExecRead_data,
input logic microcodeExecRead_done,
input logic microcodeExecRead_valid,
output logic memFetchRead_en,
output logic [31:0] memFetchRead_addr,
output logic memExecRead_en,
output logic [31:0] memExecRead_addr,
output logic memWrite_en,
output logic [31:0] memWrite_addr,
output logic [38:0] memWrite_data,
output logic rs1Read_en,
output logic [4:0] rs1Read_addr,
output logic rs2Read_en,
output logic [4:0] rs2Read_addr,
output logic rdWrite_en,
output logic [4:0] rdWrite_addr,
output logic [31:0] rdWrite_data,
output logic microcodeDecodeRead_en,
output logic [6:0] microcodeDecodeRead_addr,
output logic microcodeExecRead_en,
output logic [8:0] microcodeExecRead_addr,
output logic done,
output logic valid,
output logic [31:0] nextSp,
output logic [31:0] nextPc,
output logic [2:0] nextMode,
output logic trap,
output logic [5:0] trapCause,
output logic [31:0] trapTval,
output logic [31:0] trapEpc,
output logic isReturn,
output logic [2:0] returnLevel,
output logic memGuest,
output logic fence,
output logic interruptHold,
output logic [31:0] counter
);
logic _counter_add_const_1_carry;
logic [31:0] _in29__counter_add_const_1;
logic done_0;
logic done_1;
logic done_2;
logic fence_0;
logic fetchFault;
logic [1:0] funct2;
logic [2:0] funct3;
logic [3:0] funct4;
logic [5:0] funct6;
logic [6:0] funct7;
logic [31:0] imm;
logic [6:0] immHi;
logic [4:0] immLo;
logic [2:0] imm_hi;
logic [4:0] imm_lo;
logic [31:0] instr;
logic [8:0] instrIndex;
logic interruptHold_0;
logic isReturn_0;
logic is_BType;
logic is_CBType;
logic is_CJType;
logic is_IType;
logic is_JType;
logic is_RType;
logic is_SType;
logic is_UType;
logic is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3;
logic is_Unknown_op_rd_prime_imm_funct3;
logic is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3;
logic is_Unknown_op_rs2_imm_funct3;
logic is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6;
logic is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3;
logic is_Unknown_op_rs2_rd_rs1_funct4;
logic [10:0] jump_target;
logic [2:0] nextMode_0;
logic [31:0] nextPc_0;
logic [31:0] nextSp_0;
logic [2:0] offset_hi;
logic [4:0] offset_lo;
logic [1:0] op;
logic [6:0] opcode;
logic [31:0] pc_in;
logic [4:0] rd;
logic [2:0] rd_prime;
logic [4:0] rd_rs1;
logic [2:0] rd_rs1_prime;
logic readyExecution;
logic [2:0] returnLevel_0;
logic [4:0] rs1;
logic [2:0] rs1_prime;
logic [4:0] rs2;
logic [2:0] rs2_prime;
logic [5:0] trapCause_0;
logic [31:0] trapEpc_0;
logic [31:0] trapTval_0;
logic trap_0;
logic valid_0;
logic valid_1;
logic valid_2;
FetchUnit  river_fetch_unit(.clk(clk),.reset(reset),.enable(enable),.pc(currentPc),.advance(1'h0),.redirect(1'h0),.redirect_pc(32'h0),.fault(1'h0),.memRead_data(memFetchRead_data),.memRead_done(memFetchRead_done),.memRead_valid(memFetchRead_valid),.memRead_en(memFetchRead_en),.memRead_addr(memFetchRead_addr),.done(done_2),.valid(valid_2),.compressed(),.result(instr),.pc_out(pc_in),.fetch_fault(fetchFault));
DynamicInstructionDecoder  river_dynamic_instruction_decoder(.clk(clk),.reset(reset),.enable(((done_2 & valid_2) & enable)),.instr(instr),.pc_in(pc_in),.microcodeRead_data(microcodeDecodeRead_data),.microcodeRead_done(microcodeDecodeRead_done),.microcodeRead_valid(microcodeDecodeRead_valid),.microcodeRead_en(microcodeDecodeRead_en),.microcodeRead_addr(microcodeDecodeRead_addr),.done(done_1),.valid(valid_1),.index(instrIndex),.imm(imm),.counter(),.pc_out(),.op(op),.rd_prime(rd_prime),.funct3(funct3),.imm_lo(imm_lo),.rs1_prime(rs1_prime),.imm_hi(imm_hi),.rs2_prime(rs2_prime),.rd_rs1(rd_rs1),.jump_target(jump_target),.offset_lo(offset_lo),.offset_hi(offset_hi),.funct2(funct2),.rd_rs1_prime(rd_rs1_prime),.funct6(funct6),.rs2(rs2),.funct4(funct4),.opcode(opcode),.rd(rd),.rs1(rs1),.immLo(immLo),.immHi(immHi),.funct7(funct7),.is_Unknown_op_rd_prime_imm_funct3(is_Unknown_op_rd_prime_imm_funct3),.is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3(is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3),.is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3(is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3),.is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3(is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3),.is_CJType(is_CJType),.is_CBType(is_CBType),.is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6(is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6),.is_Unknown_op_rs2_imm_funct3(is_Unknown_op_rs2_imm_funct3),.is_Unknown_op_rs2_rd_rs1_funct4(is_Unknown_op_rs2_rd_rs1_funct4),.is_UType(is_UType),.is_JType(is_JType),.is_IType(is_IType),.is_BType(is_BType),.is_SType(is_SType),.is_RType(is_RType));
assign readyExecution = ((valid_2 & done_2) & valid_1) & done_1;  // and__1
DynamicExecutionUnit  river_dynamic_execution_unit(.clk(clk),.reset(reset),.enable(readyExecution),.currentSp(currentSp),.currentPc(currentPc),.currentMode(currentMode),.fetchFault(fetchFault),.instrIndex(instrIndex),.is_Unknown_op_rd_prime_imm_funct3(is_Unknown_op_rd_prime_imm_funct3),.is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3(is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3),.is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3(is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3),.is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3(is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3),.is_CJType(is_CJType),.is_CBType(is_CBType),.is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6(is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6),.is_Unknown_op_rs2_imm_funct3(is_Unknown_op_rs2_imm_funct3),.is_Unknown_op_rs2_rd_rs1_funct4(is_Unknown_op_rs2_rd_rs1_funct4),.is_UType(is_UType),.is_JType(is_JType),.is_IType(is_IType),.is_BType(is_BType),.is_SType(is_SType),.is_RType(is_RType),.op(op),.rd_prime(rd_prime),.imm(imm),.funct3(funct3),.imm_lo(imm_lo),.rs1_prime(rs1_prime),.imm_hi(imm_hi),.rs2_prime(rs2_prime),.rd_rs1(rd_rs1),.jump_target(jump_target),.offset_lo(offset_lo),.offset_hi(offset_hi),.funct2(funct2),.rd_rs1_prime(rd_rs1_prime),.funct6(funct6),.rs2(rs2),.funct4(funct4),.opcode(opcode),.rd(rd),.rs1(rs1),.immLo(immLo),.immHi(immHi),.funct7(funct7),.memRead_data(memExecRead_data),.memRead_done(memExecRead_done),.memRead_valid(memExecRead_valid),.memWrite_done(memWrite_done),.memWrite_valid(memWrite_valid),.rs1Read_data(rs1Read_data),.rs1Read_done(rs1Read_done),.rs1Read_valid(rs1Read_valid),.rs2Read_data(rs2Read_data),.rs2Read_done(rs2Read_done),.rs2Read_valid(rs2Read_valid),.rdWrite_done(rdWrite_done),.rdWrite_valid(rdWrite_valid),.microcodeRead_data(microcodeExecRead_data),.microcodeRead_done(microcodeExecRead_done),.microcodeRead_valid(microcodeExecRead_valid),.memRead_en(memExecRead_en),.memRead_addr(memExecRead_addr),.memWrite_en(memWrite_en),.memWrite_addr(memWrite_addr),.memWrite_data(memWrite_data),.rs1Read_en(rs1Read_en),.rs1Read_addr(rs1Read_addr),.rs2Read_en(rs2Read_en),.rs2Read_addr(rs2Read_addr),.rdWrite_en(rdWrite_en),.rdWrite_addr(rdWrite_addr),.rdWrite_data(rdWrite_data),.microcodeRead_en(microcodeExecRead_en),.microcodeRead_addr(microcodeExecRead_addr),.done(done_0),.valid(valid_0),.nextSp(nextSp_0),.nextPc(nextPc_0),.nextMode(nextMode_0),.trap(trap_0),.trapCause(trapCause_0),.trapTval(trapTval_0),.trapEpc(trapEpc_0),.isReturn(isReturn_0),.returnLevel(returnLevel_0),.memGuest(memGuest),.fence(fence_0),.interruptHold(interruptHold_0),.counter());
//  sequential
always_ff @(posedge clk) begin
  if((reset | (~done_0))) begin
      done <= 1'h0;
      valid <= 1'h0;
      nextSp <= 32'h0;
      nextPc <= 32'h0;
      nextMode <= 3'h0;
      trap <= 1'h0;
      trapCause <= 6'h0;
      trapTval <= 32'h0;
      trapEpc <= 32'h0;
      isReturn <= 1'h0;
      returnLevel <= 3'h0;
      fence <= 1'h0;
      counter <= 32'h0;
  end   else begin
      done <= ((done_2 & done_1) & done_0);
      valid <= ((valid_2 & valid_1) & valid_0);
      nextSp <= nextSp_0;
      nextPc <= nextPc_0;
      nextMode <= nextMode_0;
      trap <= trap_0;
      trapCause <= trapCause_0;
      trapTval <= trapTval_0;
      trapEpc <= trapEpc_0;
      isReturn <= isReturn_0;
      returnLevel <= returnLevel_0;
      fence <= fence_0;
      interruptHold <= interruptHold_0;
      if(enable) begin
          counter <= _in29__counter_add_const_1;
      end 

  end 

end

assign {_counter_add_const_1_carry, _in29__counter_add_const_1} = counter + 32'h1;
endmodule : RiverPipeline