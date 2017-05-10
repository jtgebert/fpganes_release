//`include "Enums.sv"
import Enums::*;

module Mem(
	input ADDR addr_sel,
	input INT_TYPE int_sel,
	input [ 15:0 ] ad, ba, pc,
	input [ 7:0 ] sp,
	input LD ld_sel,
	input ST st_sel,
	input stall,
	
	output read, write,// can_stall,
	output reg[ 15:0 ] addr
	);

	// Address Selection Logic
	always_comb begin
		case( addr_sel )
			ADDR_AD : begin
				addr = ad;
			end
			ADDR_PC : begin
				addr = pc;
			end
			ADDR_BA : begin
				addr = ba;
			end
			ADDR_SP : begin
				addr = { 8'h01, sp };
			end
			ADDR_INT_L : begin
				case( int_sel ) 
					IRQ		: addr = IRQ_L;
					NMI		: addr = NMI_L;
					RESET	: addr = RESET_L;
					default	: addr = 16'hx;
				endcase
			end
			ADDR_INT_H : begin
				case( int_sel ) 
					IRQ		: addr = IRQ_H;
					NMI		: addr = NMI_H;
					RESET	: addr = RESET_H;
					default	: addr = 16'hx;
				endcase
			end
			default : begin
				addr = 16'hx;
			end
		endcase
	end
	// Address Selection Logic end
	
	// read/!write
	assign write = stall ? 1'b0 : ( st_sel == ST_NONE ) ? 1'b0 : 1'b1;
	assign read = stall ? 1'b0 : ( ld_sel == LD_NONE ) ? 1'b0 : 1'b1;
	
	//assign can_stall = ~( write | read );	
	
endmodule
