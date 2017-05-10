module RamReader(input vga_clock,
                 input rst_n,
                 input[5:0] q,
                 input blank,
                 output reg[15:0] addr,
                 output reg rd,
                 output[7:0] vga_r,
                 output[7:0] vga_g,
                 output[7:0] vga_b);

// initialize a register to hold the 64rgb colors of the nes palette
reg[23:0] color_palette[0:63];
initial
  $readmemh("../hw/VGA/nes_palette.txt", color_palette);

reg[8:0] horiz_count, vert_count;
reg[5:0] border_count;
reg[3:0] frame_count;
wire in_frame; // low for the borders, high for the pixels

// assumes blank is active low
always @(negedge rst_n, posedge vga_clock) begin

  if (!rst_n) begin
    horiz_count = 0;
    vert_count = 0;
    border_count = 6'hFF;
    frame_count = 0;
  end
  else if (blank) begin
    border_count = border_count - 1; // repeatedly count to 64

    if (border_count == 0) // count to 64 ten times
      if (frame_count == 9)
        frame_count = 0;
      else
        frame_count = frame_count + 1;

    // first and last count to 64 is border, other 8 are pixels
    if (frame_count > 0 && frame_count < 9) begin

      if (horiz_count == 9'hFFF) // at the end of the line, increment the vertical
        if (vert_count == 9'h1DF)
          vert_count = 9'h000;
        else
          vert_count = vert_count + 1;
      horiz_count = horiz_count + 1;

    end
  end
  else begin
    horiz_count = horiz_count;
    vert_count = vert_count;
    border_count = border_count;
    frame_count = frame_count;
  end
end

assign in_frame = (frame_count > 0 && frame_count < 9);
assign addr = (horiz_count >> 1) + (vert_count >> 1) * 256;
assign rd = (frame_count > 0 && frame_count < 9) ? 1 : 0; // active high
assign vga_r = in_frame ? color_palette[q][23:16] : 8'h00;
assign vga_g = in_frame ? color_palette[q][15:8] : 8'h00;
assign vga_b = in_frame ? color_palette[q][7:0] : 8'h00;

endmodule
