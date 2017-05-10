//`include "Enums.sv"
import Enums::*;

module ALU( 
	input [ 7:0 ] in1, in2, 
	input DO_OP alu_sel,
	input [ 7:0 ] status,
	
	output reg[ 7:0 ] out,
	//output n, z, v, c, b, d, i,
	output logic[ 7:0 ] next_status,
	output logic[ 7:0 ] temp_status // only valid when needed
);

	
	// c is sometimes don't care at AND, OR etc.
	// v gives any value for non arithmetic
	logic dont_touch;
	always_comb begin
		temp_status = 8'b0;
		next_status = status;
		dont_touch = 1'b1;
		out = 8'hff;
		
		case( alu_sel )
			DO_OP_ADD_NZ : begin
				out = in1 + in2;
				dont_touch = 1'b0;
			end
			DO_OP_SUB_NZ : begin
				out = in1 - in2;
				dont_touch = 1'b0;
			end
			DO_OP_CMP: begin
				{ next_status[ C ], out } = in1 - in2;
				next_status[ C ] = ~next_status[ C ];
				//next_status[ C ] = ~out[ 7 ];
				next_status[ Z ] = ~|out;
				next_status[ N ] = out[ 7 ];
				dont_touch = 1'b1;
			end
			DO_OP_ADD : begin
				{ temp_status[ C ], out } = in1 + in2;
				//temp_status[ N ] = out[ 7 ];
				temp_status[ N ] = in2[ 7 ];
				temp_status[ Z ] = ~|out;
				temp_status[ V ] = ( in1[ 7 ] & in2[ 7 ] & ~out[ 7 ] ) | ( ~in1[ 7 ] & ~in2[ 7 ] & out[ 7 ] ); 
				dont_touch = 1'b1;
			end
			DO_OP_SUB : begin
				out = in1 - in2;
				dont_touch = 1'b1;
			end
			DO_OP_ADC : begin
				{ next_status[ C ], out } = in1 + in2 + status[ C ];
				next_status[ V ] = ( in1[ 7 ] & in2[ 7 ] & ~out[ 7 ] ) | ( ~in1[ 7 ] & ~in2[ 7 ] & out[ 7 ] ); 
				dont_touch = 1'b0;
			end
			DO_OP_SBC : begin
				{ next_status[ C ], out } = in1 - in2 - ( status[ C ] ? 8'd0 : 8'd1 );
				next_status[ C ] = ~next_status[ C ];
				next_status[ V ] = ( in1[ 7 ] & ~in2[ 7 ] & ~out[ 7 ] ) | ( ~in1[ 7 ] & in2[ 7 ] & out[ 7 ] );
				dont_touch = 1'b0;
			end
			DO_OP_AND : begin
				out = in1 & in2;
				dont_touch = 1'b0;
			end
			DO_OP_OR : begin
				out = in1 | in2;
				dont_touch = 1'b0;
			end
			DO_OP_XOR : begin
				out = in1 ^ in2;
				dont_touch = 1'b0;
			end
			DO_OP_ASL : begin
				{ next_status[ C ], out } = { in1[ 7:0 ], 1'b0 };
				dont_touch = 1'b0;
			end
			DO_OP_LSR : begin
				{ out, next_status[ C ] } = { 1'b0, in1[ 7:0 ] };
				dont_touch = 1'b0;
			end
			DO_OP_ROL : begin
				next_status[ C ] = in1[ 7 ];
				out = { in1[ 6:0 ], status[ C ] };
				dont_touch = 1'b0;
			end
			DO_OP_ROR : begin
				next_status[ C ] = in1[ 0 ];
				out = { status[ C ], in1[ 7:1 ] };
				dont_touch = 1'b0;
			end
			DO_OP_SRC2 : begin // This is for Load and Transfer, 
				out = in2;
				dont_touch = 1'b0;
			end
			DO_OP_CLR_C : begin
				next_status[ C ] = 'b0;
				dont_touch = 1'b1;
			end
			DO_OP_CLR_V : begin
				next_status[ V ] = 'b0;
				dont_touch = 1'b1;
			end
			DO_OP_SET_C : begin
				next_status[ C ] = 'b1;
				dont_touch = 1'b1;
			end
			DO_OP_SET_V : begin
				next_status[ V ] = 'b1;
				dont_touch = 1'b1;
			end
			DO_OP_CLR_I : begin
				next_status[ I ] = 'b0;
				dont_touch = 1'b1;
			end
			DO_OP_SET_I : begin
				next_status[ I ] = 'b1;
				dont_touch = 1'b1;
			end
			DO_OP_SET_BRK : begin
				next_status[ B ] = 'b1;
				next_status[ I ] = 'b1;
				dont_touch = 1'b1;
			end
			DO_OP_CLR_B : begin
				next_status[ B ] = 'b0;
				dont_touch = 1'b1;
			end
			DO_OP_BIT : begin
				next_status[ N ] = in2[ 7 ];
				next_status[ V ] = in2[ 6 ];
				next_status[ Z ] = ~|( in1 & in2 );
				dont_touch = 1'b1;
			end
			default : begin
				dont_touch = 1'b1;
			end
		endcase
		if( ~dont_touch ) begin
			next_status[ N ] = out[ 7 ];
			next_status[ Z ] = ~|out;
		end
	end
endmodule
