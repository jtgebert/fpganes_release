module VGA(	
		input vga_clock,
		input ppu_clock,
		input rendering,
		input ppu_frame_end,
		input ppu_frame_start,
		input[5:0] color,
		input rst_n,
		output[7:0] vga_r,
		output[7:0] vga_g,
		output[7:0] vga_b,
		output hsync,
		output vsync,
		output blank,
		output reg loading); // resets the nes

wire wr, rd, vga_frame_end;
wire[15:0] wr_addr, rd_addr;
wire[5:0] data, q_ram, q_rom, q;
//* Wait ~1s to start rendering PPU output
wire vga_frame_end_boot, ppu_frame_end_boot;
reg [26:0] boot_count; // count until ppu_rendering enabled
reg boot_count_done;

initial begin
	boot_count <= 27'h0000000;
	boot_count_done <= 0;
	loading <= 1;
end

always @(posedge vga_clock, negedge rst_n) begin
	if (!rst_n) begin
		boot_count <= 27'h0000000;
		boot_count_done <= 0;
	end
	else begin
		boot_count <= boot_count + 1;
		if (boot_count == 27'h7FFFFFF)
			boot_count_done <= 1;
		if (boot_count == 27'h4FFFFFF)
			loading <= 0;
	end
end

assign vga_frame_end_boot = (boot_count_done) ? vga_frame_end : 1'b0;
assign ppu_frame_end_boot = (boot_count_done) ? ppu_frame_end : 1'b0;
assign q = (boot_count_done) ? q_ram : q_rom;
// */

DisplayPlane dp(.ppu_clock(ppu_clock),
                .rst_n(rst_n),
					 .rendering(rendering),
					 .frame_start(ppu_frame_start),
                .addr(wr_addr),
                .wr(wr));
					 

RAM_wrapper ram(   .vga_clock(vga_clock),
                   .ppu_clock(ppu_clock),
                   .rst_n(rst_n),
                   .wr(wr | rendering),
                   .rd(rd),
                   .ppu_frame_end(ppu_frame_end_boot),
                   .vga_frame_end(vga_frame_end_boot),
                   .rd_addr(rd_addr),
                   .wr_addr(wr_addr),
                   .data(color),
                   .q(q_ram));

LoadScreenRom	LoadScreenRom_inst (
	.address ( rd_addr ),
	.clock ( vga_clock ),
	.rden ( rd ),
	.q ( q_rom )
	);

						 
RamReader rdr (.vga_clock(vga_clock),
               .rst_n(rst_n),
               .q(q),
               .blank(blank),
               .addr(rd_addr),
               .rd(rd),
               .vga_r(vga_r),
               .vga_g(vga_g),
               .vga_b(vga_b));

vga_time_gen tg(
               .clk(vga_clock),
               .rst_n(rst_n),
               .vsync(vsync),
               .hsync(hsync),
               .blank(blank),
					.frame_end(vga_frame_end));

endmodule
