//`include "Enums.sv"
import Enums::*;

module decoder(
  input [7:0] instruction_register,
  input n,
  input z,
  input c,
  input v,
  output AMODE addressing_mode,
  output ITYPE instruction_type,
  output SRC1 decoder_src1,
  output SRC2 decoder_src2,
  output DEST decoder_dest,
  output DO_OP alu_sel,
  output reg do_branch
);

  /*Some instructions are probably best considered simply by listing them. Here are the interrupt and subroutine instructions:							

BRK	JSR abs	RTI	RTS				
0	20	40	60				

(JSR is the only absolute-addressing instruction that doesn't fit the aaabbbcc pattern.)							

Other single-byte instructions:							

PHP	PLP	PHA	PLA	DEY	DEX INY	INX
8	28	48	68	88	CA	C8	E8
CLC	SEC	CLI	SEI		CLV	CLD	SED
18	38	58	78		B8	D8	F8
TXA	TXS	TAX	TSX	TAY TYA	NOP	
8A	9A	AA	BA	A8	98	EA
*/
  always@(*) begin
    instruction_type=NOP;
    addressing_mode=IMPLIED;
    do_branch = 1'b0;
	alu_sel = DO_OP_NONE;
	decoder_dest = DEST_NONE;
	decoder_src1 = SRC1_DC;
	decoder_src2 = SRC2_DC;
	
    case(instruction_register)
      'h00:	begin
        instruction_type=BREAK;
        addressing_mode=SPECIAL;
        alu_sel=DO_OP_SET_BRK;
      end
      'h20:	begin
        instruction_type=JSR;
        addressing_mode=ABSOLUTE;
      end
      'h40:	begin
        instruction_type=RTI;
        addressing_mode=SPECIAL;
      end
      'h60:	begin
        instruction_type=RTS;
        addressing_mode=SPECIAL;
      end
      'h08:	begin
        instruction_type=PHP;
        addressing_mode=SPECIAL;
      end
      'h28:	begin
        instruction_type=PLP;
        addressing_mode=SPECIAL;	
      end
      'h48:	begin
        instruction_type=PHA;
        addressing_mode=SPECIAL;
      end
      'h68:	begin
        instruction_type=PLA;
        addressing_mode=SPECIAL;
      end
      'h88:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SUB_NZ;//TODO we need a subtract without carry here. Also 6502.txt has a typo here
        decoder_src1=SRC1_Y;
        decoder_src2=SRC2_1;
        decoder_dest=DEST_Y;
      end
      'hCA:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SUB_NZ;//TODO we need a subtract without carry here. Also 6502.txt has a typo here
        decoder_src1=SRC1_X;
        decoder_src2=SRC2_1;
        decoder_dest=DEST_X;
      end
      'hC8:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_ADD_NZ;
        decoder_src1=SRC1_Y;
        decoder_src2=SRC2_1;
        decoder_dest=DEST_Y;
      end
      'hE8:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_ADD_NZ;
        // alu_sel=DO_OP_ADD_NZ
        decoder_src1=SRC1_X;
        decoder_src2=SRC2_1;
        decoder_dest=DEST_X;
      end
      'h18:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_CLR_C; //TODO:	begin make sure n and z are maintained from the previous operation
      end
      'h38:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SET_C;
      end
      'h58:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_CLR_I;
      end
      'h78:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SET_I;
      end
      'hB8:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_CLR_V;
      end
      'hD8:	begin
      end
      'hF8:	begin
        //TXA	TXS	TAX	TSX	TAY TYA	NOP	
        //8A	9A	AA	BA	A8	98	EA
      end
      'h8A:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SRC2;
        decoder_src1=SRC1_DC;//TODO :	begin ADD these enums
        decoder_src2=SRC2_X;
        decoder_dest=DEST_A;
      end
      'h9A:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SRC2;
        decoder_src1=SRC1_DC;
        decoder_src2=SRC2_X;
        decoder_dest=DEST_SP;
      end
      'hAA:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SRC2;
        decoder_src1=SRC1_DC;
        decoder_src2=SRC2_A;
        decoder_dest=DEST_X;
      end
      'hBA:	begin
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SRC2;
        decoder_src1=SRC1_DC;
        decoder_src2=SRC2_SP;
        decoder_dest=DEST_X;
      end
      'hA8:	begin//TAY
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SRC2;
        decoder_src1=SRC1_DC;
        decoder_src2=SRC2_A;
        decoder_dest=DEST_Y;
      end
      'h98:	begin//TYA		
        instruction_type=OTHER;
        addressing_mode=IMPLIED;
        alu_sel=DO_OP_SRC2;
        decoder_src1=SRC1_DC;
        decoder_src2=SRC2_Y;
        decoder_dest=DEST_A;
      end
      'hEA:	begin
        instruction_type=NOP;
        addressing_mode=IMPLIED;
      end
      default:	begin
        /*Instructions with cc = 01 are the most regular, and are therefore considered first. The aaa bits determine the opcode as follows:	begin	

		aaa	opcode
		0	ORA
		1	AND
		10	EOR
		11	ADC
		100	STA
		101	LDA
		110	CMP
		111	SBC

		And the addressing mode (bbb) bits:	begin	

		bbb	addressing mode
		0	(zero page,X)
		1	zero page
		10	#immediate
		11	absolute
		100	(zero page),Y
		101	zero page,X
		110	absolute,Y
		111	absolute,X
		*/

        case(instruction_register[1:0]) 
          'b01:	begin
            case(instruction_register[7:5])
              'b000:	begin
                alu_sel=DO_OP_OR;
                instruction_type=ARITHMETIC;
              end
              'b001:	begin
                alu_sel=DO_OP_AND;
                instruction_type=ARITHMETIC;
              end
              'b010:	begin
                alu_sel=DO_OP_XOR;
                instruction_type=ARITHMETIC;
              end
              'b011:	begin
                alu_sel=DO_OP_ADC;
                instruction_type=ARITHMETIC;
              end
              'b100:	begin
                alu_sel=DO_OP_SRC2;
                instruction_type=STA;
              end
              'b101:	begin
                alu_sel=DO_OP_SRC2;
                instruction_type=ARITHMETIC;
              end
              'b110:	begin				
                alu_sel=DO_OP_CMP;
                decoder_dest=DEST_NONE;
                instruction_type=ARITHMETIC;
              end
              'b111:	begin
                alu_sel=DO_OP_SBC;
                instruction_type=ARITHMETIC;
              end
            endcase
            case(instruction_register[4:2])
              'b000:	begin
                addressing_mode=INDIRECT_X;
              end
              'b001:	begin
                addressing_mode=ZEROPAGE;
              end
              'b010:	begin
                addressing_mode=IMMEDIATE;
              end
              'b011:	begin
                addressing_mode=ABSOLUTE;
              end
              'b100:	begin
                addressing_mode=INDIRECT_Y;
              end
              'b101:	begin
                addressing_mode=ZEROPAGE_INDEX;
              end
              'b110:	begin
                addressing_mode=ABSOLUTE_INDEX_Y;
              end
              'b111:	begin
                addressing_mode=ABSOLUTE_INDEX;
              end
            endcase
          end
          'b10:	begin

            /*Next we consider the cc = 10 instructions. These have a completely different set of opcodes:		

		aaa	opcode	
		0	ASL	
		1	ROL	
		10	LSR	
		11	ROR	
		100	STX	
		101	LDX	
		110	DEC	
		111	INC	

		The addressing modes are similar to the 01 case, but not quite the same:		

		bbb	addressing mode	
		0	#immediate	
		1	zero page	
		10	accumulator	
		11	absolute	
		101	zero page,X	
		111	absolute,X	

			*/
            case(instruction_register[7:5])
              'b000:	begin
                alu_sel=DO_OP_ASL;
                instruction_type=MANIPULATION;						
              end
              'b001:	begin
                alu_sel=DO_OP_ROL;
                instruction_type=MANIPULATION;
              end
              'b010:	begin
                alu_sel=DO_OP_LSR;
                instruction_type=MANIPULATION;
              end
              'b011:	begin
                alu_sel=DO_OP_ROR;
                instruction_type=MANIPULATION;
              end
              'b100:	begin
                alu_sel=DO_OP_SRC2;
                instruction_type=STX;
              end
              'b101:	begin
                alu_sel=DO_OP_SRC2;
                instruction_type=LDX;
              end
              'b110:	begin				
                alu_sel=DO_OP_SUB_NZ;
                instruction_type=RMW;
              end
              'b111:	begin
                alu_sel=DO_OP_ADD_NZ;
                instruction_type=RMW;
              end
            endcase
            case(instruction_register[4:2])

              'b000:	begin
                addressing_mode=IMMEDIATE;
              end
              'b001:	begin
                addressing_mode=ZEROPAGE;
              end
              'b010:	begin
                addressing_mode=ACCUMULATOR;
              end
              'b011:	begin
                addressing_mode=ABSOLUTE;
              end
              'b101:	begin
				if( instruction_type == STX || instruction_type == LDX ) begin
					addressing_mode=ZEROPAGE_INDEX_Y;
				end
				else begin
					addressing_mode=ZEROPAGE_INDEX;
				end
              end
              'b111:	begin
				if( instruction_type == LDX ) begin
					addressing_mode = ABSOLUTE_INDEX_Y;
				end
				else begin
					addressing_mode=ABSOLUTE_INDEX;
				end
              end
			  default : begin
				// do nothing
			  end
            endcase
          end				
          'b00:	begin
            /*
		Next, the cc = 00 instructions. Again, the opcodes are different:	

		aaa	opcode
		1	BIT
		10	JMP
		11	JMP (abs)
		100	STY
		101	LDY
		110	CPY
		111	CPX

		It's debatable whether the JMP instructions belong in this list...I've included them because they do seem to fit, provided one considers the indirect JMP a separate opcode rather than a different addressing mode of the absolute JMP.	

		The addressing modes are the same as the 10 case, except that accumulator mode is missing.	

		bbb	addressing mode
		0	#immediate
		1	zero page
		11	absolute
		101	zero page,X
		111	absolute,X

		*/
            case(instruction_register[7:5])
              'b000:	begin
              end
              'b001:	begin
                alu_sel=DO_OP_BIT;
                instruction_type=ARITHMETIC;	
				//ARITHMETIC doesn't receive decoder_dest. fix it in control.sv after switchcase
				//decoder_dest=DEST_NONE;
              end
              'b010:	begin				
                instruction_type=JUMP;
              end
              'b011:	begin
                instruction_type=JUMP_IND;
              end
              'b100:	begin
                alu_sel=DO_OP_SRC2;
                instruction_type=STY;
              end
              'b101:	begin
                alu_sel=DO_OP_SRC2;
                instruction_type=LDY;
              end
              'b110:	begin				
                alu_sel=DO_OP_CMP;
                instruction_type=CPY;
                decoder_dest=DEST_NONE;				
              end
              'b111:	begin
                alu_sel=DO_OP_CMP;
                instruction_type=CPX;
                decoder_dest=DEST_NONE;
              end
            endcase
            case(instruction_register[4:2])
              'b000:	begin
                addressing_mode=IMMEDIATE;
              end
              'b001:	begin
                addressing_mode=ZEROPAGE;
              end
              'b011:	begin
                addressing_mode=ABSOLUTE;
              end
			  'b100:	begin
                addressing_mode=RELATIVE;
                instruction_type=BRANCH;//TODO see if there can be multiple driver problems.
                //BPL	BMI	BVC	BVS	BCC	BCS	BNE	BEQ
                //10	30	50	70	90	B0	D0	F0

                case(instruction_register)
                  'h90: do_branch=(c==1'b0);
                  'hB0: do_branch=(c==1'b1);
                  'hF0: do_branch=(z==1'b1);
                  'h30: do_branch=(n==1'b1);
                  'hD0: do_branch=(z==1'b0);
                  'h10: do_branch=(n==1'b0);
                  'h50: do_branch=(v==1'b0);
                  'h70: do_branch=(v==1'b1);
				  default : do_branch = 1'bx;
                endcase
              end
              'b101:	begin
                addressing_mode=ZEROPAGE_INDEX;
              end
              'b111:	begin
                addressing_mode=ABSOLUTE_INDEX;	
              end
			  default : begin
				// do nothing
			  end
            endcase
          end

          default:	begin
          end
        endcase//case over cc
      end
    endcase
  end
endmodule
