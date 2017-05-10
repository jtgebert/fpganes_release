//`include "Enums.sv"
import Enums::*;

module tb_CPU_rst();

	typedef enum logic[ 7:0 ] {
		LDA = 8'hA9,
		ADC = 8'h69,
		TAX = 8'hAA,
		INX = 8'hE8
	} INSTRUCTION;

	reg clk, rst;
	reg[ 7:0 ] cycle_num;

	always begin
		#5 clk = ~clk;
		if( ~rst & clk ) begin
			cycle_num = cycle_num + 8'b1;
		end
	end
	
	wire read, write;
	wire[ 7:0 ] data;
	wire[ 15:0 ] addr;
	
	reg drive_data;
	reg[ 7:0 ] data_reg;
	
	assign data = drive_data ? data_reg : 8'bz;
	
	CPU DUT( 
		.clk, .rst,
		.data, .addr,
		.read, .write
	);
	
	initial begin
		cycle_num = 8'd0;
		clk = 1'b0;
		rst = 1'b1;
		drive_data = 1'b0;
		@( posedge clk );
		rst = 1'b0;
		
		@( posedge ( DUT.control.ld_sel == LD_INSTR ) );
		
		drive_data = 1'b1;
		data_reg = LDA;
		
		@( posedge clk );
		data_reg = 8'b01;
		
		@( posedge clk );
		@( posedge clk );
		@( posedge clk );
		@( posedge clk );
		
		/*
		
		
		
		@( posedge clk );
		data_reg = ADC;
		
		@( posedge clk );
		data_reg = 8'h03;
		
		@( posedge clk );
		data_reg = TAX;
		
		@( posedge clk );
		data_reg = TAX;
		
		@( posedge clk );
		data_reg = INX;
		
		@( posedge clk );
		data_reg = INX;
		
		@( posedge clk );
		drive_data = 1'b0;
		
		
		*/		
		$stop;
	end
	
	
endmodule
