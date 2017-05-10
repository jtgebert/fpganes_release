module fpganes(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	inout 		    [35:0]		GPIO
);



	//=======================================================
	//  REG/WIRE declarations
	//=======================================================
	// THE DATA INOUT
	wire[ 7:0 ] data;
	// THE DATA INOUT

	wire read_cpu, write_cpu; // read/write signal from cpu
	wire[ 15:0 ] addr_cpu, addr_dma; // address from cpu, address from dma
	wire clk_cpu, clk_ppu, clk_vga, clk_ctrl, clk_dma, rst_n; // clk for each modules, active low rst

	assign rst_n = KEY[0];

	wire nmi, irq, stall; // active high nmi, irq, stall for cpu generally

	wire apu_cs_n; // active low
	wire ppu_cs_n; // active low
	wire controller_cs_n; // active low
	wire mem_cs_n; // active low
	wire[4:0] apu_addr; // $00 - $18
	wire[2:0] ppu_addr; // $0 - $7
	wire controller_addr; // 0 for $4016, 1 for $4017
	wire[15:0] mem_addr;

	wire[7:0] pixel_data; // the 8 bit color to draw to the screen
	wire[13:0] vram_addr; // The address that the sprite/background renderer specifies
	wire vram_rw_sel; // 0 = read, 1 = write
	wire[7:0] vram_data_out; // The data to write to VRAM from PPUDATA
	wire frame_end;
	wire frame_start;
	wire rendering;

	wire [7:0] vram_data_in; // Data input from VRAM reads
	wire rw_ppu, rw_apu; // PPU register read/write toggle 0 = read, 1 = write
	assign rw_ppu = write_cpu ? 1'b1 : 1'b0;
	assign rw_apu = rw_ppu;

	wire rw_ctrl; // Controller read/write toggle 1 = read, 0 = write
	assign rw_ctrl = write_cpu ? 1'b0 : 1'b1;

	wire [7:0] vga_r, vga_g, vga_b;
	wire booting_n;
	
	wire [3:0] game;
	
	assign VGA_R = ~VGA_BLANK_N ? 8'h00 : vga_r;
	assign VGA_G = ~VGA_BLANK_N ? 8'h00 : vga_g;
	assign VGA_B = ~VGA_BLANK_N ? 8'h00 : vga_b;
	assign VGA_SYNC_N = 1'b0;
	assign VGA_CLK = clk_vga;

	wire clock_locked, vga_clock_locked;
	wire locked;
	assign locked = clock_locked & vga_clock_locked;

	assign clk_ctrl = clk_cpu;
	assign clk_dma = clk_cpu;
	assign clk_mem = clk_ppu;

	assign HEX5 = 7'b0101011;
	assign HEX4 = 7'b0000110;
	assign HEX3 = 7'b0010010;
	assign HEX2 = 7'b0101011;
	assign HEX1 = 7'b0000110;
	assign HEX0 = 7'b0010010;

	//=======================================================
	//  Structural coding
	//=======================================================
//*

	NESClock system_clocks(
		.refclk(CLOCK_50),   //  50 MHz
		.rst(~rst_n),      //   active high
		.outclk_0(clk_ppu), // 5.369458 MHz
		.outclk_1(clk_cpu), // 1.789819MHz
		.locked(clock_locked)    //  active low
	);
//*
	VGAClock clock0(
		.refclk(CLOCK_50),   //  50 MHz
		.rst(~rst_n),      //   active high
		.outclk_0(clk_vga), // 25.175 MHz
		.locked(vga_clock_locked)    // active low
	);
