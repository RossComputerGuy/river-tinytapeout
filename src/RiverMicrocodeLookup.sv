module RiverMicrocodeLookup (
input logic clk,
input logic reset,
input logic rd_en_0,
input logic [6:0] rd_addr_0,
output logic [140:0] rd_data_0
);
logic [140:0] storageBank_0;
logic [140:0] storageBank_1;
logic [140:0] storageBank_10;
logic [140:0] storageBank_11;
logic [140:0] storageBank_12;
logic [140:0] storageBank_13;
logic [140:0] storageBank_14;
logic [140:0] storageBank_15;
logic [140:0] storageBank_16;
logic [140:0] storageBank_17;
logic [140:0] storageBank_18;
logic [140:0] storageBank_19;
logic [140:0] storageBank_2;
logic [140:0] storageBank_20;
logic [140:0] storageBank_21;
logic [140:0] storageBank_22;
logic [140:0] storageBank_23;
logic [140:0] storageBank_24;
logic [140:0] storageBank_25;
logic [140:0] storageBank_26;
logic [140:0] storageBank_27;
logic [140:0] storageBank_28;
logic [140:0] storageBank_29;
logic [140:0] storageBank_3;
logic [140:0] storageBank_30;
logic [140:0] storageBank_31;
logic [140:0] storageBank_32;
logic [140:0] storageBank_33;
logic [140:0] storageBank_34;
logic [140:0] storageBank_35;
logic [140:0] storageBank_36;
logic [140:0] storageBank_37;
logic [140:0] storageBank_38;
logic [140:0] storageBank_39;
logic [140:0] storageBank_4;
logic [140:0] storageBank_40;
logic [140:0] storageBank_41;
logic [140:0] storageBank_42;
logic [140:0] storageBank_43;
logic [140:0] storageBank_44;
logic [140:0] storageBank_45;
logic [140:0] storageBank_46;
logic [140:0] storageBank_47;
logic [140:0] storageBank_48;
logic [140:0] storageBank_49;
logic [140:0] storageBank_5;
logic [140:0] storageBank_50;
logic [140:0] storageBank_51;
logic [140:0] storageBank_52;
logic [140:0] storageBank_53;
logic [140:0] storageBank_54;
logic [140:0] storageBank_55;
logic [140:0] storageBank_56;
logic [140:0] storageBank_57;
logic [140:0] storageBank_58;
logic [140:0] storageBank_59;
logic [140:0] storageBank_6;
logic [140:0] storageBank_60;
logic [140:0] storageBank_61;
logic [140:0] storageBank_62;
logic [140:0] storageBank_63;
logic [140:0] storageBank_64;
logic [140:0] storageBank_65;
logic [140:0] storageBank_7;
logic [140:0] storageBank_8;
logic [140:0] storageBank_9;
//  combinational
always_comb begin
  if((~rd_en_0)) begin
      rd_data_0 = 141'h0;
  end   else begin
      case (rd_addr_0) 
          7'h0 : begin
              rd_data_0 = storageBank_0;
          end
          7'h1 : begin
              rd_data_0 = storageBank_1;
          end
          7'h2 : begin
              rd_data_0 = storageBank_2;
          end
          7'h3 : begin
              rd_data_0 = storageBank_3;
          end
          7'h4 : begin
              rd_data_0 = storageBank_4;
          end
          7'h5 : begin
              rd_data_0 = storageBank_5;
          end
          7'h6 : begin
              rd_data_0 = storageBank_6;
          end
          7'h7 : begin
              rd_data_0 = storageBank_7;
          end
          7'h8 : begin
              rd_data_0 = storageBank_8;
          end
          7'h9 : begin
              rd_data_0 = storageBank_9;
          end
          7'ha : begin
              rd_data_0 = storageBank_10;
          end
          7'hb : begin
              rd_data_0 = storageBank_11;
          end
          7'hc : begin
              rd_data_0 = storageBank_12;
          end
          7'hd : begin
              rd_data_0 = storageBank_13;
          end
          7'he : begin
              rd_data_0 = storageBank_14;
          end
          7'hf : begin
              rd_data_0 = storageBank_15;
          end
          7'h10 : begin
              rd_data_0 = storageBank_16;
          end
          7'h11 : begin
              rd_data_0 = storageBank_17;
          end
          7'h12 : begin
              rd_data_0 = storageBank_18;
          end
          7'h13 : begin
              rd_data_0 = storageBank_19;
          end
          7'h14 : begin
              rd_data_0 = storageBank_20;
          end
          7'h15 : begin
              rd_data_0 = storageBank_21;
          end
          7'h16 : begin
              rd_data_0 = storageBank_22;
          end
          7'h17 : begin
              rd_data_0 = storageBank_23;
          end
          7'h18 : begin
              rd_data_0 = storageBank_24;
          end
          7'h19 : begin
              rd_data_0 = storageBank_25;
          end
          7'h1a : begin
              rd_data_0 = storageBank_26;
          end
          7'h1b : begin
              rd_data_0 = storageBank_27;
          end
          7'h1c : begin
              rd_data_0 = storageBank_28;
          end
          7'h1d : begin
              rd_data_0 = storageBank_29;
          end
          7'h1e : begin
              rd_data_0 = storageBank_30;
          end
          7'h1f : begin
              rd_data_0 = storageBank_31;
          end
          7'h20 : begin
              rd_data_0 = storageBank_32;
          end
          7'h21 : begin
              rd_data_0 = storageBank_33;
          end
          7'h22 : begin
              rd_data_0 = storageBank_34;
          end
          7'h23 : begin
              rd_data_0 = storageBank_35;
          end
          7'h24 : begin
              rd_data_0 = storageBank_36;
          end
          7'h25 : begin
              rd_data_0 = storageBank_37;
          end
          7'h26 : begin
              rd_data_0 = storageBank_38;
          end
          7'h27 : begin
              rd_data_0 = storageBank_39;
          end
          7'h28 : begin
              rd_data_0 = storageBank_40;
          end
          7'h29 : begin
              rd_data_0 = storageBank_41;
          end
          7'h2a : begin
              rd_data_0 = storageBank_42;
          end
          7'h2b : begin
              rd_data_0 = storageBank_43;
          end
          7'h2c : begin
              rd_data_0 = storageBank_44;
          end
          7'h2d : begin
              rd_data_0 = storageBank_45;
          end
          7'h2e : begin
              rd_data_0 = storageBank_46;
          end
          7'h2f : begin
              rd_data_0 = storageBank_47;
          end
          7'h30 : begin
              rd_data_0 = storageBank_48;
          end
          7'h31 : begin
              rd_data_0 = storageBank_49;
          end
          7'h32 : begin
              rd_data_0 = storageBank_50;
          end
          7'h33 : begin
              rd_data_0 = storageBank_51;
          end
          7'h34 : begin
              rd_data_0 = storageBank_52;
          end
          7'h35 : begin
              rd_data_0 = storageBank_53;
          end
          7'h36 : begin
              rd_data_0 = storageBank_54;
          end
          7'h37 : begin
              rd_data_0 = storageBank_55;
          end
          7'h38 : begin
              rd_data_0 = storageBank_56;
          end
          7'h39 : begin
              rd_data_0 = storageBank_57;
          end
          7'h3a : begin
              rd_data_0 = storageBank_58;
          end
          7'h3b : begin
              rd_data_0 = storageBank_59;
          end
          7'h3c : begin
              rd_data_0 = storageBank_60;
          end
          7'h3d : begin
              rd_data_0 = storageBank_61;
          end
          7'h3e : begin
              rd_data_0 = storageBank_62;
          end
          7'h3f : begin
              rd_data_0 = storageBank_63;
          end
          7'h40 : begin
              rd_data_0 = storageBank_64;
          end
          7'h41 : begin
              rd_data_0 = storageBank_65;
          end
          default : begin
              rd_data_0 = 141'h0;
          end
      endcase

  end 

