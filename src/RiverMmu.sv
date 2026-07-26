module RiverMmu (
input logic clk,
input logic reset,
input logic ifetch_en,
input logic [31:0] ifetch_addr,
input logic dport_en,
input logic [31:0] dport_addr,
input logic dport_we,
input logic [31:0] dport_wdata,
input logic [2:0] dport_size,
input logic dataBus_ACK,
input logic [31:0] dataBus_DAT_MISO,
output logic ifetch_done,
output logic ifetch_valid,
output logic [31:0] ifetch_rdata,
output logic dport_done,
output logic dport_valid,
output logic [31:0] dport_rdata,
output logic dport_fault,
output logic dport_fault_guest,
output logic ifetch_fault,
output logic dataBus_CYC,
output logic dataBus_STB,
output logic dataBus_WE,
output logic [31:0] dataBus_ADR,
output logic [31:0] dataBus_DAT_MOSI,
output logic [3:0] dataBus_SEL
);
logic [4:0] _shiftAmount__swizzled;
logic [31:0] adTransPa;
logic adWrite;
logic [31:0] adrR;
logic [1:0] arbState;
logic busActive;
logic [1:0] busLane;
logic cycR;
logic [31:0] datMosiR;
logic dpDoneR;
logic dpFaultGuestR;
logic dpFaultR;
logic [31:0] dpRdataR;
logic dpValidR;
logic [31:0] dtlbPte;
logic dtlbValid;
logic [19:0] dtlbVpn;
logic [31:0] ftlbPte;
logic ftlbValid;
logic [19:0] ftlbVpn;
logic ifDoneR;
logic ifFaultR;
logic [31:0] ifRdataR;
logic ifValidR;
logic isFetchWalk;
logic justCompleted;
logic [2:0] privShadow;
logic [31:0] reqAddr;
logic [2:0] reqSize;
logic [31:0] reqWdata;
logic reqWe;
logic [3:0] satpShadowMode;
logic [31:0] satpShadowRoot;
logic [3:0] selR;
logic stbR;
logic [31:0] walkAddr;
logic walkArmed;
logic [2:0] walkLevel;
logic walking;
logic weR;
assign ifetch_done = ifDoneR;
assign ifetch_valid = ifValidR;
assign ifetch_rdata = ifRdataR;
assign dport_done = dpDoneR;
assign dport_valid = dpValidR;
assign dport_rdata = dpRdataR;
assign dport_fault = dpFaultR;
assign dport_fault_guest = dpFaultGuestR;
assign ifetch_fault = ifFaultR;
assign dataBus_CYC = cycR;
assign dataBus_STB = stbR;
assign dataBus_WE = weR;
//  sequential
always_ff @(posedge clk) begin
  if(reset) begin
      arbState <= 2'h0;
      busActive <= 1'h0;
      justCompleted <= 1'h0;
      ifDoneR <= 1'h0;
      ifValidR <= 1'h0;
      ifRdataR <= 32'h0;
      dpDoneR <= 1'h0;
      dpValidR <= 1'h0;
      dpRdataR <= 32'h0;
      dpFaultR <= 1'h0;
      dpFaultGuestR <= 1'h0;
      ifFaultR <= 1'h0;
      isFetchWalk <= 1'h0;
      adWrite <= 1'h0;
      adTransPa <= 32'h0;
      ftlbValid <= 1'h0;
      ftlbVpn <= 20'h0;
      dtlbValid <= 1'h0;
      dtlbVpn <= 20'h0;
      dtlbPte <= 32'h0;
      ftlbPte <= 32'h0;
      satpShadowMode <= 4'h0;
      satpShadowRoot <= 32'h0;
      privShadow <= 3'h0;
      cycR <= 1'h0;
      stbR <= 1'h0;
      weR <= 1'h0;
      adrR <= 32'h0;
      datMosiR <= 32'h0;
      selR <= 4'h0;
      walking <= 1'h0;
      walkArmed <= 1'h0;
      walkAddr <= 32'h0;
      walkLevel <= 3'h0;
      reqAddr <= 32'h0;
      reqWe <= 1'h0;
      reqWdata <= 32'h0;
      reqSize <= 3'h0;
  end   else begin
      ifDoneR <= 1'h0;
      ifValidR <= 1'h0;
      dpDoneR <= 1'h0;
      dpValidR <= 1'h0;
      dpFaultR <= 1'h0;
      dpFaultGuestR <= 1'h0;
      ifFaultR <= 1'h0;
      justCompleted <= 1'h0;
      privShadow <= 3'h0;
      if((busActive & dataBus_ACK)) begin
          cycR <= 1'h0;
          stbR <= 1'h0;
          busActive <= 1'h0;
          justCompleted <= 1'h1;
          if((arbState == 2'h1)) begin
              dpRdataR <= ({$signed(dataBus_DAT_MISO) >>> ({
(adrR[1:0]), /* 4:3 */
3'h0  /* 2:0 */
})});
              dpDoneR <= 1'h1;
              dpValidR <= 1'h1;
          end 

          if((arbState == 2'h2)) begin
              ifRdataR <= dataBus_DAT_MISO;
              ifDoneR <= 1'h1;
              ifValidR <= 1'h1;
          end 

          arbState <= 2'h0;
      end       else if(busActive) begin

      end       else if((((~busActive) & (~justCompleted)) & dport_en)) begin
          arbState <= 2'h1;
          busActive <= 1'h1;
          isFetchWalk <= 1'h0;
          cycR <= 1'h1;
          stbR <= 1'h1;
          adrR <= dport_addr;
          weR <= dport_we;
          datMosiR <= dport_wdata;
          selR <= ((dport_size == 3'h0) ? 4'h1 : ((dport_size == 3'h1) ? 4'h3 : ((dport_size == 3'h2) ? 4'hf : 4'hf)));
      end       else if(((((~busActive) & (~justCompleted)) & (~dport_en)) & ifetch_en)) begin
          arbState <= 2'h2;
          busActive <= 1'h1;
          cycR <= 1'h1;
          stbR <= 1'h1;
          adrR <= ifetch_addr;
          weR <= 1'h0;
          datMosiR <= 32'h0;
          selR <= 4'hf;
      end 

  end 

end

assign busLane = adrR[1:0];  // bussubset_0
assign _shiftAmount__swizzled = {
busLane, /* 4:3 */
3'h0  /* 2:0 */
};  // swizzle_0
assign dataBus_DAT_MOSI = datMosiR << _shiftAmount__swizzled;  // lshift
assign dataBus_SEL = selR << busLane;  // lshift_0
assign dataBus_ADR = {
(adrR[31:2]), /* 31:2 */
2'h0  /*  1:0 */
};  // swizzle_1
endmodule : RiverMmu