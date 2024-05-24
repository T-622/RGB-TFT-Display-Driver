# RGB-TFT-Display-Driver
About:
A basic example of a color driver for the Terasic Cyclone 3 NIOS 2 evaluation TFT LCD.

Requirements:
- Terasic NIOS II Cyclone III development kit with TFT LCD. (https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=56&No=372)
- Download cable / appropriate software

Usage:
- 2 Files have been included with the design; "displayDriver" and "displayDriver_TB", the former being the VHDL file containing the display color test, and the _TB, being a testbench.

Simulation:
- To simulate under Modelsim, compile the 2 included VHDL design files into a library called "tftDriver". Simulate only the TB file.

Tested:
- Developed under Quartus II 13.0 SP1
- Simulated with ModelSim-Altera 10.1d

NOTE:
LCD documentation available at: https://www.terasic.com.tw/cgi-bin/page/archive_download.pl?Language=English&No=372&FID=6e4500c7d0df034e9133b910d263f5ba

