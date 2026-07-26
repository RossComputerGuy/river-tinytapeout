module river_soc (
input logic clk,
input logic reset,
input logic uart_rx,
output logic uart_tx,
// Shared QSPI Pmod bus (flash + PSRAM share SCK and the four data lines,
// each device has its own chip-select).
output logic qspi_sck,
output logic qspi_cs_flash,     // CS0 -> flash
output logic qspi_cs_ram,       // CS1 -> PSRAM bank A
output logic qspi_cs_ram2,      // CS2 -> PSRAM bank B (unused, held high)
input  logic [3:0] qspi_sd_in,
output logic [3:0] qspi_sd_out,
output logic       qspi_sd_oe
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

// Per-device SPI signals, muxed onto the shared QSPI bus below.
logic       flash_sck;
logic       flash_cs_n;
logic [3:0] flash_sd_out;
logic       flash_sd_oe;
logic       psram_sck;
logic       psram_cs_n;
logic [3:0] psram_sd_out;
logic       psram_sd_oe;

HarborSpiFlashController  flash_1(.clk(clk),.reset(reset),.bus_CYC(bus_CYC),.bus_STB(bus_STB),.bus_WE(bus_WE),.bus_ADR(bus_ADR),.bus_DAT_MOSI(bus_DAT_MOSI),.bus_SEL(bus_SEL),.wr_req(),.wr_op(),.wr_addr(),.wr_len(),.wr_data(),.spi_clk(flash_sck),.spi_cs_n(flash_cs_n),.bus_ACK(slave_1_ACK),.bus_DAT_MISO(slave_1_DAT_MISO),.wr_data_index(),.wr_busy(),.wr_done(),.wr_err(),.spi_io_in(qspi_sd_in),.spi_io_out(flash_sd_out),.spi_io_oe(flash_sd_oe));
WishboneDecoder_S3  wishbone_decoder(.master_CYC(master_CYC),.master_STB(master_STB),.master_WE(master_WE),.master_ADR(master_ADR),.master_DAT_MOSI(master_DAT_MOSI),.master_SEL(master_SEL),.slave_0_ACK(slave_0_ACK),.slave_0_DAT_MISO(slave_0_DAT_MISO),.slave_1_ACK(slave_1_ACK),.slave_1_DAT_MISO(slave_1_DAT_MISO),.slave_2_ACK(slave_2_ACK),.slave_2_DAT_MISO(slave_2_DAT_MISO),.master_ACK(dataBus_ACK),.master_DAT_MISO(dataBus_DAT_MISO),.slave_0_CYC(CYC),.slave_0_STB(STB),.slave_0_WE(WE),.slave_0_ADR(ADR),.slave_0_DAT_MOSI(DAT_MOSI),.slave_0_SEL(SEL),.slave_1_CYC(bus_CYC),.slave_1_STB(bus_STB),.slave_1_WE(bus_WE),.slave_1_ADR(bus_ADR),.slave_1_DAT_MOSI(bus_DAT_MOSI),.slave_1_SEL(bus_SEL),.slave_2_CYC(slave_2_CYC),.slave_2_STB(slave_2_STB),.slave_2_WE(slave_2_WE),.slave_2_ADR(slave_2_ADR),.slave_2_DAT_MOSI(slave_2_DAT_MOSI),.slave_2_SEL(slave_2_SEL));
RiverCore  river_core(.clk(clk),.reset(reset),.dataBus_ACK(dataBus_ACK),.dataBus_DAT_MISO(dataBus_DAT_MISO),.dataBus_CYC(master_CYC),.dataBus_STB(master_STB),.dataBus_WE(master_WE),.dataBus_ADR(master_ADR),.dataBus_DAT_MOSI(master_DAT_MOSI),.dataBus_SEL(master_SEL));
HarborPsramController  psram_0(.clk(clk),.reset(reset),.bus_CYC(CYC),.bus_STB(STB),.bus_WE(WE),.bus_ADR(ADR),.bus_DAT_MOSI(DAT_MOSI),.bus_SEL(SEL),.bus_ACK(slave_0_ACK),.bus_DAT_MISO(slave_0_DAT_MISO),.spi_clk(psram_sck),.spi_cs_n(psram_cs_n),.spi_io_out(psram_sd_out),.spi_io_oe(psram_sd_oe),.spi_io_in(qspi_sd_in));
HarborUart  uart(.clk(clk),.reset(reset),.rx(uart_rx),.bus_CYC(slave_2_CYC),.bus_STB(slave_2_STB),.bus_WE(slave_2_WE),.bus_ADR(slave_2_ADR),.bus_DAT_MOSI(slave_2_DAT_MOSI),.bus_SEL(slave_2_SEL),.tx(uart_tx),.interrupt(),.bus_ACK(slave_2_ACK),.bus_DAT_MISO(slave_2_DAT_MISO));

// Only one device is ever selected at a time (single Wishbone master), so a
// simple priority mux drives the shared clock/data lines.
wire flash_active = ~flash_cs_n;
wire psram_active = ~psram_cs_n;
assign qspi_sck      = flash_active ? flash_sck    : (psram_active ? psram_sck    : 1'b0);
assign qspi_sd_out   = flash_active ? flash_sd_out : psram_sd_out;
assign qspi_sd_oe    = flash_active ? flash_sd_oe  : (psram_active ? psram_sd_oe   : 1'b0);
assign qspi_cs_flash = flash_cs_n;
assign qspi_cs_ram   = psram_cs_n;
assign qspi_cs_ram2  = 1'b1;      // second PSRAM bank unused
endmodule : river_soc
