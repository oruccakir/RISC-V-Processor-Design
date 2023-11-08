# RISC-V-Processor-Design
A processor design with RISC-V instructions will be done via verilog

# Homework Assignment: RISC-V RV32I Processor Design

## Description

This repository contains the source code and documentation for a RISC-V RV32I processor design homework assignment. The goal of this assignment is to design a 32-bit processor capable of executing a subset of RISC-V instructions in a multi-cycle architecture.

## Features

- Three-stage pipeline architecture: "Fetch," "Decode and Register Read," and "Execute and Write Back."
- Support for 15 specific RISC-V instructions as mentioned in the assignment.
- 32 32-bit registers in the `yazmac_obegi`.
- Memory operations with 32-bit addresses and data.
- State machine for managing the processor's execution stages.

## Project Structure

- `islemci.v`: Verilog module for the processor.
- `anabellek.v`: Verilog module for memory operations.
- `testbenches/`: Directory containing testbench files for simulation.
- `tests/`: Directory containing assembly code test programs.
- `README.md`: This documentation file.

## Usage

1. Clone this repository to your local machine.

```bash
git clone https://github.com/your-username/riscv-processor-homework.git
