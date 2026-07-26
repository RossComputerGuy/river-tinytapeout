module StaticInstructionDecoder (
input logic clk,
input logic reset,
input logic enable,
input logic [31:0] instr,
input logic [31:0] pc_in,
output logic done,
output logic valid,
output logic [8:0] index,
output logic [31:0] imm,
output logic [31:0] counter,
output logic [31:0] pc_out,
output logic [1:0] op,
output logic [2:0] rd_prime,
output logic [2:0] funct3,
output logic [4:0] imm_lo,
output logic [2:0] rs1_prime,
output logic [2:0] imm_hi,
output logic [2:0] rs2_prime,
output logic [4:0] rd_rs1,
output logic [10:0] jump_target,
output logic [4:0] offset_lo,
output logic [2:0] offset_hi,
output logic [1:0] funct2,
output logic [2:0] rd_rs1_prime,
output logic [5:0] funct6,
output logic [4:0] rs2,
output logic [3:0] funct4,
output logic [6:0] opcode,
output logic [4:0] rd,
output logic [4:0] rs1,
output logic [4:0] immLo,
output logic [6:0] immHi,
output logic [6:0] funct7,
output logic is_Unknown_op_rd_prime_imm_funct3,
output logic is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3,
output logic is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3,
output logic is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3,
output logic is_CJType,
output logic is_CBType,
output logic is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6,
output logic is_Unknown_op_rs2_imm_funct3,
output logic is_Unknown_op_rs2_rd_rs1_funct4,
output logic is_UType,
output logic is_JType,
output logic is_IType,
output logic is_BType,
output logic is_SType,
output logic is_RType
);
logic _counter_add_const_1_carry;
logic [5:0] _in0;
logic [31:0] _in46__counter_add_const_1;
logic [11:0] _original__subset_31_20_instr;
logic [11:0] _original__subset_31_20_instr_0;
logic [11:0] _original__subset_31_20_instr_1;
logic [11:0] _original__subset_31_20_instr_10;
logic [11:0] _original__subset_31_20_instr_11;
logic [11:0] _original__subset_31_20_instr_12;
logic [11:0] _original__subset_31_20_instr_13;
logic [11:0] _original__subset_31_20_instr_14;
logic [11:0] _original__subset_31_20_instr_15;
logic [11:0] _original__subset_31_20_instr_2;
logic [11:0] _original__subset_31_20_instr_3;
logic [11:0] _original__subset_31_20_instr_4;
logic [11:0] _original__subset_31_20_instr_5;
logic [11:0] _original__subset_31_20_instr_6;
logic [11:0] _original__subset_31_20_instr_7;
logic [11:0] _original__subset_31_20_instr_8;
logic [11:0] _original__subset_31_20_instr_9;
logic [5:0] _original__swizzled;
logic [17:0] _original__swizzled_0;
logic [11:0] _original__swizzled_1;
logic [12:0] _original__swizzled_10;
logic [12:0] _original__swizzled_11;
logic [12:0] _original__swizzled_12;
logic [11:0] _original__swizzled_2;
logic [8:0] _original__swizzled_3;
logic [8:0] _original__swizzled_4;
logic [5:0] _original__swizzled_5;
logic [20:0] _original__swizzled_6;
logic [12:0] _original__swizzled_7;
logic [12:0] _original__swizzled_8;
logic [12:0] _original__swizzled_9;
logic [11:0] _subset_31_20_instr;
logic [9:0] _swizzled;
logic [1:0] funct2_0;
logic [1:0] funct2_1;
logic [1:0] funct2_2;
logic [1:0] funct2_3;
logic [1:0] funct2_4;
logic [1:0] funct2_5;
logic [1:0] funct2_6;
logic [2:0] funct3_0;
logic [2:0] funct3_1;
logic [2:0] funct3_10;
logic [2:0] funct3_11;
logic [2:0] funct3_12;
logic [2:0] funct3_13;
logic [2:0] funct3_14;
logic [2:0] funct3_15;
logic [2:0] funct3_16;
logic [2:0] funct3_17;
logic [2:0] funct3_18;
logic [2:0] funct3_19;
logic [2:0] funct3_2;
logic [2:0] funct3_20;
logic [2:0] funct3_21;
logic [2:0] funct3_22;
logic [2:0] funct3_23;
logic [2:0] funct3_24;
logic [2:0] funct3_25;
logic [2:0] funct3_26;
logic [2:0] funct3_27;
logic [2:0] funct3_28;
logic [2:0] funct3_29;
logic [2:0] funct3_3;
logic [2:0] funct3_30;
logic [2:0] funct3_31;
logic [2:0] funct3_32;
logic [2:0] funct3_33;
logic [2:0] funct3_34;
logic [2:0] funct3_35;
logic [2:0] funct3_36;
logic [2:0] funct3_37;
logic [2:0] funct3_38;
logic [2:0] funct3_39;
logic [2:0] funct3_4;
logic [2:0] funct3_40;
logic [2:0] funct3_41;
logic [2:0] funct3_42;
logic [2:0] funct3_43;
logic [2:0] funct3_44;
logic [2:0] funct3_45;
logic [2:0] funct3_46;
logic [2:0] funct3_47;
logic [2:0] funct3_48;
logic [2:0] funct3_49;
logic [2:0] funct3_5;
logic [2:0] funct3_50;
logic [2:0] funct3_6;
logic [2:0] funct3_7;
logic [2:0] funct3_8;
logic [2:0] funct3_9;
logic [3:0] funct4_0;
logic [3:0] funct4_1;
logic [3:0] funct4_2;
logic [3:0] funct4_3;
logic [3:0] funct4_4;
logic [5:0] funct6_0;
logic [5:0] funct6_1;
logic [5:0] funct6_2;
logic [5:0] funct6_3;
logic [5:0] funct6_4;
logic [5:0] funct6_5;
logic [5:0] funct6_6;
logic [6:0] funct7_0;
logic [6:0] funct7_1;
logic [6:0] funct7_2;
logic [6:0] funct7_3;
logic [6:0] funct7_4;
logic [6:0] funct7_5;
logic [6:0] funct7_6;
logic [6:0] funct7_7;
logic [6:0] funct7_8;
logic [6:0] funct7_9;
logic [6:0] immHi_0;
logic [6:0] immHi_1;
logic [6:0] immHi_2;
logic [6:0] immHi_3;
logic [6:0] immHi_4;
logic [6:0] immHi_5;
logic [6:0] immHi_6;
logic [6:0] immHi_7;
logic [6:0] immHi_8;
logic [4:0] immLo_0;
logic [4:0] immLo_1;
logic [4:0] immLo_2;
logic [4:0] immLo_3;
logic [4:0] immLo_4;
logic [4:0] immLo_5;
logic [4:0] immLo_6;
logic [4:0] immLo_7;
logic [4:0] immLo_8;
logic [2:0] imm_hi_0;
logic [2:0] imm_hi_1;
logic [2:0] imm_hi_2;
logic [2:0] imm_hi_3;
logic [2:0] imm_hi_4;
logic [2:0] imm_hi_5;
logic [2:0] imm_hi_6;
logic [2:0] imm_hi_7;
logic [4:0] imm_lo_0;
logic [4:0] imm_lo_1;
logic [4:0] imm_lo_2;
logic [4:0] imm_lo_3;
logic [4:0] imm_lo_4;
logic [4:0] imm_lo_5;
logic [4:0] imm_lo_6;
logic [4:0] imm_lo_7;
logic [10:0] jump_target_0;
logic [10:0] jump_target_1;
logic [2:0] offset_hi_0;
logic [2:0] offset_hi_1;
logic [4:0] offset_lo_0;
logic [4:0] offset_lo_1;
logic [1:0] op_0;
logic [1:0] op_1;
logic [1:0] op_10;
logic [1:0] op_11;
logic [1:0] op_12;
logic [1:0] op_13;
logic [1:0] op_14;
logic [1:0] op_15;
logic [1:0] op_16;
logic [1:0] op_17;
logic [1:0] op_18;
logic [1:0] op_19;
logic [1:0] op_2;
logic [1:0] op_20;
logic [1:0] op_21;
logic [1:0] op_22;
logic [1:0] op_23;
logic [1:0] op_24;
logic [1:0] op_25;
logic [1:0] op_3;
logic [1:0] op_4;
logic [1:0] op_5;
logic [1:0] op_6;
logic [1:0] op_7;
logic [1:0] op_8;
logic [1:0] op_9;
logic [6:0] opcode_0;
logic [6:0] opcode_1;
logic [6:0] opcode_10;
logic [6:0] opcode_11;
logic [6:0] opcode_12;
logic [6:0] opcode_13;
logic [6:0] opcode_14;
logic [6:0] opcode_15;
logic [6:0] opcode_16;
logic [6:0] opcode_17;
logic [6:0] opcode_18;
logic [6:0] opcode_19;
logic [6:0] opcode_2;
logic [6:0] opcode_20;
logic [6:0] opcode_21;
logic [6:0] opcode_22;
logic [6:0] opcode_23;
logic [6:0] opcode_24;
logic [6:0] opcode_25;
logic [6:0] opcode_26;
logic [6:0] opcode_27;
logic [6:0] opcode_28;
logic [6:0] opcode_29;
logic [6:0] opcode_3;
logic [6:0] opcode_30;
logic [6:0] opcode_31;
logic [6:0] opcode_32;
logic [6:0] opcode_33;
logic [6:0] opcode_34;
logic [6:0] opcode_35;
logic [6:0] opcode_36;
logic [6:0] opcode_37;
logic [6:0] opcode_38;
logic [6:0] opcode_39;
logic [6:0] opcode_4;
logic [6:0] opcode_5;
logic [6:0] opcode_6;
logic [6:0] opcode_7;
logic [6:0] opcode_8;
logic [6:0] opcode_9;
logic [4:0] rd_0;
logic [4:0] rd_1;
logic [4:0] rd_10;
logic [4:0] rd_11;
logic [4:0] rd_12;
logic [4:0] rd_13;
logic [4:0] rd_14;
logic [4:0] rd_15;
logic [4:0] rd_16;
logic [4:0] rd_17;
logic [4:0] rd_18;
logic [4:0] rd_19;
logic [4:0] rd_2;
logic [4:0] rd_20;
logic [4:0] rd_21;
logic [4:0] rd_22;
logic [4:0] rd_23;
logic [4:0] rd_24;
logic [4:0] rd_25;
logic [4:0] rd_26;
logic [4:0] rd_27;
logic [4:0] rd_28;
logic [4:0] rd_29;
logic [4:0] rd_3;
logic [4:0] rd_30;
logic [4:0] rd_4;
logic [4:0] rd_5;
logic [4:0] rd_6;
logic [4:0] rd_7;
logic [4:0] rd_8;
logic [4:0] rd_9;
logic [2:0] rd_prime_0;
logic [2:0] rd_prime_1;
logic [4:0] rd_rs1_0;
logic [4:0] rd_rs1_1;
logic [4:0] rd_rs1_10;
logic [4:0] rd_rs1_2;
logic [4:0] rd_rs1_3;
logic [4:0] rd_rs1_4;
logic [4:0] rd_rs1_5;
logic [4:0] rd_rs1_6;
logic [4:0] rd_rs1_7;
logic [4:0] rd_rs1_8;
logic [4:0] rd_rs1_9;
logic [2:0] rd_rs1_prime_0;
logic [2:0] rd_rs1_prime_1;
logic [2:0] rd_rs1_prime_2;
logic [2:0] rd_rs1_prime_3;
logic [2:0] rd_rs1_prime_4;
logic [2:0] rd_rs1_prime_5;
logic [2:0] rd_rs1_prime_6;
logic [4:0] rs1_0;
logic [4:0] rs1_1;
logic [4:0] rs1_10;
logic [4:0] rs1_11;
logic [4:0] rs1_12;
logic [4:0] rs1_13;
logic [4:0] rs1_14;
logic [4:0] rs1_15;
logic [4:0] rs1_16;
logic [4:0] rs1_17;
logic [4:0] rs1_18;
logic [4:0] rs1_19;
logic [4:0] rs1_2;
logic [4:0] rs1_20;
logic [4:0] rs1_21;
logic [4:0] rs1_22;
logic [4:0] rs1_23;
logic [4:0] rs1_24;
logic [4:0] rs1_25;
logic [4:0] rs1_26;
logic [4:0] rs1_27;
logic [4:0] rs1_28;
logic [4:0] rs1_29;
logic [4:0] rs1_3;
logic [4:0] rs1_30;
logic [4:0] rs1_31;
logic [4:0] rs1_32;
logic [4:0] rs1_33;
logic [4:0] rs1_34;
logic [4:0] rs1_35;
logic [4:0] rs1_36;
logic [4:0] rs1_4;
logic [4:0] rs1_5;
logic [4:0] rs1_6;
logic [4:0] rs1_7;
logic [4:0] rs1_8;
logic [4:0] rs1_9;
logic [2:0] rs1_prime_0;
logic [2:0] rs1_prime_1;
logic [2:0] rs1_prime_2;
logic [2:0] rs1_prime_3;
logic [4:0] rs2_0;
logic [4:0] rs2_1;
logic [4:0] rs2_10;
logic [4:0] rs2_11;
logic [4:0] rs2_12;
logic [4:0] rs2_13;
logic [4:0] rs2_14;
logic [4:0] rs2_15;
logic [4:0] rs2_16;
logic [4:0] rs2_17;
logic [4:0] rs2_18;
logic [4:0] rs2_19;
logic [4:0] rs2_2;
logic [4:0] rs2_20;
logic [4:0] rs2_21;
logic [4:0] rs2_22;
logic [4:0] rs2_23;
logic [4:0] rs2_24;
logic [4:0] rs2_3;
logic [4:0] rs2_4;
logic [4:0] rs2_5;
logic [4:0] rs2_6;
logic [4:0] rs2_7;
logic [4:0] rs2_8;
logic [4:0] rs2_9;
logic [2:0] rs2_prime_0;
logic [2:0] rs2_prime_1;
logic [2:0] rs2_prime_2;
logic [2:0] rs2_prime_3;
logic [2:0] rs2_prime_4;
logic [2:0] rs2_prime_5;
logic [2:0] rs2_prime_6;
logic [2:0] rs2_prime_7;
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      valid <= 1'h0;
      index <= 9'h0;
      done <= 1'h0;
      counter <= 32'h0;
      pc_out <= 32'h0;
      is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
      is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
      is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
      is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
      is_CJType <= 1'h0;
      is_CBType <= 1'h0;
      is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
      is_Unknown_op_rs2_imm_funct3 <= 1'h0;
      is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
      is_UType <= 1'h0;
      is_JType <= 1'h0;
      is_IType <= 1'h0;
      is_BType <= 1'h0;
      is_SType <= 1'h0;
      is_RType <= 1'h0;
      op <= 2'h0;
      rd_prime <= 3'h0;
      imm <= 32'h0;
      funct3 <= 3'h0;
      imm_lo <= 5'h0;
      rs1_prime <= 3'h0;
      imm_hi <= 3'h0;
      rs2_prime <= 3'h0;
      rd_rs1 <= 5'h0;
      jump_target <= 11'h0;
      offset_lo <= 5'h0;
      offset_hi <= 3'h0;
      funct2 <= 2'h0;
      rd_rs1_prime <= 3'h0;
      funct6 <= 6'h0;
      rs2 <= 5'h0;
      funct4 <= 4'h0;
      opcode <= 7'h0;
      rd <= 5'h0;
      rs1 <= 5'h0;
      immLo <= 5'h0;
      immHi <= 7'h0;
      funct7 <= 7'h0;
  end   else begin
      if(enable) begin
          counter <= _in46__counter_add_const_1;
          pc_out <= pc_in;
          if(((((instr & 32'he003) == 32'h0) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h0;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h1;
              op <= op_0;
              rd_prime <= rd_prime_0;
              funct3 <= funct3_0;
              rd <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              rs1 <= 5'h2;
              rs2 <= 5'h0;
              imm <= ({
22'h0, /* 31:10 */
({
(instr[10]), /*   9 */
(instr[9]), /*   8 */
(instr[8]), /*   7 */
(instr[7]), /*   6 */
(instr[12]), /*   5 */
(instr[11]), /*   4 */
(instr[5]), /*   3 */
(instr[6]), /*   2 */
2'h0  /* 1:0 */
})  /*  9: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h4000) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h5;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h1;
              op <= op_1;
              rd_prime <= rd_prime_1;
              imm_lo <= imm_lo_0;
              rs1_prime <= rs1_prime_0;
              imm_hi <= imm_hi_0;
              funct3 <= funct3_1;
              rd <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= 5'h0;
              imm <= ({
25'h0, /* 31:7 */
({
(instr[5]), /*   6 */
(instr[12]), /*   5 */
(instr[11]), /*   4 */
(instr[10]), /*   3 */
(instr[6]), /*   2 */
2'h0  /* 1:0 */
})  /*  6:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'hc000) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hb;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h1;
              op <= op_2;
              rs2_prime <= rs2_prime_0;
              imm_lo <= imm_lo_1;
              rs1_prime <= rs1_prime_1;
              imm_hi <= imm_hi_1;
              funct3 <= funct3_2;
              rd <= 5'h0;
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= ({
25'h0, /* 31:7 */
({
(instr[5]), /*   6 */
(instr[12]), /*   5 */
(instr[11]), /*   4 */
(instr[10]), /*   3 */
(instr[6]), /*   2 */
2'h0  /* 1:0 */
})  /*  6:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h1) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h11;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
              op <= op_3;
              imm_lo <= imm_lo_2;
              rd_rs1 <= rd_rs1_0;
              imm_hi <= imm_hi_2;
              funct3 <= funct3_3;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= 5'h0;
              imm <= ({
({26{(_original__swizzled[5])}}), /* 31:6 */
_original__swizzled  /*  5:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h4001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h16;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
              op <= op_4;
              imm_lo <= imm_lo_3;
              rd_rs1 <= rd_rs1_1;
              imm_hi <= imm_hi_3;
              funct3 <= funct3_4;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= 5'h0;
              imm <= ({
({26{(_in0[5])}}), /* 31:6 */
_in0  /*  5:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hef83) == 32'h6101) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h19;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
              op <= op_5;
              imm_lo <= imm_lo_4;
              rd_rs1 <= rd_rs1_2;
              imm_hi <= imm_hi_4;
              funct3 <= funct3_5;
              rd <= 5'h2;
              rs1 <= 5'h2;
              rs2 <= 5'h0;
              imm <= ({
({22{(_swizzled[9])}}), /* 31:10 */
_swizzled  /*  9: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h6001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h1e;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
              op <= op_6;
              imm_lo <= imm_lo_5;
              rd_rs1 <= rd_rs1_3;
              imm_hi <= imm_hi_5;
              funct3 <= funct3_6;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= 5'h0;
              imm <= ({
({14{(_original__swizzled_0[17])}}), /* 31:18 */
_original__swizzled_0  /* 17: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'ha001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h21;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_CJType <= 1'h1;
              op <= op_7;
              jump_target <= jump_target_0;
              funct3 <= funct3_7;
              rd <= 5'h0;
              rs1 <= 5'h0;
              rs2 <= 5'h0;
              imm <= ({
({20{(_original__swizzled_1[11])}}), /* 31:12 */
_original__swizzled_1  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h2001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h23;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_CJType <= 1'h1;
              op <= op_8;
              jump_target <= jump_target_1;
              funct3 <= funct3_8;
              rd <= 5'h1;
              rs1 <= 5'h0;
              rs2 <= 5'h0;
              imm <= ({
({20{(_original__swizzled_2[11])}}), /* 31:12 */
_original__swizzled_2  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'hc001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h26;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_CBType <= 1'h1;
              op <= op_9;
              offset_lo <= offset_lo_0;
              rs1_prime <= rs1_prime_2;
              offset_hi <= offset_hi_0;
              funct3 <= funct3_9;
              rd <= 5'h0;
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= 5'h0;
              imm <= ({
({23{(_original__swizzled_3[8])}}), /* 31:9 */
_original__swizzled_3  /*  8:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'he001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h2a;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_CBType <= 1'h1;
              op <= op_10;
              offset_lo <= offset_lo_1;
              rs1_prime <= rs1_prime_3;
              offset_hi <= offset_hi_1;
              funct3 <= funct3_10;
              rd <= 5'h0;
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= 5'h0;
              imm <= ({
({23{(_original__swizzled_4[8])}}), /* 31:9 */
_original__swizzled_4  /*  8:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hec03) == 32'h8001) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h2e;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_11;
              rs2_prime <= rs2_prime_1;
              funct2 <= funct2_0;
              rd_rs1_prime <= rd_rs1_prime_0;
              funct6 <= funct6_0;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= ({
26'h0, /* 31:6 */
({
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
})  /*  5:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hec03) == 32'h8401) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h33;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_12;
              rs2_prime <= rs2_prime_2;
              funct2 <= funct2_1;
              rd_rs1_prime <= rd_rs1_prime_1;
              funct6 <= funct6_1;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= ({
26'h0, /* 31:6 */
({
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
})  /*  5:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hec03) == 32'h8801) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h38;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_13;
              rs2_prime <= rs2_prime_3;
              funct2 <= funct2_2;
              rd_rs1_prime <= rd_rs1_prime_2;
              funct6 <= funct6_2;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= ({
({26{(_original__swizzled_5[5])}}), /* 31:6 */
_original__swizzled_5  /*  5:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfc63) == 32'h8c01) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h3d;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_14;
              rs2_prime <= rs2_prime_4;
              funct2 <= funct2_3;
              rd_rs1_prime <= rd_rs1_prime_3;
              funct6 <= funct6_3;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfc63) == 32'h8c21) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h43;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_15;
              rs2_prime <= rs2_prime_5;
              funct2 <= funct2_4;
              rd_rs1_prime <= rd_rs1_prime_4;
              funct6 <= funct6_4;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfc63) == 32'h8c41) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h49;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_16;
              rs2_prime <= rs2_prime_6;
              funct2 <= funct2_5;
              rd_rs1_prime <= rd_rs1_prime_5;
              funct6 <= funct6_5;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfc63) == 32'h8c61) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h4f;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
              op <= op_17;
              rs2_prime <= rs2_prime_7;
              funct2 <= funct2_6;
              rd_rs1_prime <= rd_rs1_prime_6;
              funct6 <= funct6_6;
              rd <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
              rs2 <= ({
2'h1, /* 4:3 */
(instr[4:2])  /* 2:0 */
});
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h2) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h55;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
              op <= op_18;
              imm_lo <= imm_lo_6;
              rd_rs1 <= rd_rs1_4;
              imm_hi <= imm_hi_6;
              funct3 <= funct3_11;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= 5'h0;
              imm <= ({
26'h0, /* 31:6 */
({
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
})  /*  5:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'h4002) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h5a;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
              op <= op_19;
              imm_lo <= imm_lo_7;
              rd_rs1 <= rd_rs1_5;
              imm_hi <= imm_hi_7;
              funct3 <= funct3_12;
              rd <= ((instr[11:7]));
              rs1 <= 5'h2;
              rs2 <= 5'h0;
              imm <= ({
24'h0, /* 31:8 */
({
(instr[3]), /*   7 */
(instr[2]), /*   6 */
(instr[12]), /*   5 */
(instr[6]), /*   4 */
(instr[5]), /*   3 */
(instr[4]), /*   2 */
2'h0  /* 1:0 */
})  /*  7:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'he003) == 32'hc002) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h60;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h1;
              op <= op_20;
              rs2 <= rs2_0;
              funct3 <= funct3_13;
              rd <= 5'h0;
              rs1 <= 5'h2;
              rs2 <= ((instr[6:2]));
              imm <= ({
24'h0, /* 31:8 */
({
(instr[8]), /*   7 */
(instr[7]), /*   6 */
(instr[12]), /*   5 */
(instr[11]), /*   4 */
(instr[10]), /*   3 */
(instr[9]), /*   2 */
2'h0  /* 1:0 */
})  /*  7:0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hf003) == 32'h8002) & ((instr & 32'h7c) != 32'h0)) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h66;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h1;
              op <= op_21;
              rs2 <= rs2_1;
              rd_rs1 <= rd_rs1_6;
              funct4 <= funct4_0;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= ((instr[6:2]));
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hf003) == 32'h9002) & ((instr & 32'h7c) != 32'h0)) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h6a;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h1;
              op <= op_22;
              rs2 <= rs2_2;
              rd_rs1 <= rd_rs1_7;
              funct4 <= funct4_1;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= ((instr[6:2]));
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hf003) == 32'h8002) & 1'h1) & ((instr & 32'h7c) == 32'h0))) begin
              valid <= 1'h1;
              index <= 9'h70;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h1;
              op <= op_23;
              rs2 <= rs2_3;
              rd_rs1 <= rd_rs1_8;
              funct4 <= funct4_2;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= ((instr[6:2]));
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hf003) == 32'h9002) & ((instr & 32'hf80) != 32'h0)) & ((instr & 32'h7c) == 32'h0))) begin
              valid <= 1'h1;
              index <= 9'h74;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h1;
              op <= op_24;
              rs2 <= rs2_4;
              rd_rs1 <= rd_rs1_9;
              funct4 <= funct4_3;
              rd <= 5'h1;
              rs1 <= ((instr[11:7]));
              rs2 <= ((instr[6:2]));
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hf003) == 32'h9002) & 1'h1) & ((instr & 32'hffc) == 32'h0))) begin
              valid <= 1'h1;
              index <= 9'h79;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h1;
              op <= op_25;
              rs2 <= rs2_5;
              rd_rs1 <= rd_rs1_10;
              funct4 <= funct4_4;
              rd <= ((instr[11:7]));
              rs1 <= ((instr[11:7]));
              rs2 <= ((instr[6:2]));
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'h7f) == 32'h37) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h7b;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_UType <= 1'h1;
              opcode <= opcode_0;
              rd <= rd_0;
              imm <= ({
(instr[31:12]), /* 31:12 */
12'h0  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h7f) == 32'h17) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h7e;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_UType <= 1'h1;
              opcode <= opcode_1;
              rd <= rd_1;
              imm <= ({
(instr[31:12]), /* 31:12 */
12'h0  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h7f) == 32'h6f) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h82;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_JType <= 1'h1;
              opcode <= opcode_2;
              rd <= rd_2;
              imm <= ({
({11{(_original__swizzled_6[20])}}), /* 31:21 */
_original__swizzled_6  /* 20: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h67) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h85;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_3;
              rd <= rd_3;
              funct3 <= funct3_14;
              rs1 <= rs1_0;
              imm <= ({
({20{(_original__subset_31_20_instr[11])}}), /* 31:12 */
_original__subset_31_20_instr  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h63) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h8a;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_BType <= 1'h1;
              opcode <= opcode_4;
              immLo <= immLo_0;
              funct3 <= funct3_15;
              rs1 <= rs1_1;
              rs2 <= rs2_6;
              immHi <= immHi_0;
              imm <= ({
({19{(_original__swizzled_7[12])}}), /* 31:13 */
_original__swizzled_7  /* 12: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h1063) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h90;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_BType <= 1'h1;
              opcode <= opcode_5;
              immLo <= immLo_1;
              funct3 <= funct3_16;
              rs1 <= rs1_2;
              rs2 <= rs2_7;
              immHi <= immHi_1;
              imm <= ({
({19{(_original__swizzled_8[12])}}), /* 31:13 */
_original__swizzled_8  /* 12: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h4063) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h96;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_BType <= 1'h1;
              opcode <= opcode_6;
              immLo <= immLo_2;
              funct3 <= funct3_17;
              rs1 <= rs1_3;
              rs2 <= rs2_8;
              immHi <= immHi_2;
              imm <= ({
({19{(_original__swizzled_9[12])}}), /* 31:13 */
_original__swizzled_9  /* 12: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h5063) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h9c;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_BType <= 1'h1;
              opcode <= opcode_7;
              immLo <= immLo_3;
              funct3 <= funct3_18;
              rs1 <= rs1_4;
              rs2 <= rs2_9;
              immHi <= immHi_3;
              imm <= ({
({19{(_original__swizzled_10[12])}}), /* 31:13 */
_original__swizzled_10  /* 12: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h6063) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'ha2;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_BType <= 1'h1;
              opcode <= opcode_8;
              immLo <= immLo_4;
              funct3 <= funct3_19;
              rs1 <= rs1_5;
              rs2 <= rs2_10;
              immHi <= immHi_4;
              imm <= ({
({19{(_original__swizzled_11[12])}}), /* 31:13 */
_original__swizzled_11  /* 12: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h7063) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'ha8;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_BType <= 1'h1;
              opcode <= opcode_9;
              immLo <= immLo_5;
              funct3 <= funct3_20;
              rs1 <= rs1_6;
              rs2 <= rs2_11;
              immHi <= immHi_5;
              imm <= ({
({19{(_original__swizzled_12[12])}}), /* 31:13 */
_original__swizzled_12  /* 12: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h3) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hae;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_10;
              rd <= rd_4;
              funct3 <= funct3_21;
              rs1 <= rs1_7;
              imm <= ({
({20{(_subset_31_20_instr[11])}}), /* 31:12 */
_subset_31_20_instr  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h1003) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hb4;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_11;
              rd <= rd_5;
              funct3 <= funct3_22;
              rs1 <= rs1_8;
              imm <= ({
({20{(_original__subset_31_20_instr_0[11])}}), /* 31:12 */
_original__subset_31_20_instr_0  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h2003) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hba;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_12;
              rd <= rd_6;
              funct3 <= funct3_23;
              rs1 <= rs1_9;
              imm <= ({
({20{(_original__subset_31_20_instr_1[11])}}), /* 31:12 */
_original__subset_31_20_instr_1  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h4003) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hc0;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_13;
              rd <= rd_7;
              funct3 <= funct3_24;
              rs1 <= rs1_10;
              imm <= ({
({20{(_original__subset_31_20_instr_2[11])}}), /* 31:12 */
_original__subset_31_20_instr_2  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h5003) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hc6;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_14;
              rd <= rd_8;
              funct3 <= funct3_25;
              rs1 <= rs1_11;
              imm <= ({
({20{(_original__subset_31_20_instr_3[11])}}), /* 31:12 */
_original__subset_31_20_instr_3  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h23) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hcc;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_SType <= 1'h1;
              opcode <= opcode_15;
              immLo <= immLo_6;
              funct3 <= funct3_26;
              rs1 <= rs1_12;
              rs2 <= rs2_12;
              immHi <= immHi_6;
              imm <= ({
20'h0, /* 31:12 */
({
(instr[31:25]), /* 11:5 */
(instr[11:7])  /*  4:0 */
})  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h1023) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hd2;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_SType <= 1'h1;
              opcode <= opcode_16;
              immLo <= immLo_7;
              funct3 <= funct3_27;
              rs1 <= rs1_13;
              rs2 <= rs2_13;
              immHi <= immHi_7;
              imm <= ({
20'h0, /* 31:12 */
({
(instr[31:25]), /* 11:5 */
(instr[11:7])  /*  4:0 */
})  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h2023) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hd8;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_SType <= 1'h1;
              opcode <= opcode_17;
              immLo <= immLo_8;
              funct3 <= funct3_28;
              rs1 <= rs1_14;
              rs2 <= rs2_14;
              immHi <= immHi_8;
              imm <= ({
20'h0, /* 31:12 */
({
(instr[31:25]), /* 11:5 */
(instr[11:7])  /*  4:0 */
})  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h13) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hde;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_18;
              rd <= rd_9;
              funct3 <= funct3_29;
              rs1 <= rs1_15;
              imm <= ({
({20{(_original__subset_31_20_instr_4[11])}}), /* 31:12 */
_original__subset_31_20_instr_4  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h2013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'he3;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_19;
              rd <= rd_10;
              funct3 <= funct3_30;
              rs1 <= rs1_16;
              imm <= ({
({20{(_original__subset_31_20_instr_5[11])}}), /* 31:12 */
_original__subset_31_20_instr_5  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h3013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'he8;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_20;
              rd <= rd_11;
              funct3 <= funct3_31;
              rs1 <= rs1_17;
              imm <= ({
({20{(_original__subset_31_20_instr_6[11])}}), /* 31:12 */
_original__subset_31_20_instr_6  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h4013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hed;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_21;
              rd <= rd_12;
              funct3 <= funct3_32;
              rs1 <= rs1_18;
              imm <= ({
({20{(_original__subset_31_20_instr_7[11])}}), /* 31:12 */
_original__subset_31_20_instr_7  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h6013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hf2;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_22;
              rd <= rd_13;
              funct3 <= funct3_33;
              rs1 <= rs1_19;
              imm <= ({
({20{(_original__subset_31_20_instr_8[11])}}), /* 31:12 */
_original__subset_31_20_instr_8  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'h7013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hf7;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_23;
              rd <= rd_14;
              funct3 <= funct3_34;
              rs1 <= rs1_20;
              imm <= ({
({20{(_original__subset_31_20_instr_9[11])}}), /* 31:12 */
_original__subset_31_20_instr_9  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfc00707f) == 32'h1013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'hfc;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_24;
              rd <= rd_15;
              funct3 <= funct3_35;
              rs1 <= rs1_21;
              imm <= ({
({20{(_original__subset_31_20_instr_10[11])}}), /* 31:12 */
_original__subset_31_20_instr_10  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfc00707f) == 32'h5013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h101;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_25;
              rd <= rd_16;
              funct3 <= funct3_36;
              rs1 <= rs1_22;
              imm <= ({
({20{(_original__subset_31_20_instr_11[11])}}), /* 31:12 */
_original__subset_31_20_instr_11  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfc00707f) == 32'h40005013) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h106;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_26;
              rd <= rd_17;
              funct3 <= funct3_37;
              rs1 <= rs1_23;
              imm <= ({
({20{(_original__subset_31_20_instr_12[11])}}), /* 31:12 */
_original__subset_31_20_instr_12  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h33) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h10b;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_27;
              rd <= rd_18;
              funct3 <= funct3_38;
              rs1 <= rs1_24;
              rs2 <= rs2_15;
              funct7 <= funct7_0;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h40000033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h111;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_28;
              rd <= rd_19;
              funct3 <= funct3_39;
              rs1 <= rs1_25;
              rs2 <= rs2_16;
              funct7 <= funct7_1;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h1033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h117;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_29;
              rd <= rd_20;
              funct3 <= funct3_40;
              rs1 <= rs1_26;
              rs2 <= rs2_17;
              funct7 <= funct7_2;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h2033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h11d;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_30;
              rd <= rd_21;
              funct3 <= funct3_41;
              rs1 <= rs1_27;
              rs2 <= rs2_18;
              funct7 <= funct7_3;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h3033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h123;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_31;
              rd <= rd_22;
              funct3 <= funct3_42;
              rs1 <= rs1_28;
              rs2 <= rs2_19;
              funct7 <= funct7_4;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h4033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h129;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_32;
              rd <= rd_23;
              funct3 <= funct3_43;
              rs1 <= rs1_29;
              rs2 <= rs2_20;
              funct7 <= funct7_5;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h5033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h12f;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_33;
              rd <= rd_24;
              funct3 <= funct3_44;
              rs1 <= rs1_30;
              rs2 <= rs2_21;
              funct7 <= funct7_6;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h40005033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h135;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_34;
              rd <= rd_25;
              funct3 <= funct3_45;
              rs1 <= rs1_31;
              rs2 <= rs2_22;
              funct7 <= funct7_7;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h6033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h13b;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_35;
              rd <= rd_26;
              funct3 <= funct3_46;
              rs1 <= rs1_32;
              rs2 <= rs2_23;
              funct7 <= funct7_8;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'hfe00707f) == 32'h7033) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h141;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_RType <= 1'h1;
              opcode <= opcode_36;
              rd <= rd_27;
              funct3 <= funct3_47;
              rs1 <= rs1_33;
              rs2 <= rs2_24;
              funct7 <= funct7_9;
              imm <= 32'h0;
              done <= 1'h1;
          end           else if(((((instr & 32'h707f) == 32'hf) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h147;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_37;
              rd <= rd_28;
              funct3 <= funct3_48;
              rs1 <= rs1_34;
              imm <= ({
({20{(_original__subset_31_20_instr_13[11])}}), /* 31:12 */
_original__subset_31_20_instr_13  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfe10707f) == 32'h73) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h14a;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_38;
              rd <= rd_29;
              funct3 <= funct3_49;
              rs1 <= rs1_35;
              imm <= ({
({20{(_original__subset_31_20_instr_14[11])}}), /* 31:12 */
_original__subset_31_20_instr_14  /* 11: 0 */
});
              done <= 1'h1;
          end           else if(((((instr & 32'hfe10707f) == 32'h100073) & 1'h1) & 1'h1)) begin
              valid <= 1'h1;
              index <= 9'h14c;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              is_IType <= 1'h1;
              opcode <= opcode_39;
              rd <= rd_30;
              funct3 <= funct3_50;
              rs1 <= rs1_36;
              imm <= ({
({20{(_original__subset_31_20_instr_15[11])}}), /* 31:12 */
_original__subset_31_20_instr_15  /* 11: 0 */
});
              done <= 1'h1;
          end           else begin
              valid <= 1'h0;
              index <= 9'h0;
              done <= 1'h1;
              is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
              is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
              is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
              is_CJType <= 1'h0;
              is_CBType <= 1'h0;
              is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
              is_Unknown_op_rs2_imm_funct3 <= 1'h0;
              is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
              is_UType <= 1'h0;
              is_JType <= 1'h0;
              is_IType <= 1'h0;
              is_BType <= 1'h0;
              is_SType <= 1'h0;
              is_RType <= 1'h0;
              op <= 2'h0;
              rd_prime <= 3'h0;
              imm <= 32'h0;
              funct3 <= 3'h0;
              imm_lo <= 5'h0;
              rs1_prime <= 3'h0;
              imm_hi <= 3'h0;
              rs2_prime <= 3'h0;
              rd_rs1 <= 5'h0;
              jump_target <= 11'h0;
              offset_lo <= 5'h0;
              offset_hi <= 3'h0;
              funct2 <= 2'h0;
              rd_rs1_prime <= 3'h0;
              funct6 <= 6'h0;
              rs2 <= 5'h0;
              funct4 <= 4'h0;
              opcode <= 7'h0;
              rd <= 5'h0;
              rs1 <= 5'h0;
              immLo <= 5'h0;
              immHi <= 7'h0;
              funct7 <= 7'h0;
          end 

      end       else begin
          valid <= 1'h0;
          index <= 9'h0;
          done <= 1'h0;
          is_Unknown_op_rd_prime_imm_funct3 <= 1'h0;
          is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
          is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h0;
          is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h0;
          is_CJType <= 1'h0;
          is_CBType <= 1'h0;
          is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h0;
          is_Unknown_op_rs2_imm_funct3 <= 1'h0;
          is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h0;
          is_UType <= 1'h0;
          is_JType <= 1'h0;
          is_IType <= 1'h0;
          is_BType <= 1'h0;
          is_SType <= 1'h0;
          is_RType <= 1'h0;
          op <= 2'h0;
          rd_prime <= 3'h0;
          imm <= 32'h0;
          funct3 <= 3'h0;
          imm_lo <= 5'h0;
          rs1_prime <= 3'h0;
          imm_hi <= 3'h0;
          rs2_prime <= 3'h0;
          rd_rs1 <= 5'h0;
          jump_target <= 11'h0;
          offset_lo <= 5'h0;
          offset_hi <= 3'h0;
          funct2 <= 2'h0;
          rd_rs1_prime <= 3'h0;
          funct6 <= 6'h0;
          rs2 <= 5'h0;
          funct4 <= 4'h0;
          opcode <= 7'h0;
          rd <= 5'h0;
          rs1 <= 5'h0;
          immLo <= 5'h0;
          immHi <= 7'h0;
          funct7 <= 7'h0;
      end 

  end 

end

assign {_counter_add_const_1_carry, _in46__counter_add_const_1} = counter + 32'h1;
assign op_0 = (instr[1:0]);  // swizzle
assign rd_prime_0 = (instr[4:2]);  // swizzle_0
assign funct3_0 = (instr[15:13]);  // swizzle_1
assign op_1 = (instr[1:0]);  // swizzle_5
assign rd_prime_1 = (instr[4:2]);  // swizzle_6
assign imm_lo_0 = {
3'h0, /* 4:2 */
(instr[6:5])  /* 1:0 */
};  // swizzle_7
assign rs1_prime_0 = (instr[9:7]);  // swizzle_8
assign imm_hi_0 = (instr[12:10]);  // swizzle_9
assign funct3_1 = (instr[15:13]);  // swizzle_10
assign op_2 = (instr[1:0]);  // swizzle_15
assign rs2_prime_0 = (instr[4:2]);  // swizzle_16
assign imm_lo_1 = {
3'h0, /* 4:2 */
(instr[6:5])  /* 1:0 */
};  // swizzle_17
assign rs1_prime_1 = (instr[9:7]);  // swizzle_18
assign imm_hi_1 = (instr[12:10]);  // swizzle_19
assign funct3_2 = (instr[15:13]);  // swizzle_20
assign op_3 = (instr[1:0]);  // swizzle_25
assign imm_lo_2 = (instr[6:2]);  // swizzle_26
assign rd_rs1_0 = (instr[11:7]);  // swizzle_27
assign imm_hi_2 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_28
assign funct3_3 = (instr[15:13]);  // swizzle_29
assign _original__swizzled = {
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
};  // swizzle_33
assign op_4 = (instr[1:0]);  // swizzle_34
assign imm_lo_3 = (instr[6:2]);  // swizzle_35
assign rd_rs1_1 = (instr[11:7]);  // swizzle_36
assign imm_hi_3 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_37
assign funct3_4 = (instr[15:13]);  // swizzle_38
assign _in0 = {
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
};  // swizzle_42
assign op_5 = (instr[1:0]);  // swizzle_43
assign imm_lo_4 = (instr[6:2]);  // swizzle_44
assign rd_rs1_2 = (instr[11:7]);  // swizzle_45
assign imm_hi_4 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_46
assign funct3_5 = (instr[15:13]);  // swizzle_47
assign _swizzled = {
(instr[12]), /*   9 */
(instr[4]), /*   8 */
(instr[3]), /*   7 */
(instr[5]), /*   6 */
(instr[2]), /*   5 */
(instr[6]), /*   4 */
4'h0  /* 3:0 */
};  // swizzle_49
assign op_6 = (instr[1:0]);  // swizzle_50
assign imm_lo_5 = (instr[6:2]);  // swizzle_51
assign rd_rs1_3 = (instr[11:7]);  // swizzle_52
assign imm_hi_5 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_53
assign funct3_6 = (instr[15:13]);  // swizzle_54
assign _original__swizzled_0 = {
(instr[12]), /*   17 */
(instr[6]), /*   16 */
(instr[5]), /*   15 */
(instr[4]), /*   14 */
(instr[3]), /*   13 */
(instr[2]), /*   12 */
12'h0  /* 11:0 */
};  // swizzle_58
assign op_7 = (instr[1:0]);  // swizzle_59
assign jump_target_0 = (instr[12:2]);  // swizzle_60
assign funct3_7 = (instr[15:13]);  // swizzle_61
assign _original__swizzled_1 = {
(instr[12]), /* 11 */
(instr[8]), /* 10 */
(instr[10]), /*  9 */
(instr[9]), /*  8 */
(instr[6]), /*  7 */
(instr[7]), /*  6 */
(instr[2]), /*  5 */
(instr[11]), /*  4 */
(instr[5]), /*  3 */
(instr[4]), /*  2 */
(instr[3]), /*  1 */
1'h0  /*  0 */
};  // swizzle_63
assign op_8 = (instr[1:0]);  // swizzle_64
assign jump_target_1 = (instr[12:2]);  // swizzle_65
assign funct3_8 = (instr[15:13]);  // swizzle_66
assign _original__swizzled_2 = {
(instr[12]), /* 11 */
(instr[8]), /* 10 */
(instr[10]), /*  9 */
(instr[9]), /*  8 */
(instr[6]), /*  7 */
(instr[7]), /*  6 */
(instr[2]), /*  5 */
(instr[11]), /*  4 */
(instr[5]), /*  3 */
(instr[4]), /*  2 */
(instr[3]), /*  1 */
1'h0  /*  0 */
};  // swizzle_68
assign op_9 = (instr[1:0]);  // swizzle_69
assign offset_lo_0 = (instr[6:2]);  // swizzle_70
assign rs1_prime_2 = (instr[9:7]);  // swizzle_71
assign offset_hi_0 = (instr[12:10]);  // swizzle_72
assign funct3_9 = (instr[15:13]);  // swizzle_73
assign _original__swizzled_3 = {
(instr[12]), /* 8 */
(instr[6]), /* 7 */
(instr[5]), /* 6 */
(instr[2]), /* 5 */
(instr[11]), /* 4 */
(instr[10]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
1'h0  /* 0 */
};  // swizzle_76
assign op_10 = (instr[1:0]);  // swizzle_77
assign offset_lo_1 = (instr[6:2]);  // swizzle_78
assign rs1_prime_3 = (instr[9:7]);  // swizzle_79
assign offset_hi_1 = (instr[12:10]);  // swizzle_80
assign funct3_10 = (instr[15:13]);  // swizzle_81
assign _original__swizzled_4 = {
(instr[12]), /* 8 */
(instr[6]), /* 7 */
(instr[5]), /* 6 */
(instr[2]), /* 5 */
(instr[11]), /* 4 */
(instr[10]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
1'h0  /* 0 */
};  // swizzle_84
assign op_11 = (instr[1:0]);  // swizzle_85
assign rs2_prime_1 = (instr[4:2]);  // swizzle_86
assign funct2_0 = (instr[6:5]);  // swizzle_87
assign rd_rs1_prime_0 = (instr[9:7]);  // swizzle_88
assign funct6_0 = (instr[15:10]);  // swizzle_89
assign op_12 = (instr[1:0]);  // swizzle_95
assign rs2_prime_2 = (instr[4:2]);  // swizzle_96
assign funct2_1 = (instr[6:5]);  // swizzle_97
assign rd_rs1_prime_1 = (instr[9:7]);  // swizzle_98
assign funct6_1 = (instr[15:10]);  // swizzle_99
assign op_13 = (instr[1:0]);  // swizzle_105
assign rs2_prime_3 = (instr[4:2]);  // swizzle_106
assign funct2_2 = (instr[6:5]);  // swizzle_107
assign rd_rs1_prime_2 = (instr[9:7]);  // swizzle_108
assign funct6_2 = (instr[15:10]);  // swizzle_109
assign _original__swizzled_5 = {
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
};  // swizzle_114
assign op_14 = (instr[1:0]);  // swizzle_115
assign rs2_prime_4 = (instr[4:2]);  // swizzle_116
assign funct2_3 = (instr[6:5]);  // swizzle_117
assign rd_rs1_prime_3 = (instr[9:7]);  // swizzle_118
assign funct6_3 = (instr[15:10]);  // swizzle_119
assign op_15 = (instr[1:0]);  // swizzle_123
assign rs2_prime_5 = (instr[4:2]);  // swizzle_124
assign funct2_4 = (instr[6:5]);  // swizzle_125
assign rd_rs1_prime_4 = (instr[9:7]);  // swizzle_126
assign funct6_4 = (instr[15:10]);  // swizzle_127
assign op_16 = (instr[1:0]);  // swizzle_131
assign rs2_prime_6 = (instr[4:2]);  // swizzle_132
assign funct2_5 = (instr[6:5]);  // swizzle_133
assign rd_rs1_prime_5 = (instr[9:7]);  // swizzle_134
assign funct6_5 = (instr[15:10]);  // swizzle_135
assign op_17 = (instr[1:0]);  // swizzle_139
assign rs2_prime_7 = (instr[4:2]);  // swizzle_140
assign funct2_6 = (instr[6:5]);  // swizzle_141
assign rd_rs1_prime_6 = (instr[9:7]);  // swizzle_142
assign funct6_6 = (instr[15:10]);  // swizzle_143
assign op_18 = (instr[1:0]);  // swizzle_147
assign imm_lo_6 = (instr[6:2]);  // swizzle_148
assign rd_rs1_4 = (instr[11:7]);  // swizzle_149
assign imm_hi_6 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_150
assign funct3_11 = (instr[15:13]);  // swizzle_151
assign op_19 = (instr[1:0]);  // swizzle_156
assign imm_lo_7 = (instr[6:2]);  // swizzle_157
assign rd_rs1_5 = (instr[11:7]);  // swizzle_158
assign imm_hi_7 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_159
assign funct3_12 = (instr[15:13]);  // swizzle_160
assign op_20 = (instr[1:0]);  // swizzle_164
assign rs2_0 = (instr[6:2]);  // swizzle_165
assign funct3_13 = (instr[15:13]);  // swizzle_166
assign op_21 = (instr[1:0]);  // swizzle_170
assign rs2_1 = (instr[6:2]);  // swizzle_171
assign rd_rs1_6 = (instr[11:7]);  // swizzle_172
assign funct4_0 = (instr[15:12]);  // swizzle_173
assign op_22 = (instr[1:0]);  // swizzle_177
assign rs2_2 = (instr[6:2]);  // swizzle_178
assign rd_rs1_7 = (instr[11:7]);  // swizzle_179
assign funct4_1 = (instr[15:12]);  // swizzle_180
assign op_23 = (instr[1:0]);  // swizzle_184
assign rs2_3 = (instr[6:2]);  // swizzle_185
assign rd_rs1_8 = (instr[11:7]);  // swizzle_186
assign funct4_2 = (instr[15:12]);  // swizzle_187
assign op_24 = (instr[1:0]);  // swizzle_191
assign rs2_4 = (instr[6:2]);  // swizzle_192
assign rd_rs1_9 = (instr[11:7]);  // swizzle_193
assign funct4_3 = (instr[15:12]);  // swizzle_194
assign op_25 = (instr[1:0]);  // swizzle_197
assign rs2_5 = (instr[6:2]);  // swizzle_198
assign rd_rs1_10 = (instr[11:7]);  // swizzle_199
assign funct4_4 = (instr[15:12]);  // swizzle_200
assign opcode_0 = (instr[6:0]);  // swizzle_204
assign rd_0 = (instr[11:7]);  // swizzle_205
assign opcode_1 = (instr[6:0]);  // swizzle_207
assign rd_1 = (instr[11:7]);  // swizzle_208
assign opcode_2 = (instr[6:0]);  // swizzle_210
assign rd_2 = (instr[11:7]);  // swizzle_211
assign _original__swizzled_6 = {
(instr[31]), /*    20 */
(instr[19:12]), /* 19:12 */
(instr[20]), /*    11 */
(instr[30:21]), /* 10: 1 */
1'h0  /*     0 */
};  // swizzle_213
assign opcode_3 = (instr[6:0]);  // swizzle_214
assign rd_3 = (instr[11:7]);  // swizzle_215
assign funct3_14 = (instr[14:12]);  // swizzle_216
assign rs1_0 = (instr[19:15]);  // swizzle_217
assign _original__subset_31_20_instr = instr[31:20];  // bussubset_312
assign opcode_4 = (instr[6:0]);  // swizzle_219
assign immLo_0 = (instr[11:7]);  // swizzle_220
assign funct3_15 = (instr[14:12]);  // swizzle_221
assign rs1_1 = (instr[19:15]);  // swizzle_222
assign rs2_6 = (instr[24:20]);  // swizzle_223
assign immHi_0 = (instr[31:25]);  // swizzle_224
assign _original__swizzled_7 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_226
assign opcode_5 = (instr[6:0]);  // swizzle_227
assign immLo_1 = (instr[11:7]);  // swizzle_228
assign funct3_16 = (instr[14:12]);  // swizzle_229
assign rs1_2 = (instr[19:15]);  // swizzle_230
assign rs2_7 = (instr[24:20]);  // swizzle_231
assign immHi_1 = (instr[31:25]);  // swizzle_232
assign _original__swizzled_8 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_234
assign opcode_6 = (instr[6:0]);  // swizzle_235
assign immLo_2 = (instr[11:7]);  // swizzle_236
assign funct3_17 = (instr[14:12]);  // swizzle_237
assign rs1_3 = (instr[19:15]);  // swizzle_238
assign rs2_8 = (instr[24:20]);  // swizzle_239
assign immHi_2 = (instr[31:25]);  // swizzle_240
assign _original__swizzled_9 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_242
assign opcode_7 = (instr[6:0]);  // swizzle_243
assign immLo_3 = (instr[11:7]);  // swizzle_244
assign funct3_18 = (instr[14:12]);  // swizzle_245
assign rs1_4 = (instr[19:15]);  // swizzle_246
assign rs2_9 = (instr[24:20]);  // swizzle_247
assign immHi_3 = (instr[31:25]);  // swizzle_248
assign _original__swizzled_10 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_250
assign opcode_8 = (instr[6:0]);  // swizzle_251
assign immLo_4 = (instr[11:7]);  // swizzle_252
assign funct3_19 = (instr[14:12]);  // swizzle_253
assign rs1_5 = (instr[19:15]);  // swizzle_254
assign rs2_10 = (instr[24:20]);  // swizzle_255
assign immHi_4 = (instr[31:25]);  // swizzle_256
assign _original__swizzled_11 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_258
assign opcode_9 = (instr[6:0]);  // swizzle_259
assign immLo_5 = (instr[11:7]);  // swizzle_260
assign funct3_20 = (instr[14:12]);  // swizzle_261
assign rs1_6 = (instr[19:15]);  // swizzle_262
assign rs2_11 = (instr[24:20]);  // swizzle_263
assign immHi_5 = (instr[31:25]);  // swizzle_264
assign _original__swizzled_12 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_266
assign opcode_10 = (instr[6:0]);  // swizzle_267
assign rd_4 = (instr[11:7]);  // swizzle_268
assign funct3_21 = (instr[14:12]);  // swizzle_269
assign rs1_7 = (instr[19:15]);  // swizzle_270
assign _subset_31_20_instr = instr[31:20];  // bussubset_384
assign opcode_11 = (instr[6:0]);  // swizzle_272
assign rd_5 = (instr[11:7]);  // swizzle_273
assign funct3_22 = (instr[14:12]);  // swizzle_274
assign rs1_8 = (instr[19:15]);  // swizzle_275
assign _original__subset_31_20_instr_0 = instr[31:20];  // bussubset_390
assign opcode_12 = (instr[6:0]);  // swizzle_277
assign rd_6 = (instr[11:7]);  // swizzle_278
assign funct3_23 = (instr[14:12]);  // swizzle_279
assign rs1_9 = (instr[19:15]);  // swizzle_280
assign _original__subset_31_20_instr_1 = instr[31:20];  // bussubset_396
assign opcode_13 = (instr[6:0]);  // swizzle_282
assign rd_7 = (instr[11:7]);  // swizzle_283
assign funct3_24 = (instr[14:12]);  // swizzle_284
assign rs1_10 = (instr[19:15]);  // swizzle_285
assign _original__subset_31_20_instr_2 = instr[31:20];  // bussubset_402
assign opcode_14 = (instr[6:0]);  // swizzle_287
assign rd_8 = (instr[11:7]);  // swizzle_288
assign funct3_25 = (instr[14:12]);  // swizzle_289
assign rs1_11 = (instr[19:15]);  // swizzle_290
assign _original__subset_31_20_instr_3 = instr[31:20];  // bussubset_408
assign opcode_15 = (instr[6:0]);  // swizzle_292
assign immLo_6 = (instr[11:7]);  // swizzle_293
assign funct3_26 = (instr[14:12]);  // swizzle_294
assign rs1_12 = (instr[19:15]);  // swizzle_295
assign rs2_12 = (instr[24:20]);  // swizzle_296
assign immHi_6 = (instr[31:25]);  // swizzle_297
assign opcode_16 = (instr[6:0]);  // swizzle_300
assign immLo_7 = (instr[11:7]);  // swizzle_301
assign funct3_27 = (instr[14:12]);  // swizzle_302
assign rs1_13 = (instr[19:15]);  // swizzle_303
assign rs2_13 = (instr[24:20]);  // swizzle_304
assign immHi_7 = (instr[31:25]);  // swizzle_305
assign opcode_17 = (instr[6:0]);  // swizzle_308
assign immLo_8 = (instr[11:7]);  // swizzle_309
assign funct3_28 = (instr[14:12]);  // swizzle_310
assign rs1_14 = (instr[19:15]);  // swizzle_311
assign rs2_14 = (instr[24:20]);  // swizzle_312
assign immHi_8 = (instr[31:25]);  // swizzle_313
assign opcode_18 = (instr[6:0]);  // swizzle_316
assign rd_9 = (instr[11:7]);  // swizzle_317
assign funct3_29 = (instr[14:12]);  // swizzle_318
assign rs1_15 = (instr[19:15]);  // swizzle_319
assign _original__subset_31_20_instr_4 = instr[31:20];  // bussubset_438
assign opcode_19 = (instr[6:0]);  // swizzle_321
assign rd_10 = (instr[11:7]);  // swizzle_322
assign funct3_30 = (instr[14:12]);  // swizzle_323
assign rs1_16 = (instr[19:15]);  // swizzle_324
assign _original__subset_31_20_instr_5 = instr[31:20];  // bussubset_444
assign opcode_20 = (instr[6:0]);  // swizzle_326
assign rd_11 = (instr[11:7]);  // swizzle_327
assign funct3_31 = (instr[14:12]);  // swizzle_328
assign rs1_17 = (instr[19:15]);  // swizzle_329
assign _original__subset_31_20_instr_6 = instr[31:20];  // bussubset_450
assign opcode_21 = (instr[6:0]);  // swizzle_331
assign rd_12 = (instr[11:7]);  // swizzle_332
assign funct3_32 = (instr[14:12]);  // swizzle_333
assign rs1_18 = (instr[19:15]);  // swizzle_334
assign _original__subset_31_20_instr_7 = instr[31:20];  // bussubset_456
assign opcode_22 = (instr[6:0]);  // swizzle_336
assign rd_13 = (instr[11:7]);  // swizzle_337
assign funct3_33 = (instr[14:12]);  // swizzle_338
assign rs1_19 = (instr[19:15]);  // swizzle_339
assign _original__subset_31_20_instr_8 = instr[31:20];  // bussubset_462
assign opcode_23 = (instr[6:0]);  // swizzle_341
assign rd_14 = (instr[11:7]);  // swizzle_342
assign funct3_34 = (instr[14:12]);  // swizzle_343
assign rs1_20 = (instr[19:15]);  // swizzle_344
assign _original__subset_31_20_instr_9 = instr[31:20];  // bussubset_468
assign opcode_24 = (instr[6:0]);  // swizzle_346
assign rd_15 = (instr[11:7]);  // swizzle_347
assign funct3_35 = (instr[14:12]);  // swizzle_348
assign rs1_21 = (instr[19:15]);  // swizzle_349
assign _original__subset_31_20_instr_10 = instr[31:20];  // bussubset_474
assign opcode_25 = (instr[6:0]);  // swizzle_351
assign rd_16 = (instr[11:7]);  // swizzle_352
assign funct3_36 = (instr[14:12]);  // swizzle_353
assign rs1_22 = (instr[19:15]);  // swizzle_354
assign _original__subset_31_20_instr_11 = instr[31:20];  // bussubset_480
assign opcode_26 = (instr[6:0]);  // swizzle_356
assign rd_17 = (instr[11:7]);  // swizzle_357
assign funct3_37 = (instr[14:12]);  // swizzle_358
assign rs1_23 = (instr[19:15]);  // swizzle_359
assign _original__subset_31_20_instr_12 = instr[31:20];  // bussubset_486
assign opcode_27 = (instr[6:0]);  // swizzle_361
assign rd_18 = (instr[11:7]);  // swizzle_362
assign funct3_38 = (instr[14:12]);  // swizzle_363
assign rs1_24 = (instr[19:15]);  // swizzle_364
assign rs2_15 = (instr[24:20]);  // swizzle_365
assign funct7_0 = (instr[31:25]);  // swizzle_366
assign opcode_28 = (instr[6:0]);  // swizzle_367
assign rd_19 = (instr[11:7]);  // swizzle_368
assign funct3_39 = (instr[14:12]);  // swizzle_369
assign rs1_25 = (instr[19:15]);  // swizzle_370
assign rs2_16 = (instr[24:20]);  // swizzle_371
assign funct7_1 = (instr[31:25]);  // swizzle_372
assign opcode_29 = (instr[6:0]);  // swizzle_373
assign rd_20 = (instr[11:7]);  // swizzle_374
assign funct3_40 = (instr[14:12]);  // swizzle_375
assign rs1_26 = (instr[19:15]);  // swizzle_376
assign rs2_17 = (instr[24:20]);  // swizzle_377
assign funct7_2 = (instr[31:25]);  // swizzle_378
assign opcode_30 = (instr[6:0]);  // swizzle_379
assign rd_21 = (instr[11:7]);  // swizzle_380
assign funct3_41 = (instr[14:12]);  // swizzle_381
assign rs1_27 = (instr[19:15]);  // swizzle_382
assign rs2_18 = (instr[24:20]);  // swizzle_383
assign funct7_3 = (instr[31:25]);  // swizzle_384
assign opcode_31 = (instr[6:0]);  // swizzle_385
assign rd_22 = (instr[11:7]);  // swizzle_386
assign funct3_42 = (instr[14:12]);  // swizzle_387
assign rs1_28 = (instr[19:15]);  // swizzle_388
assign rs2_19 = (instr[24:20]);  // swizzle_389
assign funct7_4 = (instr[31:25]);  // swizzle_390
assign opcode_32 = (instr[6:0]);  // swizzle_391
assign rd_23 = (instr[11:7]);  // swizzle_392
assign funct3_43 = (instr[14:12]);  // swizzle_393
assign rs1_29 = (instr[19:15]);  // swizzle_394
assign rs2_20 = (instr[24:20]);  // swizzle_395
assign funct7_5 = (instr[31:25]);  // swizzle_396
assign opcode_33 = (instr[6:0]);  // swizzle_397
assign rd_24 = (instr[11:7]);  // swizzle_398
assign funct3_44 = (instr[14:12]);  // swizzle_399
assign rs1_30 = (instr[19:15]);  // swizzle_400
assign rs2_21 = (instr[24:20]);  // swizzle_401
assign funct7_6 = (instr[31:25]);  // swizzle_402
assign opcode_34 = (instr[6:0]);  // swizzle_403
assign rd_25 = (instr[11:7]);  // swizzle_404
assign funct3_45 = (instr[14:12]);  // swizzle_405
assign rs1_31 = (instr[19:15]);  // swizzle_406
assign rs2_22 = (instr[24:20]);  // swizzle_407
assign funct7_7 = (instr[31:25]);  // swizzle_408
assign opcode_35 = (instr[6:0]);  // swizzle_409
assign rd_26 = (instr[11:7]);  // swizzle_410
assign funct3_46 = (instr[14:12]);  // swizzle_411
assign rs1_32 = (instr[19:15]);  // swizzle_412
assign rs2_23 = (instr[24:20]);  // swizzle_413
assign funct7_8 = (instr[31:25]);  // swizzle_414
assign opcode_36 = (instr[6:0]);  // swizzle_415
assign rd_27 = (instr[11:7]);  // swizzle_416
assign funct3_47 = (instr[14:12]);  // swizzle_417
assign rs1_33 = (instr[19:15]);  // swizzle_418
assign rs2_24 = (instr[24:20]);  // swizzle_419
assign funct7_9 = (instr[31:25]);  // swizzle_420
assign opcode_37 = (instr[6:0]);  // swizzle_421
assign rd_28 = (instr[11:7]);  // swizzle_422
assign funct3_48 = (instr[14:12]);  // swizzle_423
assign rs1_34 = (instr[19:15]);  // swizzle_424
assign _original__subset_31_20_instr_13 = instr[31:20];  // bussubset_552
assign opcode_38 = (instr[6:0]);  // swizzle_426
assign rd_29 = (instr[11:7]);  // swizzle_427
assign funct3_49 = (instr[14:12]);  // swizzle_428
assign rs1_35 = (instr[19:15]);  // swizzle_429
assign _original__subset_31_20_instr_14 = instr[31:20];  // bussubset_558
assign opcode_39 = (instr[6:0]);  // swizzle_431
assign rd_30 = (instr[11:7]);  // swizzle_432
assign funct3_50 = (instr[14:12]);  // swizzle_433
assign rs1_36 = (instr[19:15]);  // swizzle_434
assign _original__subset_31_20_instr_15 = instr[31:20];  // bussubset_564
endmodule : StaticInstructionDecoder