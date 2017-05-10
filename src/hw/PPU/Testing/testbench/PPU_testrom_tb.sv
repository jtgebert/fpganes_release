`timescale 1 ps / 1 ps
module PPU_testrom_tb();

	reg clk;
	reg [13:0] addr;
	wire [7:0] data_out;

	bg_test_rom DUT (
		.address(addr),
		.clock(clk),
		.q(data_out)
	);
	
	always 
		#5 clk = ~clk;
		
	initial begin
		clk = 0;
		addr = 0;
		for (addr = 0; addr < 10; addr = addr + 1) begin
			@(posedge clk);
			$display("0x%x: %x", addr, data_out);
		end
		$stop;
	end

endmodule