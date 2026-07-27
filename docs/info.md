<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

River is a modular RISC-V CPU using the Harbor SoC generator from Midstall.
These files were generated using River's IP generator (`river-genip`).

### Regenerating the RTL

Run from a `river` checkout (inside its `nix develop` shell). `rc1-n` is the
area-first nano tier: it uses the microcode datapath (`DynamicExecutionUnit`),
not the huge static per-instruction fabric, so the design stays small enough for
Tiny Tapeout P&R.

```sh
river-genip \
  -c rc1-n \
  -d uart:0x10000000:ns16550a \
  -d psram:0x08000000:8M \
  -d flash:0x02000000:10M \
  -t sky130:hd --pdk-root "$SKY130_PDK_ROOT/share/pdk/sky130/" \
  -p uart_tx=uart@tx:A1 -p uart_rx=uart@rx:A0 \
  -o output
```

Set `SKY130_PDK_ROOT` to your sky130 PDK install.

Then copy `output/rtl/*.sv` into `src/`. genip exposes the flash and PSRAM SPI
pins independently (`flash_spi_*`, `psram_spi_*`); the shared-QSPI-Pmod mux (both
devices on one 8-pin Pmod, separate chip-selects) is applied in the hand-written
`project.v` wrapper, which is not regenerated.

## How to test

1. Load a RV32IC binary onto the QSPI flash
2. Connect to the UART
3. Provide power and watch the system boot

## External hardware

Only requires the QSPI PMOD made by mole99 and Mike Bell as described in [Tiny Tapeout's memory specs](https://tinytapeout.com/specs/memory/).
