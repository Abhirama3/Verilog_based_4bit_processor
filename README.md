# 4 bit Multi-Cycle Processor using Verilog

## Overview
This project implements a simple **16-register, 4-bit multi-cycle processor** using Verilog HDL.
The processor is controlled by a finite state machine (FSM) and supports basic data movement
and ALU operations.

Designed and implemented as a learning project to understand multi-cycle processor architecture and FPGA-oriented digital design.

The design has been **verified using RTL simulation** and follows fully synthesizable coding
practices, making it suitable for FPGA implementation with minor system-level additions.

---

## Features
- 16 × 4-bit register bank (synchronous read/write)
- 4-bit ALU with flags:
  - Carry (Co)
  - Overflow (OF)
  - Zero (Z)
- Multi-cycle FSM-based control unit
- Program Counter (PC) with enable control
- ROM-based instruction memory

---

## Architecture Overview

### Main Components
- **processor16X4** : Top-level module
- **registerBank**  : 16×4 synchronous register file
- **ALU4bit**       : 4-bit arithmetic and logic unit
- **programCounter**: PC with enable signal
- **instructionMem**: Read-only instruction memory (ROM)

---

## Instruction Format (12-bit)

- [11] : Instruction Type
   1 → MOV
   0 → ALU operation
- [10 : 8] : ALU Opcode
- [7 : 4] : Destination Register Address
- [3 : 0] : Source Register


---

## Supported Operations

### MOV Instruction
- Writes immediate 4-bit data into a register

### ALU Operations
| Opcode | Operation |
|------:|-----------|
| 000   | ADD       |
| 001   | SUB       |
| 010   | INC       |
| 011   | DEC       |
| 100   | AND       |
| 101   | OR        |
| 110   | XOR       |
| 111   | XNOR      |

---

## FSM States and Execution Flow

Each instruction is executed over multiple clock cycles:

| State        | Function |
|-------------|----------|
| S_IDLE      | Idle / Initial state |
| S_DECODE    | Decode instruction type |
| S_MOV       | Execute MOV |
| S_LATCH_OP  | Latch ALU opcode |
| S_FETCH_A   | Read operand A |
| S_FETCH_B   | Read operand B |
| S_EXECUTE   | Perform ALU operation |
| S_WRITEBACK | Write result to register |

- MOV instructions complete in fewer cycles
- ALU instructions require full multi-cycle execution

---

## Program Counter Behavior
- The PC increments **only after instruction completion**
- Prevents instruction repetition and ensures correct sequencing

---

## Verification
- Functionally verified using **RTL simulation**
- Simulation validates:
  - MOV operations
  - ALU execution
  - Register writeback
  - PC increment behavior

---

## FPGA Implementation Notes
This design is written using synthesizable Verilog and is suitable for FPGA implementation
(Spartan-7 class devices).

For hardware deployment, the following additions would be required:
- Clock divider (For Debugging)
- Button enable logic (for PC incrementing / manual instruction feed)

---

## Status
-RTL simulation tested  
-FPGA implementation not yet tested  

---

## Author
Abhirama
