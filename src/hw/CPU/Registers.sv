//`include "Enums.sv"
import Enums::*;

module Registers(
	input clk, rst,
	input DEST dest_sel,
	input PC pc_sel,
	input SP sp_sel,
	input LD ld_sel,
	input ST st_sel,
	input clr_adh, clr_bah,
	input [ 7:0 ] alu_out,
	input logic[ 7:0 ] next_status,
	input INT_TYPE int_sel,
	input stall,

	inout [ 7:0 ] data,
	
	output logic[ 7:0 ] a, x, y, ir, imm, adv, bav, offset, sp,
	output logic[ 15:0 ] pc, ad, ba,
	output n, z, v, c, b, d, i,
	output logic[ 7:0 ] status // for alu to use
);

	logic[ 15:0 ] next_pc;

	logic[ 7:0 ] data_to_store;
	assign data = stall ? 8'bz : ( st_sel != ST_NONE ) ? data_to_store : 8'bz;

	always_comb begin
		data_to_store = 8'hff;
		case( st_sel )
			ST_A	: data_to_store = a;
			ST_X	: data_to_store = x;
			ST_Y	: data_to_store = y;
			ST_PCH	: data_to_store = pc[ 15:8 ];
			ST_PCL	: data_to_store = pc[ 7:0 ];
			ST_P	: data_to_store = { status[ 7:5 ], ( int_sel == INT_NONE ) ? 1'b1 : 1'b0, status[ 3:0 ] };
			ST_ADV	: data_to_store = adv;
			ST_BAV	: data_to_store = bav;
			default	: data_to_store = 8'hx;
		endcase
	end

	// Program Counter( PC ) Logic
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			pc <= 'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else begin
			if( ld_sel == LD_PCL ) begin
				pc[ 7:0 ] <= data;
			end
			else if( ld_sel == LD_PCH ) begin
				pc[ 15:8 ] <= data;
			end

			else if( dest_sel == DEST_PCL ) begin
				pc[ 7:0 ] <= alu_out;
			end
			else if( dest_sel == DEST_PCH ) begin
				pc[ 15:8 ] <= alu_out;
			end

			else begin
				pc <= next_pc;
			end
		end
	end

	always_comb begin
		case( pc_sel )
			AD_TO_PC : begin
				next_pc = ad;
			end
			AD_P_TO_PC : begin
				next_pc = ad + 16'b1;
			end
			INC_PC : begin
				next_pc = pc + 16'b1;
			end
			KEEP_PC : begin
				next_pc = pc;
			end
			default : begin
				next_pc = pc;
			end
		endcase
	end
	// PC end

	// status
	logic ignore;

	assign { n, v, ignore, b, d, i, z, c } = status;

	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			status <= 8'b00100000;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_P ) begin
			// if PLP
			status[ 7:6 ] <= data[ 7:6 ];
			status[ 3:0 ] <= data[ 3:0 ];
		end
		else if( ld_sel == LD_A ) begin
			// if PLA
			status[ N ] <= data[ 7 ];
			status[ Z ] <= ~|data;
		end
		else begin
			status <= next_status;
		end
	end
	// status end

	// Accumulator
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			a <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_A ) begin
			a <= data;
		end
		else if( dest_sel == DEST_A ) begin
			a <= alu_out;
		end
	end

	// X
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			x <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( dest_sel == DEST_X ) begin
			x <= alu_out;
		end
	end

	// Y
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			y <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( dest_sel == DEST_Y ) begin
			y <= alu_out;
		end
	end

	// SP
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			sp <= 8'h00;
		end
		else if( stall ) begin
			// don't change
		end
		else if( sp_sel == DEC_SP ) begin
			sp <= sp - 8'b1;
		end
		else if( sp_sel == INC_SP ) begin
			sp <= sp + 8'b1;
		end
		else if( dest_sel == DEST_SP ) begin
			sp <= alu_out;
		end
	end

	// AD
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			ad <= 16'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else begin
			if( ld_sel == LD_ADL ) begin
				ad[ 7:0 ] <= data;
			end
			else if( ld_sel == LD_ADH ) begin
				ad[ 15:8 ] <= data;
			end

			if( dest_sel == DEST_ADL ) begin
				ad[ 7:0 ] <= alu_out;
			end

			if( clr_adh ) begin
				ad[ 15:8 ] <= 8'b0;
			end
		end
	end

	//IR
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			ir <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_INSTR ) begin
			ir <= data;
		end
	end

	//BA
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			ba <= 16'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else begin
			// result of attempt to fix error in the wrong way
			if( ld_sel == LD_BAL ) begin
				ba[ 7:0 ] <= data;
				if( dest_sel == DEST_BAH ) begin
					ba[ 15:8 ] <= alu_out;
				end
				else if( clr_bah ) begin
					ba[ 15:8 ] <= 8'b0;
				end
			end

			else if( ld_sel == LD_BAH ) begin
				ba[ 15:8 ] <= data;
				if( dest_sel == DEST_BAL ) begin
					ba[ 7:0 ] <= alu_out;
				end
			end
			else begin
				if( dest_sel == DEST_BAL ) begin
					ba[ 7:0 ] <= alu_out;
					if( clr_bah ) begin
						ba[ 15:8 ] <= 8'b0;
					end
				end
				else if( dest_sel == DEST_BAH ) begin
					ba[ 15:8 ] <= alu_out;
				end
			end
		end
	end

	//IMM
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			imm <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_IMM ) begin
			imm <= data;
		end
	end

	//OFFSET
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			offset <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_OFFSET ) begin
			offset <= data;
		end
	end

	//ADV
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			adv <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_ADV ) begin
			adv <= data;
		end
		else if( dest_sel == DEST_ADV ) begin
			adv <= alu_out;
		end
	end

	//BAV
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			bav <= 8'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else if( ld_sel == LD_BAV ) begin
			bav <= data;
		end
		else if( dest_sel == DEST_BAV ) begin
			bav <= alu_out;
		end
	end

endmodule
