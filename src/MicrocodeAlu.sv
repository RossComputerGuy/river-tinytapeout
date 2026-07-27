module MicrocodeAlu (
input logic [31:0] a,
input logic [31:0] b,
input logic [6:0] funct,
output logic [31:0] result
);
logic _a_add__out_add__swizzled_carry;
logic _a_add__out_carry;
logic _control__b_equals_const_0;
logic _in0;
logic [31:0] _in0__a_add__out;
logic _in0__subset_31_31_a;
logic [31:0] _in2__a_add__out_add__swizzled;
logic [31:0] _shiftAmount__b_and_const_31;
logic [4:0] _shiftAmount__subset_4_0_b;
//  combinational
always_comb begin
  case (funct) 
      7'h0 : begin
          result = _in2__a_add__out_add__swizzled;
      end
      7'h1 : begin
          result = _in2__a_add__out_add__swizzled;
      end
      7'h12 : begin
          result = _in2__a_add__out_add__swizzled;
      end
      7'h13 : begin
          result = _in2__a_add__out_add__swizzled;
      end
      7'h2 : begin
          result = (a & b);
      end
      7'h3 : begin
          result = (a | b);
      end
      7'h4 : begin
          result = (a ^ b);
      end
      7'h1c : begin
          result = (a & (~b));
      end
      7'h5 : begin
          result = (a << _shiftAmount__b_and_const_31);
      end
      7'h6 : begin
          result = (a >> _shiftAmount__b_and_const_31);
      end
      7'h7 : begin
          result = ({$signed(a) >>> _shiftAmount__b_and_const_31});
      end
      7'h14 : begin
          result = (a << _shiftAmount__subset_4_0_b);
      end
      7'h15 : begin
          result = (a >> _shiftAmount__subset_4_0_b);
      end
      7'h16 : begin
          result = ({$signed(a) >>> _shiftAmount__subset_4_0_b});
      end
      7'h8 : begin
          result = ({
31'h0, /* 31:1 */
((_in0__subset_31_31_a ^ (b[31])) ? _in0__subset_31_31_a : (a < b))  /*    0 */
});
      end
      7'h9 : begin
          result = ({
31'h0, /* 31:1 */
(a < b)  /*    0 */
});
      end
      7'h3d : begin
          result = (_control__b_equals_const_0 ? 32'h0 : a);
      end
      7'h3e : begin
          result = (_control__b_equals_const_0 ? a : 32'h0);
      end
      default : begin
          result = 32'h0;
      end
  endcase

end

assign {_a_add__out_add__swizzled_carry, _in2__a_add__out_add__swizzled} = _in0__a_add__out + ({
31'h0, /* 31:1 */
_in0  /*    0 */
});
assign {_a_add__out_carry, _in0__a_add__out} = a + (_in0 ? (~b) : b);
assign _in0 = (funct == 7'h1) | (funct == 7'h13);  // or_
assign _shiftAmount__b_and_const_31 = b & 32'h1f;  // and__1
assign _shiftAmount__subset_4_0_b = b[4:0];  // bussubset
assign _in0__subset_31_31_a = a[31];  // bussubset_0
assign _control__b_equals_const_0 = b == 32'h0;  // equals_1
endmodule : MicrocodeAlu