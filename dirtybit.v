module dirtybit (big_bin,small_bin,clk,AN) ;
	input [13:0] big_bin;
	output reg [3:0] small_bin;
	output reg [3:0] AN; 
	input clk;

	reg [1:0] count;

	initial begin
		small_bin = 0;
		count = 0;
	end

	always @ (posedge clk) begin
		case (count)
			0: begin
				AN = 4 'b1110; 
				small_bin = big_bin[3:0];
			end
			1: begin
				AN = 4 'b1101; 
				small_bin = big_bin[7:4];
			end
			2: begin
				AN = 4 'b1011; 
				small_bin = big_bin[11:8];
			end
			3: begin
				AN = 4 'b0111; 
				small_bin = big_bin[13:12];
			end
			default: begin
				AN = 4 'b1110; 
				small_bin = big_bin[3:0];
			end
		endcase
		count = count + 1;
	end
endmodule