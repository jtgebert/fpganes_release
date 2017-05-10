module RAM_wrapper(input vga_clock,
                   input ppu_clock,
                   input rst_n,
                   input wr,
                   input rd,
                   input ppu_frame_end,
                   input vga_frame_end,
                   input[15:0] rd_addr,
                   input[15:0] wr_addr,
                   input[5:0] data,
                   output[5:0] q);

wire rd0, rd1, wr0, wr1, cant_overlap;
wire[5:0] q0, q1;
reg vga_ram, ppu_ram, switch;

assign rd0 = vga_ram ? 0 : rd;
assign rd1 = vga_ram ? rd : 0;
assign wr0 = ppu_ram ? 0 : wr;
assign wr1 = ppu_ram ? wr : 0;
assign q = vga_ram ? q1 : q0;

VGARam  ram_0 (.data ( data ),
                    .rdaddress ( rd_addr ),
                    .rdclock ( vga_clock ),
                    .rden ( rd0 ),
                    .wraddress ( wr_addr ),
                    .wrclock ( ppu_clock ),
                    .wren ( wr0 ),
                    .q ( q0 )
                    );

VGARam  ram_1 (.data ( data ),
                    .rdaddress ( rd_addr ),
                    .rdclock ( vga_clock ),
                    .rden ( rd1 ),
                    .wraddress ( wr_addr ),
                    .wrclock ( ppu_clock ),
                    .wren ( wr1 ),
                    .q ( q1 )
                    );

assign cant_overlap = (rd_addr == 16'h018C);
						  
always @(negedge rst_n, posedge ppu_frame_end, posedge vga_frame_end, posedge cant_overlap) begin

  if (!rst_n) begin
    switch = 1;
    vga_ram = 0;
    ppu_ram = 0;
  end
  else if (cant_overlap) begin
	 switch = 1;
	 ppu_ram = ppu_ram;
	 vga_ram = vga_ram;
  end
  else if (vga_frame_end) begin
	 vga_ram = ~vga_ram;
	 ppu_ram = ppu_ram;
	 switch = switch;
  end
  else if (ppu_frame_end) begin
	 if (switch) begin
      switch = 0;
      ppu_ram = ~ppu_ram;
      vga_ram = vga_ram;
	 end
	 else begin
		vga_ram = vga_ram;
		ppu_ram = ppu_ram;
		switch = switch;
	 end
  end
  else begin
    switch = switch;
    vga_ram = vga_ram;
    ppu_ram = ppu_ram;
  end

end

endmodule
