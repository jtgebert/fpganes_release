`timescale 1ps / 1ps
module RAM_wrapper_tb();

reg vga_clock, ppu_clock, rst_n, wr, rd, ppu_frame_end, vga_frame_end;
reg [15:0] rd_addr, wr_addr;
reg [5:0] data;
wire [5:0] q;

RAM_wrapper DUT( vga_clock,
                 ppu_clock,
                 rst_n,
                 wr,
                 rd,
                 ppu_frame_end,
                 vga_frame_end,
                 rd_addr,
                 wr_addr,
                 data,
                 q);

always
  #39722 vga_clock = ~vga_clock;

always
  #186243 ppu_clock = ~ppu_clock;

always begin
  repeat (89000) @(posedge ppu_clock);
  ppu_frame_end = 1;
  @(posedge ppu_clock)
  ppu_frame_end = 0;
end

always begin
  repeat (419999) @(posedge vga_clock);
  vga_frame_end = 1;
  @(posedge vga_clock);
  vga_frame_end = 0;
end

initial begin
  ppu_clock = 0;
  vga_clock = 0;
  rst_n = 0;
  wr = 1;
  rd = 1;
  wr_addr = 16'hA5A5;
  rd_addr = 16'hB4B4;
  data = 6'b011110;
  ppu_frame_end = 0;
  vga_frame_end = 0;

  repeat(20) @(posedge vga_clock);
  rst_n = 1;

  repeat (100000000) @(posedge vga_clock);
  $stop;
end

endmodule
