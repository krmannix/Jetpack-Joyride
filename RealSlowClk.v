
module RealSlowClk(i_clk , o_clk) ;
	input i_clk;
	output reg o_clk;
	reg [12:0] count;

	always @ (posedge i_clk) begin
		count <= count + 1 'b1;
		if (count >= 4096)
			o_clk <= 1;
		else
			o_clk <= 0;
	end
endmodule


