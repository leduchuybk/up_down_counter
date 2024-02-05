Coding challenge for RISCV mentorship
Project: CORE-V Wally Technology Readiness Level 5
Created by: Huyld

0. Description: 
Write a SystemVerilog module for a 4-bit synchronous up/down counter with enable, 
asynchronous reset, and synchronous load, and a testbench to verify your counter. 
Show simulation results in your favorite simulator. 
Also provide a paragraph describing the most interesting hardware or software 
project that you have completed.

1. Folder structure:
    ./counter
	|-- counter.sv
    |-- README.txt.txt
    |-- tb_counter.sv
	|-- vivado.log
	|-- waveform0.png
	`-- waveform1.png

    ** RTL Simulation tools: Xilinx Vivado 2022.2

2. Project:
* My first experience with RISCV is through Chipyard framework. I got so excited with
the idea of RoCC since then. I also implemented my own hardware accelerator using 
this interface. Then, I created my own custom instruction for this hardware accelerator.
I think this framework is simple enough for beginners to catch up with RISCV and the flow 
of creating your own custom instruction for your own hardware accelerator.
* After that, I got a chance to work in a RISCV project of my company. You can read it at
this link: https://www.kgdev.co.jp/column/efinix-0005/