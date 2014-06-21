`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Zafar M. Takhirov
// 
// Create Date:    12:59:40 04/12/2011 
// Design Name: EC311 Support Files
// Module Name:    vga_display 
// Project Name: Lab5 / Lab6 / Project
// Target Devices: xc6slx16-3csg324
// Tool versions: XILINX ISE 13.3
// Description: 
//
// Dependencies: vga_controller_640_60
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_display(rst, clk, R, G, B, HS, VS, R_control, G_control, B_control, up, down, left, right,AN,num);
	input rst;	// global reset
	input clk;	// 100MHz clk
	input up,down,left,right;
	
	// color inputs for a given pixel
	input [2:0] R_control, G_control;
	input [1:0] B_control; 
	
	// color outputs to show on display (current pixel)
	output reg [2:0] R, G;
	output reg [1:0] B;
	
	// Synchronization signals
	output HS;
	output VS;
	
	output [3:0] AN;
	output [6:0] num;
	
	// controls:
	wire [10:0] hcount, vcount;	// coordinates for the current pixel
	wire blank;	// signal to indicate the current coordinate is blank
	wire figure;	// the figure you want to display
	
	wire clk_wire;
	wire [13:0] P;
	wire [3:0] smallbin0;
	
	/////////////////////////////////////////////////////
	// Begin clock division
	parameter N = 2;	// parameter for clock division
	reg clk_25Mhz;
	reg [N-1:0] count;
	always @ (posedge clk) begin
		count <= count + 1'b1;
		clk_25Mhz <= count[N-1];
	end
	// End clock division
	/////////////////////////////////////////////////////
	
	// Call driver
	vga_controller_640_60 vc(
		.rst(rst), 
		.pixel_clk(clk_25Mhz), 
		.HS(HS), 
		.VS(VS), 
		.hcounter(hcount), 
		.vcounter(vcount), 
		.blank(blank));
	/////////////////////////////////////////////////////
	
	
	
	
	
	parameter S_IDLE = 0; // 0000 - no button pushed
	parameter S_UP = 1; // 0001 - the first button pushed
	parameter S_DOWN = 2; // 0010 - the second button pushed
	parameter S_LEFT = 4; // 0100 - and so on
	parameter S_RIGHT = 8; // 1000 - and so on
	
	reg [3:0] state , next_state;
	/////////////////////////////////////////
	
	//input up, down, left, right; // 1 bit inputs
	reg [10:0] x, y; // current position variables
	reg slow_clk; // clock for position update ,
	// if it's too fast, every push
	// of a button will make your opject fly away.
	
	initial begin // initial position of the box
	//Top left of the screen is x=0, y=0
	//For boxes the x should be set to 700 so they are made off screen
	//The lowest pixel a box can go is ~475
		x = 700; y=0;
	end
	
	///////////////////////////////////////////
	// slow clock for position update - optional
	reg [25:0] slow_count;
	always @ (posedge clk) begin
		slow_count = slow_count + 1 'b1;
		slow_clk = slow_count[23];
	end
	/////////////////////////////////////////
	
	///////////////////////////////////////////
	// State Machine
	always @ (posedge slow_clk) begin
		state = next_state;
	end
	always @ (posedge slow_clk) begin
		if(rst==1)begin
			x = 0; y = 0;
		end
//		case (state)
//			S_IDLE: next_state = {right , left, down, up}; // if input is 0000
//			S_UP: begin // if input is 0001
//					y = y - 5;
//					next_state = {right , left, down, up};
//				end
//			S_DOWN: begin // if input is 0010
//					y = y + 5;
//					next_state = {right, left, down, up};
//				end
//			S_LEFT: begin // if input is 0100
//					x = x - 5;
//					next_state = {right, left, down, up};
//				end
//			S_RIGHT: begin // if input is 1000
//					x = x + 5;
//					next_state = {right, left, down, up};
//				end
//		endcase
		x = x -5;
		if(x==0)begin
			x = 700;
		end
	end	
	
	
	
	
	
	clk_1khz clock1(clk,clk_wire);
	binbcd binary_bcd_convert(y,P);
	dirtybit mydirtybit(P,smallbin0,clk_wire,AN);
	binary_to_segment converter(smallbin0,num);
	
	
	
	
	// create a box:
	assign figure = ~blank & (hcount >= x & hcount <= 50+x & vcount >= y & vcount <= 75+y);
	// send colors:
	always @ (posedge clk) begin
		if (figure) begin	// if you are within the valid region
			R = R_control;
			G = G_control;
			B = B_control;
		end
		else begin	// if you are outside the valid region
			R = 0;
			G = 0;
			B = 0;
		end
	end
//		assign figure1 = ~blank & (hcount >= x & hcount <= 75+x & vcount >= y & vcount <= 30+y);
//	// send colors:
//	always @ (posedge clk) begin
//		if (figure) begin	// if you are within the valid region
//			R = R_control;
//			G = G_control;
//			B = B_control;
//		end
//		else begin	// if you are outside the valid region
//			R = 0;
//			G = 0;
//			B = 0;
//		end
//	end

endmodule