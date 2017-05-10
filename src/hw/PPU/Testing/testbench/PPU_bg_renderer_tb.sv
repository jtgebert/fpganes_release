
`timescale 1 ps / 1 ps
module PPU_bg_renderer_tb();

	integer file;

	reg clk;
	reg rst_n;
	reg bg_render_en;
	reg [8:0] x_pos;
	reg [8:0] y_pos;
	reg [7:0] vram_data_in;
	reg bg_pt_sel;
	reg show_bg_left_col;
	reg [2:0] fine_x_scroll;
	reg [4:0] coarse_x_scroll;
	reg [2:0] fine_y_scroll;
	reg [4:0] coarse_y_scroll;
	reg [1:0] nametable_sel;
	reg update_loopy_v;
	wire vblank_out;
	wire bg_rendering_out;
	wire [3:0] bg_pal_sel;
	wire [13:0] vram_addr_out;
	wire [7:0] red;
	wire [7:0] green;
	wire [7:0] blue;
	
	PPU_background DUT(
		.clk(clk),
		.rst_n(rst_n),
		.bg_render_en(bg_render_en),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.vram_data_in(vram_data_in),
		.bg_pt_sel(bg_pt_sel),
		.show_bg_left_col(1'b1),
		.fine_x_scroll(fine_x_scroll),
		.coarse_x_scroll(coarse_x_scroll),
		.fine_y_scroll(fine_y_scroll),
		.coarse_y_scroll(coarse_y_scroll),
		.nametable_sel(nametable_sel),
		.update_loopy_v(update_loopy_v),
		.vblank_out(vblank_out),
		.bg_rendering_out(bg_rendering_out),
		.bg_pal_sel(bg_pal_sel),
		.vram_addr_out(vram_addr_out),
		.red(red),
		.green(green),
		.blue(blue)
	);
	
	bg_test_rom VRAM(
		.address(vram_addr_out),
		.clock(clk),
		.q(vram_data_in)
	);
	
	always
		#5 clk = ~clk;
		
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			y_pos <= 9'hfff;
			x_pos <= 9'h000;
		end
		
		else if (y_pos == 260 && x_pos == 340) begin
			x_pos <= 9'h000;
			y_pos <= 9'hfff;
			$stop;
		end
		
		else if (x_pos < 340) begin
			x_pos <= x_pos + 1;
		end
		
		else begin
			x_pos <= 9'h000;
			y_pos <= y_pos + 1;
		end
		
		if (bg_rendering_out) begin
			$fwrite(file, "%d  %d  %d\n", red, green, blue);
		end
		
	end
	
	initial begin
		
		file = $fopen("I:/ECE554/fpganes/test.ppm", "w");
		$fwrite(file, "P3\n");
		$fwrite(file, "256 240\n");
		$fwrite(file, "255\n");
		
		clk = 0;
		rst_n = 0;
		bg_render_en = 1;
		vram_data_in = 0;
		bg_pt_sel = 1;
		show_bg_left_col = 0;
		fine_x_scroll = 0;
		coarse_x_scroll = 0;
		fine_y_scroll = 0;
		coarse_y_scroll = 0;
		nametable_sel = 0;
		update_loopy_v = 0;
		#5;
		rst_n = 1;
	end

endmodule