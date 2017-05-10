`timescale 1ps / 1ps
module RamReader_tb();

reg clk, rst_n;
wire vga_clock;
wire hsync, vsync;
wire[7:0] vga_r, vga_g, vga_b;
logic rd, blank, wr;
logic[5:0] q, data;
logic[15:0] addr, wr_addr;

assign data = 6'h08;
assign wr = 0;
assign wr_addr = 16'h0000;

VGARAM_test	VGARAM_inst (
	.data ( data ),
	.rdaddress ( addr ),
	.rdclock ( vga_clock ),
	.rden ( rd ),
	.wraddress ( wr_addr ),
	.wrclock ( vga_clock ),
	.wren ( wr ),
	.q ( q )
	);

RamReader DUT (vga_clock,
               rst_n,
               q,
               blank,
               addr,
               rd,
               vga_r,
               vga_g,
               vga_b);

vga_time_gen tg(
               .clk(vga_clock),
               .rst_n(rst_n),
               .vsync(vsync),
               .hsync(hsync),
               .blank(blank));

/*VGA_CLOCK_TEST clkgen(
		.refclk(clk),   //  refclk.clk
		.rst(~rst_n),      //   reset.reset
		.outclk_0(vga_clock), // outclk0.clk
		.locked(locked)    //  locked.export
	);*/

assign vga_clock = clk;

always
  #10000 clk = ~clk;

initial begin

  clk = 0;
  rst_n = 0;

  repeat (100) @(negedge vga_clock);

  rst_n = 1;

  repeat(1000000) @(negedge vga_clock);
  $stop;

end

endmodule