//	*/

	CPU cpu(
		// output
		.read( read_cpu ), .write( write_cpu ), .addr( addr_cpu ),

		// input
		.clk( clk_cpu ), .rst( ~(rst_n&locked&~booting_n) ),
		.nmi( nmi ), .irq( irq ), .stall( stall | stall_all ), // TODO added | writing for testing

		// inout
		.data( data ),

		// testing
		.pc_peek(pc_peek),
		.ir_peek(ir_peek),
		.a_peek(a_peek),
		.x_peek(x_peek),
		.y_peek(y_peek),
		.flags_peek(flags_peek),
		.other_byte_peek(other_byte_peek)
	);

	OAM_dma dma(
		// output
		.cpu_stall( stall ), .address_out( addr_dma ), .cpu_ram_read(cpu_ram_read), .ppu_oam_write(ppu_oam_write),

		// input
		.clk( clk_dma ), .rst_n( rst_n&locked&~booting_n ),
		.address_in( addr_cpu ),

		// inout
		.data( data )
	);

	HardwareDecoder decoder(
		// output
		.apu_cs_n( apu_cs_n ), .ppu_cs_n( ppu_cs_n ),
		.controller_cs_n( controller_cs_n ), .mem_cs_n( mem_cs_n ),

		.apu_addr( apu_addr ), .ppu_addr( ppu_addr ),
		.controller_addr( controller_addr ), .mem_addr( mem_addr ),

		// input
		.addr( addr_dma ), .rd(read_cpu), .wr(write_cpu)
	);

	APU apu(
		// output // none
		// input
		.clk( clk_cpu ), .rst_n( rst_n & locked & ~booting_n ),
		.address( apu_addr ), .rw( rw_apu ), .cs_in( apu_cs_n ),

		// inout
		.data( data )
	);

	GameSelect sel(
		// input
		.SW( SW ), .rst_n( rst_n ),
		
		// output
		.game( game )
	);
	
	MemoryWrapper mem(
		// input
		.clk( clk_mem ), .cs( mem_cs_n ),
		.rd( read_cpu || cpu_ram_read), .wr( write_cpu ),
		.addr( mem_addr ), .game( game ),

		// inout
		.databus( data ),

		// test
		.ram_addr_peek( ram_addr_peek )
	);

	PPU ppu(
		// output
		.irq( nmi ), .pixel_data( pixel_data ), .vram_addr_out( vram_addr ),
		.vram_rw_sel( vram_rw_sel ), .vram_data_out( vram_data_out ),
		.frame_end( frame_end ), .frame_start( frame_start ),
		.rendering( rendering ),

		// input
		.clk( clk_ppu ), .rst_n( rst_n & locked & ~booting_n ),
		.address( ppu_addr ), .vram_data_in( vram_data_in ),
		.rw(rw_ppu || ppu_oam_write), .cs_in( ppu_cs_n ),

		// inout
		.data( data )
	);

	PPUMemoryWrapper ppumem(
		//input
		.clk(clk_ppu), .rst_n(rst_n & locked & ~booting_n), .addr(vram_addr), .data(vram_data_out), 
		.rw(vram_rw_sel), .game( game ),

		//output
		.q(vram_data_in)
	);
	
	VGA vga(
		// output
		.vga_r( vga_r ), .vga_g( vga_g ), .vga_b( vga_b ), .loading( booting_n ),
		.hsync( VGA_HS ), .vsync( VGA_VS ), .blank( VGA_BLANK_N ),

		// input
		.vga_clock( clk_vga ), .ppu_clock( clk_ppu ), .rst_n( rst_n&locked ),
		.rendering( rendering ), .ppu_frame_end( frame_end ), 
		.color( pixel_data[ 5:0 ] ), .ppu_frame_start( frame_start )
	);

	

	
	ControllersWrapper ctrls(
		// output
		.txd1(GPIO[3]), .txd2( GPIO[33] ), .rx_data_peek(LEDR[9:2]), //TODO PUT BACK

		// input
		.clk( clk_ctrl ), .rst_n( rst_n&locked&~booting_n ), .addr( controller_addr ),
		.cs( controller_cs_n ), .rw( rw_ctrl ), .rxd1( GPIO[5] ), .rxd2( GPIO[31] ),

		// inout
		.cpubus( data )//,

		// testing
		//.send_cpu_states(port_wr), .cpuram_q(cpuram_q), .writing(writing),
		//.cpuram_rd_addr(cpuram_rd_addr), .cpuram_rd(cpuram_rd), .cpuram_wr_addr( cpuram_wr_addr )
	);
	

	//=======================================================
	//  Testing
	//=======================================================
