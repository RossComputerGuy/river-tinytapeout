/*
 * Copyright (c) 2024 Tristan Ross
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_river_soc (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // ------------------------------------------------------------------
  // QSPI flash + PSRAM Pmod (mole99 / Mike Bell) on the uio bus:
  //   uio[0]=CS0(flash) uio[1]=SD0 uio[2]=SD1 uio[3]=SCK
  //   uio[4]=SD2 uio[5]=SD3 uio[6]=CS1(RAM A) uio[7]=CS2(RAM B)
  //
  // genip exposes the flash and PSRAM SPI pins independently; both devices sit
  // on the ONE physical Pmod bus (shared SCK + four data lines, per-device CS),
  // so this wrapper muxes them here. A single Wishbone master means only one
  // device is ever selected (CS low) at a time, so a flash-priority mux drives
  // the shared clock/data lines.
  // ------------------------------------------------------------------

  // Per-device SPI signals from the SoC (split tristate: out / oe / in).
  wire        psram_spi_clk;
  wire        psram_spi_cs_n;
  wire [3:0]  psram_spi_io_out;
  wire [3:0]  psram_spi_io_oe;
  wire        flash_spi_clk;
  wire        flash_spi_cs_n;
  wire [3:0]  flash_spi_io_out;
  wire [3:0]  flash_spi_io_oe;
  wire        uart_tx;

  // Shared Pmod data-in (SD3,SD2,SD1,SD0), fed to both controllers.
  wire [3:0]  qspi_sd_in = {uio_in[5], uio_in[4], uio_in[2], uio_in[1]};

  river_soc soc (
    .clk             (clk),
    .reset           (~rst_n),   // SoC uses active-high reset; TT rst_n is active-low
    .uart_rx         (ui_in[0]),
    .uart_tx         (uart_tx),
    .psram_spi_clk   (psram_spi_clk),
    .psram_spi_cs_n  (psram_spi_cs_n),
    .psram_spi_io_out(psram_spi_io_out),
    .psram_spi_io_oe (psram_spi_io_oe),
    .psram_spi_io_in (qspi_sd_in),
    .flash_spi_clk   (flash_spi_clk),
    .flash_spi_cs_n  (flash_spi_cs_n),
    .flash_spi_io_out(flash_spi_io_out),
    .flash_spi_io_oe (flash_spi_io_oe),
    .flash_spi_io_in (qspi_sd_in)
  );

  // Flash-priority mux onto the shared Pmod (only one CS is ever active).
  wire        flash_active = ~flash_spi_cs_n;
  wire        psram_active = ~psram_spi_cs_n;
  wire        qspi_sck     = flash_active ? flash_spi_clk :
                             (psram_active ? psram_spi_clk : 1'b0);
  wire [3:0]  qspi_sd_out  = flash_active ? flash_spi_io_out : psram_spi_io_out;
  wire [3:0]  qspi_sd_oe   = flash_active ? flash_spi_io_oe :
                             (psram_active ? psram_spi_io_oe : 4'b0000);

  // Dedicated outputs: uart_tx on uo[0], rest unused.
  assign uo_out[0]   = uart_tx;
  assign uo_out[7:1] = 7'b0000000;

  // Drive the Pmod pins. CS(flash)=uio0, SCK=uio3, CS(RAM A)=uio6, CS(RAM B)=uio7.
  //          uio7        uio6            uio5(SD3)      uio4(SD2)      uio3      uio2(SD1)      uio1(SD0)      uio0
  assign uio_out = {1'b1, psram_spi_cs_n, qspi_sd_out[3], qspi_sd_out[2],
                    qspi_sck, qspi_sd_out[1], qspi_sd_out[0], flash_spi_cs_n};
  // CS/SCK are always outputs; each data line follows its own oe.
  assign uio_oe  = {1'b1, 1'b1, qspi_sd_oe[3], qspi_sd_oe[2],
                    1'b1, qspi_sd_oe[1], qspi_sd_oe[0], 1'b1};

  // List all unused inputs to prevent warnings.
  wire _unused = &{ena, ui_in[7:1], uio_in[7], uio_in[6], uio_in[3], uio_in[0], 1'b0};

endmodule
