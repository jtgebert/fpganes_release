//`include "Enums.sv"
import Enums::*;

module CPU(
	input clk, rst,
	inout[ 7:0 ] data,
	input nmi, irq,
	input stall,

	output read, write,
	//output can_stall,
	output [ 15:0 ] addr,
	// for testing
	output [15:0] pc_peek,
	output [7:0] ir_peek,
	output [7:0] a_peek,
	output [7:0] x_peek,
	output [7:0] y_peek,
	output [7:0] flags_peek,
	output [7:0] other_byte_peek
);

	

	// Load
	// input
	PC pc_sel;
	ADDR addr_sel;
	DEST dest_sel;
	LD ld_sel;
	ST st_sel;
	SP sp_sel;
	INT_TYPE int_sel;
	wire[ 15:0 ] ad, ba;
	wire[ 7:0 ] sp;
	// output : addr
	// ALU Input
	// input
	SRC1 src1_sel;
	SRC2 src2_sel;
	wire[ 7:0 ] a, bal, bah, adl, pcl, pch; // for src1
	wire[ 7:0 ] imm, adv, x, bav, y, offset; // for src2

	//wire[ 7:0 ] adh;

	assign { bah, bal } = ba;
	assign adl = ad[ 7:0 ];
	// ALU
	// input
	wire[ 7:0 ] in1, in2;
	DO_OP alu_sel;
	wire n, v, b, d, i, z, c;

	// output
	wire[ 7:0 ] out;

	wire[ 7:0 ] ir;

	wire clr_adh, clr_bah;

	wire[ 7:0 ] temp_status, next_status, status;


	// module
	// computes the address to input to mem.
	Mem mem(
		// output
		.addr, .read, .write,// can_stall,
		// input
		.addr_sel, .int_sel,
		.ad, .ba, .sp, .pc( { pch, pcl } ),
		.ld_sel, .st_sel,
		.stall
	);
	/* Load Module */

	/* ALU Input Selector */

	// module
	ALU_Input aluInputSelector(
		// output
		.in1, .in2,
		// input
		.clk, .rst,
		.src1_sel, .src2_sel,
		.stall,
		.a, .bal, .bah, .adl, .pcl, .pch, // for src1
		.imm, .adv, .x, .bav, .y, .offset, .sp, .temp_status // for src2
	);
	/* ALU Input Selector */

	/* ALU Module */
	// contains status register
	ALU alu(
		// output
		.out, .next_status, .temp_status,
		// input
		.alu_sel, .status,
		.in1, .in2
	);
	/* ALU Module */

	/* Registers */
	Registers registers(
		// output
		.a, .x, .y, .ir, .imm, .adv, .bav, .offset,
		.sp, .pc( { pch, pcl } ), .ad, .ba, .status,
		.n, .z, .v, .c, .b, .d, .i,

		// input
		.clk, .rst,
		.dest_sel, .pc_sel, .sp_sel, .ld_sel, .st_sel,
		.clr_adh, .clr_bah,
		.alu_out( out ), .next_status,
		.int_sel,
		.stall,

		// inout
		.data
	);
	/* Registers */


	/* Pavan's */

	AMODE addressing_mode;
	ITYPE instruction_type;
	SRC1 decoder_src1;
	SRC2 decoder_src2;
	DEST decoder_dest;
	DO_OP decoder_alu_sel;
	wire do_branch;

	decoder decoder(
		// output
		.addressing_mode, .instruction_type, .decoder_src1, .decoder_src2, .decoder_dest,
		.alu_sel( decoder_alu_sel ), .do_branch,

		// input
		.instruction_register( ir ),
		.n, .z, .c, .v
	);



	processor_control control(
		// output
		.addr_sel, .dest_sel, .ld_sel, .pc_sel, .sp_sel, .src1_sel, .src2_sel, .st_sel, .alu_sel,
		.clr_adh, .clr_bah,
		.interrupt_type( int_sel ),

		// input
		.clk, .rst,
		.instruction_type, .addressing_mode, .decoder_alu_sel, .decoder_src1, .decoder_src2, .decoder_dest,
		.do_branch, .c, .i, .temp_status, .nmi, .irq, .stall
	);

	/* Pavan's */
	
	/// TEST
	assign pc_peek = {pch, pcl};
	assign ir_peek = ir;
	assign a_peek = a;
	assign x_peek = x;
	assign y_peek = y;
	assign flags_peek = status;
	assign other_byte_peek = sp;
	
endmodule
