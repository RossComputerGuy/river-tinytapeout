/*
 * Copyright (c) 2024 Your Name
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
  // ------------------------------------------------------------------
  wire        qspi_sck;
  wire        qspi_cs_flash;
  wire        qspi_cs_ram;
  wire        qspi_cs_ram2;
  wire [3:0]  qspi_sd_out;
  wire [3:0]  qspi_sd_oe;
  wire [3:0]  qspi_sd_in = {uio_in[5], uio_in[4], uio_in[2], uio_in[1]}; // SD3,SD2,SD1,SD0

  river_soc soc (
    .clk          (clk),
    .reset        (~rst_n),          // SoC uses active-high reset; TT rst_n is active-low
    .uart_rx      (ui_in[0]),
    .uart_tx      (uo_out[0]),
    .qspi_sck     (qspi_sck),
    .qspi_cs_flash(qspi_cs_flash),
    .qspi_cs_ram  (qspi_cs_ram),
    .qspi_cs_ram2 (qspi_cs_ram2),
    .qspi_sd_in   (qspi_sd_in),
    .qspi_sd_out  (qspi_sd_out),
    .qspi_sd_oe   (qspi_sd_oe)
  );

  // Dedicated outputs: uart_tx on uo[0], rest unused.
  assign uo_out[7:1] = 7'b0000000;

  // Drive the Pmod pins.
  assign uio_out = {qspi_cs_ram2, qspi_cs_ram, qspi_sd_out[3], qspi_sd_out[2],
                    qspi_sck, qspi_sd_out[1], qspi_sd_out[0], qspi_cs_flash};
  // CS/SCK are always outputs; each data line follows its own oe.
  //          uio7   uio6   uio5(SD3)     uio4(SD2)     uio3  uio2(SD1)     uio1(SD0)     uio0
  assign uio_oe  = {1'b1, 1'b1, qspi_sd_oe[3], qspi_sd_oe[2],
                    1'b1, qspi_sd_oe[1], qspi_sd_oe[0], 1'b1};

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:1], uio_in[7], uio_in[6], uio_in[3], uio_in[0], 1'b0};

endmodule
