`timescale 1 ps / 1 ps
module PPU_tb();

	integer file;
	integer frame_count;
	string file_name = "I:/ECE554/fpganes/test";
	string file_number = "0";
	
	reg [7:0] palette_data [31:0];
	
	reg prev_nmi;
	
	reg ppu_clk;
	reg rst_n;
	reg cpu_clk;
	reg [2:0] ppu_counter;
	reg [2:0] addr;
	wire [7:0] data;
	reg rw;
	reg ppu_cs;
	wire irq;
	wire [7:0] pixel_data;
	reg [7:0] ppu_data;
	
	wire [7:0] vram_data_in;
	wire [7:0] pixel_out;
	wire [13:0] vram_addr_out;
	wire [7:0] vram_data_out;
	wire [7:0] red, blue, green;
	wire rendering;
	wire nmi;
	wire vram_rw_sel;
	reg vblank;

	PPU DUT (
		.clk(ppu_clk),
		.rst_n(rst_n),
		.data(data),
		.address(addr),
		.vram_data_in(vram_data_in),
		.rw(rw),
		.cs_in(ppu_cs),
		.irq(nmi),
		.pixel_data(pixel_out),
		.vram_addr_out(vram_addr_out),
		.vram_rw_sel(vram_rw_sel),
		.vram_data_out(vram_data_out),
	
		// DEBUG ONLY NOT FOR RELEASE
		.red(red),
		.green(green),
		.blue(blue),
		.rendering(rendering)
	);
	
	/*
	bg_test_rom VRAM(
		.address(vram_addr_out),
		.clock(ppu_clk),
		.q(vram_data_in)
	);
	*/
	
	test_ram VRAM (
		.address(vram_addr_out),
		.clock(ppu_clk),
		.data(vram_data_out),
		.wren(vram_rw_sel),
		.q(vram_data_in)
	);
	
	task write_reg;
		input [2:0] writeAddr;
		input [7:0] writeVal;
		ppu_cs = 0;
		rw = 1;
		addr = writeAddr;
		ppu_data = writeVal;
		@(posedge cpu_clk);
		ppu_cs = 1;
	endtask
	
	task read_reg;
		input [2:0] readAddr;
		input [7:0] expVal;
		ppu_cs = 0;
		rw = 0;
		addr = readAddr;
		@(negedge cpu_clk);
		if (data == expVal)
			$display("PASS: The value read from the data bus matches the expected value");
		else
			$display("FAIL: The value does not match, expected: 0x%x recieved: 0x%x", expVal, data);
		@(posedge cpu_clk);
		ppu_cs = 1;
		rw = 1;
	endtask
	
	task fill_ppu_palette;
		integer i;
		i = 0;
		@(posedge cpu_clk);
		write_reg(.writeAddr(6), .writeVal(8'h3f));
		@(posedge cpu_clk);
		write_reg(.writeAddr(6), .writeVal(8'h00));
		@(posedge cpu_clk);
		for (i = 0; i < 32; i = i + 1) begin
			write_reg(.writeAddr(7), .writeVal(palette_data[i]));
			@(posedge cpu_clk);
		end
	endtask
	
	task write_vram_scroll;
		input [15:0] addr;
		write_reg(.writeAddr(6), .writeVal(addr[15:8]));
		@(posedge cpu_clk);
		write_reg(.writeAddr(6), .writeVal(addr[7:0]));
		@(posedge cpu_clk);
	endtask
	
	task write_ppu_vram;
		input [7:0] data;
		write_reg(.writeAddr(7), .writeVal(data));
		@(posedge cpu_clk);
	endtask
	
	task read_ppu_vram;
		input [7:0] expVal;
		read_reg(.readAddr(7), .expVal(expVal));
		@(posedge cpu_clk);
	endtask
	
	task write_oam_addr;
		input [7:0] addr;
		write_reg(.writeAddr(3), .writeVal(addr));
		@(posedge cpu_clk);
	endtask
	
	task write_oam_data;
		input [7:0] data;
		write_reg(.writeAddr(4), .writeVal(data));
		@(posedge cpu_clk);
	endtask
	
	task read_oam_data;
		input [7:0] expVal;
		read_reg(.readAddr(4), .expVal(expVal));
		@(posedge cpu_clk);
	endtask
	
	task is_vblank;
		output vblank;
		ppu_cs = 0;
		rw = 0;
		addr = 2;
		@(negedge cpu_clk);
		if (data & 8'h80)
			vblank = 1;
		else
			vblank = 0;
		@(posedge cpu_clk);
		ppu_cs = 1;
		rw = 1;
	endtask
	
	task enable_rendering;
		write_reg(.writeAddr(1), .writeVal(8'h1c));
		@(posedge cpu_clk);
	endtask
	
	task disable_rendering;
		reg [7:0] reg_data;
		ppu_cs = 0;
		rw = 0;
		addr = 2;
		@(negedge cpu_clk);
		reg_data = data;
		@(posedge cpu_clk);
		ppu_cs = 1;
		rw = 1;
		@(posedge cpu_clk);
		write_reg(.writeAddr(0), .writeVal(reg_data & (~8'h1c)));
	endtask
	
	always 
		#5 ppu_clk = ~ppu_clk;
	
	always @(/*posedge ppu_clk, negedge */ppu_clk) begin
		if (!rst_n) begin
			ppu_counter <= 0;
		end
		else if (ppu_counter == 2) begin
			ppu_counter <= 0;
			cpu_clk = ~cpu_clk;
		end
		else
			ppu_counter <= ppu_counter + 1;
	end
	
	always @(posedge ppu_clk, negedge rst_n) begin
		if (!rst_n)
			prev_nmi <= 1'b0;
		else
			prev_nmi <= nmi;
	end
	
	always @(posedge ppu_clk, negedge rst_n) begin
		
		if (!prev_nmi && nmi) begin
			frame_count = frame_count + 1;
			file_number.itoa(frame_count);
			$fclose(file);
			file = $fopen({file_name, "_", file_number, ".ppm"}, "w");
			$fwrite(file, "P3\n");
			$fwrite(file, "256 240\n");
			$fwrite(file, "255\n");
		end
		
		if (frame_count == 2) begin
			$fclose(file);
			$stop;
		end
		
		if (rendering) begin
			$fwrite(file, "%d  %d  %d\n", red, green, blue);
		end
		
	end
	
	assign data = ((rw == 1) && (ppu_cs == 0)) ? ppu_data : 8'hzz;
	
	initial begin
		file = $fopen({file_name, "_", file_number, ".ppm"}, "w");
		$fwrite(file, "P3\n");
		$fwrite(file, "256 240\n");
		$fwrite(file, "255\n");
	
		$readmemh("I:/ECE554/fpganes/src/hw/PPU/mario_palette.txt", palette_data);
	
		frame_count = 0;
		rst_n = 0;
		rw = 0;
		ppu_data = 0;
		ppu_counter = 0;
		ppu_clk = 1;
		cpu_clk = 1;
		ppu_cs = 1;
		#5;
		rst_n = 1;
		
		fill_ppu_palette();

		// Set the VRAM address
		write_vram_scroll(.addr(16'h2010));
		
		// Write the vram data
		write_ppu_vram(.data(8'h56));
		write_ppu_vram(.data(8'h56));
		write_ppu_vram(.data(8'h56));
		
		// Write a palette byte
		write_vram_scroll(.addr(16'h3f00));
		write_ppu_vram(.data(8'h22));
		write_vram_scroll(.addr(16'h3f00));
		read_ppu_vram(.expVal(8'h22));
		
		// Read the vram data out
		write_vram_scroll(.addr(16'h2010));
		read_ppu_vram(.expVal(8'h56));
		read_ppu_vram(.expVal(8'h56));
		read_ppu_vram(.expVal(8'h56));
		read_ppu_vram(.expVal(8'h56));
		
		// Write to OAM
		
		write_oam_addr(.addr(0));
		write_oam_data(.data(188));
		write_oam_data(.data(3));
		write_oam_data(.data(8'h80));
		write_oam_data(.data(68));
		
		write_oam_data(.data(20));
		write_oam_data(.data(0));
		write_oam_data(.data(0));
		write_oam_data(.data(12));
		
		write_oam_data(.data(20));
		write_oam_data(.data(1));
		write_oam_data(.data(0));
		write_oam_data(.data(20));
		
		write_oam_data(.data(28));
		write_oam_data(.data(2));
		write_oam_data(.data(0));
		write_oam_data(.data(12));
		
		write_oam_data(.data(28));
		write_oam_data(.data(3));
		write_oam_data(.data(0));
		write_oam_data(.data(20));
		
		write_oam_addr(.addr(0));
		read_oam_data(.expVal(188));
		read_oam_data(.expVal(8'h3));
		
		// Reset the vram address and turn on rendering
		write_vram_scroll(.addr(16'h0080));
		write_reg(.writeAddr(5), .writeVal(8'h00));
		@(posedge cpu_clk);
		write_reg(.writeAddr(1), .writeVal(8'h1c));
		@(posedge cpu_clk);
		write_reg(.writeAddr(0), .writeVal(8'h90));
		
		vblank = 0;
		while(!vblank) begin
			is_vblank(.vblank(vblank));
			@(posedge cpu_clk);
		end
		
		/*
		write_oam_addr(.addr(4));
		write_oam_data(.data(180));
		write_oam_data(.data(0));
		write_oam_data(.data(8'h80));
		write_oam_data(.data(60));
		
		write_oam_data(.data(180));
		write_oam_data(.data(1));
		write_oam_data(.data(0));
		write_oam_data(.data(68));
		
		write_oam_data(.data(188));
		write_oam_data(.data(2));
		write_oam_data(.data(0));
		write_oam_data(.data(60));
		
		write_oam_data(.data(188));
		write_oam_data(.data(3));
		write_oam_data(.data(0));
		write_oam_data(.data(68));
		*/
		
	end

endmodule