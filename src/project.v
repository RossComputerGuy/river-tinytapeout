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

  // Bidirectional QSPI flash data lines live on uio[3:0].
  wire [3:0] spi_io_out;
  wire       spi_io_oe;

  river_soc soc (
    .clk       (clk),
    .reset     (~rst_n),        // SoC uses active-high reset; TT rst_n is active-low
    .uart_rx   (ui_in[0]),
    .spi_clk   (uo_out[0]),
    .spi_cs_n  (uo_out[1]),
    .uart_tx   (uo_out[2]),
    .spi_io_in (uio_in[3:0]),   // MISO / quad-read data from the pads
    .spi_io_out(spi_io_out),    // MOSI / quad-write data to the pads
    .spi_io_oe (spi_io_oe)      // 1 = drive spi_io, 0 = high-Z (input)
  );

  // Dedicated outputs: only [2:0] are used.
  assign uo_out[7:3] = 5'b00000;

  // Bidirectional bus: spi_io on [3:0], rest unused (kept as inputs).
  assign uio_out = {4'b0000, spi_io_out};
  assign uio_oe  = {4'b0000, {4{spi_io_oe}}};

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:1], uio_in[7:4], 1'b0};

endmodule
