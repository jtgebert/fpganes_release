//`include "Enums.sv"
import Enums::*;

module processor_control(
input clk,
input rst,
input ITYPE instruction_type,
input AMODE addressing_mode,
input DO_OP decoder_alu_sel,
input SRC1 decoder_src1,
input SRC2 decoder_src2,
input DEST decoder_dest,
input do_branch,
input c,
input i,
input[7:0] temp_status,
input nmi,
input irq,
input stall,

output ADDR addr_sel,
output DEST dest_sel,
output LD ld_sel,
output PC pc_sel,
output SP sp_sel,
output SRC1 src1_sel,
output SRC2 src2_sel,
output ST st_sel,
output reg clr_adh,
output reg clr_bah,
output DO_OP alu_sel,//TODO fix the naming
output INT_TYPE interrupt_type
);
reg [1:0] skip_cycle;
reg [3:0] state;
reg [3:0] next_state;
reg nop_cycle;
ALUMODE alu_mode;
//DO_OP next_alu_sel;

always@(posedge clk, posedge rst) begin
if(rst) begin
	state<= 'd0;
	//alu_sel<=DO_OP_CLR_C;
end 
else if( stall ) begin
	// don't change
end
else begin
	state<=next_state;

end
end

	//	reg IsNMIInterrupt;//dummy register to tell NMI is being executed
reg prev_nmi,pending_nmi,processing_nmi;
reg processing_nmi_set,processing_nmi_clr;

reg processing_ri;
reg processing_ri_clr;
wire pending_nmi_set;
reg pending_nmi_clr;
// Controls whether we'll remember the state in prev_nmi. Ignore NMI if it appears as a pulse during IRQ vector location read.
wire nmi_gated = (addr_sel!=ADDR_INT_L | addr_sel!=ADDR_INT_H) && !processing_ri ? nmi : prev_nmi;
// NMI is triggered at any time, except during reset, or when we're in the middle of
// reading the vector address
assign pending_nmi_set = ( addr_sel!=ADDR_INT_L | addr_sel!=ADDR_INT_H ) && !processing_ri && nmi && !prev_nmi;
// NMI flag is cleared right after we read the vector address
// Controls whether processing_nmi will get set
wire pending_nmi_next = pending_nmi_set ? 1'b1 : pending_nmi_clr ? 1'b0 : pending_nmi;

always @(posedge clk, posedge rst) begin

  if (rst) begin
	processing_nmi <= 0;
	prev_nmi <= 0;
	pending_nmi <= 0;
  end 
  else if( stall ) begin
	// don't change
	end
  else begin
	pending_nmi<=pending_nmi_next;
	prev_nmi <= nmi_gated;
	if(processing_nmi_set) begin
		processing_nmi<=1'b1;
	end else if(processing_nmi_clr) begin
		processing_nmi<=0;
	end else begin
		processing_nmi<=processing_nmi;
	end
  end

end

always @(posedge clk, posedge rst) begin

  if (rst) begin
	processing_ri <= 1'b1;
   end 
   else if( stall ) begin
	// don't change
end
   else if(processing_ri_clr)begin
	processing_ri <= 0 ;
  end

end
reg processing_irq;
reg processing_irq_clr;
always @(posedge clk, posedge rst) begin

  if (rst) begin
	processing_irq<=1'b0;
  end 
  else if( stall ) begin
	// don't change
end
  else if (processing_irq_clr) begin
	processing_irq<=1'b0;
  end else if(irq && ~i && next_state==1'b1 && state!=1'b0) begin
	processing_irq<=1'b1;
  end else begin
	processing_irq<=processing_irq;
  end

end


