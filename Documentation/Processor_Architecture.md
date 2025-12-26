# 4-bit Processor Architecture

## 1. Overview

This project implements a custom 4-bit processor using Verilog HDL. The design is FSM-based, fully synchronous and intended primarily for educational and simulation purposes with FPGA deployment in mind (Spartan-7 class devices).

The processor supports:
- Immediate MOV instructions
- Register-based ALU operations
- Multi-cycle instruction execution
- Program Counter–based instruction sequencing

---

## 2. Instruction Format (12-bit)

[11] : Instruction Type
  - 1 = MOV (Immediate)
  - 0 = ALU Operation

[10 : 8] : Opcode (for ALU instructions)

[7 : 4] : Destination Register Address

[3 : 0] : Source Register Address / Immediate Data

---

## 3. Register Bank

- 16 registers × 4-bit wide
- Single read port, single write port
- Controlled via:
  - `readEn`
  - `writeEn`
  - `addressBus`
  - `dataBus`

---

## 4. ALU

### Supported Operations
- ADD
- SUB
- AND
- OR
- XOR
- XNOR

### Flags
- `Co` : Carry Out
- `OF` : Overflow
- `Z`  : Zero Flag

---

## 5. Control Unit (FSM)

Instruction execution is controlled by a multi-state FSM.

### FSM States

| State        | Purpose |
|-------------|--------|
| `S_IDLE`     | Entry / Rest state |
| `S_DECODE`   | Decode instruction type |
| `S_MOV`      | Execute MOV instruction |
| `S_LATCH_OP` | Read ALU opcode |
| `S_FETCH_A`  | Read operand A |
| `S_FETCH_B`  | Read operand B |
| `S_EXECUTE`  | Execute ALU operation |
| `S_WRITEBACK`| Write result bcak to register |

---

## 6. Instruction Execution Cycles

### MOV Instruction
- **3 clock cycles**
  1. Idle
  2. Decode
  3. Write immediate data

### ALU Instruction
- **7 clock cycles**
  1. Idle
  2. Decode
  3. Latch opcode
  4. Fetch operand A
  5. Fetch operand B
  6. Execute Arithmetic/Logical operation
  7. Write back the result

This multi-cycle approach simplifies control and improves clarity.

---

## 7. Program Counter (PC)

- 4-bit wide
- Increments only when `pcEn` is asserted
- `pcEn` is generated synchronously based on FSM state
- Ensures:
  - One instruction = one PC increment
  - No unintended repeated execution

---

## 8. Instruction Memory

- Instructions loaded using `$readmemh`
- Allows real-time program changes without modifying HDL
- Enables automated simulation testing

---
