case( { instruction_type, addressing_mode } )
	{STA,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STA,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				clr_bah=1;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STA,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STA,ABSOLUTE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_T_C;
				dest_sel=DEST_BAH;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STA,ABSOLUTE_INDEX_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_T_C;
				dest_sel=DEST_BAH;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STA,INDIRECT_X}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_ADL;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAL;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_ADH;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STA,INDIRECT_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				addr_sel=ADDR_AD;
				ld_sel=LD_BAL;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_ADL;
				src2_sel=SRC2_1;
				dest_sel=DEST_ADL;
				next_state=state+1'b1;
				end
			3:  begin
				pc_sel=KEEP_PC;
				addr_sel=ADDR_AD;
				ld_sel=LD_BAH;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			4:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_T_C;
				dest_sel=DEST_BAH;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STX,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_X;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STX,ZEROPAGE_INDEX_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				clr_bah=1;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_X;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STX,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_X;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STY,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_Y;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STY,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				clr_bah=1;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_Y;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{STY,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_Y;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDX,IMMEDIATE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_IMM;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_IMM;
				dest_sel=DEST_X;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDX,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_X;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDX,ZEROPAGE_INDEX_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_X;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDX,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_X;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDX,ABSOLUTE_INDEX_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_X;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDY,IMMEDIATE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_IMM;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_IMM;
				dest_sel=DEST_Y;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDY,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_Y;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDY,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_Y;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDY,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_Y;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{LDY,ABSOLUTE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_DC;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_Y;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPX,IMMEDIATE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_IMM;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_X;
				src2_sel=SRC2_IMM;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPX,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_X;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPX,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_X;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPX,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_X;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPX,ABSOLUTE_INDEX_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_X;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPY,IMMEDIATE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_IMM;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_Y;
				src2_sel=SRC2_IMM;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPY,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_Y;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPY,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_Y;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPY,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_Y;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{CPY,ABSOLUTE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_Y;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_NONE;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,ACCUMULATOR}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_DC;
				dest_sel=DEST_A;
				//TODO;
				//just add nop instead of hanging around?;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,IMMEDIATE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_IMM;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_IMM;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,ABSOLUTE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,ABSOLUTE_INDEX_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,INDIRECT_X}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_ADL;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_ADH;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				next_state=state+1'b1;
				end
			6:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_ADV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{ARITHMETIC,INDIRECT_Y}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				addr_sel=ADDR_AD;
				ld_sel=LD_BAL;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_ADL;
				src2_sel=SRC2_1;
				dest_sel=DEST_ADL;
				next_state=state+1'b1;
				end
			3:  begin
				pc_sel=KEEP_PC;
				addr_sel=ADDR_AD;
				ld_sel=LD_BAH;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_Y;
				dest_sel=DEST_BAL;
				skip_cycle=~temp_status[ C ] ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAH;
				;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				next_state=state+1'b1;
				end
			6:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_BAV;
				dest_sel=DEST_A;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{JUMP,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				pc_sel=AD_P_TO_PC;
				addr_sel=ADDR_AD;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				end
default : begin /* do nothing */ end
		endcase
	end
	{JUMP_IND,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_ADL;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_ADH;
				next_state=state+1'b1;
				end
			5:  begin
				pc_sel=AD_P_TO_PC;
				addr_sel=ADDR_AD;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				end
default : begin /* do nothing */ end
		endcase
	end
	{BRANCH,RELATIVE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_OFFSET;
				pc_sel=INC_PC;
				skip_cycle=do_branch?2'd0:2'd2;
				next_state=state+1'b1+skip_cycle;
				end
			2:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_PCL;
				src2_sel=SRC2_OFFSET;
				dest_sel=DEST_PCL;
				skip_cycle=(!temp_status[C]&!temp_status[N])|(temp_status[C]&temp_status[N]) ? 2'b1 : 2'b0;
				next_state=state+1'b1+skip_cycle;
				end
			3:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_PCH;
				src2_sel=SRC2_OFFSET_W_C;
				dest_sel=DEST_PCH;
				next_state=state+1'b1;
				end
			4:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{OTHER,IMPLIED}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=decoder_src1;
				;
				src2_sel=decoder_src2;
				;
				dest_sel=decoder_dest;
				;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{NOP,IMPLIED}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{PHA,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_A;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_PC;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{PHP,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_P;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_PC;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{PLA,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_A;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_PC;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{PLP,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_P;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_PC;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{BREAK,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=INC_PC;
				// PC+2 so that I can jump;
				//  2 cycles at once;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_PCH;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_PCL;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_P;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_INT_L;
				ld_sel=LD_PCL;
				interrupt_type=IRQ;
				next_state=state+1'b1;
				end
			6:  begin
				addr_sel=ADDR_INT_H;
				ld_sel=LD_PCH;
				// this is to set B and I;
				//  ST_P already sets B ;
				// according to the Int_type;
				alu_mode=ALUMODE_DECODER;
				interrupt_type=IRQ;
				next_state=state+1'b1;
				end
			7:  begin
				nop_cycle=1'b1;
				addr_sel=ADDR_PC;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{RTI,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_P;
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_PCL;
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_PCH;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			6:  begin
				addr_sel=ADDR_PC;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{JSR,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_PCH;
				sp_sel=DEC_SP;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_PCL;
				sp_sel=DEC_SP;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_PC;
				ld_sel=LD_ADH;
				next_state=state+1'b1;
				end
			6:  begin
				pc_sel=AD_P_TO_PC;
				addr_sel=ADDR_AD;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				end
default : begin /* do nothing */ end
		endcase
	end
	{RTS,SPECIAL}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_PCL;
				pc_sel=KEEP_PC;
				sp_sel=INC_SP;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_SP;
				ld_sel=LD_PCH;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{RMW,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				clr_adh=1;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_ADV;
				src2_sel=SRC2_1;
				dest_sel=DEST_ADV;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_ADV;
				next_state=state+1'b1;
				end
			5:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{RMW,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				clr_bah=1;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_BAV;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAV;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_BAV;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{RMW,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_ADV;
				src2_sel=SRC2_1;
				dest_sel=DEST_ADV;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_ADV;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{RMW,ABSOLUTE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_T_C;
				dest_sel=DEST_BAH;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_BAV;
				src2_sel=SRC2_1;
				dest_sel=DEST_BAV;
				next_state=state+1'b1;
				end
			6:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_BAV;
				next_state=state+1'b1;
				end
			7:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{INTERRUPT,SPECIAL}:  begin
		case(state)
			0:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_PCH;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_PCL;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_SP;
				st_sel=ST_P;
				pc_sel=KEEP_PC;
				sp_sel=DEC_SP;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_INT_L;
				ld_sel=LD_PCL;
				interrupt_type=IRQ;
				next_state=state+1'b1;
				end
			6:  begin
				addr_sel=ADDR_INT_H;
				ld_sel=LD_PCH;
				interrupt_type=IRQ;
				next_state=state+1'b1;
				end
			7:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{MANIPULATION,ACCUMULATOR}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			2:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_A;
				src2_sel=SRC2_DC;
				dest_sel=DEST_A;
				//TODO;
				//just add nop instead of hanging around?;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{MANIPULATION,ZEROPAGE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				clr_adh=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_ADV;
				src2_sel=SRC2_DC;
				dest_sel=DEST_ADV;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_ADV;
				next_state=state+1'b1;
				end
			5:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{MANIPULATION,ZEROPAGE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				clr_bah=1;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				pc_sel=KEEP_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_BAV;
				src2_sel=SRC2_DC;
				dest_sel=DEST_BAV;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_BAV;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{MANIPULATION,ABSOLUTE}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_ADL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_ADH;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			3:  begin
				addr_sel=ADDR_AD;
				ld_sel=LD_ADV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			4:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_ADV;
				src2_sel=SRC2_DC;
				dest_sel=DEST_ADV;
				next_state=state+1'b1;
				end
			5:  begin
				addr_sel=ADDR_AD;
				st_sel=ST_ADV;
				next_state=state+1'b1;
				end
			6:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
	{MANIPULATION,ABSOLUTE_INDEX}:  begin
		case(state)
			0:  begin
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			1:  begin
				ld_sel=LD_BAL;
				pc_sel=INC_PC;
				next_state=state+1'b1;
				end
			2:  begin
				ld_sel=LD_BAH;
				pc_sel=INC_PC;
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAL;
				src2_sel=SRC2_X;
				dest_sel=DEST_BAL;
				next_state=state+1'b1;
				end
			3:  begin
				alu_mode=ALUMODE_FLAGLESS;
				src1_sel=SRC1_BAH;
				src2_sel=SRC2_T_C;
				dest_sel=DEST_BAH;
				next_state=state+1'b1;
				end
			4:  begin
				addr_sel=ADDR_BA;
				ld_sel=LD_BAV;
				pc_sel=KEEP_PC;
				next_state=state+1'b1;
				end
			5:  begin
				alu_mode=ALUMODE_DECODER;
				src1_sel=SRC1_BAV;
				src2_sel=SRC2_DC;
				dest_sel=DEST_BAV;
				next_state=state+1'b1;
				end
			6:  begin
				addr_sel=ADDR_BA;
				st_sel=ST_BAV;
				next_state=state+1'b1;
				end
			7:  begin
				nop_cycle=1'b1;
				next_state=1'b1;
				ld_sel=LD_INSTR;
				pc_sel=INC_PC;
				end
default : begin /* do nothing */ end
		endcase
	end
endcase
