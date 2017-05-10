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

reg ppu_buffer, vga_buffer, next_addr, ram_buffer_wr;
reg [15:0] ram_buffer_addr;
wire empty, ram_wr;
wire [5:0] fifo_q;

always @(posedge ppu_clock, posedge vga_clock, negedge rst_n) begin
  if (!rst_n) begin
    ppu_buffer <= 1'b0;
    vga_buffer <= 1'b0;
  end
  else if (wr_addr == rd_addr) begin
    ppu_buffer <= 1'b1;
    vga_buffer <= 1'b1;
  end
  else if (ppu_frame_end) begin
    ppu_buffer <= 1'b0;
    vga_buffer <= vga_buffer;
  end
  else if (vga_frame_end) begin
    ppu_buffer <= ppu_buffer;
    vga_buffer <= 1'b0;
  end
  else begin
    ppu_buffer <= ppu_buffer;
    vga_buffer <= vga_buffer;
  end
end

// should be delayed one clock from ram_buffer_wr
always @(posedge ppu_clock, negedge rst_n) begin
  if (!rst_n)
    ram_buffer_addr <= wr_addr;
  else if (next_addr)
    ram_buffer_adder <= rd_addr;
end

always @(posedge ppu_clock, negedge rst_n) begin
  if (!rst_n) begin
    next_addr <= 0;
    ram_buffer_wr <= 0;
  end
  else if (ram_buffer) begin
    if (nxt_ram_buffer_addr < rd_addr) begin
      nxt_addr <= 1;
      ram_buffer_wr <= 1;
    end
    else if (rd_addr == 16'b0000) begin
      nxt_addr <= 1;
      ram_buffer_wr <= 1;
    end
    else begin
      nxt_addr <= 0;
      ram_buffer_wr <= 0;
    end
  end
  else begin
    next_addr <= 0;
    ram_buffer_wr <= 1;
  end
end

assign ram_data = vga_buffer ? fifo_q : data;
assign ram_wr = vga_buffer ? ram_buffer_wr : wr;

VGAFIFO	VGAFIFO_inst (
	.aclr ( ~rst_n ), // positive?
	.data ( data ),
	.rdclk ( vga_clock ),
	.rdreq ( ram_buffer_wr ),
	.wrclk ( ppu_clock ),
	.wrreq ( wr & ppu_buffer ),
	.q ( fifo_q ),
	);

VGARam ram_0 ( .data ( ram_data ),
               .rdaddress ( rd_addr ),
               .rdclock ( vga_clock ),
               .rden ( rd ),
               .wraddress ( wr_addr ),
               .wrclock ( ppu_clock ),
               .wren ( ram_wr ),
               .q ( q )
               );

endmodule
