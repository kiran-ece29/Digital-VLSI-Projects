# FSM-Based 4-Way Traffic Light Controller

## Description
This project implements a synchronous FSM-based 4-way traffic light controller
using Verilog HDL. Only one direction is allowed GREEN at a time while all other
directions remain RED.

## Design Approach
- Finite State Machine (FSM) based control
- Parameterized green signal,red signal timing
- Synchronous reset and clocking
- Fully synthesizable RTL

## Files
- `rtl.v` : Traffic light controller RTL
- `tb.v`  : Testbench for functional verification

## Tools Used
- Verilog HDL
- xilinx vivado

## Applications
- Intersection traffic control
- FSM-based digital systems
