module river_soc (
input logic clk,
input logic reset,
input logic [3:0] psram_spi_io_in,
input logic [3:0] flash_spi_io_in,
input logic uart_rx,
output logic psram_spi_clk,
output logic psram_spi_cs_n,
output logic [3:0] psram_spi_io_out,
output logic [3:0] psram_spi_io_oe,
output logic flash_spi_clk,
output logic flash_spi_cs_n,
output logic [3:0] flash_spi_io_out,
output logic [3:0] flash_spi_io_oe,
output logic uart_tx
);
logic [31:0] ADR;
logic CYC;
logic [31:0] DAT_MOSI;
logic [3:0] SEL;
logic STB;
logic WE;
logic [31:0] bus_ADR;
logic bus_CYC;
logic [31:0] bus_DAT_MOSI;
logic [3:0] bus_SEL;
logic bus_STB;
logic bus_WE;
logic dataBus_ACK;
logic [31:0] dataBus_DAT_MISO;
logic [31:0] master_ADR;
logic master_CYC;
logic [31:0] master_DAT_MOSI;
logic [3:0] master_SEL;
logic master_STB;
logic master_WE;
logic slave_0_ACK;
logic [31:0] slave_0_DAT_MISO;
logic slave_1_ACK;
logic [31:0] slave_1_DAT_MISO;
logic slave_2_ACK;
logic [31:0] slave_2_ADR;
logic slave_2_CYC;
logic [31:0] slave_2_DAT_MISO;
logic [31:0] slave_2_DAT_MOSI;
logic [3:0] slave_2_SEL;
logic slave_2_STB;
logic slave_2_WE;
HarborPsramController  psram_0(.clk(clk),.reset(reset),.spi_io_in(psram_spi_io_in),.bus_CYC(bus_CYC),.bus_STB(bus_STB),.bus_WE(bus_WE),.bus_ADR(bus_ADR),.bus_DAT_MOSI(bus_DAT_MOSI),.bus_SEL(bus_SEL),.spi_clk(psram_spi_clk),.spi_cs_n(psram_spi_cs_n),.spi_io_out(psram_spi_io_out),.spi_io_oe(psram_spi_io_oe),.bus_ACK(slave_0_ACK),.bus_DAT_MISO(slave_0_DAT_MISO));
WishboneDecoder_S3  wishbone_decoder(.master_CYC(master_CYC),.master_STB(master_STB),.master_WE(master_WE),.master_ADR(master_ADR),.master_DAT_MOSI(master_DAT_MOSI),.master_SEL(master_SEL),.slave_0_ACK(slave_0_ACK),.slave_0_DAT_MISO(slave_0_DAT_MISO),.slave_1_ACK(slave_1_ACK),.slave_1_DAT_MISO(slave_1_DAT_MISO),.slave_2_ACK(slave_2_ACK),.slave_2_DAT_MISO(slave_2_DAT_MISO),.master_ACK(dataBus_ACK),.master_DAT_MISO(dataBus_DAT_MISO),.slave_0_CYC(bus_CYC),.slave_0_STB(bus_STB),.slave_0_WE(bus_WE),.slave_0_ADR(bus_ADR),.slave_0_DAT_MOSI(bus_DAT_MOSI),.slave_0_SEL(bus_SEL),.slave_1_CYC(CYC),.slave_1_STB(STB),.slave_1_WE(WE),.slave_1_ADR(ADR),.slave_1_DAT_MOSI(DAT_MOSI),.slave_1_SEL(SEL),.slave_2_CYC(slave_2_CYC),.slave_2_STB(slave_2_STB),.slave_2_WE(slave_2_WE),.slave_2_ADR(slave_2_ADR),.slave_2_DAT_MOSI(slave_2_DAT_MOSI),.slave_2_SEL(slave_2_SEL));
RiverCore  river_core(.clk(clk),.reset(reset),.dataBus_ACK(dataBus_ACK),.dataBus_DAT_MISO(dataBus_DAT_MISO),.dataBus_CYC(master_CYC),.dataBus_STB(master_STB),.dataBus_WE(master_WE),.dataBus_ADR(master_ADR),.dataBus_DAT_MOSI(master_DAT_MOSI),.dataBus_SEL(master_SEL));
HarborSpiFlashController  flash_1(.clk(clk),.reset(reset),.spi_io_in(flash_spi_io_in),.bus_CYC(CYC),.bus_STB(STB),.bus_WE(WE),.bus_ADR(ADR),.bus_DAT_MOSI(DAT_MOSI),.bus_SEL(SEL),.wr_req(),.wr_op(),.wr_addr(),.wr_len(),.wr_data(),.spi_clk(flash_spi_clk),.spi_cs_n(flash_spi_cs_n),.spi_io_out(flash_spi_io_out),.spi_io_oe(flash_spi_io_oe),.bus_ACK(slave_1_ACK),.bus_DAT_MISO(slave_1_DAT_MISO),.wr_data_index(),.wr_busy(),.wr_done(),.wr_err());
HarborUart  uart(.clk(clk),.reset(reset),.rx(uart_rx),.bus_CYC(slave_2_CYC),.bus_STB(slave_2_STB),.bus_WE(slave_2_WE),.bus_ADR(slave_2_ADR),.bus_DAT_MOSI(slave_2_DAT_MOSI),.bus_SEL(slave_2_SEL),.tx(uart_tx),.interrupt(),.bus_ACK(slave_2_ACK),.bus_DAT_MISO(slave_2_DAT_MISO));
endmodule : river_soc