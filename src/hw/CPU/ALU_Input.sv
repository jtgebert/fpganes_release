//`include "Enums.sv"
import Enums::*;

module ALU_Input( 
	input clk, rst,
	input SRC1 src1_sel,
	input SRC2 src2_sel,
	input stall,
	input [ 7:0 ] a, bal, bah, adl, pcl, pch, // for src1
	input [ 7:0 ] imm, adv, x, bav, y, offset, sp, temp_status, // for src2
	
	output logic[ 7:0 ] in1, in2
);	

	logic[ 7:0 ] temp_status_latch;
	always_ff @( posedge clk, posedge rst ) begin
		if( rst ) begin
			temp_status_latch <= 'b0;
		end
		else if( stall ) begin
			// don't change
		end
		else begin
			temp_status_latch <= temp_status;
		end
	end

	always_comb begin
		
		in1 = 8'hff;
		case( src1_sel )
			SRC1_A	: in1 = a;
			SRC1_BAL: in1 = bal;
			SRC1_BAH: in1 = bah;
			SRC1_ADL: in1 = adl;
			SRC1_PCL: in1 = pcl;
			SRC1_PCH: in1 = pch;
			SRC1_1	: in1 = 8'b01;
			SRC1_DC : in1 = 8'bx;
			SRC1_X	: in1 = x;
			SRC1_Y	: in1 = y;
			SRC1_BAV: in1 = bav;
			SRC1_ADV: in1 = adv;
		endcase
	end
	
	always_comb begin
		in2 = 8'hff;
		case( src2_sel )
			SRC2_DC				: in2 = 8'bx;
			SRC2_IMM			: in2 = imm;
			SRC2_ADV			: in2 = adv;
			SRC2_X				: in2 = x;
			SRC2_BAV			: in2 = bav;
			SRC2_T_C			: in2 = temp_status_latch[ C ] ? 8'b1 : 8'b0;
			//SRC2_T_C			: in2 = ((!temp_status_latch[C]&!temp_status_latch[N])|(temp_status_latch[C]&temp_status_latch[N])) ? 8'b0 : { {7{ temp_status_latch[ N ] }}, 1'b1 };
			SRC2_1				: in2 = 8'b01;
			SRC2_Y				: in2 = y;
			SRC2_OFFSET			: in2 = offset;
			SRC2_SP				: in2 = sp;
			SRC2_OFFSET_W_C 	: in2 = { {7{ temp_status_latch[ N ] }}, 1'b1 };
			SRC2_A				: in2 = a;
		endcase
	end

endmodule
