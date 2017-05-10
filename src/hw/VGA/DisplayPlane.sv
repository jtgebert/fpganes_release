module DisplayPlane(input ppu_clock,
                    input rst_n,
						  input rendering,
						  input frame_start,
                    output reg[15:0] addr,
                    output reg wr);

always @(posedge ppu_clock, negedge rst_n) begin
  if (!rst_n) begin
    addr <= 16'h0000;
    wr <= 0;
  end
  else if (frame_start) begin
	 addr <= 16'h0000;
	 wr <= 1'b0;
  end
  else if (rendering) begin
    if (addr == 16'hEFFF)
      addr <= 16'h0000;
    else
      addr <= addr + 1;
    wr <= 1;
  end
  else begin
    addr <= addr;
	 wr <= 1'b0;
  end
end

endmodule
