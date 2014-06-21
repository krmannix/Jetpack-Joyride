`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:30 04/11/2013 
// Design Name: 
// Module Name:    LFSR 
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
module LFSR(rand, clk, rst);
	input clk;
	input rst;
	reg [63:0] count;
	output reg [63:0] rand;
	
	always @ (posedge clk, posedge rst) begin
		if (rst)
			rand <= count;
		else
			rand <= {D, rand[63:1]};
	end
	
	always @ (posedge clk) begin
		count[63:0] = count[63:0] + 1'b1;
	end
	
	assign D = ~^{rand[63], rand[62], rand[60], rand[59]};


endmodule
