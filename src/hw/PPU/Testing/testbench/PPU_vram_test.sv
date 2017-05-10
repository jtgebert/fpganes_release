`timescale 1 ps / 1 ps
module PPU_vram_test();

	reg clk;
	reg rst_n;
	reg [10:0] vram_addr;
	reg [7:0] vram_data;
	reg vram_en;
	reg vram_rw;
	wire [7:0] vram_data_out;

	PPU_VRAM vram(
		.clk(clk),
		.rst_n(rst_n),
		.vram_addr(vram_addr),
		.vram_data_in(vram_data),
		.vram_en(vram_en),
		.vram_rw(vram_rw),
		.vram_data_out(vram_data_out)
	);
	
	always
		#5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst_n = 0;
		vram_addr = 0;
		vram_data = 0;
		vram_en = 0;
		vram_rw = 0;
		@(posedge clk);
		rst_n = 1;
		vram_data = 8'h55;
		vram_rw = 0;
		vram_en = 1;
		@(posedge clk);
		vram_rw = 1;
		#50;
		$stop;
	end

endmodule