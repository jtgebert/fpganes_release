module PPU_palette_mem_tb();
	
	reg clk;
	reg rst_n;
	reg [4:0] pal_addr;
	reg [7:0] palette_data_in;
	reg palette_mem_rw;
	reg palette_mem_en;
	wire [7:0] red;
	wire [7:0] green;
	wire [7:0] blue;
	
	PPU_palette_mem DUT (
		.clk(clk),
		.rst_n(rst_n),
		.pal_addr(pal_addr),
		.palette_data_in(palette_data_in),
		.palette_mem_rw(palette_mem_rw),
		.palette_mem_en(palette_mem_en),
		.red(red),
		.green(green),
		.blue(blue)
	);
	
	always
		#5 clk = ~clk;
		
	initial begin
		clk = 0;
		rst_n = 0;
		pal_addr = 0;
		palette_data_in = 0;
		palette_mem_rw = 0;
		palette_mem_en = 1;
		@(posedge clk);
		rst_n = 1;
		palette_data_in = 5'h05;
		palette_mem_rw = 1;
		palette_mem_en = 1;
		@(posedge clk);
		palette_mem_rw = 0;
		@(posedge clk);
		$stop;
	end
	
endmodule