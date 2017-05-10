/*
NOTE
If there is a difference between the trace/emulator and the documents on the web,
The testbench controls DUT to match the trace. 
However, the implmentation of DUT is remained to match the documents.






















*/





//`include "Enums.sv"
import Enums::*;

module tb_CPU_stall();

	reg clk, rst;
	
	reg [7:0] my_memory [0:16'hFFFF];
	
	always begin
		#5 clk = ~clk;
	end
	
	wire read, write;
	wire[ 7:0 ] data;
	wire[ 15:0 ] addr;
	
	wire drive_data;
	reg[ 7:0 ] data_reg;
	
	assign data = drive_data ? data_reg : 8'bz;
	
	reg nmi, irq;
	reg stall;
	
	CPU DUT( 
		.clk, .rst, .stall,
		.data, .addr,
		.read, .write,
		.nmi, .irq
	);
	
	assign drive_data = read;
	
	integer wf;
	
	integer numCyclesSkip;
	integer currentCycle;
	integer numCycle;
	int addr_rem;
	int addr_rem_d;

	string words, words_bw;
	
	int a_d, x_d, y_d, sp_d;
	string p_d;
	
	initial begin
		integer fd = $fopen( "../../../assembler/6502_functional_test.bin", "rb" );
		wf = $fopen( "./MyOutput", "w" );
		
		$fread( my_memory, fd, 'h8000 );
 
		clk = 1'b0;
		rst = 1'b1;
		nmi = 1'b0;
		irq = 1'b0;
		stall = 1'b0;
		
		numCyclesSkip = 'd2;
		currentCycle = 'd139165058;
		numCycle = 'd0;
		addr_rem = 'd0;
		
		words = "";
		words_bw = "";
		
		$fwrite( wf, "MyOutput - Trace Log File\n" );		
		
		@( negedge clk );
		rst = 1'b0;
		DUT.registers.a = 'hf0;
		DUT.registers.x = 'h10;
		DUT.registers.y = 'hff;
		DUT.registers.sp = 'hff;
		
		DUT.registers.status[ U ] = 'b0;
		
		a_d = DUT.registers.a;
		x_d = DUT.registers.x;
		y_d = DUT.registers.y;
		sp_d = DUT.registers.sp;	
		
		$sformat( p_d, "%c%c%c%c%c%s%c%c", DUT.registers.n ? "N" : "n",
					DUT.registers.v ? "V" : "v",
					DUT.registers.status[ U ] ? "U" : "u",
					DUT.registers.b ? "B" : "b",
					DUT.registers.d ? "D" : "d",
					"I",
					DUT.registers.z ? "Z" : "z",
					DUT.registers.c ? "C" : "c");
					
		
	end
	
	always@( posedge clk ) begin
		stall <= $random;
	end
	
	always @( posedge clk ) begin
	
		// YANG stall
		if( ~stall ) begin
		
			if( DUT.control.ld_sel == LD_INSTR ) begin
				addr_rem_d = addr_rem;
				addr_rem = addr;
			end
			
			case( DUT.control.ld_sel ) 
				LD_INSTR, LD_IMM, LD_OFFSET, LD_ADL, LD_ADH, LD_BAL, LD_BAH: begin
					if( addr >= 'h0200 ) begin
						words = { words, words_bw };
						words_bw = $sformatf( "%2h ", data_reg );
					end
				end
			endcase
			
			// YANG concern
			if( DUT.registers.ld_sel == LD_P ) begin
				DUT.registers.status[ 5:4 ] <= data[ 5:4 ];
			end
			
			// SETD instruction
			if( DUT.registers.ir == 'hF8 ) begin
				DUT.registers.status[ D ] <= 'b1;
			end
			// CLRD instruction
			else if( DUT.registers.ir == 'hD8 ) begin
				DUT.registers.status[ D ] <= 'b0;
			end
		// YANG stall
		end
	end
	
	string trace;
	string a, x, y, sp, address;
	
	always @( negedge clk ) begin
	
		// YANG stall
		if( ~stall ) begin
		
	
			release DUT.next_status;
			release DUT.alu.alu_sel;
		
			if( rst ) begin
				// do nothing
			end
			
			// YANG concern
			if( currentCycle == 'd139169441 ) begin
				DUT.registers.status[ B ] = 'b0;
				p_d[ 3 ] = "b";
			end
			
			// YANG concern
			// TXS should affect status registers but trace doesn't
			if( DUT.registers.ir == 'h9A ) begin
				force DUT.next_status = DUT.status;
			end
			/*
			if( currentCycle == 'd139171630 ) begin
				DUT.registers.status[ N ] = 'b1;
				DUT.registers.status[ Z ] = 'b1;
				p_d[ 0 ] = "N";
				p_d[ 6 ] = "Z";
			end
			*/
			if( DUT.registers.pc == 'h8000 ) begin
				DUT.registers.sp = 'hff;
			end
					
			if( DUT.control.state == 1'b1 ) begin
			
				if( numCyclesSkip > 0 ) begin
					numCyclesSkip--;
				end
				else begin
					
					automatic int numSpaces = 9 - words.len();
					
					if( numSpaces >= 0 ) begin
						words = { words, { numSpaces{ " " } } };
					end
					
					else begin
						words = words.substr( 0, 8 );
					end
					
					words = words.toupper();
				
					$sformat( trace, "c%9d   ", currentCycle );
					
					$write( trace );
					$fwrite( wf, trace );
				
					a = $sformatf("%2h", a_d);
					a = a.toupper();
					
					x = $sformatf("%2h", x_d);
					x = x.toupper();
					
					y = $sformatf("%2h", y_d);
					y = y.toupper();
					
					sp = $sformatf("%2h", sp_d);
					sp = sp.toupper();
					
					a_d = DUT.registers.a;
					x_d = DUT.registers.x;
					y_d = DUT.registers.y;
					sp_d = DUT.registers.sp;
											
					address = $sformatf("%4h", addr_rem_d);
					address = address.toupper();
				
					$write( "A:%s X:%s Y:%s S:%s P:%s  $%4h:",
						a,
						x,
						y,
						sp,
						p_d,
						address
					);
					
					$fwrite( wf, "A:%s X:%s Y:%s S:%s P:%s  $%4h:",
						a,
						x,
						y,
						sp,
						p_d,
						address
					);
									
					$sformat( p_d, "%c%c%c%c%c%c%c%c", DUT.registers.n ? "N" : "n",
						DUT.registers.v ? "V" : "v",
						DUT.registers.status[ U ] ? "U" : "u",
						DUT.registers.b ? "B" : "b",
						DUT.registers.d ? "D" : "d",
						DUT.registers.i ? "I" : "i",
						DUT.registers.z ? "Z" : "z",
						DUT.registers.c ? "C" : "c");
					
					$write( words );
					$fwrite( wf, words );
					
					words = "";
					
					$fwrite( wf, "\n" );
					$write( "\n" );
										
					if( currentCycle >= 'd139219723 ) begin
						$stop;
					end
					
					currentCycle += numCycle;
				end
				
				numCycle = 'd1;
			end
			else begin
				numCycle++;
			end
		// YANG stall
		end
		
	end
	
	
	
	always_ff @( edge clk ) begin
		if( rst ) begin
			data_reg <= my_memory[ addr ];
		end
		else if( read ) begin
			data_reg <= my_memory[ addr ];
		end
		
		else if( write ) begin
			my_memory[ addr ] <= data;
			// YANG concern
			if( DUT.registers.st_sel == ST_P ) begin
				my_memory[ addr ][ U ] <= 1'b1;
			end
		end
	end
	
endmodule
