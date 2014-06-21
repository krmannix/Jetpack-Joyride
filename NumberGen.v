`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:37 04/11/2013 
// Design Name: 
// Module Name:    NumberGen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module NumberGen(q, clk, rst, seed, load);
	 
	 input clk, rst, load;
	 output q;
	 input [3:0] seed;
	 wire [3:0] state_out;
	 wire [3:0] state_in;
	 wire nextbit;
	 
	 flipflop F[3:0] (state_out, clk, rst, state_in);
	 mux M1[3:0] (state_in, load, seed, {state_out[2], state_out[1], state_out[0], nextbit});
	 xor G1(nextbit, state_out[2], state_out[3]);
	 assign q = nextbit;
	 
	 
	 
	 


endmodule
