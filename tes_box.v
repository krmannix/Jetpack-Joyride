`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:38:09 04/13/2013
// Design Name:   Boxes
// Module Name:   X:/EC 311/PROJECTMultipleBoxes1/tes_box.v
// Project Name:  PROJECTMultipleBoxes1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Boxes
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tes_box;

	// Inputs
	reg clk;

	// Outputs
	wire [2:0] R;
	wire [2:0] G;
	wire [1:0] B;
	wire HS;
	wire VS;
	wire [3:0] AN;
	wire [6:0] num;

	// Instantiate the Unit Under Test (UUT)
	Boxes uut (
		.clk(clk), 
		.R(R), 
		.G(G), 
		.B(B), 
		.HS(HS), 
		.VS(VS), 
		.AN(AN), 
		.num(num)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#1 clk = ~clk;
	end
      
endmodule

