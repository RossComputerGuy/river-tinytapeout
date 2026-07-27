<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

River is a modular RISC-V CPU using the Harbor SoC generator from Midstall.
These files were generated using River's IP generator (`river-genip`).

## How to test

1. Load a RV32IC binary onto the QSPI flash
2. Connect to the UART
3. Provide power and watch the system boot

## External hardware

Only requires the QSPI PMOD made by mole99 and Mike Bell as described in [Tiny Tapeout's memory specs](https://tinytapeout.com/specs/memory/).
