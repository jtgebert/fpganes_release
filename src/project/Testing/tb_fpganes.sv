`timescale 1ns/1ps

module tb_fpganes();

	reg clk, rst_n;
	reg clk_cpu, clk_ppu, clk_vga;
	
	fpganes DUT(
		.CLOCK_50( clk ),
		.KEY( { 3'b111, rst_n } )
	);
	
	initial begin
		clk = 1'b0;
		rst_n = 1'b0;
		
		clk_cpu = 1'b0;
		clk_ppu = 1'b0;
		clk_vga = 1'b0;
		
		force DUT.locked = 1'b1;
		
		repeat (3) @ ( posedge clk );
		
		rst_n = 1'b1;
		/*
		repeat (3) @ ( posedge DUT.ctrl.clk );
		*/
		force DUT.cpu.registers.pc = 16'hfff4;
		
		
		//force DUT.ctrl.driver0.rx_data = 8'b0000_0000;
	end
	
	always begin
		#10;
		clk = ~clk;
	end
	/*
	always_comb begin
		if( DUT.mem.addr == 16'h8246 ) begin
			$stop;
		end
	end
	*/
	
	/*
	always begin
		#93.1192685;
		clk_ppu = ~clk_ppu;
		force DUT.clk_ppu = clk_ppu;
	end
	
	integer max = 3;
	integer currNum = 0;
	
	always @( edge clk_ppu ) begin
		//#279.357857;
		if( currNum == max ) begin
			clk_cpu = ~clk_cpu;
			force DUT.clk_cpu = clk_cpu;
			currNum = 0;
		end
		
		currNum = currNum + 1;		
	end
	*/
	//always begin
	/*
	always @( posedge clk_ppu ) begin
		// too fast, simulation slows down
		// I think twice as fast of PPU is enough
		//#19.8609732;
		
		clk_vga = ~clk_vga;
		force DUT.clk_vga = clk_vga;
	end
	*/
	
endmodule




