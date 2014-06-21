module binbcd(A,P);

	input [10:0] A;
	output [13:0] P;
	
	wire [3:0] ONES, TENS, HUNDREDS;
	wire [1:0] THOUSANDS;
	
	
	wire [3:0] c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
	wire [3:0] d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15;
	
	
	assign d1 = {1'b0,A[10:8]};
	assign d2 = {c1[2:0],A[7]};
	assign d3 = {c2[2:0],A[6]};
	assign d4 = {c3[2:0],A[5]};
	assign d5 = {c4[2:0],A[4]};
	assign d6 = {c5[2:0],A[3]};
	assign d7 = {c6[2:0],A[2]};
	assign d8 = {c7[2:0],A[1]};
	assign d9 = {1'b0,c1[3],c2[3],c3[3]};
	assign d10 = {c9[2:0],c4[3]};
	assign d11 = {c10[2:0],c5[3]};
	assign d12 = {c11[2:0],c6[3]};
	assign d13 = {c12[2:0],c7[3]};
	assign d14 = {1'b0,c9[3],c10[3],c11[3]};
	assign d15 = {c14[2:0],c12[3]};
	
	
	add3 m1(d1,c1);
	add3 m2(d2,c2);
	add3 m3(d3,c3);
	add3 m4(d4,c4);
	add3 m5(d5,c5);
	add3 m6(d6,c6);
	add3 m7(d7,c7);
	add3 m8(d8,c8);
	add3 m9(d9,c9);
	add3 m10(d10,c10);
	add3 m11(d11,c11);
	add3 m12(d12,c12);
	add3 m13(d13,c13);
	add3 m14(d14,c14);
	add3 m15(d15,c15);
	
	
	assign ONES = {c8[2:0],A[0]};
	assign TENS = {c13[2:0],c8[3]};
	assign HUNDREDS = {c15[2:0],c13[3]};
	assign THOUSANDS = {1'b0,c15[3]};
	
	assign P = {THOUSANDS, HUNDREDS, TENS, ONES};

endmodule