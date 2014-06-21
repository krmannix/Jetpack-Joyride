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
module Boxes(rst, clk, R, G, B, HS, VS, up, down, AN, num,ifhighScore,RESET);
	input rst;	// global reset
	input clk;	// 100MHz clk
	input up, down;
	input RESET;
	input ifhighScore;
	
	// color outputs to show on display (current pixel)
	output reg [2:0] R, G;
	output reg [1:0] B;
	
	// Synchronization signals
	output HS;
	output VS;
	output [3:0] AN;
	output [6:0] num;
	
	reg slow_clk;
	reg sec_clk;
	reg [2:0] delay;
	reg lastreset;
	reg [4:0] lastspeed;
	reg [10:0] firstTime;
	reg first;

	// controls:
	wire [10:0] hcount, vcount;	// coordinates for the current pixel
	wire blank;	// signal to indicate the current coordinate is blank
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

////////////// DUUDDDAAASSSS CODE
parameter S_IDLE = 0; // 00 - no button pushed
	parameter S_UP = 1; // 01 - the first button pushed
	parameter S_DOWN = 2; // 10 - the second button pushed
	parameter S_UPnDOWN = 3; // 11 - the top and bottom button are pushed at the same time
	
	reg [1:0] state , next_state;
	reg [10:0] x1, x2, x3, x4, x5, x6, x7, x8, y1, y2, y3, y4, y5, y6, y7, y8; 
	

	///////////////////////////////////////////
	// slow clock for position update - optional
	initial slow_count1 = 0;
	reg [25:0] slow_count1;
	always @ (posedge clk) begin
		slow_count1 = slow_count1 + 1 'b1;
		slow_clk = slow_count1[21];
	end
