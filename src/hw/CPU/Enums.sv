package Enums;

`include "Constants.sv"

	typedef enum {
		ADDR_AD,
		ADDR_PC,
		ADDR_BA,
		ADDR_SP,
		ADDR_INT_L,
		ADDR_INT_H,
		ADDR_NONE
	} ADDR;

	typedef enum {
		IRQ,
		NMI,
		RESET,
		INT_NONE
	} INT_TYPE;

	typedef enum {
		AD_P_TO_PC,
		AD_TO_PC,
		INC_PC,
		KEEP_PC
	} PC;

	typedef enum {
		DO_OP_ADD,
		DO_OP_SUB,
		DO_OP_AND,
		DO_OP_OR,
		DO_OP_XOR,
		DO_OP_ASL,
		DO_OP_LSR,
		DO_OP_ROL,
		DO_OP_ROR,
		DO_OP_SRC2,
		DO_OP_CLR_C,
		DO_OP_CLR_I,
		DO_OP_CLR_V,
		DO_OP_SET_C,
		DO_OP_SET_I,
		DO_OP_SET_V,
		DO_OP_ADC,
		DO_OP_SBC,
		DO_OP_ADD_T_C,
		DO_OP_ADD_NZ,
		DO_OP_SUB_NZ,
		DO_OP_CMP,
		DO_OP_SET_BRK,
		DO_OP_CLR_B,
		DO_OP_BIT,
		DO_OP_NONE
	} DO_OP;

	typedef enum {
		SRC1_A,
		SRC1_BAL,
		SRC1_BAH,
		SRC1_ADL,
		SRC1_PCL,
		SRC1_PCH,
		SRC1_X,
		SRC1_Y,
		SRC1_BAV,
		SRC1_1,
		SRC1_ADV,
		SRC1_DC
	} SRC1;

	typedef enum {
		SRC2_IMM,
		SRC2_ADV,
		SRC2_X,
		SRC2_BAV,
		SRC2_T_C,
		SRC2_1,
		SRC2_Y,
		SRC2_A,
		SRC2_OFFSET,
		SRC2_SP,
		SRC2_OFFSET_W_C,
		SRC2_DC
	} SRC2;

	typedef enum {
		DEST_BAL,
		DEST_BAH,
		DEST_ADL,
		DEST_A,
		DEST_X,
		DEST_Y,
		DEST_PCL,
		DEST_PCH,
		DEST_SP,
		DEST_ADV,
		DEST_BAV,
		DEST_NONE
	} DEST;

	typedef enum {
		INC_SP,
		DEC_SP,
		KEEP_SP
	} SP;

	typedef enum {
		LD_INSTR,
		LD_ADL,
		LD_ADH,
		LD_BAL,
		LD_BAH,
		LD_IMM,
		LD_OFFSET,
		LD_ADV,
		LD_BAV,
		LD_PCL,
		LD_PCH,
		LD_P,
		LD_A,
		LD_NONE
	} LD;

	typedef enum {
		ST_A,
		ST_X,
		ST_Y,
		ST_P,
		ST_PCH,
		ST_PCL,
		ST_ADV,
		ST_BAV,
		ST_NONE
	} ST;

	typedef enum {
		BR_BCC,
		BR_BCS,
		BR_BEQ,
		BR_BMI,
		BR_BNE,
		BR_BPL,
		BR_BVC,
		BR_BVS,
		BR_NONE
	} BR;

	typedef enum {
		ARITHMETIC,
		BRANCH,
		BREAK,
		LDX,
		LDY,
		CPY,
		CPX,
		INTERRUPT,
		JSR,
		JUMP,
		JUMP_IND,
		OTHER,
		PHP,
		PHA,
		PLP,
		PLA,
		RMW,
		RTI,
		RTS,
		STA,
		STX,
		STY,
		NOP,
		MANIPULATION
	} ITYPE;

	typedef enum {
		ABSOLUTE,
		ABSOLUTE_INDEX,
		ABSOLUTE_INDEX_Y,
		ACCUMULATOR,
		IMMEDIATE,
		IMPLIED,
		INDIRECT,
		INDIRECT_X,
		INDIRECT_Y,
		RELATIVE,
		SPECIAL,
		ZEROPAGE,
		ZEROPAGE_INDEX,
		ZEROPAGE_INDEX_Y,
		AMODE_NONE
	} AMODE;

	typedef enum {
		ALUMODE_DECODER,
		ALUMODE_FLAGLESS,
		ALUMODE_ONLYC,
		ALUMODE_NONE
	} ALUMODE;

endpackage : Enums