module vga_time_gen(
	input clk,
	input rst_n,
	output vsync,
	output hsync,
	output blank,
	output frame_end
);

	reg [9:0] pixel_x;
	reg [9:0] pixel_y;
	// pixel_count logic
	wire [9:0] next_pixel_x;
	wire [9:0] next_pixel_y;
	// increment each pixel until we get to the end of the row / column, then reset to 0
	assign next_pixel_x = (pixel_x == 10'd799) ? 0 : pixel_x+1;
	assign next_pixel_y = (pixel_x == 10'd799) ?
						  ((pixel_y == 10'd524)? 0 : pixel_y+1)
						  : pixel_y;

	// increment each pixel on each clock edge
	always@(posedge clk, negedge rst_n) begin
		if(!rst_n) begin
			pixel_x <= 10'h000;
			pixel_y <= 10'h000;
		end else begin
			pixel_x <= next_pixel_x;
			pixel_y <= next_pixel_y;
		end
	end


	assign hsync = (pixel_x < 10'd656) || (pixel_x > 10'd751); // 96 cycle pulse
	assign vsync = (pixel_y < 10'd490) || (pixel_y > 10'd491); // 2 cycle pulse
	assign blank = ~((pixel_x > 10'd639) || (pixel_y > 10'd479)); // read from fifo when blank is low
	assign frame_end = (pixel_y == 10'd480) && (pixel_x == 10'd0);

endmodule