/*
	wire [15:0] pc_peek;
	reg [15:0] pc_peek_r;
	reg[6:0] nmi_count;
	reg nmi_reg;

	always @(posedge clk_cpu, negedge rst_n) begin
		if (!rst_n) begin
			pc_peek_r = 16'h0000;
		end
		else begin
			pc_peek_r = pc_peek;
		end
	end

	assign HEX5 = 7'b0001100;

	assign HEX4 = 7'b1000110;

	assign HEX3 = (cpuram_rd_addr[13:12] == 4'hF) ? 7'b0001110 :
					  (cpuram_rd_addr[13:12] == 4'hE) ? 7'b0000110 :
					  (cpuram_rd_addr[13:12] == 4'hD) ? 7'b0100001 :
					  (cpuram_rd_addr[13:12] == 4'hC) ? 7'b1000110 :
					  (cpuram_rd_addr[13:12] == 4'hB) ? 7'b0000011 :
					  (cpuram_rd_addr[13:12] == 4'hA) ? 7'b0001000 :
					  (cpuram_rd_addr[13:12] == 4'h9) ? 7'b0011000 :
					  (cpuram_rd_addr[13:12] == 4'h8) ? 7'b0000000 :
					  (cpuram_rd_addr[13:12] == 4'h7) ? 7'b1111000 :
					  (cpuram_rd_addr[13:12] == 4'h6) ? 7'b0000010 :
					  (cpuram_rd_addr[13:12] == 4'h5) ? 7'b0010010 :
					  (cpuram_rd_addr[13:12] == 4'h4) ? 7'b0011001 :
					  (cpuram_rd_addr[13:12] == 4'h3) ? 7'b0110000 :
					  (cpuram_rd_addr[13:12] == 4'h2) ? 7'b0100100 :
					  (cpuram_rd_addr[13:12] == 4'h1) ? 7'b1111001 :
					  7'b1000000;

	assign HEX2 = (cpuram_rd_addr[11:8] == 4'hF) ? 7'b0001110 :
					  (cpuram_rd_addr[11:8] == 4'hE) ? 7'b0000110 :
					  (cpuram_rd_addr[11:8] == 4'hD) ? 7'b0100001 :
					  (cpuram_rd_addr[11:8] == 4'hC) ? 7'b1000110 :
					  (cpuram_rd_addr[11:8] == 4'hB) ? 7'b0000011 :
					  (cpuram_rd_addr[11:8] == 4'hA) ? 7'b0001000 :
					  (cpuram_rd_addr[11:8] == 4'h9) ? 7'b0011000 :
					  (cpuram_rd_addr[11:8] == 4'h8) ? 7'b0000000 :
					  (cpuram_rd_addr[11:8] == 4'h7) ? 7'b1111000 :
					  (cpuram_rd_addr[11:8] == 4'h6) ? 7'b0000010 :
					  (cpuram_rd_addr[11:8] == 4'h5) ? 7'b0010010 :
					  (cpuram_rd_addr[11:8] == 4'h4) ? 7'b0011001 :
					  (cpuram_rd_addr[11:8] == 4'h3) ? 7'b0110000 :
					  (cpuram_rd_addr[11:8] == 4'h2) ? 7'b0100100 :
					  (cpuram_rd_addr[11:8] == 4'h1) ? 7'b1111001 :
					  7'b1000000;

	assign HEX1 = (cpuram_rd_addr[7:4] == 4'hF) ? 7'b0001110 :
					  (cpuram_rd_addr[7:4] == 4'hE) ? 7'b0000110 :
					  (cpuram_rd_addr[7:4] == 4'hD) ? 7'b0100001 :
					  (cpuram_rd_addr[7:4] == 4'hC) ? 7'b1000110 :
					  (cpuram_rd_addr[7:4] == 4'hB) ? 7'b0000011 :
					  (cpuram_rd_addr[7:4] == 4'hA) ? 7'b0001000 :
					  (cpuram_rd_addr[7:4] == 4'h9) ? 7'b0011000 :
					  (cpuram_rd_addr[7:4] == 4'h8) ? 7'b0000000 :
					  (cpuram_rd_addr[7:4] == 4'h7) ? 7'b1111000 :
					  (cpuram_rd_addr[7:4] == 4'h6) ? 7'b0000010 :
					  (cpuram_rd_addr[7:4] == 4'h5) ? 7'b0010010 :
					  (cpuram_rd_addr[7:4] == 4'h4) ? 7'b0011001 :
					  (cpuram_rd_addr[7:4] == 4'h3) ? 7'b0110000 :
					  (cpuram_rd_addr[7:4] == 4'h2) ? 7'b0100100 :
					  (cpuram_rd_addr[7:4] == 4'h1) ? 7'b1111001 :
					  7'b1000000;

	assign HEX0 = (cpuram_rd_addr[3:0] == 4'hF) ? 7'b0001110 :
					  (cpuram_rd_addr[3:0] == 4'hE) ? 7'b0000110 :
					  (cpuram_rd_addr[3:0] == 4'hD) ? 7'b0100001 :
					  (cpuram_rd_addr[3:0] == 4'hC) ? 7'b1000110 :
					  (cpuram_rd_addr[3:0] == 4'hB) ? 7'b0000011 :
					  (cpuram_rd_addr[3:0] == 4'hA) ? 7'b0001000 :
					  (cpuram_rd_addr[3:0] == 4'h9) ? 7'b0011000 :
					  (cpuram_rd_addr[3:0] == 4'h8) ? 7'b0000000 :
					  (cpuram_rd_addr[3:0] == 4'h7) ? 7'b1111000 :
					  (cpuram_rd_addr[3:0] == 4'h6) ? 7'b0000010 :
					  (cpuram_rd_addr[3:0] == 4'h5) ? 7'b0010010 :
					  (cpuram_rd_addr[3:0] == 4'h4) ? 7'b0011001 :
					  (cpuram_rd_addr[3:0] == 4'h3) ? 7'b0110000 :
					  (cpuram_rd_addr[3:0] == 4'h2) ? 7'b0100100 :
					  (cpuram_rd_addr[3:0] == 4'h1) ? 7'b1111001 :
					  7'b1000000;
	always @(posedge nmi, negedge rst_n) begin
		if (!rst_n) begin
			nmi_count <= 7'h00;
			nmi_reg <= 1'b0;
		end
		else if (nmi) begin
			nmi_count <= nmi_count + 1;
			if (nmi_count == 7'hFF)
				nmi_reg <= ~nmi_reg;
			else
				nmi_reg <= nmi_reg;
		end
		else begin
			nmi_count <= nmi_count;
			nmi_reg <= nmi_reg;
		end
	end

	//assign LEDR[6:0] = {rendering, frame_end, !mem_cs_n, !controller_cs_n, !apu_cs_n, !ppu_cs_n, stall};
	reg port_wr;
	reg stall_all;
	wire [13:0] ram_addr_peek;

	always @(posedge clk_ctrl, negedge rst_n) begin

		if (!rst_n) begin
			port_wr = 0;
			stall_all = 0;
		end

		else if( ~KEY[1] ) begin
			stall_all = 0;
			port_wr = 0;
		end

		//else if ( pc_peek == 16'hfff4 ) begin
		//	port_wr = 1;
		//	stall_all = 1;
		//end

		//DUT.control.state == 1'b1
		else if( data == 8'hC4 ) begin
			if ( ram_addr_peek == 14'bxx_x000_0000_1110 ) begin // 0E
				port_wr = 1;
				stall_all = 1;
			end
		end
	end

	//assign LEDR[4:0] = {cpuram_rd, cpuram_wr, stall_all, port_wr, writing};

	// WRITE CPU VALS TO THE RAM AND SEND THEM OVER SPART ON KEY 1 PRESS //
	reg [13:0] cpuram_wr_addr;
	wire [7:0] flags_peek, ir_peek, a_peek, x_peek, y_peek, other_byte_peek;


	always @(posedge clk_cpu, negedge rst_n) begin
		if (!rst_n)
			cpuram_wr_addr <= 14'h0000;
		else if( stall_all ) begin
			cpuram_wr_addr <= cpuram_wr_addr;
		end
		else
			cpuram_wr_addr <= cpuram_wr_addr + 1;
	end

	//wire [63:0] cpuram_data;
	//assign cpuram_data = KEY[1] ? {pc_peek, ir_peek, a_peek, x_peek, y_peek, flags_peek, other_byte_peek} : 64'h0123456789ABCDEF;

	wire [13:0] cpuram_rd_addr;
	wire cpuram_rd;
	wire [63:0] cpuram_q;
	wire cpuram_wr, writing;

	assign cpuram_wr = stall_all ? 1'b0 : (pc_peek != 16'h8058 && pc_peek != 16'h8059 && pc_peek != 16'h805A) ? 1'b1 : 1'b0;

	test_CPURAM	test_CPURAM_inst (
		.data ( {pc_peek, a_peek, x_peek, y_peek, mem_cs_n, write_cpu, ram_addr_peek, data } ),
		.rdaddress ( cpuram_rd_addr ),
		.rdclock ( clk_ctrl ),
		.rden ( cpuram_rd ),
		.wraddress ( cpuram_wr_addr ),
		.wrclock ( clk_cpu ),
		.wren ( cpuram_wr ),
		.q ( cpuram_q )
		);*/

endmodule
