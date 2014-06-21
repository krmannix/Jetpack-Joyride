`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:43 04/11/2013 
// Design Name: 
// Module Name:    mux 
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
module mux(q, control, a, b);

	output reg q;
	input control, a, b;
	
	wire notcontrol;
	
	always @ (control or notcontrol or a or b) 
	q = (control & a) | (notcontrol & b);
	not(notcontrol, control);
	endmodule
