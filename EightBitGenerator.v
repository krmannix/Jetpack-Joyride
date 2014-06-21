`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:11 04/11/2013 
// Design Name: 
// Module Name:    EightBitGenerator 
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
module EightBitGenerator(out8, seed, clk, rst, load);

output reg [7:0] out8;
input [3:0] seed;
input clk, rst, load;

NumberGen N0(out8[0], clk, rst, seed, load);
NumberGen N1(out8[1], clk, rst, {seed[3], seed[2], seed[1], ~seed[0]}, load);
NumberGen N2(out8[2], clk, rst, {seed[3], seed[2], ~seed[1], seed[0]}, load);
NumberGen N3(out8[3], clk, rst, {seed[3], seed[2], ~seed[1], ~seed[0]}, load);
NumberGen N4(out8[4], clk, rst, {seed[3], ~seed[2], seed[1], seed[0]}, load);
NumberGen N5(out8[5], clk, rst, {seed[3], ~seed[2], seed[1], ~seed[0]}, load);
NumberGen N6(out8[6], clk, rst, {seed[3], ~seed[2], ~seed[1], ~seed[0]}, load);
NumberGen N7(out8[7], clk, rst, {~seed[3], seed[2], seed[1], seed[0]}, load);



endmodule
