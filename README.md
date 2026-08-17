# 🚦 Traffic Light Controller using Verilog HDL

## 📌 Project Description

Traffic Light Controller is a Verilog HDL-based digital system designed to control traffic signals for two roads at an intersection. It uses a Finite State Machine (FSM), clock, and counter to control Red, Yellow, and Green lights with predefined timing.

## ✨ Features

- Two-road traffic light control
- FSM-based design
- Red, Yellow, and Green signal control
- Clock-based timing
- Counter-based state transitions
- Reset functionality
- Configurable timing parameters
- Verilog testbench for simulation

## 🛠️ Technologies Used

- Verilog HDL
- Xilinx Vivado
- Simulation Waveform
- Finite State Machine (FSM)

## 🔌 Inputs

| Input | Description |
|---|---|
| `clk` | System clock |
| `rst` | Reset signal |

## 💡 Outputs

| Output | Description |
|---|---|
| `A_red` | Road A Red light |
| `A_yellow` | Road A Yellow light |
| `A_green` | Road A Green light |
| `B_red` | Road B Red light |
| `B_yellow` | Road B Yellow light |
| `B_green` | Road B Green light |

## ⚙️ Parameters

```verilog
CLK_FREQ = 50
GREEN_TIME = 10
YELLOW_TIME = 3
