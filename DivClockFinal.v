module DivClockFinal(i_clk, o_clk);
	parameter NCOUNT = 100;
	parameter NBIT = 9;
	input i_clk;
	output reg o_clk;
	reg [NBIT-1:0] count;
	
	
	always @ (posedge i_clk) begin
		if (count < NCOUNT) begin
			o_clk <= 1;
			count <= count + 1'b1;
		end else if (count >= NCOUNT && count < 2*NCOUNT) begin
			o_clk <= 0;
			count <= count + 1'b1;
		 end else
			count <= 0;
	end
endmodule