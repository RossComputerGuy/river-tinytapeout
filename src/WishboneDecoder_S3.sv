module WishboneDecoder_S3 (
input logic master_CYC,
input logic master_STB,
input logic master_WE,
input logic [31:0] master_ADR,
input logic [31:0] master_DAT_MOSI,
input logic [3:0] master_SEL,
input logic slave_0_ACK,
input logic [31:0] slave_0_DAT_MISO,
input logic slave_1_ACK,
input logic [31:0] slave_1_DAT_MISO,
input logic slave_2_ACK,
input logic [31:0] slave_2_DAT_MISO,
output logic master_ACK,
output logic [31:0] master_DAT_MISO,
output logic slave_0_CYC,
output logic slave_0_STB,
output logic slave_0_WE,
output logic [31:0] slave_0_ADR,
output logic [31:0] slave_0_DAT_MOSI,
output logic [3:0] slave_0_SEL,
output logic slave_1_CYC,
output logic slave_1_STB,
output logic slave_1_WE,
output logic [31:0] slave_1_ADR,
output logic [31:0] slave_1_DAT_MOSI,
output logic [3:0] slave_1_SEL,
output logic slave_2_CYC,
output logic slave_2_STB,
output logic slave_2_WE,
output logic [31:0] slave_2_ADR,
output logic [31:0] slave_2_DAT_MOSI,
output logic [3:0] slave_2_SEL
);
logic hit_0;
logic hit_1;
logic hit_2;
logic muxed_ack;
logic [31:0] muxed_data;
assign master_ACK = muxed_ack;
assign master_DAT_MISO = muxed_data;
assign slave_0_WE = master_WE;
assign slave_1_WE = slave_0_WE;
assign slave_2_WE = slave_0_WE;
assign slave_0_DAT_MOSI = master_DAT_MOSI;
assign slave_1_DAT_MOSI = slave_0_DAT_MOSI;
assign slave_2_DAT_MOSI = slave_0_DAT_MOSI;
assign slave_0_SEL = master_SEL;
assign slave_1_SEL = slave_0_SEL;
assign slave_2_SEL = slave_0_SEL;
//  combinational
always_comb begin
  muxed_ack = 1'h0;
  muxed_data = 32'h0;
  if(hit_2) begin
      muxed_ack = slave_2_ACK;
      muxed_data = slave_2_DAT_MISO;
  end 

  if(hit_1) begin
      muxed_ack = slave_1_ACK;
      muxed_data = slave_1_DAT_MISO;
  end 

  if(hit_0) begin
      muxed_ack = slave_0_ACK;
      muxed_data = slave_0_DAT_MISO;
  end 

end

assign slave_2_CYC = master_CYC & hit_2;  // and_
assign hit_0 = (master_CYC & (master_ADR >= 32'h8000000)) & (master_ADR < 32'h8010000);  // and__1
assign slave_0_CYC = master_CYC & hit_0;  // and__2
assign slave_0_STB = master_STB & hit_0;  // and__3
assign slave_1_STB = master_STB & hit_1;  // and__4
assign slave_1_CYC = master_CYC & hit_1;  // and__5
assign hit_1 = (master_CYC & (master_ADR >= 32'h2000000)) & (master_ADR < 32'h2a00000);  // and__6
assign slave_0_ADR = master_ADR - 32'h8000000;  // subtract
assign slave_1_ADR = master_ADR - 32'h2000000;  // subtract_0
assign hit_2 = (master_CYC & (master_ADR >= 32'h10000000)) & (master_ADR < 32'h10001000);  // and__9
assign slave_2_ADR = master_ADR - 32'h10000000;  // subtract_1
assign slave_2_STB = master_STB & hit_2;  // and__10
endmodule : WishboneDecoder_S3