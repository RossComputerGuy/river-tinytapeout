module DynamicInstructionDecoder (
input logic clk,
input logic reset,
input logic enable,
input logic [31:0] instr,
input logic [31:0] pc_in,
input logic [140:0] microcodeRead_data,
input logic microcodeRead_done,
input logic microcodeRead_valid,
output logic microcodeRead_en,
output logic [6:0] microcodeRead_addr,
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
logic _counter_add_const_1_carry_0;
logic [8:0] _in0;
logic [31:0] _in1__subset_108_77_data;
logic [31:0] _in1__subset_140_109_data;
logic [6:0] _in376__counter_add_const_1;
logic [31:0] _in50__counter_add_const_1;
logic [11:0] _original__subset_31_20_instr;
logic [11:0] _original__swizzled;
logic [20:0] _original__swizzled_0;
logic [12:0] _original__swizzled_1;
logic [5:0] _original__swizzled_10;
logic [5:0] _original__swizzled_2;
logic [5:0] _original__swizzled_3;
logic [9:0] _original__swizzled_4;
logic [17:0] _original__swizzled_5;
logic [11:0] _original__swizzled_6;
logic [11:0] _original__swizzled_7;
logic [8:0] _original__swizzled_8;
logic [8:0] _original__swizzled_9;
logic [8:0] _swizzled;
logic [6:0] counter_0;
logic [1:0] funct2_0;
logic [2:0] funct3_0;
logic [2:0] funct3_1;
logic [2:0] funct3_10;
logic [2:0] funct3_2;
logic [2:0] funct3_3;
logic [2:0] funct3_4;
logic [2:0] funct3_5;
logic [2:0] funct3_6;
logic [2:0] funct3_7;
logic [2:0] funct3_8;
logic [2:0] funct3_9;
logic [3:0] funct4_0;
logic [5:0] funct6_0;
logic [6:0] funct7_0;
logic held;
logic [6:0] immHi_0;
logic [6:0] immHi_1;
logic [4:0] immLo_0;
logic [4:0] immLo_1;
logic [2:0] imm_hi_0;
logic [2:0] imm_hi_1;
logic [2:0] imm_hi_2;
logic [4:0] imm_lo_0;
logic [4:0] imm_lo_1;
logic [4:0] imm_lo_2;
logic [10:0] jump_target_0;
logic nzfMatch;
logic [2:0] offset_hi_0;
logic [4:0] offset_lo_0;
logic [1:0] op_0;
logic [1:0] op_1;
logic [1:0] op_2;
logic [1:0] op_3;
logic [1:0] op_4;
logic [1:0] op_5;
logic [1:0] op_6;
logic [1:0] op_7;
logic [1:0] op_8;
logic [6:0] opcode_0;
logic [6:0] opcode_1;
logic [6:0] opcode_2;
logic [6:0] opcode_3;
logic [6:0] opcode_4;
logic [6:0] opcode_5;
logic patternMatch;
logic [4:0] rd_0;
logic [4:0] rd_1;
logic [4:0] rd_2;
logic [4:0] rd_3;
logic [2:0] rd_prime_0;
logic [2:0] rd_prime_1;
logic [4:0] rd_rs1_0;
logic [4:0] rd_rs1_1;
logic [2:0] rd_rs1_prime_0;
logic [4:0] rs1_0;
logic [4:0] rs1_1;
logic [4:0] rs1_2;
logic [4:0] rs1_3;
logic [2:0] rs1_prime_0;
logic [2:0] rs1_prime_1;
logic [2:0] rs1_prime_2;
logic [4:0] rs2_0;
logic [4:0] rs2_1;
logic [4:0] rs2_2;
logic [4:0] rs2_3;
logic [4:0] rs2_4;
logic [2:0] rs2_prime_0;
logic [2:0] rs2_prime_1;
logic zfMatch;
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      valid <= 1'h0;
      index <= 9'h0;
      done <= 1'h0;
      counter <= 32'h0;
      pc_out <= 32'h0;
      microcodeRead_en <= 1'h0;
      microcodeRead_addr <= 7'h0;
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
      counter_0 <= 7'h0;
      held <= 1'h0;
  end   else begin
      if(enable) begin
          counter <= _in50__counter_add_const_1;
          pc_out <= pc_in;
          if(held) begin
              microcodeRead_en <= 1'h0;
              done <= 1'h1;
              valid <= 1'h1;
          end           else begin
              microcodeRead_en <= 1'h1;
              microcodeRead_addr <= counter_0;
              if(microcodeRead_done) begin
                  if(microcodeRead_valid) begin
                      if(((patternMatch & nzfMatch) & zfMatch)) begin
                          held <= 1'h1;
                          index <= (_in0);
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
                          case ((microcodeRead_data[76:73])) 
                              4'h0 : begin
                                  is_Unknown_op_rd_prime_imm_funct3 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_0;
                                  rd_prime <= rd_prime_0;
                                  funct3 <= funct3_0;
                                  imm <= 32'h0;
                              end
                              4'h1 : begin
                                  is_Unknown_op_rd_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_1;
                                  rd_prime <= rd_prime_1;
                                  imm_lo <= imm_lo_0;
                                  rs1_prime <= rs1_prime_0;
                                  imm_hi <= imm_hi_0;
                                  funct3 <= funct3_1;
                                  imm <= 32'h0;
                              end
                              4'h2 : begin
                                  is_Unknown_op_rs2_prime_imm_lo_rs1_prime_imm_hi_funct3 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_2;
                                  rs2_prime <= rs2_prime_0;
                                  imm_lo <= imm_lo_1;
                                  rs1_prime <= rs1_prime_1;
                                  imm_hi <= imm_hi_1;
                                  funct3 <= funct3_2;
                                  imm <= 32'h0;
                              end
                              4'h3 : begin
                                  is_Unknown_op_imm_lo_rd_rs1_imm_hi_funct3 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_3;
                                  imm_lo <= imm_lo_2;
                                  rd_rs1 <= rd_rs1_0;
                                  imm_hi <= imm_hi_2;
                                  funct3 <= funct3_3;
                                  imm <= 32'h0;
                              end
                              4'h4 : begin
                                  is_CJType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_4;
                                  jump_target <= jump_target_0;
                                  funct3 <= funct3_4;
                                  imm <= ({
({20{(_original__swizzled[11])}}), /* 31:12 */
_original__swizzled  /* 11: 0 */
});
                              end
                              4'h5 : begin
                                  is_CBType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_5;
                                  offset_lo <= offset_lo_0;
                                  rs1_prime <= rs1_prime_2;
                                  offset_hi <= offset_hi_0;
                                  funct3 <= funct3_5;
                                  imm <= ({
({23{(_swizzled[8])}}), /* 31:9 */
_swizzled  /*  8:0 */
});
                              end
                              4'h6 : begin
                                  is_Unknown_op_rs2_prime_funct2_rd_rs1_prime_funct6 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_6;
                                  rs2_prime <= rs2_prime_1;
                                  funct2 <= funct2_0;
                                  rd_rs1_prime <= rd_rs1_prime_0;
                                  funct6 <= funct6_0;
                                  imm <= 32'h0;
                              end
                              4'h7 : begin
                                  is_Unknown_op_rs2_imm_funct3 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_7;
                                  rs2 <= rs2_0;
                                  funct3 <= funct3_6;
                                  imm <= 32'h0;
                              end
                              4'h8 : begin
                                  is_Unknown_op_rs2_rd_rs1_funct4 <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  op <= op_8;
                                  rs2 <= rs2_1;
                                  rd_rs1 <= rd_rs1_1;
                                  funct4 <= funct4_0;
                                  imm <= 32'h0;
                              end
                              4'h9 : begin
                                  is_UType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  opcode <= opcode_0;
                                  rd <= rd_0;
                                  imm <= ({
(instr[31:12]), /* 31:12 */
12'h0  /* 11: 0 */
});
                              end
                              4'ha : begin
                                  is_JType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  opcode <= opcode_1;
                                  rd <= rd_1;
                                  imm <= ({
({11{(_original__swizzled_0[20])}}), /* 31:21 */
_original__swizzled_0  /* 20: 0 */
});
                              end
                              4'hb : begin
                                  is_IType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  opcode <= opcode_2;
                                  rd <= rd_2;
                                  funct3 <= funct3_7;
                                  rs1 <= rs1_0;
                                  imm <= ({
({20{(_original__subset_31_20_instr[11])}}), /* 31:12 */
_original__subset_31_20_instr  /* 11: 0 */
});
                              end
                              4'hc : begin
                                  is_BType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  opcode <= opcode_3;
                                  immLo <= immLo_0;
                                  funct3 <= funct3_8;
                                  rs1 <= rs1_1;
                                  rs2 <= rs2_2;
                                  immHi <= immHi_0;
                                  imm <= ({
({19{(_original__swizzled_1[12])}}), /* 31:13 */
_original__swizzled_1  /* 12: 0 */
});
                              end
                              4'hd : begin
                                  is_SType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  opcode <= opcode_4;
                                  immLo <= immLo_1;
                                  funct3 <= funct3_9;
                                  rs1 <= rs1_2;
                                  rs2 <= rs2_3;
                                  immHi <= immHi_1;
                                  imm <= ({
20'h0, /* 31:12 */
({
(instr[31:25]), /* 11:5 */
(instr[11:7])  /*  4:0 */
})  /* 11: 0 */
});
                              end
                              4'he : begin
                                  is_RType <= 1'h1;
                                  done <= 1'h1;
                                  valid <= 1'h1;
                                  opcode <= opcode_5;
                                  rd <= rd_3;
                                  funct3 <= funct3_10;
                                  rs1 <= rs1_3;
                                  rs2 <= rs2_4;
                                  funct7 <= funct7_0;
                                  imm <= 32'h0;
                              end
                          endcase

                          case (_in0) 
                              9'h0 : begin
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
                              end
                              9'h5 : begin
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
                              end
                              9'hb : begin
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
                              end
                              9'h11 : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= 5'h0;
                                  imm <= ({
({26{(_original__swizzled_2[5])}}), /* 31:6 */
_original__swizzled_2  /*  5:0 */
});
                              end
                              9'h16 : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= 5'h0;
                                  imm <= ({
({26{(_original__swizzled_3[5])}}), /* 31:6 */
_original__swizzled_3  /*  5:0 */
});
                              end
                              9'h19 : begin
                                  rd <= 5'h2;
                                  rs1 <= 5'h2;
                                  rs2 <= 5'h0;
                                  imm <= ({
({22{(_original__swizzled_4[9])}}), /* 31:10 */
_original__swizzled_4  /*  9: 0 */
});
                              end
                              9'h1e : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= 5'h0;
                                  imm <= ({
({14{(_original__swizzled_5[17])}}), /* 31:18 */
_original__swizzled_5  /* 17: 0 */
});
                              end
                              9'h21 : begin
                                  rd <= 5'h0;
                                  rs1 <= 5'h0;
                                  rs2 <= 5'h0;
                                  imm <= ({
({20{(_original__swizzled_6[11])}}), /* 31:12 */
_original__swizzled_6  /* 11: 0 */
});
                              end
                              9'h23 : begin
                                  rd <= 5'h1;
                                  rs1 <= 5'h0;
                                  rs2 <= 5'h0;
                                  imm <= ({
({20{(_original__swizzled_7[11])}}), /* 31:12 */
_original__swizzled_7  /* 11: 0 */
});
                              end
                              9'h26 : begin
                                  rd <= 5'h0;
                                  rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
                                  rs2 <= 5'h0;
                                  imm <= ({
({23{(_original__swizzled_8[8])}}), /* 31:9 */
_original__swizzled_8  /*  8:0 */
});
                              end
                              9'h2a : begin
                                  rd <= 5'h0;
                                  rs1 <= ({
2'h1, /* 4:3 */
(instr[9:7])  /* 2:0 */
});
                                  rs2 <= 5'h0;
                                  imm <= ({
({23{(_original__swizzled_9[8])}}), /* 31:9 */
_original__swizzled_9  /*  8:0 */
});
                              end
                              9'h2e : begin
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
                              end
                              9'h33 : begin
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
                              end
                              9'h38 : begin
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
({26{(_original__swizzled_10[5])}}), /* 31:6 */
_original__swizzled_10  /*  5:0 */
});
                              end
                              9'h3d : begin
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
                              end
                              9'h43 : begin
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
                              end
                              9'h49 : begin
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
                              end
                              9'h4f : begin
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
                              end
                              9'h55 : begin
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
                              end
                              9'h5a : begin
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
                              end
                              9'h60 : begin
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
                              end
                              9'h66 : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= ((instr[6:2]));
                                  imm <= 32'h0;
                              end
                              9'h6a : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= ((instr[6:2]));
                                  imm <= 32'h0;
                              end
                              9'h70 : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= ((instr[6:2]));
                                  imm <= 32'h0;
                              end
                              9'h74 : begin
                                  rd <= 5'h1;
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= ((instr[6:2]));
                                  imm <= 32'h0;
                              end
                              9'h79 : begin
                                  rd <= ((instr[11:7]));
                                  rs1 <= ((instr[11:7]));
                                  rs2 <= ((instr[6:2]));
                                  imm <= 32'h0;
                              end
                          endcase

                      end                       else begin
                          counter_0 <= _in376__counter_add_const_1;
                          done <= 1'h0;
                          valid <= 1'h0;
                          index <= 9'h0;
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

                  end                   else begin
                      done <= 1'h1;
                      valid <= 1'h0;
                      index <= 9'h0;
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

              end               else begin
                  done <= 1'h0;
                  valid <= 1'h0;
                  index <= 9'h0;
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

      end       else begin
          valid <= 1'h0;
          index <= 9'h0;
          done <= 1'h0;
          microcodeRead_en <= 1'h0;
          microcodeRead_addr <= 7'h0;
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
          counter_0 <= 7'h0;
          held <= 1'h0;
      end 

  end 

