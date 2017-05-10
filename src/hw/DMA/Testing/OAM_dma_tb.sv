module OAM_dma_tb();

	reg clk;
	reg rst_n;
	reg [15:0] address_in;
	reg [8:0] data_in;
	wire cpu_stall;
	wire [15:0] address_out;
	wire [7:0] data_out;

	OAM_dma DUT (
		.clk(clk),
		.rst_n(rst_n),
		.address_in(address_in),
		.data_in(data_in),
		.cpu_stall(cpu_stall),
		.address_out(address_out),
		.data_out(data_out)
	);
	
	always
		#5 clk = ~clk;
		
	initial begin
		clk = 0;
		rst_n = 0;
		address_in = 0;
		data_in = 0;
		@(posedge clk);
		rst_n = 1;
		@(posedge clk);
		address_in = 16'h4014;
		data_in = 8'h55;
		@(posedge clk);
		@(posedge clk);
		address_in = 16'h0000;
		while (cpu_stall) begin
			@(posedge clk);
		end
		@(posedge clk);
		$stop;
	end

endmodule