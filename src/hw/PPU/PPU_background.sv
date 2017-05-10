/*
 * This module is the background renderer for the NES. For each scanline on the screen it 
 * keeps reading background data from VRAM and then places it into a series of shift registers. 
 * As each pixel is rendered the background data is shifted.
 * 
 * ------------------------------------------------------------
 * The background renderer is active for the folowing scanlines
 * ------------------------------------------------------------
 * scanline (-1, 261): dummy scanline for filling shift registers with data for the
 *					   first two tiles for the next scanline
 *
 * scanline (0-239): These are the active scanlines for drawing on the screen
 *
 * -----------------------------------------------------------------------
 * The background renderer is active for the folowing cycles in a scanline
 * -----------------------------------------------------------------------
 * cycle (1-256): During these cycles the background data is always being read from
 *				  VRAM in the folowing order.
 *
 *				  1.) Nametable Byte
 *				  2.) Attribute Byte
 *				  3.) Tile Bitmap Low
 *				  4.) Tile Bitmap High
 *
 *				  Since each of these reads takes 2 PPU cycles each tile takes 8 cycles to read.
 *
 * cycle (321-336): This is where the data for the first two tiles on the next scanline is read			  
 *
 * Eric Sullivan
 * ECE 554
 * UW-Madison Spring 2017
 */

