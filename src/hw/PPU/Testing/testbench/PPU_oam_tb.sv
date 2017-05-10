module PPU_oam_tb();
	
	reg clk;
	reg rst_n;
	reg oam_en;
	reg oam_rw;
	reg [5:0] spr_select;
	reg [1:0] byte_select;
	reg [7:0] data_in;
	wire [7:0] data_out;
	
	integer fail_count;
	
	PPU_oam DUT (
		.clk(clk),
		.rst_n(rst_n),
		.oam_en(oam_en),
		.oam_rw(oam_rw),
		.spr_select(spr_select),
		.byte_select(byte_select),
		.data_in(data_in),
		.data_out(data_out)
	);
	
	always
		#5 clk = ~clk;
		
	task write_oam;
		input [7:0] address;
		input [7:0] data;
		@(posedge clk);
		oam_en = 1'b1;
		oam_rw = 1'b0;
		spr_select = address[7:2];
		byte_select = address[1:0];
		data_in = data;
	endtask
	
	task read_oam;
		input [7:0] address;
		input [7:0] expected;
		@(posedge clk);
		oam_en = 1'b1;
		oam_rw = 1'b1;
		spr_select = address[7:2];
		byte_select = address[1:0];
		
		if (data_out != expected) begin
			$display("ERROR: value read from address %x is incorrect read: %x expected: %x\n", address, data_out, expected);
			fail_count = fail_count + 1;
		end
		
	endtask
		
	task fill_mem;
		integer i;
		for (i = 0; i < 256; i = i + 1)
			write_oam(.address(i), .data(i));
		for (i = 0; i < 256; i = i + 1)
			read_oam(.address(i), .expected(i));
	endtask
		
	initial begin
		clk = 1'b0;
		rst_n = 1'b0;
		oam_en = 1'b0;
		oam_rw = 1'b0;
		spr_select = 6'h00;
		byte_select = 2'h0;
		data_in = 8'h00;
		fail_count = 0;
		@(posedge clk);
		fill_mem();
		if (fail_count == 0)
			$display("PASSED: OAM test");
		$stop;
	end
	
endmodule