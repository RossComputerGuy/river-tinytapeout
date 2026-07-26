module HarborSram_65536 (
input logic clk,
input logic reset,
input logic bus_CYC,
input logic bus_STB,
input logic bus_WE,
input logic [31:0] bus_ADR,
input logic [31:0] bus_DAT_MOSI,
input logic [3:0] bus_SEL,
output logic bus_ACK,
output logic [31:0] bus_DAT_MISO
);
logic bus_ack_out;
logic [31:0] bus_dat_out;
logic csb0;
assign bus_ACK = bus_ack_out;
assign bus_DAT_MISO = bus_dat_out;
//  sequential
always_ff @(posedge clk) begin
  bus_ack_out <= 1'h0;
  if((csb0 & (~bus_ack_out))) begin
      bus_ack_out <= 1'h1;
  end 

end

assign csb0 = bus_CYC & bus_STB;  // and__0
sky130_sram_1rw1r_16384_32_8  sky130_sram_1rw1r_16384_32_8(.clk0(clk),.addr0((bus_ADR[15:2])),.din0(bus_DAT_MOSI),.web0((csb0 & bus_WE)),.csb0(csb0),.dout0(bus_dat_out));
endmodule : HarborSram_65536