///////////////////////////////////
	//// CLOCK FOR INCREASING SPEED
	reg [10:0] scoreout;
	
	// Create a faster clock to count up
	wire kindclk;
	wire fiveclk;
	DivClockFinal #(20000000, 100) slowerKhz(clk, kindclk);
	DivClockFinal #(200000000, 100) fiverClk(clk, fiveclk);
	reg [4:0] increaseSpeed;


	
	// DUDAS CODE..output for Screen display
   clk_1khz clock1(clk,clk_wire);
	reg [10:0] scoreVar;
	reg [10:0] highScore;
	reg [100:0] togglecount;
	//	always @ (edge RESET) begin
	//	first = 1'b0;
	//	end
	
	always @ (posedge kindclk) begin
	// TEST
		delay = delay + 1'b1;
		if (delay >= 3'b111) begin
			delay = 0;
			lastspeed = lastspeed +1'b1;
			climb3 = ~climb3;
		end
		if (lose == 1'b0 && first == 1'b0) begin
			scoreVar = scoreVar + 3'b101;
			end
		else begin
			scoreVar = scoreVar;
		end
		if (lastreset != RESET) begin
			togglecount = togglecount + 1'b1;
			scoreVar = 0;
			// We added this
//			if (togglecount == 1) begin
//				if (lastreset == 1'b0 & RESET == 1'b1) begin
//					first = 1'b1;
//				end
//				else begin
//					first = 1'b0;
//				end
//			end
//			else begin
//				first = 1'b0;
//			end
			first = 0;
			// delete if problem
			lastreset = RESET;
			lastspeed = 1'b1;
		end
		if (scoreVar > highScore) begin
			highScore = scoreVar;
		end
		else begin
			highScore = highScore;
		end
		increaseSpeed = lastspeed;
	end
	// y1 should be replaced with scorevar
	
	
	always @(posedge clk) begin
		case (ifhighScore)
			0: begin
				scoreout = scoreVar;
				end
			1: begin
				scoreout = highScore;
				end
			endcase
	end
	binbcd binary_bcd_convert(scoreout,P);
	dirtybit mydirtybit(P,smallbin0,clk_wire,AN);
	binary_to_segment converter(smallbin0,num);

	
	
	// Create color states
   reg [2:0] Rrand1, Grand1, Rrand2, Grand2,  Rrand3, Grand3,  Rrand4, Grand4,  Rrand5, Grand5, Rrand6, Grand6;
	reg [1:0] Brand1, Brand2, Brand3, Brand4, Brand5, Brand6;
	
	/////////////////////////////////////////
	reg [10:0] boxx1, boxy1; 
	reg [10:0] boxx2, boxy2;
	reg [10:0] boxx3, boxy3;
	reg [10:0] boxx4, boxy4;
   reg [10:0] boxx5, boxy5;
	reg [10:0] boxx6, boxy6;
	
	reg [10:0] star1x, star2x, star3x, star4x, star5x, star6x, star7x, star8x, star9x, star10x, star11x; 
	reg [10:0] star12x, star13x, star14x, star15x, star16x, star17x, star18x, star19x, star20x;
	reg [10:0] star21x, star22x, star23x, star24x, star25x;
	reg [10:0] star1y, star2y, star3y, star4y, star5y, star6y, star7y, star8y, star9y, star10y, star11y; 
	reg [10:0] star12y, star13y, star14y, star15y, star16y, star17y, star18y, star19y, star20y;
	reg [10:0] star21y, star22y, star23y, star24y, star25y;
	
	reg [10:0] xG1,xG2,xG3,xG4,xG5,xG6,yG1,yG2,yG3,yG4,yG5,yG6; // position of the game over variables
	reg [10:0] xA1,xA2,xA3,xA4,yA1,yA2,yA3,yA4;
	reg [10:0] xM1,xM2,xM3,xM4,xM5,yM1,yM2,yM3,yM4,yM5;
	reg [10:0] xE1,xE2,xE3,xE4,yE1,yE2,yE3,yE4;
	reg [10:0] xO1,xO2,xO3,xO4,yO1,yO2,yO3,yO4;
	reg [10:0] xV1,xV2,xV3,xV4,xV5,yV1,yV2,yV3,yV4,yV5;
	reg [10:0] xE01,xE02,xE03,xE04,yE01,yE02,yE03,yE04;
	reg [10:0] xR1,xR2,xR3,xR4,xR5,xR6,yR1,yR2,yR3,yR4,yR5,yR6;
	
	reg [10:0] xJ1,xJ2,xJ3,yJ1,yJ2,yJ3;
	reg [10:0] xE11,xE12,xE13,xE14,yE11,yE12,yE13,yE14;
	reg [10:0] xT1,xT2,yT1,yT2;
	reg [10:0] xP1,xP2,xP3,xP4,yP1,yP2,yP3,yP4;
	reg [10:0] xA01,xA02,xA03,xA04,yA01,yA02,yA03,yA04;
	reg [10:0] xC1,xC2,xC3,xC4,xC5,yC1,yC2,yC3,yC4,yC5;
	reg [10:0] xK1,xK2,xK3,xK4,xK5,xK6,yK1,yK2,yK3,yK4,yK5,yK6;
	//////
	
	wire [63:0] rand;
	// What if this reset was 
	LFSR numgen(rand, clk, 1'b0);
	// STATE MACHINE PORTION 
	
	reg [6:0] squareSize1; 
	reg [6:0] squareSize2;
	reg [6:0] squareSize3; 
	reg [6:0] squareSize4;
	reg [6:0] squareSize5;
	reg [6:0] squareSize6;
	///////////////////////////////////////////
	// State Machine 1
	always @ (posedge slow_clk) begin
		if(boxx1 < 1800 && boxx1 > 1500 ) begin
			boxy1 = rand[16:8];
			squareSize1 = rand[6:0];
			boxx1 = 700;
			Grand1 = rand[55:53];
			Rrand1 = rand[41:39];
			Brand1 = rand[11:10];
			end
		else begin
		boxx1 = boxx1 - 5 - increaseSpeed;
		end
		
	end	
	
	///////////////////////////
	// State Machine 2
	always @ (posedge slow_clk) begin
		if(boxx2 < 1800 && boxx2 > 1500 )begin
			boxy2 = rand[24:16];
			squareSize2 = rand[15:8];
			boxx2 = 700;
			Grand2 = rand[59:57];
			Rrand2 = rand[56:54];
			Brand2 = rand[11:10];
			end
		else begin
		// Testing for increaseSpeed
		boxx2 = boxx2 - 6 - increaseSpeed;
		end
		
	end	
	
	reg climb3;
	////////////
	// STATE MACHINE 3
		always @ (posedge slow_clk) begin
		if(boxx3 < 1800 && boxx3 > 1500 )begin
			boxy3 = rand[30:22];
			squareSize3 = rand[12:5];
			boxx3 = 700;
			Grand3 = rand[14:12];
			Rrand3 = rand[3:1];
			Brand3 = rand[11:10];
			end
		else begin
		boxx3 = boxx3 - 9 - increaseSpeed;
		if (climb3 == 1'b1) begin
		boxy3 = boxy3 - 2;
		end 
		else begin
		boxy3 = boxy3 + 2;
		end
		
		end
		
	end	
	
	
	///////////
	// STATE MACFHINE 4
	always @ (posedge slow_clk) begin
		if(boxx4 < 1800 && boxx4 > 1500 )begin
			boxy4 = rand[6:0];
			squareSize4 = rand[9:3];
			boxx4 = 700;
			Grand4 = rand[59:57];
			Rrand4 = rand[56:54];
			Brand4 = rand[11:10];
			end
		else begin
		boxx4 = boxx4 - 4 - increaseSpeed;
		end
		
	end
	
	////////
	// STATE MACHINE 5
			always @ (posedge slow_clk) begin
		if(boxx5 < 1800 && boxx5 > 1500 )begin
			boxy5 = rand[29:22];
			squareSize5 = rand[15:8];
			boxx5 = 700;
			Grand5 = rand[59:57];
			Rrand5 = rand[56:54];
			Brand5 = rand[11:10];
			end
		else begin
		boxx5 = boxx5 - 7 - increaseSpeed;
		end
		
	end
	
	/////////
	// STATe MACHINE 6
		always @ (posedge slow_clk) begin
		if(boxx6 < 1800 && boxx6 > 1500) begin
			boxy6 = rand[16:8];
			squareSize6 = rand[6:0];
			boxx6 = 700;
			Grand6 = 7;
			Rrand6 = 7;
			Brand6 = 3;
			end
			else begin
		boxx6 = boxx6 - 9 - increaseSpeed;
		if (climb3 == 1'b0) begin
		boxy6 = boxy6 - 2;
		end 
		else begin
		boxy6 = boxy6 + 2;
		end
		
		end
		
	end	
	
	// State Machine for STARS
	always @ (posedge slow_clk) begin
		if(star1x <= 1)begin
			star1x = 700;
			star1y = rand[6:0];
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star2x <= 1)begin
			star2x = 700;
			star2y = rand[8:0];
		star1x = star1x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star3x <= 1)begin
			star3x = 700;
			star3y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star4x <= 1)begin
			star4x = 700;
			star4y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star5x <= 1)begin
			star5x = 700;
			star5y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star6x <= 1)begin
			star6x = 700;
			star6y = rand[4:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star7x <= 1)begin
			star7x = 700;
			star7y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star8x <= 1)begin
			star8x = 700;
			star8y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star9x <= 1)begin
			star9x = 700;
			star9y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star10x <= 1)begin
			star10x = 700;
			star10y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star11x <= 1)begin
			star11x = 700;
			star11y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star12x <= 1)begin
			star12x = 700;
			star12y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star13x <= 1)begin
			star13x = 700;
			star13y = rand[7:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star14x <= 1)begin
			star14x = 700;
			star14y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star15x <= 1)begin
			star15x = 700;
			star15y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star16x <= 1)begin
			star16x = 700;
			star16y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star17x <= 1)begin
			star17x = 700;
			star17y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star18x <= 1)begin
			star18x = 700;
			star18y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star19x <= 1)begin
			star19x = 700;
			star19y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star20x <= 1)begin
			star20x = 700;
			star20y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star21x <= 1)begin
			star21x = 700;
			star21y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 1;
		star9x = star9x - 1;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star22x <= 1)begin
			star22x = 700;
			star22y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 2;
		star9x = star9x - 0;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;
		end
		else if(star23x <= 1)begin
			star23x = 700;
			star23y = rand[6:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 2;
		star9x = star9x - 0;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		else if(star24x <= 1)begin
			star24x = 700;
			star24y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 2;
		star9x = star9x - 0;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star25x = star25x - 1;
		end
		else if(star25x <= 1)begin
			star25x = 700;
			star25y = rand[8:0];
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 2;
		star9x = star9x - 0;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		end		
		else begin
		star1x = star1x - 1;
		star2x = star2x - 1;
		star3x = star3x - 1;
		star4x = star4x - 1;
		star5x = star5x - 1;
		star6x = star6x - 1;
		star7x = star7x - 1;
		star8x = star8x - 2;
		star9x = star9x - 0;
		star10x = star10x - 2;
		star11x = star11x - 1;
		star12x = star12x - 1;
		star13x = star13x - 1;
		star14x = star14x - 2;
		star15x = star15x - 1;
		star16x = star16x - 1;
		star17x = star17x - 1;
		star18x = star18x - 2;
		star19x = star19x - 1;
		star20x = star20x - 1;
		star21x = star21x - 1;
		star22x = star22x - 2;
		star23x = star23x - 1;
		star24x = star24x - 1;
		star25x = star25x - 1;	
		end
		
	end
	
	initial begin // initial position of the box
		//Top left of the screen is x=0, y=0
		//For boxes the x should be set to 700 so they are made off screen
		//The lowest pixel a box can go is ~475
		climb3 = 0;
		//	lose = 0;
		scoreVar = 10'b0000000000;
		highScore = 10'b0000000000;
		first = 1'b1;
		// I changed toggle count, was working before this on sunday 4/21 2:53
		togglecount = 0;

		boxx1 = 700; boxy1=0; squareSize1 = 6'b100011; 
		boxx2 = 900; boxy2 = 200; squareSize2 = 6'b100011;
		boxx3 = 1000; boxy3 = 150; squareSize3 = 6'b100101;
		boxx4 = 1100; boxy4 = 230; squareSize4 = 6'b100011;
		boxx5 = 1300; boxy5 = 360; squareSize5 = 6'b100011;	
		boxx6 = 1500; boxy6 = 180; squareSize6 = 6'b100011;
		
		lastreset = RESET;
		lastspeed = 1;
		delay = 0;
		
		// STAR BLOCK
		star1x = 20; star2x = 110; star3x = 130; star4x = 340; star5x = 280; 
		star1y = 040; star2y = 120; star3y = 090; star4y = 147; star5y = 020;
		star6x = 40; star7x = 90; star8x = 454; star9x = 300; star10x = 70;
		star6y = 320; star7y = 400; star8y = 264; star9y = 321; star10y = 370;
		star11x = 80; star12x = 150; star13x = 510; star14x = 390; star15x = 550;
		star11y = 189; star12y = 300; star13y = 125; star14y = 200; star15y = 410;
		star16x = 600; star17x = 177; star18x = 510; star19x = 230; star20x = 630;
		star16y = 470; star17y = 40; star18y = 80; star19y = 210; star20y = 10;
		star21x = 550; star22x = 350; star23x = 610; star24x = 350; star25x = 320;
		star21y = 369; star22y = 278; star23y = 253; star24y = 400; star25y = 430;
		
		// DUDAS (SPACEMAN)
		x1 = 135; y1 = 452; x2 = 137; y2 = 450; x3 = 132; y3 = 454; x4 = 131; y4 = 455;
		x5 = 135; y5 = 456; x6 = 135; y6 = 465; x7 = 130; y7 = 462; x8 = 132; y8 = 462;
		
		// Game Over
		xG1 = 125; yG1 = 135;// location of the G in the game over screen
		xG2 = 133; yG2 = 127;
		xG3 = 155; yG3 = 135;
		xG4 = 133; yG4 = 175;
		xG5 = 155; yG5 = 155;
		xG6 = 145; yG6 = 155;
		
		xA1 = 172; yA1 = 135;// location of the A in the game over screen
		xA2 = 180; yA2 = 127;
		xA3 = 202; yA3 = 135;
		xA4 = 180; yA4 = 155;
		
		xM1 = 218; yM1 = 127;// location of the M in the game over screen
		xM2 = 226; yM2 = 135;
		xM3 = 234; yM3 = 143;
		xM4 = 242; yM4 = 135;
		xM5 = 250; yM5 = 127;
		
		xE1 = 266; yE1 = 127;// location of the E in the game over screen
		xE2 = 272; yE2 = 127;
		xE3 = 272; yE3 = 151;
		xE4 = 272; yE4 = 175;
		
		xO1 = 328; yO1 = 135;// location of the O in the game over screen
		xO2 = 336; yO2 = 127;
		xO3 = 336; yO3 = 175;
		xO4 = 358; yO4 = 135;
		
		xV1 = 374; yV1 = 127;// location of the V in the game over screen
		xV2 = 382; yV2 = 147;
		xV3 = 390; yV3 = 167;
		xV4 = 398; yV4 = 147;
		xV5 = 406; yV5 = 127;
		
		xE01 = 422; yE01 = 127;// location of the second E in the game over screen
		xE02 = 430; yE02 = 127;
		xE03 = 430; yE03 = 151;
		xE04 = 430; yE04 = 175;
		
		xR1 = 468; yR1 = 127;// location of the R in the game over screen
		xR2 = 476; yR2 = 127;
		xR3 = 476; yR3 = 151;
		xR4 = 498; yR4 = 135;
		xR5 = 490; yR5 = 159;
		xR6 = 498; yR6 = 167;
		
		// JETPACK TITLE SCREEN
		xJ1 = 125+20; yJ1 = 167+30;// location of the J in the game over screen
		xJ2 = 133+20; yJ2 = 175+30;
		xJ3 = 155+20; yJ3 = 127+30;
		
		xE11 = 172+20; yE11 = 127+30;// location of the E in the game over screen
		xE12 = 180+20; yE12 = 127+30;
		xE13 = 180+20; yE13 = 175+30;
		xE14 = 180+20; yE14 = 155+30;
		
		xT1 = 218+20; yT1 = 127+30;// location of the T in the game over screen
		xT2 = 233+20; yT2 = 135+30;
		
		xP1 = 264+20; yP1 = 127+30;// location of the P in the game over screen
		xP2 = 272+20; yP2 = 127+30;
		xP3 = 272+20; yP3 = 151+30;
		xP4 = 294+20; yP4 = 135+30;
		
		xA01 = 310+20; yA01 = 135+30;// location of the A in the game over screen
		xA02 = 318+20; yA02 = 127+30;
		xA03 = 318+20; yA03 = 151+30;
		xA04 = 340+20; yA04 = 135+30;
		
		xC1 = 356+20; yC1 = 135+30;// location of the C in the game over screen
		xC2 = 364+20; yC2 = 127+30;
		xC3 = 364+20; yC3 = 175+30;
		xC4 = 386+20; yC4 = 167+30;
		xC5 = 386+20; yC5 = 135+30;
		
		xK1 = 402+20; yK1 = 127+30;// location of the K in the game over screen
		xK2 = 410+20; yK2 = 143+30;
		xK3 = 424+20; yK3 = 135+30;
		xK4 = 432+20; yK4 = 127+30;
		xK5 = 424+20; yK5 = 151+30;
		xK6 = 432+20; yK6 = 159+30;
	end
	
	// SPACEMAN DUDA STATE MACHINE
	always @ (posedge clk) begin
		state = next_state;
	end
	always @ (posedge slow_clk) begin
		if(rst==1)begin
			x1 = 135; y1 = 452; x2 = 137; y2 = 450; x3 = 132; y3 = 454; x4 = 131; y4 = 455;
			x5 = 135; y5 = 456; x6 = 135; y6 = 465; x7 = 130; y7 = 462; x8 = 132; y8 = 462;
		end
		case (state)
			S_IDLE: begin  // if input is 00
					y1 = y1 + 10; y2 = y2 + 10; y3 = y3 + 10; y4 = y4 + 10;
					y5 = y5 + 10; y6 = y6 + 10; y7 = y7 + 10; y8 = y8 + 10; 
					next_state = {down, up};
				end
			S_UP: begin // if input is 01
					y1 = y1 - 12; y2 = y2 - 12; y3 = y3 - 12; y4 = y4 - 12;
					y5 = y5 - 12; y6 = y6 - 12; y7 = y7 - 12; y8 = y8 - 12; 
					next_state = {down, up};
				end
			S_DOWN: begin // if input is 10
					y1 = y1 + 12; y2 = y2 + 12; y3 = y3 + 12; y4 = y4 + 12;
					y5 = y5 + 12; y6 = y6 + 12; y7 = y7 + 12; y8 = y8 + 12; 
					next_state = {down, up};
				end
			S_UPnDOWN: begin // if input is 11
					y1 = y1 + 10; y2 = y2 + 10; y3 = y3 + 10; y4 = y4 + 10;
					y5 = y5 + 10; y6 = y6 + 10; y7 = y7 + 10; y8 = y8 + 10; 
					next_state = {down, up};
				end
		endcase
		if(5+y6 >470 && 1+y6 < 500)begin
			y1 = 452; y2 = 450; y3 = 454; y4 = 455; y5 = 456; y6 = 465; y7 = 462; y8 = 462;
		end
		if(y2>800) begin
			y1 = 2; y2 = 0; y3 = 4; y4 = 5; y5 = 5; y6 = 15; y7 = 11; y8 = 11;
		end
	end	

	


	// CURRENT POSITION SECTION
	// CREATE THESE FOR EVERY FIGURE
	
	/*	wire box1;	// the figure you want to display
   wire box2;
	wire box3;
	wire box4;
   wire box5;
	wire star1, star2, star3, star4, star5, star6, star7, star8, star9;
	wire star10, star11, star12, star13, star14, star15, star16, star17, star18;
	wire star19, star20, star21, star22, star23, star24, star25;*/
	wire dude, objects, gameover, rainbowbegin, jetpack;

	// ACTUAL FIGURE PORTION
	
	// Game over
	assign G1 = ~blank & (hcount >= xG1 & hcount <= 7+xG1 & vcount >= yG1 & vcount <= 39+yG1); //used to display a G for the game over screen
	assign G2 = ~blank & (hcount >= xG2 & hcount <= 21+xG2 & vcount >= yG2 & vcount <= 7+yG2);
	assign G3 = ~blank & (hcount >= xG3 & hcount <= 7+xG3 & vcount >= yG3 & vcount <= 7+yG3);
	assign G4 = ~blank & (hcount >= xG4 & hcount <= 21+xG4 & vcount >= yG4 & vcount <= 7+yG4);
	assign G5 = ~blank & (hcount >= xG5 & hcount <= 7+xG5 & vcount >= yG5 & vcount <= 19+yG5);
	assign G6 = ~blank & (hcount >= xG6 & hcount <= 9+xG6 & vcount >= yG6 & vcount <= 7+yG6);
	
	assign A1 = ~blank & (hcount >= xA1 & hcount <= 7+xA1 & vcount >= yA1 & vcount <= 47+yA1);
	assign A2 = ~blank & (hcount >= xA2 & hcount <= 21+xA2 & vcount >= yA2 & vcount <= 7+yA2);
	assign A3 = ~blank & (hcount >= xA3 & hcount <= 7+xA3 & vcount >= yA3 & vcount <= 47+yA3);
	assign A4 = ~blank & (hcount >= xA4 & hcount <= 21+xA4 & vcount >= yA4 & vcount <= 7+yA4);
	
	assign M1 = ~blank & (hcount >= xM1 & hcount <= 7+xM1 & vcount >= yM1 & vcount <= 55+yM1);
	assign M2 = ~blank & (hcount >= xM2 & hcount <= 7+xM2 & vcount >= yM2 & vcount <= 9+yM2);
	assign M3 = ~blank & (hcount >= xM3 & hcount <= 7+xM3 & vcount >= yM3 & vcount <= 7+yM3);
	assign M4 = ~blank & (hcount >= xM4 & hcount <= 7+xM4 & vcount >= yM4 & vcount <= 9+yM4);
	assign M5 = ~blank & (hcount >= xM5 & hcount <= 7+xM5 & vcount >= yM5 & vcount <= 55+yM5);

	assign E1 = ~blank & (hcount >= xE1 & hcount <= 7+xE1 & vcount >= yE1 & vcount <= 55+yE1);
	assign E2 = ~blank & (hcount >= xE2 & hcount <= 29+xE2 & vcount >= yE2 & vcount <= 7+yE2);
	assign E3 = ~blank & (hcount >= xE3 & hcount <= 29+xE3 & vcount >= yE3 & vcount <= 7+yE3);
	assign E4 = ~blank & (hcount >= xE4 & hcount <= 29+xE4 & vcount >= yE4 & vcount <= 7+yE4);

	assign O1 = ~blank & (hcount >= xO1 & hcount <= 7+xO1 & vcount >= yO1 & vcount <= 39+yO1);
	assign O2 = ~blank & (hcount >= xO2 & hcount <= 21+xO2 & vcount >= yO2 & vcount <= 7+yO2);
	assign O3 = ~blank & (hcount >= xO3 & hcount <= 21+xO3 & vcount >= yO3 & vcount <= 7+yO3);
	assign O4 = ~blank & (hcount >= xO4 & hcount <= 7+xO4 & vcount >= yO4 & vcount <= 39+yO4);
	
	assign V1 = ~blank & (hcount >= xV1 & hcount <= 7+xV1 & vcount >= yV1 & vcount <= 19+yV1);
	assign V2 = ~blank & (hcount >= xV2 & hcount <= 7+xV2 & vcount >= yV2 & vcount <= 19+yV2);
	assign V3 = ~blank & (hcount >= xV3 & hcount <= 7+xV3 & vcount >= yV3 & vcount <= 15+yV3);
	assign V4 = ~blank & (hcount >= xV4 & hcount <= 7+xV4 & vcount >= yV4 & vcount <= 19+yV4);
	assign V5 = ~blank & (hcount >= xV5 & hcount <= 7+xV5 & vcount >= yV5 & vcount <= 19+yV5);
	
	assign E01 = ~blank & (hcount >= xE01 & hcount <= 7+xE01 & vcount >= yE01 & vcount <= 55+yE01);
	assign E02 = ~blank & (hcount >= xE02 & hcount <= 29+xE02 & vcount >= yE02 & vcount <= 7+yE02);
	assign E03 = ~blank & (hcount >= xE03 & hcount <= 29+xE03 & vcount >= yE03 & vcount <= 7+yE03);
	assign E04 = ~blank & (hcount >= xE04 & hcount <= 29+xE04 & vcount >= yE04 & vcount <= 7+yE04);
	
	assign R1 = ~blank & (hcount >= xR1 & hcount <= 7+xR1 & vcount >= yR1 & vcount <= 55+yR1);
	assign R2 = ~blank & (hcount >= xR2 & hcount <= 21+xR2 & vcount >= yR2 & vcount <= 7+yR2);
	assign R3 = ~blank & (hcount >= xR3 & hcount <= 21+xR3 & vcount >= yR3 & vcount <= 7+yR3);
	assign R4 = ~blank & (hcount >= xR4 & hcount <= 7+xR4 & vcount >= yR4 & vcount <= 15+yR4);
	assign R5 = ~blank & (hcount >= xR5 & hcount <= 7+xR5 & vcount >= yR5 & vcount <= 7+yR5);
	assign R6 = ~blank & (hcount >= xR6 & hcount <= 7+xR6 & vcount >= yR6 & vcount <= 15+yR6);
	assign gameover = ((G1 | G2 | G3 | G4 | G5 | G6| A1 | A2 | A3 | A4 | M1 | M2 | M3 | M4 | M5 | E1 | E2 | E3 | E4 | O1 | O2 | O3 | O4 | V1 | V2 | V3 | V4 | V5 | E01 | E02 | E03 | E04 | R1 | R2 | R3 | R4 | R5 | R6) & lose);
	
	// JETPACL
	assign J1 = ~blank & (hcount >= xJ1 & hcount <= 7+xJ1 & vcount >= yJ1 & vcount <= 7+yJ1); //used to display the start screen
	assign J2 = ~blank & (hcount >= xJ2 & hcount <= 21+xJ2 & vcount >= yJ2 & vcount <= 7+yJ2);
	assign J3 = ~blank & (hcount >= xJ3 & hcount <= 7+xJ3 & vcount >= yJ3 & vcount <= 47+yJ3);
	
	assign E11 = ~blank & (hcount >= xE11 & hcount <= 7+xE11 & vcount >= yE11 & vcount <= 55+yE11);
	assign E12 = ~blank & (hcount >= xE12 & hcount <= 29+xE12 & vcount >= yE12 & vcount <= 7+yE12);
	assign E13 = ~blank & (hcount >= xE13 & hcount <= 29+xE13 & vcount >= yE13 & vcount <= 7+yE13);
	assign E14 = ~blank & (hcount >= xE14 & hcount <= 29+xE14 & vcount >= yE14 & vcount <= 7+yE14);
	
	assign T1 = ~blank & (hcount >= xT1 & hcount <= 37+xT1 & vcount >= yT1 & vcount <= 8+yT1);
	assign T2 = ~blank & (hcount >= xT2 & hcount <= 7+xT2 & vcount >= yT2 & vcount <= 47+yT2);

	assign P1 = ~blank & (hcount >= xP1 & hcount <= 7+xP1 & vcount >= yP1 & vcount <= 55+yP1);
	assign P2 = ~blank & (hcount >= xP2 & hcount <= 21+xP2 & vcount >= yP2 & vcount <= 7+yP2);
	assign P3 = ~blank & (hcount >= xP3 & hcount <= 21+xP3 & vcount >= yP3 & vcount <= 7+yP3);
	assign P4 = ~blank & (hcount >= xP4 & hcount <= 7+xP4 & vcount >= yP4 & vcount <= 15+yP4);

	assign A01 = ~blank & (hcount >= xA01 & hcount <= 7+xA01 & vcount >= yA01 & vcount <= 47+yA01);
	assign A02 = ~blank & (hcount >= xA02 & hcount <= 21+xA02 & vcount >= yA02 & vcount <= 7+yA02);
	assign A03 = ~blank & (hcount >= xA03 & hcount <= 21+xA03 & vcount >= yA03 & vcount <= 7+yA03);
	assign A04 = ~blank & (hcount >= xA04 & hcount <= 7+xA04 & vcount >= yA04 & vcount <= 47+yA04);
	
	assign C1 = ~blank & (hcount >= xC1 & hcount <= 7+xC1 & vcount >= yC1 & vcount <= 39+yC1);
	assign C2 = ~blank & (hcount >= xC2 & hcount <= 21+xC2 & vcount >= yC2 & vcount <= 7+yC2);
	assign C3 = ~blank & (hcount >= xC3 & hcount <= 21+xC3 & vcount >= yC3 & vcount <= 7+yC3);
	assign C4 = ~blank & (hcount >= xC4 & hcount <= 7+xC4 & vcount >= yC4 & vcount <= 7+yC4);
	assign C5 = ~blank & (hcount >= xC5 & hcount <= 7+xC5 & vcount >= yC5 & vcount <= 7+yC5);
	
	assign K1 = ~blank & (hcount >= xK1 & hcount <= 7+xK1 & vcount >= yK1 & vcount <= 55+yK1);
	assign K2 = ~blank & (hcount >= xK2 & hcount <= 15+xK2 & vcount >= yK2 & vcount <= 7+yK2);
	assign K3 = ~blank & (hcount >= xK3 & hcount <= 7+xK3 & vcount >= yK3 & vcount <= 7+yK3);
	assign K4 = ~blank & (hcount >= xK4 & hcount <= 7+xK4 & vcount >= yK4 & vcount <= 7+yK4);
	assign K5 = ~blank & (hcount >= xK5 & hcount <= 7+xK5 & vcount >= yK5 & vcount <= 7+yK5);
	assign K6 = ~blank & (hcount >= xK6 & hcount <= 7+xK6 & vcount >= yK6 & vcount <= 23+yK6);
	assign jetpack = (J1 | J2 | J3 | E11 | E12 | E13 | E14 | T1 | T2| P1 | P2 | P3 | P4 | A01 | A02 | A03 | A04 | C1 | C2 | C3 | C4 | C5 | K1 | K2 | K3 | K4 | K5 | K6) & first;
	// DUDA SPACEMAN FIGURES
	assign figure1 = ~blank & (hcount >= x1 & hcount <= 7+x1 & vcount >= y1 & vcount <= 15+y1);
	assign figure2 = ~blank & (hcount >= x2 & hcount <= 3+x2 & vcount >= y2 & vcount <= 17+y2);
	assign figure3 = ~blank & (hcount >= x3 & hcount <= 2+x3 & vcount >= y3 & vcount <= 5+y3);
	assign figure4 = ~blank & (hcount >= x4 & hcount <= 2+x4 & vcount >= y4 & vcount <= 5+y4);
	assign figure5 = ~blank & (hcount >= x5 & hcount <= 9+x5 & vcount >= y5 & vcount <= 2+y5);
	assign figure6 = ~blank & (hcount >= x6 & hcount <= 9+x6 & vcount >= y6 & vcount <= 2+y6);
	assign figure7 = ~blank & (hcount >= x7 & hcount <= 3+x7 & vcount >= y7 & vcount <= 4+y7);
	assign figure8 = ~blank & (hcount >= x7 & hcount <= 1+x7 & vcount >= y7 & vcount <= 7+y7);
	// Changed this to ~first
	assign dude = (figure1 | figure2 | figure3 | figure4 | figure5 | figure6 | figure7 | figure8) & ~lose & ~first;

	// RAINBOW
	assign rainbow1 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 125-40+30 & vcount <= 129-40+30);
	assign rainbow2 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 130-40+30 & vcount <= 134-40+30);
	assign rainbow3 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 135-40+30 & vcount <= 139-40+30);
	assign rainbow4 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 140-40+30 & vcount <= 144-40+30);
	assign rainbow5 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 145-40+30 & vcount <= 149-40+30);
	assign rainbow6 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 150-40+30 & vcount <= 154-40+30);
	assign rainbow7 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 155-40+30 & vcount <= 160-40+30);
	assign rainbowbegin = (rainbow1 | rainbow2 | rainbow3 | rainbow4 | rainbow5 | rainbow6 | rainbow7 | rainbow8 | rainbow9 | rainbow10 | rainbow11 | rainbow12 | rainbow13 | rainbow14) & first;
	assign rainbow8 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 189+30 & vcount <= 189+4+30);
	assign rainbow9 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 194+30 & vcount <= 194+4+30);
	assign rainbow10 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 199+30 & vcount <= 199+4+30);
	assign rainbow11 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 204+30 & vcount <= 204+4+30);
	assign rainbow12 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 209+30 & vcount <= 209+4+30);
	assign rainbow13 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 214+30 & vcount <= 214+4+30);
	assign rainbow14 = ~blank & (hcount >= 0 & hcount <= 700 & vcount >= 219+30 & vcount <= 219+4+30);
	


	// create a box: // 
	assign box1 = ~blank & (hcount >= boxx1 & hcount <= squareSize1+boxx1 & vcount >= boxy1 & vcount <= squareSize1+boxy1);
   assign box2 = ~blank & (hcount >= boxx2 & hcount <= squareSize2+boxx2 & vcount >= boxy2 & vcount <= squareSize2+boxy2);
	assign box3 = ~blank & (hcount >= boxx3 & hcount <= squareSize3+boxx3 & vcount >= boxy3 & vcount <= squareSize3+boxy3);
	assign box4 = ~blank & (hcount >= boxx4 & hcount <= squareSize4+boxx4 & vcount >= boxy4 & vcount <= squareSize4+boxy4);
	assign box5 = ~blank & (hcount >= boxx5 & hcount <= squareSize5+boxx5 & vcount >= boxy5 & vcount <= squareSize5+boxy5);
	assign box6 = ~blank & (hcount >= boxx6-squareSize6 & hcount <= boxx6 & vcount >= boxy6 & vcount <= squareSize6+boxy6);
	assign objects = box1 | box2 | box3 | box4 | box5 | box6;
	//
	// STAR FIGURE
	
	assign star1 = ~blank & (hcount >= star1x & hcount <= star1x+2 & vcount >= star1y & vcount <= star1y + 2);
	assign star2 = ~blank & (hcount >= star2x & hcount <= star2x+2 & vcount >= star2y & vcount <= star2y + 2);
	assign star3 = ~blank & (hcount >= star3x & hcount <= star3x+2 & vcount >= star3y & vcount <= star3y + 2);
	assign star4 = ~blank & (hcount >= star4x & hcount <= star4x+2 & vcount >= star4y & vcount <= star4y + 2);
	assign star5 = ~blank & (hcount >= star5x & hcount <= star5x+2 & vcount >= star5y & vcount <= star5y + 2);
	assign star6 = ~blank & (hcount >= star6x & hcount <= star6x+2 & vcount >= star6y & vcount <= star6y + 2);
	assign star7 = ~blank & (hcount >= star7x & hcount <= star7x+2 & vcount >= star7y & vcount <= star7y + 2);
	assign star8 = ~blank & (hcount >= star8x & hcount <= star8x+2 & vcount >= star8y & vcount <= star8y + 2);
	assign star9 = ~blank & (hcount >= star9x & hcount <= star9x+2 & vcount >= star9y & vcount <= star9y + 2);
	assign star10 = ~blank & (hcount >= star10x & hcount <= star10x+2 & vcount >= star10y & vcount <= star10y + 2);
	assign star11 = ~blank & (hcount >= star11x & hcount <= star11x+2 & vcount >= star11y & vcount <= star11y + 2);
	assign star12 = ~blank & (hcount >= star12x & hcount <= star12x+2 & vcount >= star12y & vcount <= star12y + 2);
	assign star13 = ~blank & (hcount >= star13x & hcount <= star13x+2 & vcount >= star13y & vcount <= star13y + 2);
	assign star14 = ~blank & (hcount >= star14x & hcount <= star14x+2 & vcount >= star14y & vcount <= star14y + 2);
	assign star15 = ~blank & (hcount >= star15x & hcount <= star15x+2 & vcount >= star15y & vcount <= star15y + 2);
	assign star16 = ~blank & (hcount >= star16x & hcount <= star16x+2 & vcount >= star16y & vcount <= star16y + 2);
	assign star17 = ~blank & (hcount >= star17x & hcount <= star17x+2 & vcount >= star17y & vcount <= star17y + 2);
	assign star18 = ~blank & (hcount >= star18x & hcount <= star18x+2 & vcount >= star18y & vcount <= star18y + 2);
	assign star19 = ~blank & (hcount >= star19x & hcount <= star19x+2 & vcount >= star19y & vcount <= star19y + 2);
	assign star20 = ~blank & (hcount >= star20x & hcount <= star20x+2 & vcount >= star20y & vcount <= star20y + 2);
	assign star21 = ~blank & (hcount >= star21x & hcount <= star21x+2 & vcount >= star21y & vcount <= star21y + 2);
	assign star22 = ~blank & (hcount >= star22x & hcount <= star22x+2 & vcount >= star22y & vcount <= star22y + 2);
	assign star23 = ~blank & (hcount >= star23x & hcount <= star23x+2 & vcount >= star23y & vcount <= star23y + 2);
	assign star24 = ~blank & (hcount >= star24x & hcount <= star24x+2 & vcount >= star24y & vcount <= star24y + 2);
	assign star25 = ~blank & (hcount >= star25x & hcount <= star25x+2 & vcount >= star25y & vcount <= star25y + 2);
	assign stars = star1 | star2 | star3 | star4 | star5 | star6 | star7 | star8 | star9 | star10 | star11 | star12 | star13 | star14 | star15 | star16 | star17 | star18 | star19 | star20 | star21 | star22 | star23 | star24 | star25;
	// send colors:
	
	reg lose;
	initial begin
		lose = 0;
	end
	// COLOR PORTION
	always @ (posedge clk) begin
		if (objects & dude) begin
			lose = 1;
		end
		else if (lastreset != RESET)begin
			lose = 0;
		end
	end
	
	// Boxes Take Precedence
	always @ (posedge clk) begin
	if (jetpack) begin
		if (J1) begin 
						R = 7;
						G = 0;
						B = 0;
			end 
			else if (J2) begin 
						R = 7;
						G = 0;
						B = 0;
			end 
			else if (J3) begin 
						R = 7;
						G = 0;
						B = 0;
			end 
			else if (E11) begin 
						R = 7;
						G = 3;
						B = 0;
			end 
			else if (E12) begin 
						R = 7;
						G = 3;
						B = 0;
			end 
			else if (E13) begin 
						R = 7;
						G = 3;
						B = 0;
			end 
			else if (E14) begin 
						R = 7;
						G = 3;
						B = 0;
			end 
			else if (T1) begin 
						R = 7;
						G = 7;
						B = 0;
			end 
			else if (T2) begin 
						R = 7;
						G = 7;
						B = 0;
			end 
			else if (P1) begin 
						R = 0;
						G = 7;
						B = 0;
			end 
			else if (P2) begin 
						R = 0;
						G = 7;
						B = 0;
			end 
			else if (P3) begin 
						R = 0;
						G = 7;
						B = 0;
			end 
			else if (P4) begin 
						R = 0;
						G = 7;
						B = 0;
			end 
			else if (A01) begin 
						R = 0;
						G = 0;
						B = 7;
			end 
			else if (A02) begin 
						R = 0;
						G = 0;
						B = 7;
			end 
			else if (A03) begin 
						R = 0;
						G = 0;
						B = 7;
			end 
			else if (A04) begin 
						R = 0;
						G = 0;
						B = 7;
			end 
			else if (C1) begin 
						R = 4;
						G = 2;
						B = 6;
			end 
			else if (C2) begin 
						R = 4;
						G = 2;
						B = 6;
			end 
			else if (C3) begin 
						R = 4;
						G = 2;
						B = 6;
			end 
			else if (C4) begin 
						R = 4;
						G = 2;
						B = 6;
			end 
			else if (C5) begin 
						R = 4;
						G = 2;
						B = 6;
			end 
			else if (K1) begin 
						R = 7;
						G = 0;
						B = 7;
			end 
			else if (K2) begin 
						R = 7;
						G = 0;
						B = 7;
			end 
			else if (K3) begin 
						R = 7;
						G = 0;
						B = 7;
			end 
			else if (K4) begin 
						R = 7;
						G = 0;
						B = 7;
			end 
			else if (K5) begin 
						R = 7;
						G = 0;
						B = 7;
			end 
			else if (K6) begin 
						R = 7;
						G = 0;
						B = 7;
			end
		end
		else if (rainbowbegin) begin
			if (rainbow1) begin
			R = 15;
			G = 0;
			B = 0;
			end
			else if (rainbow2) begin
			R = 7;
			G = 3;
			B = 0;
			end
			else if (rainbow3) begin
			R = 15;
			G = 15;
			B = 0;
			end
			else if (rainbow4) begin
			R = 5;
			G = 15;
			B = 0;
			end
			else if (rainbow5) begin
			R = 0;
			G = 0;
			B = 7;
			end
			else if (rainbow6) begin
			R = 4;
			G = 2;
			B = 6;
			end
			else if (rainbow7) begin
			R = 6;
			G = 3;
			B = 6;
			end 
			else if (rainbow14) begin
			R = 7;
			G = 3;
			B = 0;
			end
			else if (rainbow13) begin
			R = 7;
			G = 3;
			B = 0;
			end
			else if (rainbow12) begin
			R = 15;
			G = 15;
			B = 0;
			end
			else if (rainbow11) begin
			R = 5;
			G = 15;
			B = 0;
			end
			else if (rainbow10) begin
			R = 0;
			G = 0;
			B = 7;
			end
			else if (rainbow9) begin
			R = 4;
			G = 2;
			B = 6;
			end
			else if (rainbow8) begin
			R = 6;
			G = 3;
			B = 6;
			end 
	end
	else if (dude) begin
		if (figure1) begin	// if you are within the valid region
				R = 15;
				G = 15;
				B = 7;
			end
			else if (figure2) begin 
				R = 15;
				G = 15;
				B = 7;
			end 
			else if (figure3) begin 
				R = 13;
				G = 13;
				B = 6;
			end 
			else if (figure4) begin 
				R = 13;
				G = 13;
				B = 6;
			end 
			else if (figure5) begin 
				R = 15;
				G = 15;
				B = 7;
			end 
			else if (figure6) begin 
				R = 15;
				G = 15;
				B = 7;
			end 
			else if (up == 1'b1 && figure7) begin 
				R = 15;
				G = 2;
				B = 1;
			end 
			else if (up == 1'b1 && figure8) begin 
				R = 7;
				G = 2;
				B = 1;
			end 
		end
		else if (gameover) begin
		if (G1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (G2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (G3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (G4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (G5) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (G6) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (A1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (A2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (A3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (A4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (M1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (M2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (M3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (M4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (M5) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (O1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (O2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (O3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (O4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (V1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (V2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (V3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (V4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (V5) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E01) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E02) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E03) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (E04) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (R1) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (R2) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (R3) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (R4) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (R5) begin 
					R = 7;
					G = 2;
					B = 1;
				end 
				else if (R6) begin 
					R = 7;
					G = 2;
					B = 1;
				end
		end
		else if (box1) begin	// if you are within the valid region
			R = 3;
			G = Grand1;
			B = Brand1;
		end
		else if (box2) begin
			R = Rrand2;
			G = Grand2;
			B = 3;
		end
    	else if (box3) begin
			R = Rrand3;
			G = 6;
			B = Brand3;
		end
		else if (box4) begin
			R = 7;
			G = 5;
			B = Brand4;
		end
		else if (box5) begin
			R = Rrand5;
			G = Grand5;
			B = 1;
		end
		else if (box6) begin
			R = Rrand6;
			G = Grand6;
			B = Brand6;
		end
		else if (stars) begin
			R = 15;
			G = 15;
			B = 7;
		end
		else begin	// if you are outside the valid region
			R = 0;
			G = 0;
			B = 0;
		end
	end

endmodule 