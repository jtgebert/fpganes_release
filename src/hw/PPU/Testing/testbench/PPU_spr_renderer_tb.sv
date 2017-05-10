
`timescale 1 ps / 1 ps
module PPU_spr_renderer_tb();
	
	integer file;
	
	reg clk;
	reg rst_n;
	reg spr_render_en;
	reg [8:0] x_pos;
	reg [8:0] y_pos;
	reg [7:0] spr_addr_in;
	reg [7:0] spr_data_in;
	reg [7:0] vram_data_in;
	reg oam_wr_en;
	reg spr_pt_sel;
	reg spr_size_sel;
	reg show_spr_left_col;
	wire spr_overflow;
	wire spr_zero_hit;
	wire spr_pri_out;
	wire [7:0] spr_data_out;
	wire [3:0] spr_pal_sel;
	wire [13:0] vram_addr_out;
	wire spr_vram_req;
	
	wire [7:0] red, green, blue;
	wire spr_rendering_out;
	
	PPU_sprite DUT(
		.clk(clk),
		.rst_n(rst_n),
		.spr_render_en(spr_render_en),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.spr_addr_in(spr_addr_in),
		.spr_data_in(spr_data_in),
		.vram_data_in(vram_data_in),
		.oam_wr_en(oam_wr_en),
		.spr_pt_sel(spr_pt_sel),
		.spr_size_sel(spr_size_sel),
		.show_spr_left_col(show_spr_left_col),
		.spr_overflow(spr_overflow),
		.spr_zero_hit(spr_zero_hit),
		.spr_pri_out(spr_pri_out),
		.spr_data_out(spr_data_out),
		.spr_pal_sel(spr_pal_sel),
		.vram_addr_out(vram_addr_out),
		.spr_vram_req(spr_vram_req),
		
		.red(red),
		.green(green),
		.blue(blue),
		.spr_rendering_out(spr_rendering_out)
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
		
		if (spr_rendering_out) begin
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
		spr_render_en = 1;
		spr_addr_in = 0;
		spr_data_in = 0;
		oam_wr_en = 0;
		spr_pt_sel = 0;
		spr_size_sel = 0;
		show_spr_left_col = 1;
		@(posedge clk);
		rst_n = 1;
	end
	
endmodule