module binary_to_segment (bin, seven) ;
input [3:0] bin;
output reg [6:0] seven; // Assume MSB is A, and LSB is G

initial // Initial block , used for correct simulations
seven = 0;

always @ (*)
	case (bin)
	0: seven = 7'b1000000;// Some code here
	1: seven = 7'b1111001;
	2: seven = 7'b0100100;//0010010;
	3: seven = 7'b0110000;//0000110;
	4: seven = 7'b0011001;//1001100;
	5: seven = 7'b0010010;//0100100;
	6: seven = 7'b0000010;//0100000;
	7: seven = 7'b1111000;//0001111;
	8: seven = 7'b0000000;
	9: seven = 7'b0010000;//0000100;
	default: seven = 7 'b0110110;// Something here
endcase
endmodule