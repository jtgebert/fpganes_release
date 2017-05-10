//`include "Enums.sv"
import Enums::*;

module tb_CPU_other_testsuite();

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
	
	
	string p;
	integer fd, result;
	
	initial begin
		fd = $fopen( "../../../assembler/6502_functional_test.bin", "rb" );
		wf = $fopen( "./MyOutput", "w" );
		
		result = $fread( my_memory, fd, 'h0400 );
 
	
 
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
		DUT.registers.a = 'h00;
		DUT.registers.x = 'h00;
		DUT.registers.y = 'h00;
		DUT.registers.sp = 'hff;
		
	end
	
	always @( posedge clk ) begin
		if( DUT.control.ld_sel == LD_INSTR ) begin
			addr_rem_d = addr_rem;
			addr_rem = addr;
		end
		
		case( DUT.control.ld_sel ) 
			LD_INSTR, LD_IMM, LD_OFFSET, LD_ADL, LD_ADH, LD_BAL, LD_BAH: begin
				//if( addr >= 'h0200 ) begin
					words = { words, words_bw };
					words_bw = $sformatf( "%2h ", data_reg );
				//end
			end
		endcase
		/*
		// YANG concern
		if( DUT.registers.ld_sel == LD_P ) begin
			DUT.registers.status[ 5:4 ] <= data[ 5:4 ];
		end
		*/
		// SETD instruction
		if( DUT.registers.ir == 'hF8 ) begin
			DUT.registers.status[ D ] <= 'b1;
		end
		// CLRD instruction
		else if( DUT.registers.ir == 'hD8 ) begin
			DUT.registers.status[ D ] <= 'b0;
		end
	end
	
	string trace;
	string a, x, y, sp, address, f;
	string line;
	
	always @( negedge clk ) begin
	
		
	
		release DUT.next_status;
		release DUT.alu.alu_sel;
		release DUT.registers.pc;
		release DUT.registers.sp;
		release DUT.registers.status;
	
		if( rst ) begin
			// do nothing
		end
		
		if( DUT.registers.pc == 'h0400 ) begin
			force DUT.registers.status[ I ] = 'b0;
			force DUT.registers.sp = 'hff;
			words = "";
			words_bw = "";
		end
		
		/*
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
		*/
		/*
		if( currentCycle == 'd139171630 ) begin
			DUT.registers.status[ N ] = 'b1;
			DUT.registers.status[ Z ] = 'b1;
			p_d[ 0 ] = "N";
			p_d[ 6 ] = "Z";
		end
		*/
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
						
				a = $sformatf("%2h", DUT.registers.a);
				a = a.toupper();
				
				x = $sformatf("%2h", DUT.registers.x);
				x = x.toupper();
				
				y = $sformatf("%2h", DUT.registers.y);
				y = y.toupper();
				
				sp = $sformatf("%2h", DUT.registers.sp);
				sp = sp.toupper();
				
				f = $sformatf( "%2h", DUT.registers.status );
				f = f.toupper();
													
				address = $sformatf("%4h", addr_rem_d);
				address = address.toupper();
								
				$sformat( p, "[%c%c%s%c%c%s%c%c]", 
					DUT.registers.n ? "N" : ".",
					DUT.registers.v ? "V" : ".",
					"-",
					DUT.registers.b ? "B" : ".",
					DUT.registers.d ? "D" : ".",
					DUT.registers.i ? "I" : ".",
					DUT.registers.z ? "Z" : ".",
					DUT.registers.c ? "C" : ".");
				
				$sformat( line, "%s  %sA:%s X:%s Y:%s F:%s S:1%s %s\n"
					, address
					, words
					, a
					, x
					, y
					, f
					, sp
					, p
				);
				
				words = "";
								
				$fwrite( wf, line );
				$write( line );
						
			end
			
			
		end
	end
	
	
	
	always_ff @( edge clk ) begin
		if( rst ) begin
			my_memory[ 'hFFFC ] <= 'h00;
			my_memory[ 'hFFFD ] <= 'h04;
			my_memory[ 'h040D ] <= 'h04;
		end
		
		else if( read ) begin
			data_reg <= my_memory[ addr ];
		end
		
		else if( write ) begin
			my_memory[ addr ] <= data;
			/*
			// YANG concern
			if( DUT.registers.st_sel == ST_P ) begin
				my_memory[ addr ][ U ] <= 1'b1;
			end
			*/
		end
	end
	
endmodule