end

assign {_counter_add_const_1_carry, _in50__counter_add_const_1} = counter + 32'h1;
assign {_counter_add_const_1_carry_0, _in376__counter_add_const_1} = counter_0 + 7'h1;
assign patternMatch = (instr & (microcodeRead_data[31:0])) == (microcodeRead_data[63:32]);  // equals
assign _in0 = microcodeRead_data[72:64];  // bussubset_1
assign _in1__subset_108_77_data = microcodeRead_data[108:77];  // bussubset_3
assign nzfMatch = (_in1__subset_108_77_data != 32'h0) ? ((instr & _in1__subset_108_77_data) != 32'h0) : 1'h1;  // mux
assign _in1__subset_140_109_data = microcodeRead_data[140:109];  // bussubset_4
assign zfMatch = (_in1__subset_140_109_data != 32'h0) ? ((instr & _in1__subset_140_109_data) == 32'h0) : 1'h1;  // mux_0
assign op_0 = (instr[1:0]);  // swizzle_0
assign rd_prime_0 = (instr[4:2]);  // swizzle_1
assign funct3_0 = (instr[15:13]);  // swizzle_2
assign op_1 = (instr[1:0]);  // swizzle_3
assign rd_prime_1 = (instr[4:2]);  // swizzle_4
assign imm_lo_0 = {
3'h0, /* 4:2 */
(instr[6:5])  /* 1:0 */
};  // swizzle_5
assign rs1_prime_0 = (instr[9:7]);  // swizzle_6
assign imm_hi_0 = (instr[12:10]);  // swizzle_7
assign funct3_1 = (instr[15:13]);  // swizzle_8
assign op_2 = (instr[1:0]);  // swizzle_9
assign rs2_prime_0 = (instr[4:2]);  // swizzle_10
assign imm_lo_1 = {
3'h0, /* 4:2 */
(instr[6:5])  /* 1:0 */
};  // swizzle_11
assign rs1_prime_1 = (instr[9:7]);  // swizzle_12
assign imm_hi_1 = (instr[12:10]);  // swizzle_13
assign funct3_2 = (instr[15:13]);  // swizzle_14
assign op_3 = (instr[1:0]);  // swizzle_15
assign imm_lo_2 = (instr[6:2]);  // swizzle_16
assign rd_rs1_0 = (instr[11:7]);  // swizzle_17
assign imm_hi_2 = {
2'h0, /* 2:1 */
(instr[12])  /*   0 */
};  // swizzle_18
assign funct3_3 = (instr[15:13]);  // swizzle_19
assign op_4 = (instr[1:0]);  // swizzle_20
assign jump_target_0 = (instr[12:2]);  // swizzle_21
assign funct3_4 = (instr[15:13]);  // swizzle_22
assign _original__swizzled = {
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
};  // swizzle_24
assign op_5 = (instr[1:0]);  // swizzle_25
assign offset_lo_0 = (instr[6:2]);  // swizzle_26
assign rs1_prime_2 = (instr[9:7]);  // swizzle_27
assign offset_hi_0 = (instr[12:10]);  // swizzle_28
assign funct3_5 = (instr[15:13]);  // swizzle_29
assign _swizzled = {
(instr[12]), /* 8 */
(instr[6]), /* 7 */
(instr[5]), /* 6 */
(instr[2]), /* 5 */
(instr[11]), /* 4 */
(instr[10]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
1'h0  /* 0 */
};  // swizzle_31
assign op_6 = (instr[1:0]);  // swizzle_32
assign rs2_prime_1 = (instr[4:2]);  // swizzle_33
assign funct2_0 = (instr[6:5]);  // swizzle_34
assign rd_rs1_prime_0 = (instr[9:7]);  // swizzle_35
assign funct6_0 = (instr[15:10]);  // swizzle_36
assign op_7 = (instr[1:0]);  // swizzle_37
assign rs2_0 = (instr[6:2]);  // swizzle_38
assign funct3_6 = (instr[15:13]);  // swizzle_39
assign op_8 = (instr[1:0]);  // swizzle_40
assign rs2_1 = (instr[6:2]);  // swizzle_41
assign rd_rs1_1 = (instr[11:7]);  // swizzle_42
assign funct4_0 = (instr[15:12]);  // swizzle_43
assign opcode_0 = (instr[6:0]);  // swizzle_44
assign rd_0 = (instr[11:7]);  // swizzle_45
assign opcode_1 = (instr[6:0]);  // swizzle_47
assign rd_1 = (instr[11:7]);  // swizzle_48
assign _original__swizzled_0 = {
(instr[31]), /*    20 */
(instr[19:12]), /* 19:12 */
(instr[20]), /*    11 */
(instr[30:21]), /* 10: 1 */
1'h0  /*     0 */
};  // swizzle_50
assign opcode_2 = (instr[6:0]);  // swizzle_51
assign rd_2 = (instr[11:7]);  // swizzle_52
assign funct3_7 = (instr[14:12]);  // swizzle_53
assign rs1_0 = (instr[19:15]);  // swizzle_54
assign _original__subset_31_20_instr = instr[31:20];  // bussubset_80
assign opcode_3 = (instr[6:0]);  // swizzle_56
assign immLo_0 = (instr[11:7]);  // swizzle_57
assign funct3_8 = (instr[14:12]);  // swizzle_58
assign rs1_1 = (instr[19:15]);  // swizzle_59
assign rs2_2 = (instr[24:20]);  // swizzle_60
assign immHi_0 = (instr[31:25]);  // swizzle_61
assign _original__swizzled_1 = {
(instr[31]), /*   12 */
(instr[7]), /*   11 */
(instr[30:25]), /* 10:5 */
(instr[11:8]), /*  4:1 */
1'h0  /*    0 */
};  // swizzle_63
assign opcode_4 = (instr[6:0]);  // swizzle_64
assign immLo_1 = (instr[11:7]);  // swizzle_65
assign funct3_9 = (instr[14:12]);  // swizzle_66
assign rs1_2 = (instr[19:15]);  // swizzle_67
assign rs2_3 = (instr[24:20]);  // swizzle_68
assign immHi_1 = (instr[31:25]);  // swizzle_69
assign opcode_5 = (instr[6:0]);  // swizzle_72
assign rd_3 = (instr[11:7]);  // swizzle_73
assign funct3_10 = (instr[14:12]);  // swizzle_74
assign rs1_3 = (instr[19:15]);  // swizzle_75
assign rs2_4 = (instr[24:20]);  // swizzle_76
assign funct7_0 = (instr[31:25]);  // swizzle_77
assign _original__swizzled_2 = {
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
};  // swizzle_92
assign _original__swizzled_3 = {
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
};  // swizzle_96
assign _original__swizzled_4 = {
(instr[12]), /*   9 */
(instr[4]), /*   8 */
(instr[3]), /*   7 */
(instr[5]), /*   6 */
(instr[2]), /*   5 */
(instr[6]), /*   4 */
4'h0  /* 3:0 */
};  // swizzle_98
assign _original__swizzled_5 = {
(instr[12]), /*   17 */
(instr[6]), /*   16 */
(instr[5]), /*   15 */
(instr[4]), /*   14 */
(instr[3]), /*   13 */
(instr[2]), /*   12 */
12'h0  /* 11:0 */
};  // swizzle_102
assign _original__swizzled_6 = {
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
};  // swizzle_104
assign _original__swizzled_7 = {
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
};  // swizzle_106
assign _original__swizzled_8 = {
(instr[12]), /* 8 */
(instr[6]), /* 7 */
(instr[5]), /* 6 */
(instr[2]), /* 5 */
(instr[11]), /* 4 */
(instr[10]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
1'h0  /* 0 */
};  // swizzle_109
assign _original__swizzled_9 = {
(instr[12]), /* 8 */
(instr[6]), /* 7 */
(instr[5]), /* 6 */
(instr[2]), /* 5 */
(instr[11]), /* 4 */
(instr[10]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
1'h0  /* 0 */
};  // swizzle_112
assign _original__swizzled_10 = {
(instr[12]), /* 5 */
(instr[6]), /* 4 */
(instr[5]), /* 3 */
(instr[4]), /* 2 */
(instr[3]), /* 1 */
(instr[2])  /* 0 */
};  // swizzle_127
endmodule : DynamicInstructionDecoder