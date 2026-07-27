module DynamicExecutionUnit (
input logic clk,
input logic reset,
input logic enable,
input logic [31:0] currentSp,
input logic [31:0] currentPc,
input logic [2:0] currentMode,
input logic fetchFault,
input logic [8:0] instrIndex,
input logic is_Unknown_op_rd_prime_imm_funct3,
input logic is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3,
input logic is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3,
input logic is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3,
input logic is_CJType,
input logic is_CBType,
input logic is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6,
input logic is_Unknown_op_rs2_imm_funct3,
input logic is_Unknown_op_rs2_rd_rs1_funct4,
input logic is_UType,
input logic is_JType,
input logic is_IType,
input logic is_BType,
input logic is_SType,
input logic is_RType,
input logic [1:0] op,
input logic [2:0] rd_prime,
input logic [31:0] imm,
input logic [2:0] funct3,
input logic [4:0] imm_lo,
input logic [2:0] rs1_prime,
input logic [2:0] imm_hi,
input logic [2:0] rs2_prime,
input logic [4:0] rd_rs1,
input logic [10:0] jump_target,
input logic [4:0] offset_lo,
input logic [2:0] offset_hi,
input logic [1:0] funct2,
input logic [2:0] rd_rs1_prime,
input logic [5:0] funct6,
input logic [4:0] rs2,
input logic [3:0] funct4,
input logic [6:0] opcode,
input logic [4:0] rd,
input logic [4:0] rs1,
input logic [4:0] immLo,
input logic [6:0] immHi,
input logic [6:0] funct7,
input logic [31:0] memRead_data,
input logic memRead_done,
input logic memRead_valid,
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
input logic [74:0] microcodeRead_data,
input logic microcodeRead_done,
input logic microcodeRead_valid,
output logic memRead_en,
output logic [31:0] memRead_addr,
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
output logic microcodeRead_en,
output logic [8:0] microcodeRead_addr,
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
logic _currentPc_add_immState_carry;
logic _currentPc_add_immState_carry_0;
logic _currentPc_add_immState_carry_1;
logic _currentPc_add_immState_carry_2;
logic _currentPc_add_immState_carry_3;
logic _currentPc_add_immState_carry_4;
logic [31:0] _d0__out;
logic [31:0] _d1__data_add__out;
logic [31:0] _d1__out;
logic _d1__subset_31_31_data;
logic _d1__subset_31_31_rs1State;
logic _data_add__out_carry;
logic [31:0] _data_add_mopReadRegister_valueOffset;
logic _data_add_mopReadRegister_valueOffset_carry;
logic _data_add_mopReadRegister_valueOffset_carry_0;
logic [31:0] _in0;
logic [31:0] _in0_0;
logic [31:0] _in0_1;
logic [31:0] _in0_2;
logic [31:0] _in0__out;
logic [2:0] _in0__out_0;
logic [2:0] _in0__out_1;
logic [2:0] _in0__out_2;
logic [2:0] _in0__out_3;
logic [31:0] _in0__out_add__out;
logic [31:0] _in0__out_add_immState;
logic [31:0] _in0__out_add_immState_0;
logic [31:0] _in0__out_add_immState_1;
logic [31:0] _in0__out_add_immState_2;
logic [31:0] _in0__out_add_immState_3;
logic _in0__subset_31_31_data;
logic _in0__subset_31_31_rs1State;
logic [3:0] _in103__mopStep_add_const_1;
logic [3:0] _in122__mopStep_add_const_1;
logic [31:0] _in127__out_add_immState;
logic [3:0] _in143__mopStep_add_const_1;
logic [3:0] _in167__mopStep_add_const_1;
logic [31:0] _in172__out_add_immState;
logic [3:0] _in184__mopStep_add_const_1;
logic [3:0] _in199__mopStep_add_const_1;
logic [3:0] _in211__mopStep_add_const_1;
logic [3:0] _in226__mopStep_add_const_1;
logic [3:0] _in237__mopStep_add_const_1;
logic [31:0] _in241__out_add_mopWriteRegister_valueOffset;
logic [31:0] _in244__out_add_mopWriteRegister_valueOffset;
logic [3:0] _in249__mopStep_add_const_1;
logic [3:0] _in253__mopStep_add_const_1;
logic [3:0] _in257__mopStep_add_const_1;
logic [3:0] _in261__mopStep_add_const_1;
logic [3:0] _in265__mopStep_add_const_1;
logic [3:0] _in269__mopStep_add_const_1;
logic [3:0] _in273__mopStep_add_const_1;
logic [3:0] _in277__mopStep_add_const_1;
logic [3:0] _in281__mopStep_add_const_1;
logic [3:0] _in285__mopStep_add_const_1;
logic [3:0] _in289__mopStep_add_const_1;
logic [3:0] _in293__mopStep_add_const_1;
logic [3:0] _in297__mopStep_add_const_1;
logic [3:0] _in300__mopStep_add_const_1;
logic [3:0] _in304__mopStep_add_const_1;
logic [31:0] _in311__out_add_immState;
logic [31:0] _in317__out_add_immState;
logic [31:0] _in321__out_add_immState;
logic [31:0] _in327__out_add_immState;
logic [31:0] _in32__counter_add_const_1;
logic [31:0] _in331__out_add_immState;
logic [31:0] _in337__out_add_immState;
logic [31:0] _in343__out_add_immState;
logic [31:0] _in349__out_add_immState;
logic [31:0] _in354__out_add_immState;
logic [31:0] _in360__out_add_immState;
logic [31:0] _in365__out_add_immState;
logic [31:0] _in371__out_add_immState;
logic [3:0] _in401__mopStep_add_const_1;
logic [31:0] _in423__currentPc_add_immState;
logic [3:0] _in427__mopStep_add_const_1;
logic [31:0] _in431__currentPc_add_immState;
logic [3:0] _in435__mopStep_add_const_1;
logic [31:0] _in439__currentPc_add_immState;
logic [3:0] _in443__mopStep_add_const_1;
logic [31:0] _in447__currentPc_add_immState;
logic [3:0] _in451__mopStep_add_const_1;
logic [31:0] _in455__currentPc_add_immState;
logic [3:0] _in459__mopStep_add_const_1;
logic [31:0] _in463__currentPc_add_immState;
logic [3:0] _in467__mopStep_add_const_1;
logic [8:0] _in46__swizzled_add__swizzled;
logic [31:0] _in475__nextPc_add_mopWriteLinkRegister_pcOffset;
logic [3:0] _in477__mopStep_add_const_1;
logic [31:0] _in483__nextPc_add_mopWriteLinkRegister_pcOffset;
logic [3:0] _in485__mopStep_add_const_1;
logic [3:0] _in494__mopStep_add_const_1;
logic [3:0] _in510__mopStep_add_const_1;
logic [3:0] _in526__mopStep_add_const_1;
logic [3:0] _in534__mopStep_add_const_1;
logic [8:0] _in544__swizzled_add__swizzled;
logic [3:0] _in80__mopStep_add_const_1;
logic [3:0] _in98__mopStep_add_const_1;
logic _mopStep_add_const_1_carry;
logic _mopStep_add_const_1_carry_0;
logic _mopStep_add_const_1_carry_1;
logic _mopStep_add_const_1_carry_10;
logic _mopStep_add_const_1_carry_11;
logic _mopStep_add_const_1_carry_12;
logic _mopStep_add_const_1_carry_13;
logic _mopStep_add_const_1_carry_14;
logic _mopStep_add_const_1_carry_15;
logic _mopStep_add_const_1_carry_16;
logic _mopStep_add_const_1_carry_17;
logic _mopStep_add_const_1_carry_18;
logic _mopStep_add_const_1_carry_19;
logic _mopStep_add_const_1_carry_2;
logic _mopStep_add_const_1_carry_20;
logic _mopStep_add_const_1_carry_21;
logic _mopStep_add_const_1_carry_22;
logic _mopStep_add_const_1_carry_23;
logic _mopStep_add_const_1_carry_24;
logic _mopStep_add_const_1_carry_25;
logic _mopStep_add_const_1_carry_26;
logic _mopStep_add_const_1_carry_27;
logic _mopStep_add_const_1_carry_28;
logic _mopStep_add_const_1_carry_29;
logic _mopStep_add_const_1_carry_3;
logic _mopStep_add_const_1_carry_30;
logic _mopStep_add_const_1_carry_31;
logic _mopStep_add_const_1_carry_32;
logic _mopStep_add_const_1_carry_33;
logic _mopStep_add_const_1_carry_34;
logic _mopStep_add_const_1_carry_35;
logic _mopStep_add_const_1_carry_36;
logic _mopStep_add_const_1_carry_37;
logic _mopStep_add_const_1_carry_4;
logic _mopStep_add_const_1_carry_5;
logic _mopStep_add_const_1_carry_6;
logic _mopStep_add_const_1_carry_7;
logic _mopStep_add_const_1_carry_8;
logic _mopStep_add_const_1_carry_9;
logic _nextPc_add_mopWriteLinkRegister_pcOffset_carry;
logic _nextPc_add_mopWriteLinkRegister_pcOffset_carry_0;
logic [31:0] _original__out;
logic [31:0] _original__out_0;
logic [31:0] _original__out_1;
logic [31:0] _original__out_2;
logic [31:0] _original__out_3;
logic [31:0] _original__out_4;
logic [31:0] _original__out_5;
logic [31:0] _original__out_6;
logic [31:0] _original__out_7;
logic [31:0] _original__out_8;
logic [15:0] _original__subset_15_0_data;
logic [7:0] _original__subset_7_0_data;
logic [31:0] _original__swizzled_add_mopReadRegister_offset;
logic [31:0] _original__swizzled_add_mopReadRegister_offset_0;
logic [31:0] _original__swizzled_add_mopReadRegister_offset_1;
logic [31:0] _original__swizzled_add_mopWriteRegister_offset;
logic [31:0] _original__swizzled_add_mopWriteRegister_offset_0;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_0;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_1;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_10;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_11;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_12;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_13;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_14;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_2;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_3;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_4;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_5;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_6;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_7;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_8;
logic [31:0] _original__swizzled_lshift_const_32_h1f_or__swizzled_9;
logic [2:0] _out;
logic _out_add__out_carry;
logic [31:0] _out_add_immState;
logic _out_add_immState_carry;
logic _out_add_immState_carry_0;
logic _out_add_immState_carry_1;
logic _out_add_immState_carry_10;
logic _out_add_immState_carry_11;
logic _out_add_immState_carry_12;
logic _out_add_immState_carry_13;
logic _out_add_immState_carry_14;
logic _out_add_immState_carry_15;
logic _out_add_immState_carry_16;
logic _out_add_immState_carry_17;
logic _out_add_immState_carry_18;
logic _out_add_immState_carry_2;
logic _out_add_immState_carry_3;
logic _out_add_immState_carry_4;
logic _out_add_immState_carry_5;
logic _out_add_immState_carry_6;
logic _out_add_immState_carry_7;
logic _out_add_immState_carry_8;
logic _out_add_immState_carry_9;
logic _out_add_mopWriteRegister_valueOffset_carry;
logic _out_add_mopWriteRegister_valueOffset_carry_0;
logic [31:0] _shiftAmount_const_32_h1f;
logic [31:0] _shiftAmount_const_32_h1f_0;
logic [31:0] _shiftAmount_const_32_h1f_1;
logic [31:0] _shiftAmount_const_32_h1f_10;
logic [31:0] _shiftAmount_const_32_h1f_11;
logic [31:0] _shiftAmount_const_32_h1f_12;
logic [31:0] _shiftAmount_const_32_h1f_13;
logic [31:0] _shiftAmount_const_32_h1f_14;
logic [31:0] _shiftAmount_const_32_h1f_15;
logic [31:0] _shiftAmount_const_32_h1f_2;
logic [31:0] _shiftAmount_const_32_h1f_3;
logic [31:0] _shiftAmount_const_32_h1f_4;
logic [31:0] _shiftAmount_const_32_h1f_5;
logic [31:0] _shiftAmount_const_32_h1f_6;
logic [31:0] _shiftAmount_const_32_h1f_7;
logic [31:0] _shiftAmount_const_32_h1f_8;
logic [31:0] _shiftAmount_const_32_h1f_9;
logic _swizzled_add__swizzled_carry;
logic _swizzled_add__swizzled_carry_0;
logic [31:0] _swizzled_add_mopReadRegister_offset;
logic _swizzled_add_mopReadRegister_offset_carry;
logic _swizzled_add_mopReadRegister_offset_carry_0;
logic _swizzled_add_mopReadRegister_offset_carry_1;
logic _swizzled_add_mopReadRegister_offset_carry_2;
logic [31:0] _swizzled_add_mopWriteRegister_offset;
logic _swizzled_add_mopWriteRegister_offset_carry;
logic _swizzled_add_mopWriteRegister_offset_carry_0;
logic _swizzled_add_mopWriteRegister_offset_carry_1;
logic [31:0] _swizzled_lshift_const_32_h1f_or__swizzled;
logic [31:0] aluState;
logic [31:0] amoOld;
logic [31:0] immState;
logic [2:0] mopAlu_a;
logic [6:0] mopAlu_alu;
logic [2:0] mopAlu_b;
logic [4:0] mopAlu_funct;
logic [3:0] mopAtomicMemory_afunct;
logic [2:0] mopAtomicMemory_base;
logic [2:0] mopAtomicMemory_dest;
logic [4:0] mopAtomicMemory_funct;
logic [2:0] mopAtomicMemory_size;
logic [2:0] mopAtomicMemory_src;
logic [3:0] mopBranchIf_condition;
logic [4:0] mopBranchIf_funct;
logic mopBranchIf_hasField;
logic [31:0] mopBranchIf_offset;
logic [2:0] mopBranchIf_offsetField;
logic [2:0] mopBranchIf_target;
logic [2:0] mopCopyField_dest;
logic [4:0] mopCopyField_funct;
logic [2:0] mopCopyField_src;
logic [3:0] mopCount;
logic [4:0] mopFence_funct;
logic [2:0] mopFpuOp_a;
logic [2:0] mopFpuOp_b;
logic [2:0] mopFpuOp_dest;
logic mopFpuOp_doublePrecision;
logic [4:0] mopFpuOp_fpuFunct;
logic [4:0] mopFpuOp_funct;
logic mopFpuOp_hasB;
logic [4:0] mopFunct;
logic [4:0] mopInterruptHold_funct;
logic [2:0] mopLoadReserved_base;
logic [2:0] mopLoadReserved_dest;
logic [4:0] mopLoadReserved_funct;
logic [2:0] mopLoadReserved_size;
logic [2:0] mopMemLoad_base;
logic [2:0] mopMemLoad_dest;
logic [4:0] mopMemLoad_funct;
logic [2:0] mopMemLoad_size;
logic mopMemLoad_unsigned;
logic [2:0] mopMemStore_base;
logic [4:0] mopMemStore_funct;
logic [2:0] mopMemStore_size;
logic [2:0] mopMemStore_src;
logic [2:0] mopMoveToField_dest;
logic [4:0] mopMoveToField_funct;
logic [2:0] mopMoveToField_src;
logic [4:0] mopReadRegister_funct;
logic [31:0] mopReadRegister_offset;
logic [2:0] mopReadRegister_source;
logic [31:0] mopReadRegister_valueOffset;
logic [4:0] mopReturn_funct;
logic [2:0] mopReturn_privilegeLevel;
logic [3:0] mopStep;
logic [2:0] mopStoreConditional_base;
logic [2:0] mopStoreConditional_dest;
logic [4:0] mopStoreConditional_funct;
logic [2:0] mopStoreConditional_size;
logic [2:0] mopStoreConditional_src;
logic [4:0] mopTlbFence_funct;
logic [4:0] mopTlbInvalidate_funct;
logic [5:0] mopTrap_causeCode;
logic [4:0] mopTrap_funct;
logic mopTrap_isInterrupt;
logic mopUpdatePC_absolute;
logic mopUpdatePC_align;
logic [4:0] mopUpdatePC_funct;
logic mopUpdatePC_hasField;
logic mopUpdatePC_hasSource;
logic [31:0] mopUpdatePC_offset;
logic [2:0] mopUpdatePC_offsetField;
logic [2:0] mopUpdatePC_offsetSource;
logic [4:0] mopWriteLinkRegister_funct;
logic [1:0] mopWriteLinkRegister_link;
logic [31:0] mopWriteLinkRegister_pcOffset;
logic [2:0] mopWriteRegister_field;
logic [4:0] mopWriteRegister_funct;
logic [31:0] mopWriteRegister_offset;
logic [2:0] mopWriteRegister_source;
logic [31:0] mopWriteRegister_valueOffset;
logic [31:0] rdState;
logic [31:0] reservationAddr;
logic reservationValid;
logic [31:0] result;
logic [31:0] rs1State;
logic [31:0] rs2State;
assign _shiftAmount_const_32_h1f = 32'h1f;
assign _shiftAmount_const_32_h1f_0 = 32'h1f;
assign _shiftAmount_const_32_h1f_1 = 32'h1f;
assign _shiftAmount_const_32_h1f_2 = 32'h1f;
assign _shiftAmount_const_32_h1f_3 = 32'h1f;
assign _shiftAmount_const_32_h1f_4 = 32'h1f;
assign _shiftAmount_const_32_h1f_5 = 32'h1f;
assign _shiftAmount_const_32_h1f_6 = 32'h1f;
assign _shiftAmount_const_32_h1f_7 = 32'h1f;
assign _shiftAmount_const_32_h1f_8 = 32'h1f;
assign _shiftAmount_const_32_h1f_9 = 32'h1f;
assign _shiftAmount_const_32_h1f_10 = 32'h1f;
assign _shiftAmount_const_32_h1f_11 = 32'h1f;
assign _shiftAmount_const_32_h1f_12 = 32'h1f;
assign _shiftAmount_const_32_h1f_13 = 32'h1f;
assign _shiftAmount_const_32_h1f_14 = 32'h1f;
assign _shiftAmount_const_32_h1f_15 = 32'h1f;
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      aluState <= 32'h0;
      mopStep <= 4'h0;
      done <= 1'h0;
      trap <= 1'h0;
      trapEpc <= currentPc;
      isReturn <= 1'h0;
      returnLevel <= 3'h0;
      memGuest <= 1'h0;
      reservationValid <= 1'h0;
      amoOld <= 32'h0;
      rs1Read_en <= 1'h0;
      rs1Read_addr <= 5'h0;
      rs2Read_en <= 1'h0;
      rs2Read_addr <= 5'h0;
      rdWrite_en <= 1'h0;
      rdWrite_addr <= 5'h0;
      rdWrite_data <= 32'h0;
      memRead_en <= 1'h0;
      memRead_addr <= 32'h0;
      memWrite_en <= 1'h0;
      memWrite_addr <= 32'h0;
      memWrite_data <= 39'h0;
      microcodeRead_en <= 1'h0;
      microcodeRead_addr <= 9'h0;
      fence <= 1'h0;
      interruptHold <= 1'h0;
      nextPc <= currentPc;
      nextSp <= currentSp;
      nextMode <= 3'h3;
      counter <= 32'h0;
  end   else begin
      if(enable) begin
          counter <= _in32__counter_add_const_1;
          nextMode <= currentMode;
          trap <= 1'h0;
          trapEpc <= currentPc;
          isReturn <= 1'h0;
          returnLevel <= 3'h0;
          memGuest <= 1'h0;
          if(fetchFault) begin
              trapCause <= (_swizzled_lshift_const_32_h1f_or__swizzled[5:0]);
              trapTval <= currentPc;
              trapEpc <= currentPc;
              trap <= 1'h1;
              done <= 1'h1;
              valid <= 1'h1;
          end           else begin
              if((mopStep == 4'h0)) begin
                  microcodeRead_en <= 1'h1;
                  microcodeRead_addr <= _in46__swizzled_add__swizzled;
                  done <= 1'h0;
                  valid <= 1'h0;
                  if((microcodeRead_done & microcodeRead_valid)) begin
                      mopCount <= (microcodeRead_data[3:0]);
                      aluState <= 32'h0;
                      fence <= 1'h0;
                      rs1State <= ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
});
                      rs2State <= ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
});
                      rdState <= ({
27'h0, /* 31:5 */
rd  /*  4:0 */
});
                      immState <= (imm);
                      mopStep <= 4'h1;
                      microcodeRead_en <= 1'h0;
                  end 

                  if((microcodeRead_done & (~microcodeRead_valid))) begin
                      done <= 1'h1;
                      valid <= 1'h0;
                      microcodeRead_en <= 1'h0;
                  end 

              end               else if(rs1Read_en) begin
                  case (mopFunct) 
                      5'h2 : begin
                          if((rs1Read_done & rs1Read_valid)) begin
                              case (mopReadRegister_source) 
                                  3'h0 : begin
                                      rdState <= (_data_add_mopReadRegister_valueOffset);
                                  end
                                  3'h1 : begin
                                      rs1State <= (_data_add_mopReadRegister_valueOffset);
                                  end
                                  3'h2 : begin
                                      rs2State <= (_data_add_mopReadRegister_valueOffset);
                                  end
                                  3'h4 : begin
                                      immState <= (_data_add_mopReadRegister_valueOffset);
                                  end
                                  3'h5 : begin
                                      nextSp <= (_data_add_mopReadRegister_valueOffset);
                                  end
                                  default : begin
                                      done <= 1'h1;
                                      valid <= 1'h0;
                                  end
                              endcase

                              mopStep <= _in80__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                              rs1Read_en <= 1'h0;
                          end 

                      end
                  endcase

              end               else if(rs2Read_en) begin
                  case (mopFunct) 
                      5'h2 : begin
                          if((rs2Read_done & rs2Read_valid)) begin
                              case (mopReadRegister_source) 
                                  3'h0 : begin
                                      rdState <= (_in0_1);
                                  end
                                  3'h1 : begin
                                      rs1State <= (_in0_1);
                                  end
                                  3'h2 : begin
                                      rs2State <= (_in0_1);
                                  end
                                  3'h4 : begin
                                      immState <= (_in0_1);
                                  end
                                  3'h5 : begin
                                      nextSp <= (_in0_1);
                                  end
                                  default : begin
                                      done <= 1'h1;
                                      valid <= 1'h0;
                                  end
                              endcase

                              mopStep <= _in98__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                              rs2Read_en <= 1'h0;
                          end 

                      end
                  endcase

              end               else if(rdWrite_en) begin
                  if((rdWrite_done & rdWrite_valid)) begin
                      mopStep <= _in103__mopStep_add_const_1;
                      microcodeRead_en <= 1'h0;
                      rdWrite_en <= 1'h0;
                  end 

              end               else if(memRead_en) begin
                  case (mopFunct) 
                      5'h8 : begin
                          if((memRead_done & memRead_valid)) begin
                              case (mopMemLoad_dest) 
                                  3'h0 : begin
                                      rdState <= (_in0_0);
                                  end
                                  3'h1 : begin
                                      rs1State <= (_in0_0);
                                  end
                                  3'h2 : begin
                                      rs2State <= (_in0_0);
                                  end
                                  3'h4 : begin
                                      immState <= (_in0_0);
                                  end
                                  3'h5 : begin
                                      nextSp <= (_in0_0);
                                  end
                                  default : begin
                                      done <= 1'h1;
                                      valid <= 1'h0;
                                  end
                              endcase

                              mopStep <= _in122__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                              memRead_en <= 1'h0;
                          end 

                          if((memRead_done & (~memRead_valid))) begin
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_0[5:0]);
                              trapTval <= _in127__out_add_immState;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end 

                      end
                      5'h11 : begin
                          if((memRead_done & memRead_valid)) begin
                              reservationValid <= 1'h1;
                              reservationAddr <= memRead_addr;
                              memRead_en <= 1'h0;
                              case (mopLoadReserved_size) 
                                  3'h2 : begin
                                      if(((_original__out_1[4:0]) > 5'h0)) begin
                                          rdWrite_addr <= (_original__out_2[4:0]);
                                          rdWrite_data <= memRead_data;
                                          rdWrite_en <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in143__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                              endcase

                          end 

                          if((memRead_done & (~memRead_valid))) begin
                              memRead_en <= 1'h0;
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_1[5:0]);
                              trapTval <= _in0__out;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end 

                      end
                      5'h13 : begin
                          if((memRead_done & memRead_valid)) begin
                              amoOld <= memRead_data;
                              memWrite_en <= 1'h1;
                              memWrite_addr <= memRead_addr;
                              memWrite_data <= ({
7'h4, /* 38:32 */
(((mopAtomicMemory_afunct == 4'h0) ? _d1__data_add__out : ((mopAtomicMemory_afunct == 4'h1) ? _d0__out : ((mopAtomicMemory_afunct == 4'h2) ? (memRead_data ^ _d0__out) : ((mopAtomicMemory_afunct == 4'h3) ? (memRead_data & _d0__out) : ((mopAtomicMemory_afunct == 4'h4) ? (memRead_data | _d0__out) : ((mopAtomicMemory_afunct == 4'h5) ? (((_d1__subset_31_31_data ^ (_d0__out[31])) ? _d1__subset_31_31_data : (memRead_data < _d0__out)) ? memRead_data : _d0__out) : ((mopAtomicMemory_afunct == 4'h6) ? (((_in0__subset_31_31_data ^ (_d0__out[31])) ? _in0__subset_31_31_data : (memRead_data < _d0__out)) ? _d0__out : memRead_data) : ((mopAtomicMemory_afunct == 4'h7) ? ((memRead_data < _d0__out) ? memRead_data : _d0__out) : ((mopAtomicMemory_afunct == 4'h8) ? ((memRead_data < _d0__out) ? _d0__out : memRead_data) : _d0__out))))))))))  /* 31: 0 */
});
                              memRead_en <= 1'h0;
                          end 

                          if((memRead_done & (~memRead_valid))) begin
                              memRead_en <= 1'h0;
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_2[5:0]);
                              trapTval <= _in0__out;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end 

                      end
                  endcase

              end               else if(memWrite_en) begin
                  case (mopFunct) 
                      5'h9 : begin
                          if((memWrite_done & memWrite_valid)) begin
                              memWrite_en <= 1'h0;
                              mopStep <= _in167__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                          end 

                          if((memWrite_done & (~memWrite_valid))) begin
                              memWrite_en <= 1'h0;
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_3[5:0]);
                              trapTval <= _in172__out_add_immState;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end 

                      end
                      5'h13 : begin
                          if((memWrite_done & memWrite_valid)) begin
                              memWrite_en <= 1'h0;
                              if(((_original__out_3[4:0]) > 5'h0)) begin
                                  rdWrite_addr <= (_original__out_4[4:0]);
                                  rdWrite_data <= ((mopFunct == 5'h13) ? amoOld : 32'h0);
                                  rdWrite_en <= 1'h1;
                              end                               else begin
                                  mopStep <= _in184__mopStep_add_const_1;
                                  microcodeRead_en <= 1'h0;
                              end 

                          end 

                          if((memWrite_done & (~memWrite_valid))) begin
                              memWrite_en <= 1'h0;
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_4[5:0]);
                              trapTval <= _in0__out;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end 

                      end
                      5'h12 : begin
                          if((memWrite_done & memWrite_valid)) begin
                              memWrite_en <= 1'h0;
                              if(((_original__out_5[4:0]) > 5'h0)) begin
                                  rdWrite_addr <= (_original__out_6[4:0]);
                                  rdWrite_data <= ((mopFunct == 5'h13) ? amoOld : 32'h0);
                                  rdWrite_en <= 1'h1;
                              end                               else begin
                                  mopStep <= _in199__mopStep_add_const_1;
                                  microcodeRead_en <= 1'h0;
                              end 

                          end 

                          if((memWrite_done & (~memWrite_valid))) begin
                              memWrite_en <= 1'h0;
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_5[5:0]);
                              trapTval <= _in0__out;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end 

                      end
                  endcase

              end               else if(((mopStep - 4'h1) < mopCount)) begin
                  if((microcodeRead_done & microcodeRead_valid)) begin
                      case (mopFunct) 
                          5'h2 : begin
                              if(((_original__swizzled_add_mopReadRegister_offset[4:0]) == 5'h0)) begin
                                  mopStep <= _in211__mopStep_add_const_1;
                                  microcodeRead_en <= 1'h0;
                              end                               else if(((_swizzled_add_mopReadRegister_offset[4:0]) == 5'h2)) begin
                                  case (mopReadRegister_source) 
                                      3'h0 : begin
                                          rdState <= (currentSp);
                                      end
                                      3'h1 : begin
                                          rs1State <= (currentSp);
                                      end
                                      3'h2 : begin
                                          rs2State <= (currentSp);
                                      end
                                      3'h4 : begin
                                          immState <= (currentSp);
                                      end
                                      3'h5 : begin
                                          nextSp <= (currentSp);
                                      end
                                      default : begin
                                          done <= 1'h1;
                                          valid <= 1'h0;
                                      end
                                  endcase

                                  mopStep <= _in226__mopStep_add_const_1;
                                  microcodeRead_en <= 1'h0;
                              end                               else begin
                                  if((mopReadRegister_source == 3'h3)) begin
                                      rs2Read_en <= 1'h1;
                                      rs2Read_addr <= (_original__swizzled_add_mopReadRegister_offset_0[4:0]);
                                  end                                   else begin
                                      rs1Read_en <= 1'h1;
                                      rs1Read_addr <= (_original__swizzled_add_mopReadRegister_offset_1[4:0]);
                                  end 

                              end 

                          end
                          5'h3 : begin
                              if(((_original__swizzled_add_mopWriteRegister_offset[4:0]) == 5'h0)) begin
                                  mopStep <= _in237__mopStep_add_const_1;
                                  microcodeRead_en <= 1'h0;
                              end                               else begin
                                  if(((_swizzled_add_mopWriteRegister_offset[4:0]) == 5'h2)) begin
                                      nextSp <= _in241__out_add_mopWriteRegister_valueOffset;
                                  end 

                                  rdWrite_en <= 1'h1;
                                  rdWrite_addr <= (_original__swizzled_add_mopWriteRegister_offset_0[4:0]);
                                  rdWrite_data <= _in244__out_add_mopWriteRegister_valueOffset;
                              end 

                          end
                          5'h5 : begin
                              case (mopAlu_alu) 
                                  7'ha : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in249__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h17 : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in253__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'hb : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in257__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'hc : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in261__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'hd : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in265__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'he : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in269__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'hf : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in273__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h19 : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in277__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h18 : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in281__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h10 : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in285__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h11 : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in289__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h1b : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in293__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  7'h1a : begin
                                      aluState <= 32'h0;
                                      mopStep <= _in297__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                                  default : begin
                                      aluState <= result;
                                      mopStep <= _in300__mopStep_add_const_1;
                                      microcodeRead_en <= 1'h0;
                                  end
                              endcase

                          end
                          5'h7 : begin
                              nextPc <= (_in0__out_add__out & (~(mopUpdatePC_align ? 32'h1 : 32'h0)));
                              mopStep <= _in304__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                          end
                          5'h8 : begin
                              case (mopMemLoad_size) 
                                  3'h0 : begin
                                      if(((_in0__out_add_immState & 32'h0) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_6[5:0]);
                                          trapTval <= _in311__out_add_immState;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memRead_en <= 1'h1;
                                          memRead_addr <= _in317__out_add_immState;
                                      end 

                                  end
                                  3'h1 : begin
                                      if(((_out_add_immState & 32'h1) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_7[5:0]);
                                          trapTval <= _in321__out_add_immState;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memRead_en <= 1'h1;
                                          memRead_addr <= _in327__out_add_immState;
                                      end 

                                  end
                                  3'h2 : begin
                                      if(((_in0__out_add_immState_0 & 32'h3) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_8[5:0]);
                                          trapTval <= _in331__out_add_immState;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memRead_en <= 1'h1;
                                          memRead_addr <= _in337__out_add_immState;
                                      end 

                                  end
                              endcase

                          end
                          5'h9 : begin
                              case (mopMemStore_size) 
                                  3'h0 : begin
                                      if(((_in0__out_add_immState_1 & 32'h0) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_9[5:0]);
                                          trapTval <= _in343__out_add_immState;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memWrite_en <= 1'h1;
                                          memWrite_addr <= _in349__out_add_immState;
                                          memWrite_data <= ({
(7'h1 << mopMemStore_size), /* 38:32 */
_in0  /* 31: 0 */
});
                                      end 

                                  end
                                  3'h1 : begin
                                      if(((_in0__out_add_immState_2 & 32'h1) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_10[5:0]);
                                          trapTval <= _in354__out_add_immState;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memWrite_en <= 1'h1;
                                          memWrite_addr <= _in360__out_add_immState;
                                          memWrite_data <= ({
(7'h1 << mopMemStore_size), /* 38:32 */
_in0  /* 31: 0 */
});
                                      end 

                                  end
                                  3'h2 : begin
                                      if(((_in0__out_add_immState_3 & 32'h3) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_11[5:0]);
                                          trapTval <= _in365__out_add_immState;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memWrite_en <= 1'h1;
                                          memWrite_addr <= _in371__out_add_immState;
                                          memWrite_data <= ({
(7'h1 << mopMemStore_size), /* 38:32 */
_in0  /* 31: 0 */
});
                                      end 

                                  end
                              endcase

                          end
                          5'h11 : begin
                              case (mopLoadReserved_size) 
                                  3'h2 : begin
                                      if(((_in0__out & 32'h3) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_12[5:0]);
                                          trapTval <= _in0__out;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memRead_en <= 1'h1;
                                          memRead_addr <= _in0__out;
                                      end 

                                  end
                              endcase

                          end
                          5'h12 : begin
                              case (mopStoreConditional_size) 
                                  3'h2 : begin
                                      if(((_in0__out & 32'h3) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_13[5:0]);
                                          trapTval <= _in0__out;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          reservationValid <= 1'h0;
                                          if((reservationValid & (reservationAddr == _in0__out))) begin
                                              memWrite_en <= 1'h1;
                                              memWrite_addr <= _in0__out;
                                              memWrite_data <= ({
7'h4, /* 38:32 */
_in0  /* 31: 0 */
});
                                          end                                           else begin
                                              if(((_original__out_7[4:0]) > 5'h0)) begin
                                                  rdWrite_addr <= (_original__out_8[4:0]);
                                                  rdWrite_data <= 32'h1;
                                                  rdWrite_en <= 1'h1;
                                              end                                               else begin
                                                  mopStep <= _in401__mopStep_add_const_1;
                                                  microcodeRead_en <= 1'h0;
                                              end 

                                          end 

                                      end 

                                  end
                              endcase

                          end
                          5'h13 : begin
                              case (mopAtomicMemory_size) 
                                  3'h2 : begin
                                      if(((_in0__out & 32'h3) != 32'h0)) begin
                                          trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled_14[5:0]);
                                          trapTval <= _in0__out;
                                          trapEpc <= currentPc;
                                          trap <= 1'h1;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          memRead_en <= 1'h1;
                                          memRead_addr <= _in0__out;
                                      end 

                                  end
                              endcase

                          end
                          5'ha : begin
                              trapCause <= (_original__swizzled_lshift_const_32_h1f_or__swizzled[5:0]);
                              trapTval <= 32'h0;
                              trapEpc <= currentPc;
                              trap <= 1'h1;
                              done <= 1'h1;
                              valid <= 1'h1;
                          end
                          5'h6 : begin
                              case (mopBranchIf_condition) 
                                  4'h0 : begin
                                      if((rs1State == rs2State)) begin
                                          nextPc <= _in423__currentPc_add_immState;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in427__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                                  4'h1 : begin
                                      if((rs1State != rs2State)) begin
                                          nextPc <= _in431__currentPc_add_immState;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in435__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                                  4'h2 : begin
                                      if(((_d1__subset_31_31_rs1State ^ (rs2State[31])) ? _d1__subset_31_31_rs1State : (rs1State < rs2State))) begin
                                          nextPc <= _in439__currentPc_add_immState;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in443__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                                  4'h3 : begin
                                      if((~((_in0__subset_31_31_rs1State ^ (rs2State[31])) ? _in0__subset_31_31_rs1State : (rs1State < rs2State)))) begin
                                          nextPc <= _in447__currentPc_add_immState;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in451__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                                  4'h4 : begin
                                      if((rs1State < rs2State)) begin
                                          nextPc <= _in455__currentPc_add_immState;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in459__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                                  4'h5 : begin
                                      if((~(rs1State < rs2State))) begin
                                          nextPc <= _in463__currentPc_add_immState;
                                          done <= 1'h1;
                                          valid <= 1'h1;
                                      end                                       else begin
                                          mopStep <= _in467__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                              endcase

                          end
                          5'hf : begin
                              case (mopWriteLinkRegister_link) 
                                  2'h0 : begin
                                      if(((_original__out[4:0]) != 5'h0)) begin
                                          rdWrite_en <= 1'h1;
                                          rdWrite_addr <= (_original__out_0[4:0]);
                                          rdWrite_data <= _in475__nextPc_add_mopWriteLinkRegister_pcOffset;
                                      end                                       else begin
                                          mopStep <= _in477__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                                  2'h1 : begin
                                      if((5'h1 != 5'h0)) begin
                                          rdWrite_en <= 1'h1;
                                          rdWrite_addr <= 5'h1;
                                          rdWrite_data <= _in483__nextPc_add_mopWriteLinkRegister_pcOffset;
                                      end                                       else begin
                                          mopStep <= _in485__mopStep_add_const_1;
                                          microcodeRead_en <= 1'h0;
                                      end 

                                  end
                              endcase

                          end
                          5'hd : begin
                              rs1Read_en <= 1'h0;
                              rs2Read_en <= 1'h0;
                              memRead_en <= 1'h0;
                              memWrite_en <= 1'h0;
                              rdWrite_en <= 1'h0;
                              fence <= 1'h1;
                              mopStep <= _in494__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                          end
                          5'h17 : begin
                              case (mopCopyField_dest) 
                                  3'h0 : begin
                                      rdState <= (_d1__out);
                                  end
                                  3'h1 : begin
                                      rs1State <= (_d1__out);
                                  end
                                  3'h2 : begin
                                      rs2State <= (_d1__out);
                                  end
                                  3'h4 : begin
                                      immState <= (_d1__out);
                                  end
                                  3'h5 : begin
                                      nextSp <= (_d1__out);
                                  end
                                  default : begin
                                      done <= 1'h1;
                                      valid <= 1'h0;
                                  end
                              endcase

                              mopStep <= _in510__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                          end
                          5'h18 : begin
                              case (mopMoveToField_dest) 
                                  3'h0 : begin
                                      rdState <= (_in0_2);
                                  end
                                  3'h1 : begin
                                      rs1State <= (_in0_2);
                                  end
                                  3'h2 : begin
                                      rs2State <= (_in0_2);
                                  end
                                  3'h4 : begin
                                      immState <= (_in0_2);
                                  end
                                  3'h5 : begin
                                      nextSp <= (_in0_2);
                                  end
                                  default : begin
                                      done <= 1'h1;
                                      valid <= 1'h0;
                                  end
                              endcase

                              mopStep <= _in526__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                          end
                          5'he : begin
                              isReturn <= 1'h1;
                              returnLevel <= (mopReturn_privilegeLevel);
                              done <= 1'h1;
                              valid <= 1'h1;
                          end
                          5'h14 : begin
                              mopStep <= _in534__mopStep_add_const_1;
                              microcodeRead_en <= 1'h0;
                          end
                          5'h0 : begin

                          end
                          default : begin
                              done <= 1'h1;
                              valid <= 1'h0;
                          end
                      endcase

                  end 

                  if(((microcodeRead_en & microcodeRead_done) & (~microcodeRead_valid))) begin
                      done <= 1'h1;
                      valid <= 1'h0;
                  end 

                  if((~microcodeRead_en)) begin
                      microcodeRead_en <= 1'h1;
                      microcodeRead_addr <= _in544__swizzled_add__swizzled;
                  end 

              end               else begin
                  done <= 1'h1;
                  valid <= 1'h1;
              end 

          end 

      end       else begin
          aluState <= 32'h0;
          mopStep <= 4'h0;
          done <= 1'h0;
          rs1Read_en <= 1'h0;
          rs1Read_addr <= 5'h0;
          rs2Read_en <= 1'h0;
          rs2Read_addr <= 5'h0;
          rdWrite_en <= 1'h0;
          rdWrite_addr <= 5'h0;
          rdWrite_data <= 32'h0;
          memRead_en <= 1'h0;
          memRead_addr <= 32'h0;
          memWrite_en <= 1'h0;
          memWrite_addr <= 32'h0;
          memWrite_data <= 39'h0;
          microcodeRead_en <= 1'h0;
          microcodeRead_addr <= 9'h0;
          fence <= 1'h0;
          interruptHold <= 1'h0;
          nextPc <= currentPc;
          nextSp <= currentSp;
          nextMode <= currentMode;
          trap <= 1'h0;
          trapEpc <= currentPc;
          isReturn <= 1'h0;
          returnLevel <= 3'h0;
          memGuest <= 1'h0;
      end 

  end 

end

assign _in0_2 = (_in0__out_0 == 3'h1) ? immState : ((_in0__out_0 == 3'h0) ? aluState : ((_in0__out_0 == 3'h2) ? rs1State : ((_in0__out_0 == 3'h3) ? rs2State : ((_in0__out_0 == 3'h5) ? rdState : nextPc))));  // mux_0
assign {_out_add_mopWriteRegister_valueOffset_carry, _in241__out_add_mopWriteRegister_valueOffset} = _in0_2 + mopWriteRegister_valueOffset;
assign {_out_add_mopWriteRegister_valueOffset_carry_0, _in244__out_add_mopWriteRegister_valueOffset} = _in0_2 + mopWriteRegister_valueOffset;
assign mopWriteRegister_valueOffset = microcodeRead_data[74:43];  // bussubset
assign mopReadRegister_funct = microcodeRead_data[4:0];  // bussubset_0
assign mopReadRegister_source = microcodeRead_data[7:5];  // bussubset_1
assign {_swizzled_add_mopReadRegister_offset_carry, _original__swizzled_add_mopReadRegister_offset} = (((mopReadRegister_source == 3'h0) ? (rdState) : ((mopReadRegister_source == 3'h1) ? (rs1State) : ((mopReadRegister_source == 3'h2) ? (rs2State) : ((mopReadRegister_source == 3'h4) ? immState : ((mopReadRegister_source == 3'h5) ? nextPc : nextSp)))))) + mopReadRegister_offset;
assign {_swizzled_add_mopReadRegister_offset_carry_0, _swizzled_add_mopReadRegister_offset} = (((mopReadRegister_source == 3'h0) ? (rdState) : ((mopReadRegister_source == 3'h1) ? (rs1State) : ((mopReadRegister_source == 3'h2) ? (rs2State) : ((mopReadRegister_source == 3'h4) ? immState : ((mopReadRegister_source == 3'h5) ? nextPc : nextSp)))))) + mopReadRegister_offset;
MicrocodeAlu  microcode_alu(.a(((mopAlu_a == 3'h0) ? (rdState) : ((mopAlu_a == 3'h1) ? (rs1State) : ((mopAlu_a == 3'h2) ? (rs2State) : ((mopAlu_a == 3'h4) ? immState : ((mopAlu_a == 3'h5) ? nextPc : nextSp)))))),.b(((mopAlu_b == 3'h0) ? (rdState) : ((mopAlu_b == 3'h1) ? (rs1State) : ((mopAlu_b == 3'h2) ? (rs2State) : ((mopAlu_b == 3'h4) ? immState : ((mopAlu_b == 3'h5) ? nextPc : nextSp)))))),.funct(mopAlu_alu),.result(result));
assign _in0__out = (_in0__out_3 == 3'h0) ? (rdState) : ((_in0__out_3 == 3'h1) ? (rs1State) : ((_in0__out_3 == 3'h2) ? (rs2State) : ((_in0__out_3 == 3'h4) ? immState : ((_in0__out_3 == 3'h5) ? nextPc : nextSp))));  // mux_18
assign {_out_add_immState_carry, _in127__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_0, _in172__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_1, _in0__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_2, _in311__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_3, _in317__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_4, _out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_5, _in321__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_6, _in327__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_7, _in0__out_add_immState_0} = _in0__out + immState;
assign {_out_add_immState_carry_8, _in331__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_9, _in337__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_10, _in0__out_add_immState_1} = _in0__out + immState;
assign {_out_add_immState_carry_11, _in343__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_12, _in349__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_13, _in0__out_add_immState_2} = _in0__out + immState;
assign {_out_add_immState_carry_14, _in354__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_15, _in360__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_16, _in0__out_add_immState_3} = _in0__out + immState;
assign {_out_add_immState_carry_17, _in365__out_add_immState} = _in0__out + immState;
assign {_out_add_immState_carry_18, _in371__out_add_immState} = _in0__out + immState;
assign _in0__out_3 = (mopFunct == 5'h8) ? mopMemLoad_base : ((mopFunct == 5'h9) ? mopMemStore_base : ((mopFunct == 5'h11) ? mopLoadReserved_base : ((mopFunct == 5'h12) ? mopStoreConditional_base : mopAtomicMemory_base)));  // mux_19
assign mopAtomicMemory_base = microcodeRead_data[11:9];  // bussubset_4
assign mopStoreConditional_base = microcodeRead_data[7:5];  // bussubset_5
assign mopLoadReserved_base = microcodeRead_data[7:5];  // bussubset_6
assign mopMemStore_base = microcodeRead_data[7:5];  // bussubset_7
assign _out = (mopFunct == 5'h9) ? mopMemStore_src : mopStoreConditional_src;  // mux_23
assign _in0 = (_out == 3'h0) ? (rdState) : ((_out == 3'h1) ? (rs1State) : ((_out == 3'h2) ? (rs2State) : ((_out == 3'h4) ? immState : ((_out == 3'h5) ? nextPc : nextSp))));  // mux_24
assign mopMemStore_size = microcodeRead_data[13:11];  // bussubset_8
assign _in0__out_0 = (mopFunct == 5'h7) ? mopUpdatePC_offsetSource : ((mopFunct == 5'h18) ? mopMoveToField_src : mopWriteRegister_source);  // mux_30
assign mopWriteRegister_source = microcodeRead_data[10:8];  // bussubset_9
assign mopMoveToField_src = microcodeRead_data[7:5];  // bussubset_10
assign mopUpdatePC_offsetSource = microcodeRead_data[46:44];  // bussubset_11
assign _d1__out = (_in0__out_1 == 3'h0) ? (rdState) : ((_in0__out_1 == 3'h1) ? (rs1State) : ((_in0__out_1 == 3'h2) ? (rs2State) : ((_in0__out_1 == 3'h4) ? immState : ((_in0__out_1 == 3'h5) ? nextPc : nextSp))));  // mux_34
assign {_out_add__out_carry, _in0__out_add__out} = (mopUpdatePC_absolute ? 32'h0 : currentPc) + (mopUpdatePC_hasField ? _d1__out : (mopUpdatePC_hasSource ? _in0_2 : mopUpdatePC_offset));
assign mopUpdatePC_align = microcodeRead_data[6];  // bussubset_12
assign mopUpdatePC_absolute = microcodeRead_data[5];  // bussubset_13
assign mopUpdatePC_hasField = microcodeRead_data[7];  // bussubset_14
assign mopUpdatePC_hasSource = microcodeRead_data[8];  // bussubset_15
assign mopUpdatePC_offset = microcodeRead_data[40:9];  // bussubset_16
assign _in0__out_1 = (mopFunct == 5'h7) ? mopUpdatePC_offsetField : mopCopyField_src;  // mux_39
assign mopCopyField_src = microcodeRead_data[7:5];  // bussubset_17
assign mopUpdatePC_offsetField = microcodeRead_data[43:41];  // bussubset_18
assign _d0__out = (mopAtomicMemory_src == 3'h0) ? (rdState) : ((mopAtomicMemory_src == 3'h1) ? (rs1State) : ((mopAtomicMemory_src == 3'h2) ? (rs2State) : ((mopAtomicMemory_src == 3'h4) ? immState : ((mopAtomicMemory_src == 3'h5) ? nextPc : nextSp))));  // mux_44
assign {_data_add__out_carry, _d1__data_add__out} = memRead_data + _d0__out;
assign _d1__subset_31_31_data = memRead_data[31];  // bussubset_19
assign _in0__subset_31_31_data = memRead_data[31];  // bussubset_21
assign _in0_0 = (mopMemLoad_size == 3'h2) ? (mopMemLoad_unsigned ? (memRead_data) : memRead_data) : ((mopMemLoad_size == 3'h1) ? (mopMemLoad_unsigned ? ({
16'h0, /* 31:16 */
(memRead_data[15:0])  /* 15: 0 */
}) : ({
({16{(_original__subset_15_0_data[15])}}), /* 31:16 */
_original__subset_15_0_data  /* 15: 0 */
})) : (mopMemLoad_unsigned ? ({
24'h0, /* 31:8 */
(memRead_data[7:0])  /*  7:0 */
}) : ({
({24{(_original__subset_7_0_data[7])}}), /* 31:8 */
_original__subset_7_0_data  /*  7:0 */
})));  // mux_62
assign mopMemLoad_size = microcodeRead_data[13:11];  // bussubset_24
assign _original__subset_15_0_data = memRead_data[15:0];  // bussubset_25
assign mopMemLoad_unsigned = microcodeRead_data[14];  // bussubset_28
assign _original__subset_7_0_data = memRead_data[7:0];  // bussubset_29
assign mopAtomicMemory_afunct = microcodeRead_data[8:5];  // bussubset_31
assign mopAtomicMemory_src = microcodeRead_data[14:12];  // bussubset_32
assign _original__out = (3'h5 == 3'h1) ? immState : ((3'h5 == 3'h0) ? aluState : ((3'h5 == 3'h2) ? rs1State : ((3'h5 == 3'h3) ? rs2State : ((3'h5 == 3'h5) ? rdState : nextPc))));  // mux_73
assign _original__out_0 = (3'h5 == 3'h1) ? immState : ((3'h5 == 3'h0) ? aluState : ((3'h5 == 3'h2) ? rs1State : ((3'h5 == 3'h3) ? rs2State : ((3'h5 == 3'h5) ? rdState : nextPc))));  // mux_78
assign _d1__subset_31_31_rs1State = rs1State[31];  // bussubset_35
assign _in0__subset_31_31_rs1State = rs1State[31];  // bussubset_37
assign mopStoreConditional_src = microcodeRead_data[10:8];  // bussubset_39
assign mopMemStore_src = microcodeRead_data[10:8];  // bussubset_40
assign _in0__out_2 = (mopFunct == 5'h13) ? mopAtomicMemory_dest : ((mopFunct == 5'h12) ? mopStoreConditional_dest : mopLoadReserved_dest);  // mux_86
assign _original__out_1 = (_in0__out_2 == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((_in0__out_2 == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((_in0__out_2 == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((_in0__out_2 == 3'h4) ? imm : ((_in0__out_2 == 3'h5) ? nextPc : nextSp))));  // mux_87
assign _original__out_2 = (_in0__out_2 == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((_in0__out_2 == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((_in0__out_2 == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((_in0__out_2 == 3'h4) ? imm : ((_in0__out_2 == 3'h5) ? nextPc : nextSp))));  // mux_92
assign _original__out_3 = (_in0__out_2 == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((_in0__out_2 == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((_in0__out_2 == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((_in0__out_2 == 3'h4) ? imm : ((_in0__out_2 == 3'h5) ? nextPc : nextSp))));  // mux_97
assign _original__out_4 = (_in0__out_2 == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((_in0__out_2 == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((_in0__out_2 == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((_in0__out_2 == 3'h4) ? imm : ((_in0__out_2 == 3'h5) ? nextPc : nextSp))));  // mux_102
assign _original__out_5 = (_in0__out_2 == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((_in0__out_2 == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((_in0__out_2 == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((_in0__out_2 == 3'h4) ? imm : ((_in0__out_2 == 3'h5) ? nextPc : nextSp))));  // mux_107
assign _original__out_6 = (_in0__out_2 == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((_in0__out_2 == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((_in0__out_2 == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((_in0__out_2 == 3'h4) ? imm : ((_in0__out_2 == 3'h5) ? nextPc : nextSp))));  // mux_112
assign mopAtomicMemory_dest = microcodeRead_data[17:15];  // bussubset_47
assign mopLoadReserved_dest = microcodeRead_data[10:8];  // bussubset_48
assign _original__out_7 = (mopStoreConditional_dest == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopStoreConditional_dest == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopStoreConditional_dest == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopStoreConditional_dest == 3'h4) ? imm : ((mopStoreConditional_dest == 3'h5) ? nextPc : nextSp))));  // mux_117
assign _original__out_8 = (mopStoreConditional_dest == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopStoreConditional_dest == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopStoreConditional_dest == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopStoreConditional_dest == 3'h4) ? imm : ((mopStoreConditional_dest == 3'h5) ? nextPc : nextSp))));  // mux_122
assign mopStoreConditional_dest = microcodeRead_data[13:11];  // bussubset_51
assign mopFunct = microcodeRead_data[4:0];  // bussubset_52
assign mopMemLoad_base = microcodeRead_data[7:5];  // bussubset_53
assign mopAlu_b = microcodeRead_data[17:15];  // bussubset_54
assign mopAlu_alu = microcodeRead_data[11:5];  // bussubset_55
assign mopAlu_a = microcodeRead_data[14:12];  // bussubset_56
assign {_currentPc_add_immState_carry, _in423__currentPc_add_immState} = currentPc + immState;
assign {_currentPc_add_immState_carry_0, _in431__currentPc_add_immState} = currentPc + immState;
assign {_currentPc_add_immState_carry_1, _in439__currentPc_add_immState} = currentPc + immState;
assign {_currentPc_add_immState_carry_2, _in447__currentPc_add_immState} = currentPc + immState;
assign {_currentPc_add_immState_carry_3, _in455__currentPc_add_immState} = currentPc + immState;
assign {_currentPc_add_immState_carry_4, _in463__currentPc_add_immState} = currentPc + immState;
assign {_swizzled_add_mopReadRegister_offset_carry_1, _original__swizzled_add_mopReadRegister_offset_0} = (((mopReadRegister_source == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopReadRegister_source == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopReadRegister_source == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopReadRegister_source == 3'h4) ? imm : ((mopReadRegister_source == 3'h5) ? nextPc : nextSp)))))) + mopReadRegister_offset;
assign {_swizzled_add_mopReadRegister_offset_carry_2, _original__swizzled_add_mopReadRegister_offset_1} = (((mopReadRegister_source == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopReadRegister_source == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopReadRegister_source == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopReadRegister_source == 3'h4) ? imm : ((mopReadRegister_source == 3'h5) ? nextPc : nextSp)))))) + mopReadRegister_offset;
assign mopReadRegister_offset = microcodeRead_data[39:8];  // bussubset_59
assign mopReadRegister_valueOffset = microcodeRead_data[71:40];  // bussubset_60
assign {_data_add_mopReadRegister_valueOffset_carry, _data_add_mopReadRegister_valueOffset} = rs1Read_data + mopReadRegister_valueOffset;
assign {_data_add_mopReadRegister_valueOffset_carry_0, _in0_1} = rs2Read_data + mopReadRegister_valueOffset;
assign mopWriteRegister_funct = microcodeRead_data[4:0];  // bussubset_61
assign mopWriteRegister_field = microcodeRead_data[7:5];  // bussubset_62
assign {_swizzled_add_mopWriteRegister_offset_carry, _original__swizzled_add_mopWriteRegister_offset} = (((mopWriteRegister_field == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h4) ? imm : ((mopWriteRegister_field == 3'h5) ? nextPc : nextSp)))))) + mopWriteRegister_offset;
assign {_swizzled_add_mopWriteRegister_offset_carry_0, _swizzled_add_mopWriteRegister_offset} = (((mopWriteRegister_field == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h4) ? imm : ((mopWriteRegister_field == 3'h5) ? nextPc : nextSp)))))) + mopWriteRegister_offset;
assign {_swizzled_add_mopWriteRegister_offset_carry_1, _original__swizzled_add_mopWriteRegister_offset_0} = (((mopWriteRegister_field == 3'h0) ? ({
27'h0, /* 31:5 */
rd  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h1) ? ({
27'h0, /* 31:5 */
rs1  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h2) ? ({
27'h0, /* 31:5 */
rs2  /*  4:0 */
}) : ((mopWriteRegister_field == 3'h4) ? imm : ((mopWriteRegister_field == 3'h5) ? nextPc : nextSp)))))) + mopWriteRegister_offset;
assign mopWriteRegister_offset = microcodeRead_data[42:11];  // bussubset_66
assign mopAlu_funct = microcodeRead_data[4:0];  // bussubset_67
assign mopBranchIf_funct = microcodeRead_data[4:0];  // bussubset_68
assign mopBranchIf_condition = microcodeRead_data[8:5];  // bussubset_69
assign mopBranchIf_target = microcodeRead_data[11:9];  // bussubset_70
assign mopBranchIf_hasField = microcodeRead_data[12];  // bussubset_71
assign mopBranchIf_offset = microcodeRead_data[44:13];  // bussubset_72
assign mopBranchIf_offsetField = microcodeRead_data[47:45];  // bussubset_73
assign mopUpdatePC_funct = microcodeRead_data[4:0];  // bussubset_74
assign mopMemLoad_funct = microcodeRead_data[4:0];  // bussubset_75
assign mopMemLoad_dest = microcodeRead_data[10:8];  // bussubset_76
assign mopMemStore_funct = microcodeRead_data[4:0];  // bussubset_77
assign mopTrap_funct = microcodeRead_data[4:0];  // bussubset_78
assign mopTrap_causeCode = microcodeRead_data[10:5];  // bussubset_79
assign _original__swizzled_lshift_const_32_h1f_or__swizzled = (({
31'h0, /* 31:1 */
mopTrap_isInterrupt  /*    0 */
}) << _shiftAmount_const_32_h1f) | ({
26'h0, /* 31:6 */
mopTrap_causeCode  /*  5:0 */
});  // or__0
assign mopTrap_isInterrupt = microcodeRead_data[11];  // bussubset_81
assign mopReturn_funct = microcodeRead_data[4:0];  // bussubset_82
assign mopReturn_privilegeLevel = microcodeRead_data[7:5];  // bussubset_83
assign mopWriteLinkRegister_funct = microcodeRead_data[4:0];  // bussubset_84
assign mopWriteLinkRegister_link = microcodeRead_data[6:5];  // bussubset_85
assign mopWriteLinkRegister_pcOffset = microcodeRead_data[38:7];  // bussubset_86
assign {_nextPc_add_mopWriteLinkRegister_pcOffset_carry, _in475__nextPc_add_mopWriteLinkRegister_pcOffset} = nextPc + mopWriteLinkRegister_pcOffset;
assign {_nextPc_add_mopWriteLinkRegister_pcOffset_carry_0, _in483__nextPc_add_mopWriteLinkRegister_pcOffset} = nextPc + mopWriteLinkRegister_pcOffset;
assign mopFence_funct = microcodeRead_data[4:0];  // bussubset_87
assign mopInterruptHold_funct = microcodeRead_data[4:0];  // bussubset_88
assign mopCopyField_funct = microcodeRead_data[4:0];  // bussubset_89
assign mopCopyField_dest = microcodeRead_data[10:8];  // bussubset_90
assign mopMoveToField_funct = microcodeRead_data[4:0];  // bussubset_91
assign mopMoveToField_dest = microcodeRead_data[10:8];  // bussubset_92
assign mopTlbFence_funct = microcodeRead_data[4:0];  // bussubset_93
assign mopTlbInvalidate_funct = microcodeRead_data[4:0];  // bussubset_94
assign mopFpuOp_funct = microcodeRead_data[4:0];  // bussubset_95
assign mopFpuOp_fpuFunct = microcodeRead_data[9:5];  // bussubset_96
assign mopFpuOp_a = microcodeRead_data[12:10];  // bussubset_97
assign mopFpuOp_dest = microcodeRead_data[15:13];  // bussubset_98
assign mopFpuOp_hasB = microcodeRead_data[16];  // bussubset_99
assign mopFpuOp_b = microcodeRead_data[19:17];  // bussubset_100
assign mopFpuOp_doublePrecision = microcodeRead_data[20];  // bussubset_101
assign mopLoadReserved_funct = microcodeRead_data[4:0];  // bussubset_102
assign mopLoadReserved_size = microcodeRead_data[13:11];  // bussubset_103
assign mopStoreConditional_funct = microcodeRead_data[4:0];  // bussubset_104
assign mopStoreConditional_size = microcodeRead_data[16:14];  // bussubset_105
assign mopAtomicMemory_funct = microcodeRead_data[4:0];  // bussubset_106
assign mopAtomicMemory_size = microcodeRead_data[20:18];  // bussubset_107
assign {_swizzled_add__swizzled_carry, _in46__swizzled_add__swizzled} = (instrIndex) + ({
5'h0, /* 8:4 */
mopStep  /* 3:0 */
});
assign {_mopStep_add_const_1_carry, _in80__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_0, _in98__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_1, _in103__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_2, _in122__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_3, _in143__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_4, _in167__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_5, _in184__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_6, _in199__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_7, _in211__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_8, _in226__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_9, _in237__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_10, _in249__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_11, _in253__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_12, _in257__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_13, _in261__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_14, _in265__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_15, _in269__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_16, _in273__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_17, _in277__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_18, _in281__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_19, _in285__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_20, _in289__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_21, _in293__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_22, _in297__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_23, _in300__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_24, _in304__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_25, _in401__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_26, _in427__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_27, _in435__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_28, _in443__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_29, _in451__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_30, _in459__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_31, _in467__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_32, _in477__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_33, _in485__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_34, _in494__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_35, _in510__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_36, _in526__mopStep_add_const_1} = mopStep + 4'h1;
assign {_mopStep_add_const_1_carry_37, _in534__mopStep_add_const_1} = mopStep + 4'h1;
assign {_swizzled_add__swizzled_carry_0, _in544__swizzled_add__swizzled} = (instrIndex) + ({
5'h0, /* 8:4 */
mopStep  /* 3:0 */
});
assign {_counter_add_const_1_carry, _in32__counter_add_const_1} = counter + 32'h1;
assign _swizzled_lshift_const_32_h1f_or__swizzled = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_0) | ({
26'h0, /* 31:6 */
6'hc  /*  5:0 */
});  // or__1
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_0 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_1) | ({
26'h0, /* 31:6 */
6'hd  /*  5:0 */
});  // or__2
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_1 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_2) | ({
26'h0, /* 31:6 */
6'hd  /*  5:0 */
});  // or__3
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_2 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_3) | ({
26'h0, /* 31:6 */
6'hd  /*  5:0 */
});  // or__4
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_3 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_4) | ({
26'h0, /* 31:6 */
6'hf  /*  5:0 */
});  // or__5
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_4 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_5) | ({
26'h0, /* 31:6 */
6'hf  /*  5:0 */
});  // or__6
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_5 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_6) | ({
26'h0, /* 31:6 */
6'hf  /*  5:0 */
});  // or__7
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_6 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_7) | ({
26'h0, /* 31:6 */
6'h4  /*  5:0 */
});  // or__8
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_7 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_8) | ({
26'h0, /* 31:6 */
6'h4  /*  5:0 */
});  // or__9
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_8 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_9) | ({
26'h0, /* 31:6 */
6'h4  /*  5:0 */
});  // or__10
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_9 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_10) | ({
26'h0, /* 31:6 */
6'h6  /*  5:0 */
});  // or__11
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_10 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_11) | ({
26'h0, /* 31:6 */
6'h6  /*  5:0 */
});  // or__12
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_11 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_12) | ({
26'h0, /* 31:6 */
6'h6  /*  5:0 */
});  // or__13
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_12 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_13) | ({
26'h0, /* 31:6 */
6'h4  /*  5:0 */
});  // or__14
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_13 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_14) | ({
26'h0, /* 31:6 */
6'h6  /*  5:0 */
});  // or__15
assign _original__swizzled_lshift_const_32_h1f_or__swizzled_14 = (({
31'h0, /* 31:1 */
1'h0  /*    0 */
}) << _shiftAmount_const_32_h1f_15) | ({
26'h0, /* 31:6 */
6'h6  /*  5:0 */
});  // or__16
endmodule : DynamicExecutionUnit