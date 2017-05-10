module PPU_reg_tb();
	
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
	
	integer i;
	
	always 
		#5 ppu_clk = ~ppu_clk;
	
	always @(posedge ppu_clk, negedge ppu_clk) begin
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
	
	PPU DUT (
		.clk(ppu_clk), // PPU system clock
		.rst_n(rst_n), // active low reset
		.data(data), // line for PPU->CPU and CPU->PPU data
		.address(addr), // PPU register select
		.rw(rw), // PPU register read/write toggle
		.cs_in(ppu_cs), // PPU chip select
		.irq(irq), // connected to the 6502's NMI pin
		.pixel_data(pixel_data) // the 8 bit color to draw to the screen
	);
	
	assign data = ((rw == 1) && (ppu_cs == 0)) ? ppu_data : 8'hzz;
	
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
	
	initial begin
		rst_n = 0;
		rw = 0;
		ppu_data = 0;
		ppu_counter = 0;
		ppu_clk = 1;
		cpu_clk = 1;
		ppu_cs = 1;
		#5;
		rst_n = 1;
		
		/*
		@(posedge cpu_clk);
		write_reg(.writeAddr(8'h6), .writeVal(8'h55));
		@(posedge cpu_clk);
		write_reg(.writeAddr(8'h6), .writeVal(8'h55));
		*/
		
		for (i = 0; i < 8; i = i + 1) begin
			@(posedge cpu_clk);
			write_reg(.writeAddr(i), .writeVal(8'h55));
			@(posedge cpu_clk);
			read_reg(.readAddr(i), .expVal(8'h55));
		end
		
		#50;
		$stop;
	end
	
endmodule