always_comb begin
	next_state=state;
	addr_sel=ADDR_PC;
	dest_sel=DEST_NONE;
	ld_sel=LD_NONE;
	//ld_sel=LD_INSTR;
    pc_sel=KEEP_PC;
    sp_sel=KEEP_SP;	
	src1_sel=SRC1_DC;
	src2_sel=SRC2_DC;
	st_sel=ST_NONE;
	clr_adh=1'b0;
	clr_bah=1'b0;
	interrupt_type=INT_NONE;
	skip_cycle = 2'b0;
	nop_cycle = 'b0;
	alu_mode=ALUMODE_NONE;
	alu_sel = DO_OP_NONE;
	
	pending_nmi_clr=1'b0;	
	processing_nmi_set=1'b0;
	processing_irq_clr=1'b0;
	processing_nmi_clr=1'b0;
	processing_ri_clr = 1'b0;
	
	if(processing_nmi | processing_irq | processing_ri) begin
		case(state)
		0:  begin
				if( addr_sel == ADDR_AD ) begin
					pc_sel = AD_TO_PC;
				end
				else begin
					pc_sel=KEEP_PC;
				end
				next_state=state+1'b1;
			end
		1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
			end
		2:  begin
				addr_sel=ADDR_SP;
				if( processing_ri ) begin
					st_sel = ST_NONE;
					sp_sel = KEEP_SP;
				end
				else begin
					st_sel=ST_PCH;
					sp_sel=DEC_SP;
				end
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
			end
		3:  begin
				addr_sel=ADDR_SP;
				if( processing_ri ) begin
					st_sel = ST_NONE;
					sp_sel = KEEP_SP;
				end
				else begin
					st_sel=ST_PCL;
					sp_sel=DEC_SP;
				end
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
			end
		4:  begin
				addr_sel=ADDR_SP;
				if( processing_ri ) begin
					st_sel = ST_NONE;
					sp_sel = KEEP_SP;
				end
				else begin
					st_sel=ST_P;
					sp_sel=DEC_SP;
				end
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
			end
		5:  begin
				addr_sel=ADDR_INT_L;
				ld_sel=LD_PCL;
				if(processing_irq) begin
					interrupt_type=IRQ;
				end else if(processing_nmi) begin 
					interrupt_type=NMI;
				end else if(processing_ri) begin
					interrupt_type=RESET;
				end
				alu_sel=DO_OP_SET_I;
				next_state=state+1'b1;
			end
		6:  begin
				addr_sel=ADDR_INT_H;
				ld_sel=LD_PCH;
				alu_sel=DO_OP_CLR_B;
				if(processing_irq) begin
					interrupt_type=IRQ;
				end else if(processing_nmi) begin 
					interrupt_type=NMI;
				end else if(processing_ri) begin
					interrupt_type=RESET;
				end			
				next_state=state+1'b1;
			end
		7:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				pc_sel=INC_PC;
				if(processing_irq) begin
					processing_irq_clr=1'b1;
				end else if(processing_nmi) begin 
					processing_nmi_clr=1'b1;
					pending_nmi_clr=1'b1;
				end else if(processing_ri) begin
					processing_ri_clr=1'b1;
				end		
				ld_sel = LD_INSTR;
			end
		default : begin 
			
		end
		endcase
	end
	else begin
		//case({instruction_type,addressing_mode})
		`include "cpu_switchcase.sv"
		//endcase
		
		alu_sel=(alu_mode==ALUMODE_DECODER)?decoder_alu_sel:(alu_mode==ALUMODE_FLAGLESS)?DO_OP_ADD:DO_OP_NONE;
		
		case( alu_sel )
			DO_OP_CMP, DO_OP_BIT :
				dest_sel = DEST_NONE;
			default : begin 
				
			end
		endcase
		
		
		if( irq && ~i && next_state==1'b1 && state!=1'b0 ) begin
			ld_sel = LD_NONE;
			if( addr_sel == ADDR_AD ) begin
				pc_sel = AD_TO_PC;
			end
			else begin
				pc_sel=KEEP_PC;
			end
		end
	end
	if(next_state==1'b1 && state!=1'b0 && pending_nmi && !processing_nmi) begin
		processing_nmi_set=1'b1;
		//processing_nmi=1'b1;
		ld_sel = LD_NONE;
		if( addr_sel == ADDR_AD ) begin
			pc_sel = AD_TO_PC;
		end
		else begin
			pc_sel=KEEP_PC;
		end
	end
	/* if( posedge hardware interrupt ) {
		latch ( latched_signal )
	}
	if( latched_signal & state == 0 ) {
		overwrite instruction
	}
	*/

end
endmodule
