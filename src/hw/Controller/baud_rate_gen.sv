module baud_rate_gen(
	input clk,
	input rst_n,
	output reg en
	);

	reg [15:0] count;

	// Down counter
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			count <= 16'h005D; // 1200 baud (1202 actual)
		else if (en)
			count <= 16'h005D; // 1200 baud (1202 actual)
		else
			count <= count - 1;
	end

	// Decoder logic (enable on count zero)
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			en <= 1'b0;
		else if (count == 16'h0000)
			en <= 1'b1;
		else
			en <= 1'b0;
	end

endmodule
