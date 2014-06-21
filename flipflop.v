`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:30 04/11/2013 
// Design Name: 
// Module Name:    flipflop 
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
module flipflop(q, clk, rst, d);

input clk;
input rst;
input d;
output reg q;

always @ (posedge clk or posedge rst) 
	begin
	if (rst)
	#2 q = 0;
	else
	q = #3 d;
	end
endmodule
