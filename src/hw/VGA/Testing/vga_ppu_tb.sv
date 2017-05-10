`timescale 1ps / 1ps
module vga_ppu_tb();

reg vga_clock, ppu_clock, rst_n;
wire blank;
wire [7:0] vga_r, vga_g, vga_b;
wire [7:0] vram_data_in;
wire [7:0] pixel_out;
wire [13:0] vram_addr_out;
wire vram_rw_sel;
wire [7:0] vram_data_out;
wire nmi;
wire [7:0] red, green, blue;
wire rendering, ppu_frame_end;
wire [7:0] ppu_data;
wire init_busy;

always
  #39722 vga_clock = ~vga_clock;

always
  #186243 ppu_clock = ~ppu_clock;

initial begin
  ppu_clock = 0;
  vga_clock = 0;
  rst_n = 0;

  repeat(20) @(posedge vga_clock);
  rst_n = 1;

  repeat (100000000) @(posedge vga_clock);
  $stop;
end

VGA vgaDUT(.vga_clock(vga_clock),
		.ppu_clock(ppu_clock),
		.rendering(rendering),
		.ppu_frame_end(ppu_frame_end),
		.color(pixel_out[5:0]),
		.rst_n(rst_n),
		.vga_r(vga_r),
		.vga_g(vga_g),
		.vga_b(vga_b),
		.hsync(VGA_HS),
		.vsync(VGA_VS),
		.blank(blank),
		.init_busy(init_busy));
	
PPU DUT (
	.clk(ppu_clock),
	.rst_n(rst_n),
	.data(ppu_data),
	.address(3'h0),
	.vram_data_in(vram_data_in),
	.rw(1'b0),
	.cs_in(1'b1),
	.irq(nmi),
	.pixel_data(pixel_out),
	.vram_addr_out(vram_addr_out),
	.vram_rw_sel(vram_rw_sel),
	.vram_data_out(vram_data_out),
	.frame_end(ppu_frame_end),

	// DEBUG ONLY NOT FOR RELEASE
	.red(red),
	.green(green),
	.blue(blue),
	.rendering(rendering)
);

test_ram VRAM (
	.address(vram_addr_out),
	.clock(ppu_clock),
	.data(vram_data_out),
	.wren(vram_rw_sel),
	.q(vram_data_in)
);

endmodule