module PPU_background(
    input clk, // PPU system clock input
    input rst_n, // Active low system reset
    input bg_render_en, // Background render enable, disables all reads/writes to VRAM
    input [8:0] x_pos, // The current pixel of the scanline being rendered
    input [8:0] y_pos, // The current scanline being rendered
    input [7:0] vram_data_in, // The data that the background renderer has read from VRAM
    input bg_pt_sel, // Selects the background pattern table address 0: $0000 1: $1000
    input show_bg_left_col, // Selects if the background renderer will render the leftmost blocks
    input [2:0] fine_x_scroll, // Selects the pixel drawn on the left hand side of the screen
	input [4:0] coarse_x_scroll, // Selects the tile for the current scanline in the nametable
    input [2:0] fine_y_scroll, // Selects the pixel drawn on the top of the screen
	input [4:0] coarse_y_scroll, // Selects the scanline to draw from the nametable
	input [1:0] nametable_sel, // Specifies what nametable to read data from
	input update_loopy_v, // signal to update the vram address count register
	input cpu_loopy_v_inc,
	input cpu_loopy_v_inc_amt,
	output reg vblank_out,
	output bg_rendering_out,
    output [3:0] bg_pal_sel, // Selects the palette for the background pixel
	output [14:0] loopy_v_out,
    output reg [13:0] vram_addr_out, // VRAM address the background renderer wants to read from
	
	// DEBUG OUTPUT NOT FOR FINAL RELEASE
	output reg [7:0] red,
	output reg [7:0] green,
	output reg [7:0] blue
	);
	
	typedef enum reg [4:0] {
		IDLE, // Initial state on startup and final state when rendering is off
		WAIT, // State used to wait for the next scanline to start after pre loading the first two tiles
		GET_NT_0, // Place nametable member address on vram_addr_out
		GET_NT_1, // Read nametable byte from vram_data_in
		GET_ATTR_0, // Place attribute table address on vram_addr_out
		GET_ATTR_1, // Read attribute byte from vram_data_in
		GET_PT_LOW_0, // Place pagetable low address on vram_addr_out
		GET_PT_LOW_1, // Read pagetable low byte from vram_data_in
		GET_PT_HIGH_0, // Place the pagetable high address on vram_addr_out
		GET_PT_HIGH_1, // Read the pagetable high byte from vram_data_in
		VBLANK // Trigger VBLANK and wait to render the next frame
	} bg_fetch_state;

	bg_fetch_state bg_state;
	bg_fetch_state nxt_bg_state;
	
	reg [14:0] loopy_v;
	
	reg [2:0] fine_x_scroll_v, fine_x_scroll_d;
	reg [4:0] coarse_x_scroll_v, coarse_x_scroll_d;
	reg [2:0] fine_y_scroll_v, fine_y_scroll_d;
	reg [4:0] coarse_y_scroll_v, coarse_y_scroll_d;
	reg [1:0] nametable_sel_v, nametable_sel_d;
	
	reg [2:0] curr_fine_x_scroll_v, curr_fine_x_scroll_d;
	reg [4:0] curr_coarse_x_scroll_v, curr_coarse_x_scroll_d;
	reg [2:0] curr_fine_y_scroll_v, curr_fine_y_scroll_d;
	reg [4:0] curr_coarse_y_scroll_v, curr_coarse_y_scroll_d;
	reg [1:0] curr_nametable_sel_v, curr_nametable_sel_d;
	reg update_curr;
	
	reg [7:0] nametable_byte, nametable_byte_d;
	reg [7:0] attribute_byte, attribute_byte_d;
	reg [7:0] pt_low_byte, pt_low_byte_d;
	reg [7:0] pt_high_byte, pt_high_byte_d;
	
	reg [1:0] curr_pal_attr_sel, cur_pal_attr_sel_d;
	reg [1:0] next_pal_attr_sel, next_pal_attr_sel_d;
	
	reg update_shift_reg, update_shift_reg_d;
	reg update_vram_addr, update_vram_addr_d;
	reg new_frame_start, new_frame_start_d;
	reg new_scanline_start, new_scanline_start_d;
	reg bg_rendering, bg_rendering_d;
	
	wire pal_swap;
	
	reg [7:0] next_tile_low, next_tile_low_d;
	reg [7:0] next_tile_high, next_tile_high_d;
	reg [1:0] next_palette, next_palette_d;
	reg [7:0] curr_tile_low, curr_tile_low_d;
	reg [7:0] curr_tile_high, curr_tile_high_d;
	reg [1:0] curr_palette, curr_palette_d;
	
	// bg rendering next state register
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			bg_state <= IDLE;
			nametable_byte <= 8'h00;
			attribute_byte <= 8'h00;
			pt_low_byte <= 8'h00;
			pt_high_byte <= 8'h00;
			
			fine_x_scroll_v <= 3'h0;
			coarse_x_scroll_v <= 5'h00;
			fine_y_scroll_v <= 3'h0;
			coarse_y_scroll_v <= 5'h00;
			nametable_sel_v <= 2'h0;
			
			curr_fine_x_scroll_v <= 3'h0;
			curr_coarse_x_scroll_v <= 5'h00;
			curr_fine_y_scroll_v <= 3'h0;
			curr_coarse_y_scroll_v <= 5'h00;
			curr_nametable_sel_v <= 2'h0;
			
			update_shift_reg <= 1'b0;
			update_vram_addr <= 1'b0;
			new_frame_start <= 1'b0;
			new_scanline_start <= 1'b0;
			bg_rendering <= 1'b0;
			
			next_tile_low <= 8'h00;
			next_tile_high <= 8'h00;
			next_palette <= 2'b00;
			
			curr_tile_low <= 8'h00;
			curr_tile_high <= 8'h00;
			curr_palette <= 2'b00;
		end
		else begin
			bg_state <= nxt_bg_state;
			nametable_byte <= nametable_byte_d;
			attribute_byte <= attribute_byte_d;
			pt_low_byte <= pt_low_byte_d;
			pt_high_byte <= pt_high_byte_d;
			
			fine_x_scroll_v <= fine_x_scroll_d;
			coarse_x_scroll_v <= coarse_x_scroll_d;
			fine_y_scroll_v <= fine_y_scroll_d;
			coarse_y_scroll_v <= coarse_y_scroll_d;
			nametable_sel_v <= nametable_sel_d;
			
			curr_fine_x_scroll_v <= curr_fine_x_scroll_d;
			curr_coarse_x_scroll_v <= curr_coarse_x_scroll_d;
			curr_fine_y_scroll_v <= curr_fine_y_scroll_d;
			curr_coarse_y_scroll_v <= curr_coarse_y_scroll_d;
			curr_nametable_sel_v <= curr_nametable_sel_d;
			
			update_shift_reg <= update_shift_reg_d;
			update_vram_addr <= update_vram_addr_d;
			new_frame_start <= new_frame_start_d;
			new_scanline_start <= new_scanline_start_d;
			bg_rendering <= bg_rendering_d;
			
			next_tile_low <= next_tile_low_d;
			next_tile_high <= next_tile_high_d;
			next_palette <= next_palette_d;
			
			curr_tile_low <= curr_tile_low_d;
			curr_tile_high <= curr_tile_high_d;
			curr_palette <= curr_palette_d;
		end
	end
	
	// bg rendering vram data fetch logic
	always_comb begin
	
		nxt_bg_state = bg_state;
		nametable_byte_d = nametable_byte;
		attribute_byte_d = attribute_byte;
		pt_low_byte_d = pt_low_byte;
		pt_high_byte_d = pt_high_byte;
		
		update_shift_reg_d = 0;
		update_vram_addr_d = update_vram_addr;
		bg_rendering_d = bg_rendering;
		new_frame_start_d = 0;
		new_scanline_start_d = 0;
		vblank_out = 0;
		update_curr = 0;
	
		vram_addr_out = 14'hzzzz;
	
		case(bg_state)
			IDLE: begin
				if (bg_render_en) begin
					// pre load the first two tiles for the next scanline
					if (x_pos == 320 && y_pos == 9'hfff) begin
						new_frame_start_d = 1;
						nxt_bg_state = GET_NT_0;
						update_vram_addr_d = 1;
						update_curr = 1;
					end
					else if (x_pos == 320 && y_pos < 240) begin
						//new_scanline_start_d = 1;
						nxt_bg_state = GET_NT_0;
						update_vram_addr_d = 1;
						update_curr = 1;
					end
					else if (x_pos == 9'h000 && y_pos == 241) begin
						nxt_bg_state = VBLANK;
					end
					else if (x_pos == 257) begin
						new_scanline_start_d = 1;
					end
				end
			end
			WAIT: begin
				if (y_pos == 239 && x_pos == 340) 
					nxt_bg_state = IDLE;
				if (x_pos == 0) begin
					nxt_bg_state = GET_NT_0;
					update_curr = 1;
					update_vram_addr_d = 1;
					bg_rendering_d = 1;
				end
			end
			GET_NT_0: begin
				update_curr = 1;
				nxt_bg_state = GET_NT_1;
				vram_addr_out = {2'b10, nametable_sel_v, coarse_y_scroll_v, coarse_x_scroll_v};
			end
			GET_NT_1: begin
				nxt_bg_state = GET_ATTR_0;
				nametable_byte_d = vram_data_in;
			end
			GET_ATTR_0: begin
				nxt_bg_state = GET_ATTR_1;
				vram_addr_out = {2'b10, curr_nametable_sel_v, 4'b1111, curr_coarse_y_scroll_v[4:2], curr_coarse_x_scroll_v[4:2]};
			end
			GET_ATTR_1: begin
				nxt_bg_state = GET_PT_LOW_0;
				attribute_byte_d = vram_data_in;
			end
			GET_PT_LOW_0: begin
				nxt_bg_state = GET_PT_LOW_1;
				vram_addr_out = {1'b0, bg_pt_sel, nametable_byte, 1'b0, curr_fine_y_scroll_v};
			end
			GET_PT_LOW_1: begin
				nxt_bg_state = GET_PT_HIGH_0;
				pt_low_byte_d = vram_data_in;
			end
			GET_PT_HIGH_0: begin
				nxt_bg_state = GET_PT_HIGH_1;
				vram_addr_out = {1'b0, bg_pt_sel, nametable_byte, 1'b1, curr_fine_y_scroll_v};
			end
			GET_PT_HIGH_1: begin
				nxt_bg_state = (x_pos == 256) ? IDLE : 
							   (x_pos == 336) ? WAIT : GET_NT_0;
				update_curr = 1;
				update_shift_reg_d = 1;
				update_vram_addr_d = ((y_pos == 239 && x_pos == 256) || (x_pos == 336 || x_pos == 256)) ? 0 : 1;
				pt_high_byte_d = vram_data_in;
				bg_rendering_d = (nxt_bg_state == GET_NT_0 && x_pos != 328) ? 1 : 0;
			end
			VBLANK: begin
				vblank_out = 1;
				if (x_pos == 0 && y_pos == 9'hfff)
					nxt_bg_state = IDLE;
			end
		endcase
	end
	
	always_comb begin
		if (update_curr) begin
			curr_fine_x_scroll_d = fine_x_scroll_v;
			curr_coarse_x_scroll_d = coarse_x_scroll_v;
			curr_fine_y_scroll_d = fine_y_scroll_v;
			curr_coarse_y_scroll_d = coarse_y_scroll_v;
			curr_nametable_sel_d = nametable_sel_v;
		end
		else begin
			curr_fine_x_scroll_d <= curr_fine_x_scroll_v;
			curr_coarse_x_scroll_d <= curr_coarse_x_scroll_v;
			curr_fine_y_scroll_d <= curr_fine_y_scroll_v;
			curr_coarse_y_scroll_d <= curr_coarse_y_scroll_v;
			curr_nametable_sel_d <= curr_nametable_sel_v;
		end
	end
	
	always_comb begin
	
		curr_tile_low_d = curr_tile_low;
		curr_tile_high_d = curr_tile_high;
		curr_palette_d = curr_palette;
		next_tile_low_d = next_tile_low;
		next_tile_high_d = next_tile_high;
		next_palette_d = next_palette;
	
		if (bg_rendering) begin
			{curr_tile_high_d, next_tile_high_d} = {curr_tile_high[6:0], next_tile_high, 1'b0};
			{curr_tile_low_d, next_tile_low_d} = {curr_tile_low[6:0], next_tile_low, 1'b0};
		end
	
		if (pal_swap && bg_rendering)
			curr_palette_d = next_palette;
	
		if (update_shift_reg_d) begin

			if (!bg_rendering) begin
				curr_tile_low_d = next_tile_low;
				curr_tile_high_d = next_tile_high;
				curr_palette_d = next_palette;
			end

			next_tile_low_d = pt_low_byte;
			next_tile_high_d = pt_high_byte_d;
			
			// Select the correct palette from the attribute byte for the current tile
			if (curr_coarse_x_scroll_v[1])
				if (curr_coarse_y_scroll_v[1])
					next_palette_d = attribute_byte[7:6];
				else
					next_palette_d = attribute_byte[3:2];
			else
				if (curr_coarse_y_scroll_v[1])
					next_palette_d = attribute_byte[5:4];
				else
					next_palette_d = attribute_byte[1:0];
		end
	end
	
	// bg rendering vram address logic (loopy_v)
	always_comb begin
		if (!vblank_out && bg_render_en) begin
			if (update_vram_addr) 
				{coarse_x_scroll_d, fine_x_scroll_d} = {coarse_x_scroll_v, fine_x_scroll_v} + 1;
			else
				{coarse_x_scroll_d, fine_x_scroll_d} = {coarse_x_scroll_v, fine_x_scroll_v};
			
			fine_y_scroll_d = fine_y_scroll_v;
			coarse_y_scroll_d = coarse_y_scroll_v;
			nametable_sel_d = nametable_sel_v;
		
			if (update_loopy_v || new_frame_start_d) begin
				fine_x_scroll_d = fine_x_scroll;
				coarse_x_scroll_d = coarse_x_scroll;
				fine_y_scroll_d = fine_y_scroll;
				coarse_y_scroll_d = coarse_y_scroll;
				nametable_sel_d = nametable_sel;
			end
			else if (new_scanline_start_d) begin
				fine_x_scroll_d = fine_x_scroll;
				coarse_x_scroll_d = coarse_x_scroll;
				nametable_sel_d[0] = nametable_sel[0];
			end
			else begin
				// Coarse X increment wrapping
				if (coarse_x_scroll_v == 31 && fine_x_scroll_v == 7) begin
					coarse_x_scroll_d = 5'h00;
					nametable_sel_d = nametable_sel_v ^ 2'b01;
				end
				
				// Coarse Y increment
				/*
				if (x_pos == 256 && y_pos != 9'hfff) begin
					{coarse_y_scroll_d, fine_y_scroll_d} = {coarse_y_scroll_v, fine_y_scroll_v} + 1;
				end
				*/
				
				if (x_pos == 256 && y_pos != 9'hfff) begin
					if (fine_y_scroll_v < 3'h7) begin
						fine_y_scroll_d = fine_y_scroll_v + 1;
					end
					else begin
						fine_y_scroll_d = 0;
						if (coarse_y_scroll_v == 29) begin
							coarse_y_scroll_d = 0;
							nametable_sel_d[1] = nametable_sel_v[1] ^ 1'b1;
						end
						else if (coarse_y_scroll_v == 31) begin
							coarse_y_scroll_d = 0;
						end
						else begin
							coarse_y_scroll_d = coarse_y_scroll_v + 1;
						end
					end
				end
				
			end
		end
		else begin
			{coarse_x_scroll_d, fine_x_scroll_d} = {coarse_x_scroll_v, fine_x_scroll_v};
			fine_y_scroll_d = fine_y_scroll_v;
			coarse_y_scroll_d = coarse_y_scroll_v;
			nametable_sel_d = nametable_sel_v;
			
			if (update_loopy_v) begin
				fine_x_scroll_d = fine_x_scroll;
				coarse_x_scroll_d = coarse_x_scroll;
				fine_y_scroll_d = fine_y_scroll;
				coarse_y_scroll_d = coarse_y_scroll;
				nametable_sel_d = nametable_sel;
			end
			
			if (cpu_loopy_v_inc) begin
				if (cpu_loopy_v_inc_amt)
					{fine_y_scroll_d, nametable_sel_d, coarse_y_scroll_d, coarse_x_scroll_d} = {fine_y_scroll_v, nametable_sel_v, coarse_y_scroll_v, coarse_x_scroll_v} + 32;
				else
					{fine_y_scroll_d, nametable_sel_d, coarse_y_scroll_d, coarse_x_scroll_d} = {fine_y_scroll_v, nametable_sel_v, coarse_y_scroll_v, coarse_x_scroll_v} + 1;
			end
		end
	end
	
	assign pal_swap = (fine_x_scroll_v == 7 && update_vram_addr_d);
	
	// Only assign the output color if the background is currently rendering
	assign bg_pal_sel = (bg_rendering) ? {curr_palette, curr_tile_high[7 - fine_x_scroll], curr_tile_low[7 - fine_x_scroll]} :
										 4'b0000;
	assign bg_rendering_out = bg_rendering;
			
	assign loopy_v_out = {fine_y_scroll_v, nametable_sel_v, coarse_y_scroll_v, coarse_x_scroll_v};

	// DEBUG ONLY NOT FOR FINAL RELEASE
	always_comb begin
		case(bg_pal_sel)
			4'h0: {red, green, blue} = 24'h6888FC;
			4'h1: {red, green, blue} = 24'hB8F818;
			4'h2: {red, green, blue} = 24'h00A800;
			4'h3: {red, green, blue} = 24'h000000;
			4'h4: {red, green, blue} = 24'h6888FC;
			4'h5: {red, green, blue} = 24'hF0D0B0;
			4'h6: {red, green, blue} = 24'hE45C10;
			4'h7: {red, green, blue} = 24'h000000;
			4'h8: {red, green, blue} = 24'h6888FC;
			4'h9: {red, green, blue} = 24'hFCFCFC;
			4'hA: {red, green, blue} = 24'h3CBCFC;
			4'hB: {red, green, blue} = 24'h000000;
			4'hC: {red, green, blue} = 24'h6888FC;
			4'hD: {red, green, blue} = 24'hFCA044;
			4'hE: {red, green, blue} = 24'hE45C10;
			4'hF: {red, green, blue} = 24'h000000;
		endcase
	end
	
endmodule



























