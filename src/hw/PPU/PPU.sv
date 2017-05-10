/*
 * This is the top level module for the NES picture processing unit. It contains all of the register logic,
 * scrolling logic, current pixel/scanline count logic, and it instantiates the background renderer and
 * sprite renderer.
 *
 * Eric Sullivan
 * ECE 554
 * UW-Madison Spring 2017
 */

module PPU (
	input clk, // PPU system clock
	input rst_n, // active low reset
	inout [7:0] data, // line for PPU->CPU and CPU->PPU data
	input [2:0] address, // PPU register select
	input [7:0] vram_data_in, // Data input from VRAM reads
	input rw, // PPU register read/write toggle
	input cs_in, // PPU chip select
	output irq, // connected to the 6502's NMI pin
	output [7:0] pixel_data, // the 8 bit color to draw to the screen
	output [13:0] vram_addr_out, // The address that the sprite/background renderer specifies
	output reg vram_rw_sel,
	output reg [7:0] vram_data_out, // The data to write to VRAM from PPUDATA
	output frame_end,
	output frame_start,
	output rendering,
	// DEBUG ONLY NOT FOR RELEASE
	output [7:0] red,
	output [7:0] green,
	output [7:0] blue
	);

	//
	// PPU params
	//
	parameter READ = 0;
	parameter WRITE = 1;

	//
	// PPU control register define
	//
	reg [7:0] PPUCTRL, PPUCTRL_D;
	reg [7:0] PPUMASK, PPUMASK_D;
	reg [7:0] PPUSTATUS, PPUSTATUS_D;
	reg [7:0] OAMADDR, OAMADDR_D;
	reg [7:0] OAMDATA, OAMDATA_D;
	reg [7:0] PPUSCROLL, PPUSCROLL_D;
	reg [7:0] PPUADDR, PPUADDR_D;
	reg [7:0] PPUDATA, PPUDATA_D;
	reg [7:0] OAMDMA, OAMDMA_D;

	//
	// PPU data output reg
	//
	reg [7:0] data_out, data_out_d;
	reg cpu_vram_read, cpu_vram_read_d;
	reg cpu_oam_read, cpu_oam_read_d;

	//
	// PPU loopy register
	//
	reg [14:0] loopy_t, loopy_t_d;
	wire [14:0] loopy_v;
	reg [2:0] fine_x_scroll, fine_x_scroll_d;
	reg w, w_d;
	reg update_loopy_v, update_loopy_v_d;
	reg cpu_loopy_v_inc;

	//
	// Control signals from the PPU registers
	//

	// PPUCTRL values
	wire [1:0] base_nt_addr;
	wire vram_addr_inc;
	wire spr_pt_sel;
	wire bg_pt_sel;
	wire spr_size_sel;
	wire ppu_ms_sel; // Not used in NES
	wire vblank_nmi_gen;

	// PPUMASK values
	wire use_grayscale;
	wire show_bg_left_col;
	wire show_spr_left_col;
	wire bg_render_en;
	wire spr_render_en;
	wire red_bg_color;
	wire green_bg_color;
	wire blue_bg_color;

	// PPUSTATUS wires
	wire spr_overflow;
	wire spr_zero_hit;
	wire vblank_status;

	// Loopy control wires
	wire [4:0] coarse_x_scroll;
	wire [4:0] coarse_y_scroll;
	wire [2:0] fine_y_scroll;

	//
	// Current scanline used to determine when to set Vblank and some other stuff.
	// The PPU renders 262 scanlines per frame and each scanline is 341 PPU clocks where
	// each clock produces one pixel.
	//
	reg [8:0] scanline_count;

	//
	// Current pixel used to determine where the PPU is at in the current scanline
	// and it should be put through the range [0, 340] for each scanline
	//
	reg [8:0] pixel_count;

	//
	// Since the PPU runs at a higher clock rate than the CPU we only want to write data
	// into the registers on the falling edge of the chip select. This prevents multiple
	// writes to the same register
	//
	reg prev_cs_in;

	// Background rendering pixel data
	wire [3:0] bg_pal_out;
	wire [13:0] bg_vram_addr;
	wire [7:0] bg_red, bg_green, bg_blue;
	wire bg_active;

	// Sprite rendering pixel data
	wire [3:0] spr_pal_out;
	wire [13:0] spr_vram_addr;
	wire [7:0] oam_data_out;
	wire [7:0] spr_red, spr_green, spr_blue;
	wire spr_vram_req;
	wire spr_pri_out;
	wire spr_active;
	wire spr_0_rendering;

	// Palette Memory Registers
	wire [4:0] pal_addr;
	reg [7:0] palette_data_in;
	reg palette_mem_rw;
	wire palette_mem_en;
	reg cpu_pal_req;
	wire [7:0] pal_color_out;
	wire [7:0] pal_red, pal_green, pal_blue;

	// CPU VRAM request signals
	reg cpu_vram_req;

	// OAM signals
	reg cpu_oam_req;
	reg oam_rw_en;

	// vblank status register set signals
	reg ppustatus_vblank;
	reg clear_vblank_read;
	reg clear_vblank;
	wire set_vblank;

	// Sprite 0 hit registers
	reg ppustatus_spr_0_hit;
	wire set_spr_0_hit;
	wire clear_spr_0_hit;

	// Sprite overflow registers
	reg ppustatus_spr_overflow;
	wire set_spr_overflow;
	wire clear_spr_overflow;


	PPU_background bg (
		.clk(clk),
		.rst_n(rst_n),
		.bg_render_en(bg_render_en),
		.x_pos(pixel_count),
		.y_pos(scanline_count),
		.vram_data_in(vram_data_in),
		.bg_pt_sel(bg_pt_sel),
		.show_bg_left_col(show_bg_left_col),
		.fine_x_scroll(fine_x_scroll),
		.coarse_x_scroll(coarse_x_scroll),
		.fine_y_scroll(fine_y_scroll),
		.coarse_y_scroll(coarse_y_scroll),
		.nametable_sel(base_nt_addr),
		.update_loopy_v(update_loopy_v),
		.cpu_loopy_v_inc(cpu_loopy_v_inc),
		.cpu_loopy_v_inc_amt(vram_addr_inc),
		.vblank_out(vblank_status),
		.bg_rendering_out(bg_active),
		.bg_pal_sel(bg_pal_out),
		.loopy_v_out(loopy_v),
		.vram_addr_out(bg_vram_addr),

		// DEBUG OUTPUT NOT FOR FINAL RELEASE
		.red(bg_red),
		.green(bg_green),
		.blue(bg_blue)
	);

	PPU_sprite spr (
		.clk(clk),
		.rst_n(rst_n),
		.spr_render_en(spr_render_en),
		.x_pos(pixel_count),
		.y_pos(scanline_count),
		.spr_addr_in(OAMADDR),
		.spr_data_in(OAMDATA_D),
		.vram_data_in(vram_data_in),
		.cpu_oam_rw(oam_rw_en),
		.cpu_oam_req(cpu_oam_req),
		.spr_pt_sel(spr_pt_sel),
		.spr_size_sel(spr_size_sel),
		.show_spr_left_col(show_spr_left_col),
		.spr_overflow(set_spr_overflow),
		.spr_pri_out(spr_pri_out),
		.spr_data_out(oam_data_out),
		.spr_pal_sel(spr_pal_out),
		.vram_addr_out(spr_vram_addr),
		.spr_vram_req(spr_vram_req),
		.spr_0_rendering(spr_0_rendering),

		// DEBUG OUTPUT NOT FOR FINAL RELEASE
		.red(spr_red),
		.green(spr_green),
		.blue(spr_blue),
		.spr_rendering_out(spr_active)
	);

	PPU_palette_mem pal_mem (
		.clk(clk),
		.rst_n(rst_n),
		.pal_addr(pal_addr),
		.palette_data_in(palette_data_in),
		.palette_mem_rw(palette_mem_rw),
		.palette_mem_en(palette_mem_en),
		.color_out(pal_color_out),

		// DEBUG ONLY NOT FOR RELEASE
		.red(pal_red),
		.green(pal_green),
		.blue(pal_blue)
	);

	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			PPUCTRL <= 8'h00;
			PPUMASK <= 8'h00;
			PPUSTATUS <= 8'h00;
			OAMADDR <= 8'h00;
			OAMDATA <= 8'h00;
			PPUSCROLL <= 8'h00;
			PPUADDR <= 8'h00;
			PPUDATA <= 8'h00;
			OAMDMA <= 8'h00;
			loopy_t <= 15'h0000;
			fine_x_scroll <= 3'h0;
			w <= 1'b0;
			update_loopy_v <= 1'b0;
			prev_cs_in <= 1;
			data_out <= 8'h00;
			cpu_vram_read <= 1'b0;
			cpu_oam_read <= 1'b0;
		end
		else begin
			PPUCTRL <= PPUCTRL_D;
			PPUMASK <= PPUMASK_D;
			PPUSTATUS <= PPUSTATUS_D;
			OAMADDR <= OAMADDR_D;
			OAMDATA <= OAMDATA_D;
			PPUSCROLL <= PPUSCROLL_D;
			PPUADDR <= PPUADDR_D;
			PPUDATA <= PPUDATA_D;
			OAMDMA <= OAMDMA_D;
			loopy_t <= loopy_t_d;
			fine_x_scroll <= fine_x_scroll_d;
			w <= w_d;
			update_loopy_v <= update_loopy_v_d;
			prev_cs_in <= cs_in;
			data_out <= data_out_d;
			cpu_vram_read <= cpu_vram_read_d;
			cpu_oam_read <= cpu_oam_read_d;
		end
	end

	// vblank set/clear logic
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			ppustatus_vblank <= 1'b0;
		else if (set_vblank)
			ppustatus_vblank <= 1'b1;
		else if (clear_vblank || clear_vblank_read)
			ppustatus_vblank <= 1'b0;
		else
			ppustatus_vblank <= ppustatus_vblank;
	end

	// Sprite 0 hit set/clear logic
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			ppustatus_spr_0_hit <= 1'b0;
		else if (set_spr_0_hit)
			ppustatus_spr_0_hit <= 1'b1;
		else if (clear_spr_0_hit)
			ppustatus_spr_0_hit <= 1'b0;
		else
			ppustatus_spr_0_hit <= ppustatus_spr_0_hit;
	end

	// Sprite overflow set/clear logic
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			ppustatus_spr_overflow <= 1'b0;
		else if (set_spr_overflow)
			ppustatus_spr_overflow <= 1'b1;
		else if (clear_spr_overflow)
			ppustatus_spr_overflow <= 1'b0;
		else
			ppustatus_spr_overflow <= ppustatus_spr_overflow;
	end

	// Register R/W logic
	always_comb begin

		PPUCTRL_D = PPUCTRL;
		PPUMASK_D = PPUMASK;
		PPUSTATUS_D = PPUSTATUS;
		//OAMADDR_D = OAMADDR;
		OAMDATA_D = OAMDATA;
		PPUSCROLL_D = PPUSCROLL;
		PPUADDR_D = PPUADDR;
		PPUDATA_D = PPUDATA;
		OAMDMA_D = OAMDMA;
		loopy_t_d = loopy_t;
		fine_x_scroll_d = fine_x_scroll;
		w_d = w;
		data_out_d = data_out;

		update_loopy_v_d = 0;
		vram_rw_sel = 0;
		cpu_vram_req = 0;
		cpu_vram_read_d = 0;
		cpu_pal_req = 0;
		palette_mem_rw = 0;
		palette_data_in = 8'h00;
		vram_data_out = 8'hzz;

		cpu_oam_read_d = 1'b0;
		oam_rw_en = 1'b0;
		cpu_oam_req = 1'b0;

		clear_vblank_read = 1'b0;
		
		cpu_loopy_v_inc = 1'b0;
		
		if ((scanline_count == 9'hfff || (scanline_count >= 0 && scanline_count < 241)) && pixel_count == 240)
			OAMADDR_D = 8'h00;
		else
			OAMADDR_D = OAMADDR;

		// Only process a command on the falling edge of the clock
		// this prevents multiple writes
		if (prev_cs_in && ~cs_in) begin // NOTE: Hey Eric, does this means the CPU cant do multiple writes to different registers back to back? Is this correct? -Jon
			if (rw == WRITE) begin
				case (address)
					3'h0: begin
						PPUCTRL_D = data;
						loopy_t_d[11:10] = data[1:0];
					end
					3'h1: PPUMASK_D = data;
					3'h2: PPUSTATUS_D = data;
					3'h3: OAMADDR_D = data;
					3'h4: begin
						OAMADDR_D = OAMADDR + 1;
						OAMDATA_D = data;
						cpu_oam_req = 1;
					end
					3'h5: begin
						w_d = !w;
						if (!w) begin
							loopy_t_d[4:0] = data[7:3];
							fine_x_scroll_d = data[2:0];
						end
						else begin
							{loopy_t_d[14:12], loopy_t_d[9:5]} = {data[2:0], data[7:3]};
						end
					end
					3'h6: begin
						w_d = !w;
						if (!w) begin
							{loopy_t_d[14], loopy_t_d[13:8]} = {1'b0, data[5:0]};
						end
						else begin
							loopy_t_d[7:0] = data;
							update_loopy_v_d = 1;
						end
					end
					3'h7: begin
						cpu_loopy_v_inc = 1'b1;
						if (loopy_v[13:0] < 14'h3f00) begin
							data_out_d = 8'h00; // Need to flush the buffer
							cpu_vram_req = 1;
							vram_rw_sel = 1;
							vram_data_out = data;
						end
						else begin
							cpu_pal_req = 1;
							palette_mem_rw = 1;
							palette_data_in = data;
						end
						/*
						if (vram_addr_inc)
							loopy_t_d = loopy_t + 32;
						else
							loopy_t_d = loopy_t + 1;
						*/
					end
				endcase
			end
			// If this is a read
			else begin
				case (address)
					3'h0: data_out_d = PPUCTRL;
					3'h1: data_out_d = PPUMASK;
					3'h2: begin
						data_out_d = {ppustatus_vblank, ppustatus_spr_0_hit, ppustatus_spr_overflow, 5'h00};
						clear_vblank_read = 1'b1;
						w_d = 0;
					end
					3'h3: data_out_d = OAMADDR;
					3'h4: begin
						if (vblank_status || (!spr_render_en && !bg_render_en)) begin
							//OAMADDR_D = OAMADDR + 1;
							data_out_d = 8'h00; // Need to flush the buffer
							cpu_oam_read_d = 1'b1;
							oam_rw_en = 1'b1;
							cpu_oam_req = 1'b1;
						end
						else
							data_out_d = 8'hff;
					end
					3'h5: data_out_d = PPUSCROLL;
					3'h6: data_out_d = PPUADDR;
					3'h7: begin
						cpu_loopy_v_inc = 1'b1;
						if (loopy_v[13:0] < 14'h3f00) begin
							//data_out_d = 8'h00 // Need to flush the buffer
							data_out_d = PPUDATA;
							cpu_vram_req = 1;
							cpu_vram_read_d = 1;
						end
						else begin
							cpu_pal_req = 1;
							data_out_d = pal_color_out;
							PPUDATA_D = pal_color_out;
						end
						/*
						if (vram_addr_inc)
							loopy_t_d = loopy_t + 32;
						else
							loopy_t_d = loopy_t + 1;
						*/
					end
				endcase
			end
		end

		if (cpu_vram_read)
			PPUDATA_D = vram_data_in;
			//data_out_d = vram_data_in;
		if (cpu_oam_read)
			data_out_d = oam_data_out;
	end

	// The PPU should only take the data bus when the CPU is doing a read
	// otherwise the PPU should leave the data bus for the CPU
	assign data = (rw == READ && !cs_in) ? (data_out_d | data_out) : 8'hzz;

	assign vram_addr_inc = PPUCTRL[2];
	assign spr_pt_sel = PPUCTRL[3];
	assign bg_pt_sel = PPUCTRL[4];
	assign spr_size_sel = PPUCTRL[5];
	assign ppu_ms_sel = PPUCTRL[6];
	assign vblank_nmi_gen = PPUCTRL[7];

	assign use_grayscale = PPUMASK[0];
	assign show_bg_left_col = PPUMASK[1];
	assign show_spr_left_col = PPUMASK[2];
	assign bg_render_en = PPUMASK[3];
	assign spr_render_en = PPUMASK[4];
	assign red_bg_color = PPUMASK[5];
	assign green_bg_color = PPUMASK[6];
	assign blue_bg_color = PPUMASK[7];

	assign coarse_x_scroll = loopy_t[4:0];
	assign coarse_y_scroll = loopy_t[9:5];
	assign base_nt_addr = loopy_t[11:10];
	assign fine_y_scroll = loopy_t[14:12];

	assign vram_addr_out = (cpu_vram_req && (vblank_status || (!bg_render_en && !spr_render_en))) ?  loopy_v[13:0] :
						   spr_vram_req ? spr_vram_addr : bg_vram_addr;

	// NMI is positive edge triggered so it is okay to set it high
	// for the duration of vblank
	assign irq = ppustatus_vblank && vblank_nmi_gen;

	// BEGIN DEBUG ONLY NOT FOR RELEASE

	assign red = pal_red;
	assign green = pal_green;
	assign blue = pal_blue;

	// END DEBUG ONLY

	assign rendering = bg_active;

	assign pal_addr = (cpu_pal_req && (vblank_status || (!bg_render_en && !spr_render_en))) ? loopy_v[4:0] :
					  (!spr_pri_out && spr_pal_out[1:0] != 0) ? {1'b1, spr_pal_out} :
					  (spr_pal_out[1:0] == 0 && bg_pal_out[1:0] != 0) ? {1'b0, bg_pal_out} :
					  (bg_pal_out[1:0] == 0 && spr_pal_out[1:0] != 0) ? {1'b1, spr_pal_out} : {1'b0, bg_pal_out};

	assign palette_mem_en = cpu_pal_req || bg_active;

	assign pixel_data = pal_color_out;

	assign frame_end = (scanline_count == 240) && (pixel_count == 256);
	assign frame_start = (scanline_count == 0) && (pixel_count == 0);
	
	assign set_vblank = (scanline_count == 241) && (pixel_count == 0);
	assign clear_vblank = (scanline_count == 9'hfff) && (pixel_count == 0);
	assign set_spr_0_hit = spr_0_rendering && (spr_pal_out[1:0] != 0) && (bg_pal_out[1:0] != 0);
	assign clear_spr_0_hit = (scanline_count == 9'hfff) && (pixel_count == 9'h000);
	assign clear_spr_overflow = (scanline_count == 9'hfff) && (pixel_count == 9'h000);
	
	// Pixel and scanline count logic
	// 262 scanlines in one frame
	// 341 pixels in one scanline
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			scanline_count <= 9'hfff;
			pixel_count <= 9'h000;
		end

		else if (scanline_count == 260 && pixel_count == 340) begin
			pixel_count <= 9'h000;
			scanline_count <= 9'hfff;
		end

		else if (pixel_count < 340) begin
			pixel_count <= pixel_count + 1;
		end

		else begin
			pixel_count <= 9'h000;
			scanline_count <= scanline_count + 1;
		end
	end


endmodule
