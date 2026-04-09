# LSTM on FPGA — VHDL Implementation

A hardware implementation of a Long Short-Term Memory (LSTM) recurrent neural network written in VHDL, targeting FPGA synthesis. Pre-trained weights are embedded directly into the design, enabling inference without an external memory interface.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
  - [Top-Level Network](#top-level-network)
  - [LSTM Cell](#lstm-cell)
  - [Classification Layer](#classification-layer)
  - [Supporting Modules](#supporting-modules)
- [Fixed-Point Representation](#fixed-point-representation)
- [Repository Structure](#repository-structure)
- [Simulation with GHDL](#simulation-with-ghdl)
- [Synthesis](#synthesis)
- [Weights](#weights)

---

## Overview

This project implements a **binary classifier** based on an unrolled LSTM network in VHDL. The network accepts an input sequence of **20 time-steps**, each of dimension **4**, and produces a **2-dimensional** output vector via a dense sigmoid classification layer.

```
Input:  matrix_20_4  (20 × 4  — sequence of 4-feature vectors)
Hidden: matrix_1_8   (hidden state size = 8)
Output: matrix_1_2   (2-class probability vector)
```

All weights and biases are hard-coded as initialisation functions in the utility package (`neurals_utils_pkg.vhd`), derived from a pre-trained model exported to `W.txt`.

---

## Architecture

### Top-Level Network (`LSTM_NN.vhd`)

`LSTM_NN` is the top-level entity. It instantiates **20 LSTM cells** connected in a chain (spatially unrolled in hardware), followed by a single `Classify` layer.

```
xm(0) → LSTM_0 ─┐
xm(1) → LSTM_1 ─┤  h, c passed between cells
  ...            │
xm(19)→ LSTM_19 ─┴→ Classify → om (2-class output)
```

The `ready` output is asserted when all 20 LSTM cells **and** the classifier have completed their computation.

| Port   | Direction | Type        | Description                              |
|--------|-----------|-------------|------------------------------------------|
| `clk`  | in        | std_logic   | Clock                                    |
| `rst`  | in        | std_logic   | Synchronous reset (active high)          |
| `xm`   | in        | matrix_20_4 | Input sequence (20 time-steps × 4 features) |
| `om`   | out       | matrix_1_2  | 2-class output probabilities             |
| `ready`| out       | std_logic   | Asserted when inference is complete      |

---

### LSTM Cell (`LSTM.vhd`)

Each LSTM cell computes the standard gated recurrence:

```
i_t = σ(W_i · x_t + U_i · h_{t-1} + b_i)   — input gate
f_t = σ(W_f · x_t + U_f · h_{t-1} + b_f)   — forget gate
o_t = σ(W_o · x_t + U_o · h_{t-1} + b_o)   — output gate
c̃_t = tanh(W_c · x_t + U_c · h_{t-1} + b_c) — candidate cell state

c_t = f_t ⊙ c_{t-1} + i_t ⊙ c̃_t
h_t = o_t ⊙ tanh(c_t)
```

| Port     | Direction | Type       | Description            |
|----------|-----------|------------|------------------------|
| `clk`    | in        | std_logic  | Clock                  |
| `rst`    | in        | std_logic  | Reset                  |
| `x`      | in        | matrix_1_4 | Current input vector   |
| `h_old`  | in        | matrix_1_8 | Previous hidden state  |
| `c_old`  | in        | matrix_1_8 | Previous cell state    |
| `c_new`  | out       | matrix_1_8 | Updated cell state     |
| `h_new`  | out       | matrix_1_8 | Updated hidden state   |
| `ready`  | out       | std_logic  | Computation complete   |

The linear pre-activations for all four gates are computed in parallel by the `sop` (sum-of-products) module: `O = X·W + H·U + B`.

---

### Classification Layer (`Classify.vhd`)

A single dense layer maps the final hidden state `h_20` (size 8) to a 2-dimensional output:

```
O = σ(h_20 · W^T + B)
```

| Port    | Direction | Type       | Description             |
|---------|-----------|------------|-------------------------|
| `clk`   | in        | std_logic  | Clock                   |
| `rst`   | in        | std_logic  | Reset                   |
| `X`     | in        | matrix_1_8 | Input (last hidden state) |
| `O`     | out       | matrix_1_2 | Sigmoid-activated output |
| `ready` | out       | std_logic  | Computation complete    |

---

### Supporting Modules

| File | Entity | Description |
|------|--------|-------------|
| `neurals_utils_pkg.vhd` | `neurals_utils` package | Custom types (`matrix_*`), float↔SLV conversion, and all pre-trained weight initialisation functions |
| `sum_of_product.vhd` | `sop` | Computes `X·W + H·U + B` using two parallel matrix multiplications followed by element-wise addition |
| `matrix_multipler.vhd` | `matrix_multipler` | Generic pipelined matrix multiplier (parameterised by row/column counts) |
| `mat_mul_148.vhd` | `mat_mul_148` | 1×4 × 4×8 matrix multiply (input × weight) |
| `mat_mul_188.vhd` | `mat_mul_188` | 1×8 × 8×8 matrix multiply (hidden × recurrent weight) |
| `mat_mul_182.vhd` | `mat_mul_182` | 1×8 × 2×8 matrix multiply (classifier) |
| `sigmoid_module.vhd` | `sigmoid_module` | Scalar sigmoid; 6-cycle pipelined |
| `sigmoid_matrix.vhd` | `sigmoid_matrix_1_8` | Element-wise sigmoid for 1×8 vectors |
| `sigmoid_matrix2.vhd` | `sigmoid_matrix_1_2` | Element-wise sigmoid for 1×2 vectors |
| `tanh_module.vhd` | `tanh_module` | Scalar tanh; 4-cycle pipelined |
| `tanh_matrix.vhd` | `tanh_matrix_1_8` | Element-wise tanh for 1×8 vectors |
| `mult_mat.vhd` | `mul_mat_1_8` | Element-wise (Hadamard) multiplication of two 1×8 vectors |
| `multipier_module.vhd` | `multipier_module` | Scalar 32-bit multiplier |
| `add_matrix.vhd` | `add_mat_1_8` | Element-wise addition of two 1×8 vectors |
| `add_matrix2.vhd` | `add_mat_1_2` | Element-wise addition of two 1×2 vectors |
| `add_module.vhd` | `add_module` | Scalar 32-bit adder |
| `TB.vhd` | `TB` | Testbench skeleton (work-in-progress) |

---

## Fixed-Point Representation

All values are stored as **32-bit signed fixed-point** numbers in Q8.23 format (approximated). The utility package provides two conversion helpers:

```vhdl
-- Convert a 32-bit SLV to a VHDL real
function slv_to_single_float(input : std_logic_vector(31 downto 0)) return real;

-- Convert a VHDL real to a 32-bit SLV
function single_float_to_slv(input : real) return std_logic_vector;
```

The mapping is: `real_value ≈ integer_value × 2^(-23)`.

> **Note:** The conversion is a simulation approximation. A fully synthesisable design would require a proper fixed-point or floating-point IP core.

---

## Repository Structure

```
LSTM_FPGA/
├── neurals_utils_pkg.vhd   # Types, helpers, and hardcoded weights
├── LSTM_NN.vhd             # Top-level 20-step unrolled LSTM network
├── LSTM.vhd                # Single LSTM cell
├── Classify.vhd            # Dense classification layer
├── sum_of_product.vhd      # Gate pre-activation: X·W + H·U + B
├── matrix_multipler.vhd    # Generic parameterised matrix multiplier
├── mat_mul_148.vhd         # 1×4 × 4×8 specialisation
├── mat_mul_182.vhd         # 1×8 × 2×8 specialisation
├── mat_mul_188.vhd         # 1×8 × 8×8 specialisation
├── sigmoid_module.vhd      # Scalar sigmoid (pipelined, 6 cycles)
├── sigmoid_matrix.vhd      # 1×8 element-wise sigmoid
├── sigmoid_matrix2.vhd     # 1×2 element-wise sigmoid
├── tanh_module.vhd         # Scalar tanh (pipelined, 4 cycles)
├── tanh_matrix.vhd         # 1×8 element-wise tanh
├── mult_mat.vhd            # 1×8 Hadamard (element-wise) product
├── multipier_module.vhd    # Scalar multiplier
├── add_matrix.vhd          # 1×8 element-wise addition
├── add_matrix2.vhd         # 1×2 element-wise addition
├── add_module.vhd          # Scalar adder
├── TB.vhd                  # Testbench (work-in-progress)
└── W.txt                   # Pre-trained weights (human-readable)
```

---

## Simulation with GHDL

[GHDL](https://github.com/ghdl/ghdl) is an open-source VHDL simulator and can be used to analyse and simulate this design.

### 1. Analyse all source files

```bash
ghdl -a --std=93 neurals_utils_pkg.vhd
ghdl -a --std=93 add_module.vhd
ghdl -a --std=93 multipier_module.vhd
ghdl -a --std=93 sigmoid_module.vhd
ghdl -a --std=93 tanh_module.vhd
ghdl -a --std=93 add_matrix.vhd
ghdl -a --std=93 add_matrix2.vhd
ghdl -a --std=93 mult_mat.vhd
ghdl -a --std=93 sigmoid_matrix.vhd
ghdl -a --std=93 sigmoid_matrix2.vhd
ghdl -a --std=93 tanh_matrix.vhd
ghdl -a --std=93 matrix_multipler.vhd
ghdl -a --std=93 mat_mul_148.vhd
ghdl -a --std=93 mat_mul_182.vhd
ghdl -a --std=93 mat_mul_188.vhd
ghdl -a --std=93 sum_of_product.vhd
ghdl -a --std=93 LSTM.vhd
ghdl -a --std=93 Classify.vhd
ghdl -a --std=93 LSTM_NN.vhd
ghdl -a --std=93 TB.vhd
```

### 2. Elaborate the testbench

```bash
ghdl -e --std=93 TB
```

### 3. Run the simulation

```bash
ghdl -r --std=93 TB --vcd=waveform.vcd --stop-time=10us
```

### 4. View waveforms

Open `waveform.vcd` in [GTKWave](http://gtkwave.sourceforge.net/) or any VCD-compatible viewer:

```bash
gtkwave waveform.vcd
```

---

## Synthesis

The design targets any FPGA that supports VHDL-93. Typical workflows:

- **Xilinx Vivado** — create a new project, add all `.vhd` source files, set `LSTM_NN` as the top-level entity, select your target part, and run *Synthesis → Implementation → Generate Bitstream*.
- **Intel Quartus Prime** — create a new project, import all `.vhd` files, assign `LSTM_NN` as the top-level entity, set the target device, and run the *Compile Design* flow.

> **Note:** The `sigmoid_module` and `tanh_module` entities use VHDL `REAL` arithmetic and IEEE `math_real` functions (e.g., `EXP`, `TANH`). These are supported in simulation but **not synthesisable** as-is. For a fully synthesisable implementation, replace these modules with a look-up table (LUT) or CORDIC-based approximation.

---

## Weights

The file `W.txt` contains the human-readable trained weights in the following order:

| Section | Shape | Description |
|---------|-------|-------------|
| `Wi`    | 4 × 8 | Input gate — input weight matrix |
| `Wf`    | 4 × 8 | Forget gate — input weight matrix |
| `Wc`    | 4 × 8 | Candidate gate — input weight matrix |
| `Wo`    | 4 × 8 | Output gate — input weight matrix |
| `Ui`    | 8 × 8 | Input gate — recurrent weight matrix |
| `Uf`    | 8 × 8 | Forget gate — recurrent weight matrix |
| `Uc`    | 8 × 8 | Candidate gate — recurrent weight matrix |
| `Uo`    | 8 × 8 | Output gate — recurrent weight matrix |
| `Bi`    | 1 × 8 | Input gate — bias |
| `Bf`    | 1 × 8 | Forget gate — bias |
| `Bc`    | 1 × 8 | Candidate gate — bias |
| `Bo`    | 1 × 8 | Output gate — bias |

These values are converted to the 32-bit fixed-point representation and embedded as VHDL constants via the `init_W*`, `init_U*`, and `init_B*` functions in `neurals_utils_pkg.vhd`.