end

//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      storageBank_0 <= 141'he003;
      storageBank_1 <= 141'h205000040000000e003;
      storageBank_2 <= 141'h40b0000c0000000e003;
      storageBank_3 <= 141'h611000000010000e003;
      storageBank_4 <= 141'h616000040010000e003;
      storageBank_5 <= 141'h619000061010000ef83;
      storageBank_6 <= 141'h61e000060010000e003;
      storageBank_7 <= 141'h8210000a0010000e003;
      storageBank_8 <= 141'h823000020010000e003;
      storageBank_9 <= 141'ha260000c0010000e003;
      storageBank_10 <= 141'ha2a0000e0010000e003;
      storageBank_11 <= 141'hc2e000080010000ec03;
      storageBank_12 <= 141'hc33000084010000ec03;
      storageBank_13 <= 141'hc38000088010000ec03;
      storageBank_14 <= 141'hc3d00008c010000fc63;
      storageBank_15 <= 141'hc4300008c210000fc63;
      storageBank_16 <= 141'hc4900008c410000fc63;
      storageBank_17 <= 141'hc4f00008c610000fc63;
      storageBank_18 <= 141'h655000000020000e003;
      storageBank_19 <= 141'h65a000040020000e003;
      storageBank_20 <= 141'he600000c0020000e003;
      storageBank_21 <= 141'hf9066000080020000f003;
      storageBank_22 <= 141'hf906a000090020000f003;
      storageBank_23 <= 141'hf800000001070000080020000f003;
      storageBank_24 <= 141'hf800001f01074000090020000f003;
      storageBank_25 <= 141'h1ff800000001079000090020000f003;
      storageBank_26 <= 141'h127b000000370000007f;
      storageBank_27 <= 141'h127e000000170000007f;
      storageBank_28 <= 141'h14820000006f0000007f;
      storageBank_29 <= 141'h1685000000670000707f;
      storageBank_30 <= 141'h188a000000630000707f;
      storageBank_31 <= 141'h1890000010630000707f;
      storageBank_32 <= 141'h1896000040630000707f;
      storageBank_33 <= 141'h189c000050630000707f;
      storageBank_34 <= 141'h18a2000060630000707f;
      storageBank_35 <= 141'h18a8000070630000707f;
      storageBank_36 <= 141'h16ae000000030000707f;
      storageBank_37 <= 141'h16b4000010030000707f;
      storageBank_38 <= 141'h16ba000020030000707f;
      storageBank_39 <= 141'h16c0000040030000707f;
      storageBank_40 <= 141'h16c6000050030000707f;
      storageBank_41 <= 141'h1acc000000230000707f;
      storageBank_42 <= 141'h1ad2000010230000707f;
      storageBank_43 <= 141'h1ad8000020230000707f;
      storageBank_44 <= 141'h16de000000130000707f;
      storageBank_45 <= 141'h16e3000020130000707f;
      storageBank_46 <= 141'h16e8000030130000707f;
      storageBank_47 <= 141'h16ed000040130000707f;
      storageBank_48 <= 141'h16f2000060130000707f;
      storageBank_49 <= 141'h16f7000070130000707f;
      storageBank_50 <= 141'h16fc00001013fc00707f;
      storageBank_51 <= 141'h170100005013fc00707f;
      storageBank_52 <= 141'h170640005013fc00707f;
      storageBank_53 <= 141'h1d0b00000033fe00707f;
      storageBank_54 <= 141'h1d1140000033fe00707f;
      storageBank_55 <= 141'h1d1700001033fe00707f;
      storageBank_56 <= 141'h1d1d00002033fe00707f;
      storageBank_57 <= 141'h1d2300003033fe00707f;
      storageBank_58 <= 141'h1d2900004033fe00707f;
      storageBank_59 <= 141'h1d2f00005033fe00707f;
      storageBank_60 <= 141'h1d3540005033fe00707f;
      storageBank_61 <= 141'h1d3b00006033fe00707f;
      storageBank_62 <= 141'h1d4100007033fe00707f;
      storageBank_63 <= 141'h17470000000f0000707f;
      storageBank_64 <= 141'h174a00000073fe10707f;
      storageBank_65 <= 141'h174c00100073fe10707f;
  end   else begin

  end 

end

endmodule : RiverMicrocodeLookup