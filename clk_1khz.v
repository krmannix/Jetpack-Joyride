module clk_1khz (i_clk , o_clk) ;
	input i_clk;
	output reg o_clk;
	reg [10:0] count;
	
	initial count = 0;
	always @ (posedge i_clk) begin
		count <= count + 1 'b1;
		if (count >= 1024)
			o_clk <= 1;
		else
			o_clk <= 0;
	end
endmodule