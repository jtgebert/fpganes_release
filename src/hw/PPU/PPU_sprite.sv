/*
 * This module is the sprite renderer for the NES. For each frame it has the job of 
 * finding all of the sprites that fall on a given scanline, and then putting the pixel
 * data of those sprites out to the screen when the scanline is currently rendering
 * the pixels the sprite falls in.
 *
 * Eric Sullivan
 * ECE 554
 * UW-Madison Spring 2017
 */

module PPU_sprite(
	input clk, // PPU system clock
	input rst_n, // PPU active low reset
	input spr_render_en, // Sprite render enable, used to disable VRAM reads/writes
	input [8:0] x_pos, // The current pixel of the scanline being rendered
	input [8:0] y_pos, // The current scanline being rendered
	input [7:0] spr_addr_in, // The OAM address the CPU wants to write to
	input [7:0] spr_data_in, // The data the CPU wants to write to the OAM
	input [7:0] vram_data_in, // The data that the sprite renderer has read from VRAM
	input cpu_oam_rw, // Determines if the CPU wants to read or write to OAM
	input cpu_oam_req, // Signals the cpu is requesting a read/write
	input spr_pt_sel, // Selects the sprite pattern table address 0: $0000 1: $1000
	input spr_size_sel, // Selects the size of sprites to be drawn 0: 8x8 1: 8x16
	input show_spr_left_col, // Determines if sprites in far left 8 pixels will be drawn
	output reg spr_overflow, // Set if more than 8 sprites fall on a single scanline
	output spr_pri_out,
	output [7:0] spr_data_out, // The OAM data the CPU requested for an OAM read
	output [3:0] spr_pal_sel, // Outputs the palette assignment for the pixel to be drawn
	output reg [13:0] vram_addr_out, // The VRAM address the sprite renderer wants to read from
	output reg spr_vram_req, // Set to ensure the sprite VRAM address is selected over bg
	output spr_0_rendering, // Set if OAM sprite 0 is being rendered
	output reg inc_oam_addr,
	
	// DEBUG OUTPUT NOT FOR FINAL RELEASE
	output reg [7:0] red,
	output reg [7:0] green,
	output reg [7:0] blue,
	output reg spr_rendering_out
	);

	integer i;
	
	typedef enum reg [4:0] {
		IDLE, // This is the default state where the spr renderer doesn't do anything
		SEC_OAM_CLEAR, // Cycles 1-64: Set all the data in secondary OAM to $ff
		SPR_EVAL_READ_Y, // Cycles 65-256: Evaluate each sprite in OAM to determine if it is on the next scanline
		SPR_EVAL_WRITE_Y,
		SPR_EVAL_READ_TILE,
		SPR_EVAL_WRITE_TILE,
		SPR_EVAL_READ_ATTR,
		SPR_EVAL_WRITE_ATTR,
		SPR_EVAL_READ_X,
		SPR_EVAL_WRITE_X,
		SPR_GET_Y, // Read the current sprite y coord from secondary OAM
		SPR_GET_TILE, // Read the current sprite tile number from secondary OAM
		SPR_GET_ATTR, // Read the current sprite attribute byte from OAM
		SPR_GET_X, // Read the current sprite x coord from secondary OAM
		SPR_PT_LOW_0, // Place the PT low address on the address bus
		SPR_PT_LOW_1, // Read the PT low data from the data bus
		SPR_PT_HIGH_0, // Place the PT high address on the address bus
		SPR_PT_HIGH_1 // Read the PT high data from the data bus
	} spr_fetch_state;
	
	spr_fetch_state spr_state;
	spr_fetch_state nxt_spr_state;	
	
	// OAM registers
	reg oam_en, oam_en_d;
	reg oam_rw, oam_rw_d;
	reg write_secondary_oam_d;
	reg [6:0] oam_spr_select, oam_spr_select_d;
	reg [1:0] oam_byte_select, oam_byte_select_d;
	reg [7:0] oam_data_in, oam_data_in_d;
	reg [31:0] secondary_oam_data_in, secondary_oam_data_in_d;
	reg [4:0] secondary_oam_addr, secondary_oam_addr_d;
	wire [31:0] secondary_oam_data_out;
	wire [7:0] oam_data_out;
	
	// VRAM fetch registers
	reg [5:0] curr_spr, curr_spr_d;
	reg [7:0] curr_spr_y, curr_spr_y_d;
	reg [7:0] curr_spr_x, curr_spr_x_d;
	reg [7:0] curr_spr_attr, curr_spr_attr_d;
	reg [7:0] curr_spr_tile, curr_spr_tile_d;
	reg [7:0] curr_spr_pt_low, curr_spr_pt_low_d;
	reg [7:0] curr_spr_pt_high, curr_spr_pt_high_d;
	
	
	// Sprite shift registers for next scanline, and shift logic registers
	
	reg update_shift_reg;
	
	reg [7:0] spr_0_low_shift_reg;
	reg [7:0] spr_0_high_shift_reg;
	reg [7:0] spr_0_attr;
	reg [8:0] spr_0_x_count;
	reg is_oam_spr_0;
	reg oam_spr_0_in_range, oam_spr_0_in_range_d;
	wire spr_0_active;
	
	reg [7:0] spr_1_low_shift_reg;
	reg [7:0] spr_1_high_shift_reg;
	reg [7:0] spr_1_attr;
	reg [8:0] spr_1_x_count;
	wire spr_1_active;
	
	reg [7:0] spr_2_low_shift_reg;
	reg [7:0] spr_2_high_shift_reg;
	reg [7:0] spr_2_attr;
	reg [8:0] spr_2_x_count;
	wire spr_2_active;
	
	reg [7:0] spr_3_low_shift_reg;
	reg [7:0] spr_3_high_shift_reg;
	reg [7:0] spr_3_attr;
	reg [8:0] spr_3_x_count;
	wire spr_3_active;
	
	reg [7:0] spr_4_low_shift_reg;
	reg [7:0] spr_4_high_shift_reg;
	reg [7:0] spr_4_attr;
	reg [8:0] spr_4_x_count;
	wire spr_4_active;
	
	reg [7:0] spr_5_low_shift_reg;
	reg [7:0] spr_5_high_shift_reg;
	reg [7:0] spr_5_attr;
	reg [8:0] spr_5_x_count;
	wire spr_5_active;
	
	reg [7:0] spr_6_low_shift_reg;
	reg [7:0] spr_6_high_shift_reg;
	reg [7:0] spr_6_attr;
	reg [8:0] spr_6_x_count;
	wire spr_6_active;
	
	reg [7:0] spr_7_low_shift_reg;
	reg [7:0] spr_7_high_shift_reg;
	reg [7:0] spr_7_attr;
	reg [8:0] spr_7_x_count;
	wire spr_7_active;
	
	wire active_pixel;
	
	wire oam_en_in;
	wire oam_rw_in;
	wire [5:0] oam_spr_select_in;
	wire [1:0] oam_byte_select_in;
	
	PPU_oam OAM (
		.clk(clk),
		.rst_n(rst_n),
		.oam_en(oam_en_in),
		.oam_rw(oam_rw_in),
		.spr_select(oam_spr_select_in),
		.byte_select(oam_byte_select_in),
		.data_in(spr_data_in),
		.data_out(oam_data_out)
	);
	
	reg [31:0] secondary_oam [7:0];
	
	// Sprite Renderer SM registers
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			spr_state <= IDLE;
			oam_en <= 1'b0;
			oam_rw <= 1'b0;
			oam_spr_select <= 7'h00;
			oam_byte_select <= 2'h0;
			oam_data_in <= 8'h00;
			secondary_oam_data_in <= 8'h00;
			secondary_oam_addr <= 8'h00;
			
			curr_spr <= 3'h0;
			curr_spr_y <= 8'h00;
			curr_spr_x <= 8'h00;
			curr_spr_attr <= 8'h00;
			curr_spr_tile <= 8'h00;
			curr_spr_pt_low <= 8'h00;
			curr_spr_pt_high <= 8'h00;
			
			oam_spr_0_in_range <= 1'b0;
			
			for (i = 0; i < 8; i = i + 1)
				secondary_oam[i] <= 8'h00;
		end
		else begin
			spr_state <=  nxt_spr_state;
			oam_en <= oam_en_d;
			oam_rw <= oam_rw_d;
			oam_spr_select <= oam_spr_select_d;
			oam_byte_select <= oam_byte_select_d;
			oam_data_in <= oam_data_in_d;
			secondary_oam_data_in <= secondary_oam_data_in_d;
			secondary_oam_addr <= secondary_oam_addr_d;
			
			curr_spr <= curr_spr_d;
			curr_spr_y <= curr_spr_y_d;
			curr_spr_x <= curr_spr_x_d;
			curr_spr_attr <= curr_spr_attr_d;
			curr_spr_tile <= curr_spr_tile_d;
			curr_spr_pt_low <= curr_spr_pt_low_d;
			curr_spr_pt_high <= curr_spr_pt_high_d;
			
			oam_spr_0_in_range <= oam_spr_0_in_range_d;
			
			if (write_secondary_oam_d)
				secondary_oam[secondary_oam_addr] <= secondary_oam_data_in_d;
		end
	end
	
	// Sprite shift register loading/shift logic
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			spr_0_low_shift_reg <= 8'hff;
			spr_0_high_shift_reg <= 8'h00;
			spr_0_attr <= 8'h00;
			spr_0_x_count <= 9'hfff;
			is_oam_spr_0 <= 1'b0;
			
			spr_1_low_shift_reg <= 8'h00;
			spr_1_high_shift_reg <= 8'h00;
			spr_1_attr <= 8'h00;
			spr_1_x_count <= 9'hfff;
			
			spr_2_low_shift_reg <= 8'h00;
			spr_2_high_shift_reg <= 8'h00;
			spr_2_attr <= 8'h00;
			spr_2_x_count <= 9'hfff;
			
			spr_3_low_shift_reg <= 8'h00;
			spr_3_high_shift_reg <= 8'h00;
			spr_3_attr <= 8'h00;
			spr_3_x_count <= 9'hfff;
			
			spr_4_low_shift_reg <= 8'h00;
			spr_4_high_shift_reg <= 8'h00;
			spr_4_attr <= 8'h00;
			spr_4_x_count <= 9'hfff;
			
			spr_5_low_shift_reg <= 8'h00;
			spr_5_high_shift_reg <= 8'h00;
			spr_5_attr <= 8'h00;
			spr_5_x_count <= 9'hfff;
			
			spr_6_low_shift_reg <= 8'h00;
			spr_6_high_shift_reg <= 8'h00;
			spr_6_attr <= 8'h00;
			spr_6_x_count <= 9'hfff;
			
			spr_7_low_shift_reg <= 8'h00;
			spr_7_high_shift_reg <= 8'h00;
			spr_7_attr <= 8'h00;
			spr_7_x_count <= 9'hfff;
		end
		else if (update_shift_reg) begin
			case(curr_spr)
				0: begin
					spr_0_low_shift_reg <= curr_spr_pt_low;
					spr_0_high_shift_reg <= curr_spr_pt_high_d;
					spr_0_attr <= curr_spr_attr;
					spr_0_x_count <= curr_spr_x;
					is_oam_spr_0 <= oam_spr_0_in_range;
				end
				1: begin
					spr_1_low_shift_reg <= curr_spr_pt_low;
					spr_1_high_shift_reg <= curr_spr_pt_high_d;
					spr_1_attr <= curr_spr_attr;
					spr_1_x_count <= curr_spr_x;
				end
				2: begin
					spr_2_low_shift_reg <= curr_spr_pt_low;
					spr_2_high_shift_reg <= curr_spr_pt_high_d;
					spr_2_attr <= curr_spr_attr;
					spr_2_x_count <= curr_spr_x;
				end
				3: begin
					spr_3_low_shift_reg <= curr_spr_pt_low;
					spr_3_high_shift_reg <= curr_spr_pt_high_d;
					spr_3_attr <= curr_spr_attr;
					spr_3_x_count <= curr_spr_x;
				end
				4: begin
					spr_4_low_shift_reg <= curr_spr_pt_low;
					spr_4_high_shift_reg <= curr_spr_pt_high_d;
					spr_4_attr <= curr_spr_attr;
					spr_4_x_count <= curr_spr_x;
				end
				5: begin
					spr_5_low_shift_reg <= curr_spr_pt_low;
					spr_5_high_shift_reg <= curr_spr_pt_high_d;
					spr_5_attr <= curr_spr_attr;
					spr_5_x_count <= curr_spr_x;
				end
				6: begin
					spr_6_low_shift_reg <= curr_spr_pt_low;
					spr_6_high_shift_reg <= curr_spr_pt_high_d;
					spr_6_attr <= curr_spr_attr;
					spr_6_x_count <= curr_spr_x;
				end
				7: begin
					spr_7_low_shift_reg <= curr_spr_pt_low;
					spr_7_high_shift_reg <= curr_spr_pt_high_d;
					spr_7_attr <= curr_spr_attr;
					spr_7_x_count <= curr_spr_x;
				end
			endcase
		end
		else if (active_pixel) begin
			
			spr_0_x_count <= spr_0_x_count - 1;
			spr_1_x_count <= spr_1_x_count - 1;
			spr_2_x_count <= spr_2_x_count - 1;
			spr_3_x_count <= spr_3_x_count - 1;
			spr_4_x_count <= spr_4_x_count - 1;
			spr_5_x_count <= spr_5_x_count - 1;
			spr_6_x_count <= spr_6_x_count - 1;
			spr_7_x_count <= spr_7_x_count - 1;
		
			if (spr_0_active) begin
				spr_0_low_shift_reg <= {spr_0_low_shift_reg[6:0], 1'b0};
				spr_0_high_shift_reg <= {spr_0_high_shift_reg[6:0], 1'b0};
			end
			if (spr_1_active) begin
				spr_1_low_shift_reg <= {spr_1_low_shift_reg[6:0], 1'b0};
				spr_1_high_shift_reg <= {spr_1_high_shift_reg[6:0], 1'b0};
			end
			if (spr_2_active) begin
				spr_2_low_shift_reg <= {spr_2_low_shift_reg[6:0], 1'b0};
				spr_2_high_shift_reg <= {spr_2_high_shift_reg[6:0], 1'b0};
			end
			if (spr_3_active) begin
				spr_3_low_shift_reg <= {spr_3_low_shift_reg[6:0], 1'b0};
				spr_3_high_shift_reg <= {spr_3_high_shift_reg[6:0], 1'b0};
			end
			if (spr_4_active) begin
				spr_4_low_shift_reg <= {spr_4_low_shift_reg[6:0], 1'b0};
				spr_4_high_shift_reg <= {spr_4_high_shift_reg[6:0], 1'b0};
			end
			if (spr_5_active) begin
				spr_5_low_shift_reg <= {spr_5_low_shift_reg[6:0], 1'b0};
				spr_5_high_shift_reg <= {spr_5_high_shift_reg[6:0], 1'b0};
			end
			if (spr_6_active) begin
				spr_6_low_shift_reg <= {spr_6_low_shift_reg[6:0], 1'b0};
				spr_6_high_shift_reg <= {spr_6_high_shift_reg[6:0], 1'b0};
			end
			if (spr_7_active) begin
				spr_7_low_shift_reg <= {spr_7_low_shift_reg[6:0], 1'b0};
				spr_7_high_shift_reg <= {spr_7_high_shift_reg[6:0], 1'b0};
			end
		end
		else begin
			
		end
	end
	
	// Sprite Renderer SM Logic
	always_comb begin
	
		nxt_spr_state = spr_state;
		write_secondary_oam_d = 0;
		secondary_oam_data_in_d = 0;
	
		curr_spr_d = curr_spr;
		curr_spr_y_d = curr_spr_y;
		curr_spr_x_d = curr_spr_x;
		curr_spr_attr_d = curr_spr_attr;
		curr_spr_tile_d = curr_spr_tile;
		curr_spr_pt_low_d = curr_spr_pt_low;
		curr_spr_pt_high_d = curr_spr_pt_high;
	
		secondary_oam_addr_d = secondary_oam_addr;
		update_shift_reg = 0;
		
		oam_spr_select_d = oam_spr_select;
		oam_byte_select_d = oam_byte_select;
		
		spr_vram_req = 0;
		oam_rw_d = 1'b0;
		oam_en_d = 1'b0;
	
		vram_addr_out = 14'hzzzz;
		
		oam_spr_0_in_range_d = oam_spr_0_in_range;
		
		spr_overflow = 1'b0;
		
		inc_oam_addr = 1'b0;
	
		case(spr_state)
			IDLE: begin
				if (y_pos >= 0 && y_pos < 239 && spr_render_en) begin
					if (x_pos == 0) begin
						nxt_spr_state = SEC_OAM_CLEAR;
						secondary_oam_addr_d = 5'h00;
						secondary_oam_data_in_d = 8'hff;
						oam_spr_0_in_range_d = 1'b0;
					end
					else if (x_pos == 64) begin
						nxt_spr_state = SPR_EVAL_READ_Y;
						oam_spr_select_d = 0;
						oam_byte_select_d = 0;
						curr_spr_d = 0;
						oam_en_d = 1;
						oam_rw_d = 1;
					end
					else if (x_pos == 256) begin
						nxt_spr_state = SPR_GET_Y;
						curr_spr_d = 0;
					end
				end
			end
			SEC_OAM_CLEAR: begin
				write_secondary_oam_d = 1;
				secondary_oam_addr_d = secondary_oam_addr + 1;
				secondary_oam_data_in_d = 32'hffffffff;
				if (secondary_oam_addr == 7)
					nxt_spr_state = IDLE;
			end
			SPR_EVAL_READ_Y: begin 
				if (oam_spr_select == 64) begin
					nxt_spr_state = IDLE;
					oam_spr_select_d = 0;
				end
				else begin
					nxt_spr_state = SPR_EVAL_WRITE_Y;
					curr_spr_y_d = oam_data_out;
					secondary_oam_addr_d = curr_spr;
				end
			end
			SPR_EVAL_WRITE_Y: begin
				if (y_pos >= curr_spr_y && y_pos < curr_spr_y + 8) begin
					if (curr_spr == 8) begin
						nxt_spr_state = IDLE;
						spr_overflow = 1'b1;
					end
					else begin
						nxt_spr_state = SPR_EVAL_READ_TILE;
						
						if (oam_spr_select == 0)
							oam_spr_0_in_range_d = 1'b1;
							
						oam_byte_select_d = oam_byte_select + 1;
						oam_en_d = 1;
						oam_rw_d = 1;
					end
				end
				else begin
					nxt_spr_state = SPR_EVAL_READ_Y;
					oam_spr_select_d = oam_spr_select + 1;
					oam_byte_select_d = 0;
					oam_en_d = 1;
					oam_rw_d = 1;
				end
			end
			SPR_EVAL_READ_TILE: begin 
				nxt_spr_state = SPR_EVAL_WRITE_TILE;
				curr_spr_tile_d = oam_data_out;
			end
			SPR_EVAL_WRITE_TILE: begin
				nxt_spr_state = SPR_EVAL_READ_ATTR;
				oam_byte_select_d = oam_byte_select + 1;
				oam_en_d = 1;
				oam_rw_d = 1;
			end
			SPR_EVAL_READ_ATTR: begin 
				nxt_spr_state = SPR_EVAL_WRITE_ATTR;
				curr_spr_attr_d = oam_data_out;
			end
			SPR_EVAL_WRITE_ATTR: begin
				nxt_spr_state = SPR_EVAL_READ_X;
				oam_byte_select_d = oam_byte_select + 1;
				oam_en_d = 1;
				oam_rw_d = 1;
			end
			SPR_EVAL_READ_X: begin 
				nxt_spr_state = SPR_EVAL_WRITE_X;
				curr_spr_x_d = oam_data_out;
			end
			SPR_EVAL_WRITE_X: begin
				nxt_spr_state = SPR_EVAL_READ_Y;
				oam_byte_select_d = 0;
				oam_spr_select_d = oam_spr_select + 1;
				curr_spr_d = curr_spr + 1;
				write_secondary_oam_d = 1;
				secondary_oam_data_in_d = {curr_spr_x, curr_spr_attr, curr_spr_tile, curr_spr_y};
				oam_en_d = 1;
				oam_rw_d = 1;
			end
			SPR_GET_Y: begin
				nxt_spr_state = SPR_GET_TILE;
				secondary_oam_addr_d = curr_spr;
				curr_spr_y_d = secondary_oam_data_out[7:0];
			end
			SPR_GET_TILE: begin
				nxt_spr_state = SPR_GET_ATTR;
				secondary_oam_addr_d = curr_spr;
				curr_spr_tile_d = secondary_oam_data_out[15:8];
			end
			SPR_GET_ATTR: begin
				nxt_spr_state = SPR_GET_X;
				secondary_oam_addr_d = curr_spr;
				curr_spr_attr_d = secondary_oam_data_out[23:16];
			end
			SPR_GET_X: begin
				nxt_spr_state = SPR_PT_LOW_0;
				secondary_oam_addr_d = curr_spr;
				curr_spr_x_d = secondary_oam_data_out[31:24];
			end
			SPR_PT_LOW_0: begin
				nxt_spr_state = SPR_PT_LOW_1;
				if (curr_spr_attr[7])
					vram_addr_out = {1'b0, spr_pt_sel, curr_spr_tile, 1'b0, 3'h7 - (y_pos[2:0] - curr_spr_y[2:0])};
				else
					vram_addr_out = {1'b0, spr_pt_sel, curr_spr_tile, 1'b0, y_pos[2:0] - curr_spr_y[2:0]};
				spr_vram_req = 1;
			end
			SPR_PT_LOW_1: begin
				nxt_spr_state = SPR_PT_HIGH_0;
				if (curr_spr_attr[6]) begin
					curr_spr_pt_low_d[7] = vram_data_in[0];
					curr_spr_pt_low_d[6] = vram_data_in[1];
					curr_spr_pt_low_d[5] = vram_data_in[2];
					curr_spr_pt_low_d[4] = vram_data_in[3];
					curr_spr_pt_low_d[3] = vram_data_in[4];
					curr_spr_pt_low_d[2] = vram_data_in[5];
					curr_spr_pt_low_d[1] = vram_data_in[6];
					curr_spr_pt_low_d[0] = vram_data_in[7];
				end
				else
					curr_spr_pt_low_d = vram_data_in;
			end
			SPR_PT_HIGH_0: begin
				nxt_spr_state = SPR_PT_HIGH_1;
				if (curr_spr_attr[7])
					vram_addr_out = {1'b0, spr_pt_sel, curr_spr_tile, 1'b1, 3'h7 - (y_pos[2:0] - curr_spr_y[2:0])};
				else
					vram_addr_out = {1'b0, spr_pt_sel, curr_spr_tile, 1'b1, y_pos[2:0] - curr_spr_y[2:0]};
				spr_vram_req = 1;
			end
			SPR_PT_HIGH_1: begin
			
				update_shift_reg = 1;
				if (curr_spr_attr[6]) begin
					curr_spr_pt_high_d[7] = vram_data_in[0];
					curr_spr_pt_high_d[6] = vram_data_in[1];
					curr_spr_pt_high_d[5] = vram_data_in[2];
					curr_spr_pt_high_d[4] = vram_data_in[3];
					curr_spr_pt_high_d[3] = vram_data_in[4];
					curr_spr_pt_high_d[2] = vram_data_in[5];
					curr_spr_pt_high_d[1] = vram_data_in[6];
					curr_spr_pt_high_d[0] = vram_data_in[7];
				end
				else
					curr_spr_pt_high_d = vram_data_in;
					
				if (x_pos == 320) begin
					nxt_spr_state = IDLE;
				end
				else begin
					nxt_spr_state = SPR_GET_Y;
					curr_spr_d = curr_spr + 1;
				end
			end
		endcase
	end

	assign secondary_oam_data_out = write_secondary_oam_d ? 32'h00000000 : secondary_oam[secondary_oam_addr_d];
	assign spr_0_active = (spr_0_x_count == 9'h00) || (spr_0_x_count <= 511 && spr_0_x_count > 504);
	assign spr_1_active = (spr_1_x_count == 9'h00) || (spr_1_x_count <= 511 && spr_1_x_count > 504);
	assign spr_2_active = (spr_2_x_count == 9'h00) || (spr_2_x_count <= 511 && spr_2_x_count > 504);
	assign spr_3_active = (spr_3_x_count == 9'h00) || (spr_3_x_count <= 511 && spr_3_x_count > 504);
	assign spr_4_active = (spr_4_x_count == 9'h00) || (spr_4_x_count <= 511 && spr_4_x_count > 504);
	assign spr_5_active = (spr_5_x_count == 9'h00) || (spr_5_x_count <= 511 && spr_5_x_count > 504);
	assign spr_6_active = (spr_6_x_count == 9'h00) || (spr_6_x_count <= 511 && spr_6_x_count > 504);
	assign spr_7_active = (spr_7_x_count == 9'h00) || (spr_7_x_count <= 511 && spr_7_x_count > 504);
	assign active_pixel = (x_pos > 0 && x_pos < 257 && y_pos > 0 && y_pos < 240);
	
	assign {spr_pri_out, spr_pal_sel} = 
	(!spr_render_en || (x_pos < 9 && !show_spr_left_col) || !active_pixel) ? 5'h10 :
	(spr_0_active && {spr_0_high_shift_reg[7], spr_0_low_shift_reg[7]} != 2'h0) ? {spr_0_attr[5], spr_0_attr[1:0], spr_0_high_shift_reg[7], spr_0_low_shift_reg[7]} :
	(spr_1_active && {spr_1_high_shift_reg[7], spr_1_low_shift_reg[7]} != 2'h0) ? {spr_1_attr[5], spr_1_attr[1:0], spr_1_high_shift_reg[7], spr_1_low_shift_reg[7]} :
	(spr_2_active && {spr_2_high_shift_reg[7], spr_2_low_shift_reg[7]} != 2'h0) ? {spr_2_attr[5], spr_2_attr[1:0], spr_2_high_shift_reg[7], spr_2_low_shift_reg[7]} :
	(spr_3_active && {spr_3_high_shift_reg[7], spr_3_low_shift_reg[7]} != 2'h0) ? {spr_3_attr[5], spr_3_attr[1:0], spr_3_high_shift_reg[7], spr_3_low_shift_reg[7]} :
	(spr_4_active && {spr_4_high_shift_reg[7], spr_4_low_shift_reg[7]} != 2'h0) ? {spr_4_attr[5], spr_4_attr[1:0], spr_4_high_shift_reg[7], spr_4_low_shift_reg[7]} :
	(spr_5_active && {spr_5_high_shift_reg[7], spr_5_low_shift_reg[7]} != 2'h0) ? {spr_5_attr[5], spr_5_attr[1:0], spr_5_high_shift_reg[7], spr_5_low_shift_reg[7]} :
	(spr_6_active && {spr_6_high_shift_reg[7], spr_6_low_shift_reg[7]} != 2'h0) ? {spr_6_attr[5], spr_6_attr[1:0], spr_6_high_shift_reg[7], spr_6_low_shift_reg[7]} :
	(spr_7_active && {spr_7_high_shift_reg[7], spr_7_low_shift_reg[7]} != 2'h0) ? {spr_7_attr[5], spr_7_attr[1:0], spr_7_high_shift_reg[7], spr_7_low_shift_reg[7]} :
					 5'h10;
					 
	// DEBUG ONLY NOT FOR FINAL RELEASE
	always_comb begin
		case(spr_pal_sel)
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
	
	assign spr_rendering_out = active_pixel;
	assign spr_data_out = oam_data_out;
	assign oam_en_in = (active_pixel && spr_render_en) ? oam_en_d : cpu_oam_req;
	assign oam_rw_in = (active_pixel && spr_render_en) ? oam_rw_d : cpu_oam_rw;
	assign oam_spr_select_in = (active_pixel && spr_render_en) ? oam_spr_select_d[5:0] : spr_addr_in[7:2];
	assign oam_byte_select_in = (active_pixel && spr_render_en) ? oam_byte_select_d : spr_addr_in[1:0];
	assign spr_0_rendering = is_oam_spr_0 && spr_0_active;
	
endmodule









