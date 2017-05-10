#!/usr/bin/env python

from register import RegisterFile
from memory import Memory
from opcodes import *
from cpu_enums import *
from instruction import *

class CPU:

	reset_vector = 0xffff #TODO: Find the real reset vector
	
	def __init__(self, memory):
		self.register = RegisterFile()
		self.memory = memory
		self.program_start = memory.program_start
		self.cycles = 0
		self.register.PC = self.program_start

	def dump_registers(self):
		print ""
		print "REGISTER FILE DUMP"
		print "------------------"	
		print "A = 0x" + format(self.register.A, '02x')
		print "X = 0x" + format(self.register.X, '02x')
		print "Y = 0x" + format(self.register.Y, '02x')
		print "PC = 0x" + format(self.register.PC, '04x')
		print "NEG = " + str(self.register.neg_flag)
		print "OVERFLOW = " + str(self.register.overflow_flag)
		print "ZERO = " + str(self.register.zero_flag)
		print "CARRY = " + str(self.register.carry_flag)

	def run(self):
		print ""
		halt = False
		while not halt:
			opcode = self.memory.read(self.register.PC)

			if opcode == BRK_IMPLIED:
				print "INSTR: HALT"
				break

			self.inc_pc()
			instruction = self.decode(opcode)

			print "INSTR: " + INSTRUCTION_STR[instruction.function] + " MODE: " + ADDR_MODE_STR[instruction.addr_mode]

			self.execute(instruction, self.register)

		self.dump_registers()

	def program_step(self):
		print "USAGE"
		print "-----"
		print "r: Dump the current cpu register state"
		print "PRESS ANY KEY TO BEGIN EXECUTION"
		raw_input()
		print ""
		
		while True:
			opcode = self.memory.read(self.register.PC)

			if opcode == BRK_IMPLIED:
				print "INSTR: HALT"
				break

			self.inc_pc()
			instruction = self.decode(opcode)
			print "PC: 0x" + format(self.register.PC, '04x') + " " + "INSTR: " + INSTRUCTION_STR[instruction.function] + \
								" MODE: " + ADDR_MODE_STR[instruction.addr_mode]
			self.execute(instruction, self.register)

			input = raw_input()
			
			if input == 'r':
				self.dump_registers()
				print ""

	def load_register(self, register):
		self.register = register	

	def set_pc(self, address):
		self.register.PC = address

	def inc_pc(self):
		self.register.PC += 1

	def reset(self):
		self.register.PC = reset_vector
		self.register.SP = 0xff
		self.register.A = 0
		self.register.X = 0
		self.register.Y = 0
		self.register.neg = False
		self.overflow = False
		self.zero = False
		self.carry = False

	def load_program(self):
		self.memory.write(self.program_start + 0x0, 0xa9)
		self.memory.write(self.program_start + 0x1, 0xff)
		self.memory.write(self.program_start + 0x2, 0x29)
		self.memory.write(self.program_start + 0x3, 0x33)
		self.memory.write(self.program_start + 0x4, 0xa2)
		self.memory.write(self.program_start + 0x5, 0x33)
		self.memory.write(self.program_start + 0x6, 0x00)

	# Get the source addresss for the instruction
	# and then calculate the result
	def execute(self, instruction, register):

		address = 0

		addr_mode = instruction.addr_mode
		function = instruction.function

		if addr_mode is IMMEDIATE:
			address = self.Mode_IMMEDIATE()
		elif addr_mode is ZERO_PAGE:
			address = self.Mode_ZERO_PAGE()
		elif addr_mode is ZERO_PAGE_X:
			address = self.Mode_ZERO_PAGE_X()
		elif addr_mode is ZERO_PAGE_Y:
			address = self.Mode_ZERO_PAGE_Y()
		elif addr_mode is ABSOLUTE:
			address = self.Mode_ABSOLUTE()
		elif addr_mode is ABSOLUTE_X:
			address = self.Mode_ABSOLUTE_X()
		elif addr_mode is ABSOLUTE_Y:
			address = self.Mode_ABSOLUTE_Y()
		elif addr_mode is INDIRECT:
			address = self.Mode_INDIRECT()
		elif addr_mode is INDIRECT_X:
			address = self.Mode_INDIRECT_X()
		elif addr_mode is INDIRECT_Y:
			address = self.Mode_INDIRECT_Y()
		elif addr_mode is IMPLICIT():
			address = self.Mode_IMPLICIT()
		elif addr_mode is ACCUMULATOR:
			address = self.Mode_ACCUMULATOR()
		elif addr_mode is RELATIVE:
			address = self.Mode_RELATIVE()
		elif addr_mode is IMPLIED:
			address = self.Mode_IMPLIED()
		else:
			print "ERROR: That addressing mode does not exist"
			exit()

		if function is ADC:
			self.Op_ADC(address)
		elif function is AND:
			self.Op_AND(address)
		elif function is ASL:
			self.Op_ASL(address)
		elif function is BIT:
			self.Op_BIT(address)
		elif function is BRK:
			self.Op_BRK(address)
		elif function is CMP:
			self.Op_CMP(address)
		elif function is CPX:
			self.Op_CPX(address)
		elif function is CPY:
			self.Op_CPY(address)
		elif function is DEC:
			self.Op_DEC(address)
		elif function is EOR:
			self.Op_EOR(address)
		elif function is INC:
			self.Op_INC(address)
		elif function is JMP:
			self.Op_JMP(address)
		elif function is JSR:
			self.Op_JSR(address)
		elif function is LDA:
			self.Op_LDA(address)
		elif function is LDX:
			self.Op_LDX(address)
		elif function is LDY:
			self.Op_LDY(address)
		elif function is LSR:
			self.Op_LSR(address)
		elif function is NOP:
			self.Op_NOP(address)
		elif function is ROL:
			self.Op_ROL(address)
		elif function is ROR:
			self.Op_ROR(address)
		elif function is RTI:
			self.Op_RTI(address)
		elif function is RTS:
			self.Op_RTS(address)
		elif function is SBC:
			self.Op_SBC(address)
		elif function is STA:
			self.Op_STA(address)
		elif function is STX:
			self.Op_STX(address)
		elif function is STY:
			self.Op_STY(address)
		elif function is BPL:
			self.Op_BPL(address)
		elif function is BMI:
			self.Op_BMI(address)
		elif function is BVC:
			self.Op_BVC(address)
		elif function is BVS:
			self.Op_BVS(address)
		elif function is BCC:
			self.Op_BCC(address)
		elif function is BCS:
			self.Op_BCS(address)
		elif function is BNE:
			self.Op_BNE(address)
		elif function is BEQ:
			self.Op_BEQ(address)
		elif function is CLC:
			self.Op_CLC(address)
		elif function is SEC:
			self.Op_SEC(address)
		elif function is CLI:
			self.Op_CLI(address)
		elif function is SEI:
			self.Op_SEI(address)
		elif function is CLV:
			self.Op_CLV(address)
		elif function is CLD:
			self.Op_CLD(address)
		elif function is SED:
			self.Op_SED(address)
		elif function is TAX:
			self.Op_TAX(address)
		elif function is TXA:
			self.Op_TXA(address)
		elif function is DEX:
			self.Op_DEX(address)
		elif function is INX:
			self.Op_INX(address)
		elif function is TAY:
			self.Op_TAY(address)
		elif function is TYA:
			self.Op_TYA(address)
		elif function is DEY:
			self.Op_DEY(address)
		elif function is INY:
			self.Op_INY(address)
		elif function is TXS:
			self.Op_TXS(address)
		elif function is TSX:
			self.Op_TSX(address)
		elif function is PHA:
			self.Op_PHA(address)
		elif function is PLA:
			self.Op_PLA(address)
		elif function is PHP:
			self.Op_PHP(address)
		elif function is PLP:
			self.Op_PLP(address)
		else:
			print "ERROR: That function does not exist"
			exit()

		return
		
	def Op_ADC(self, address):
		value = self.memory.read(address)
		result = self.register.A + value + self.register.carry()
		self.register.carry_flag = result & ~0xff > 0
		self.register.zero_flag = (result & 0xff) == 0
		#self.register.overflow_flag = 
		self.register.neg_flag = (result & 0xff) >> 7 > 0
		self.register.A = result & 0xff

		return

	def Op_AND(self, address):
		value = self.memory.read(address)
		result = self.register.A & value
		self.register.zero_flag = result == 0
		#self.register.neg_flag = (result
		self.register.A = result
		return 

	def Op_ASL(self, address):	
		return

	def Op_BIT(self, address):
		return

	def Op_BRK(self, address):
		return

	def Op_CMP(self, address):
		return

	def Op_CPX(self, address):
		return

	def Op_CPY(self, address):
		return

	def Op_DEC(self, address):
		return

	def Op_EOR(self, address):
		return

	def Op_INC(self, address):
		return

	def Op_JMP(self, address):
		return

	def Op_JSR(self, address):
		return

	def Op_LDA(self, address):
		self.register.A = self.memory.read(address)
		return

	def Op_LDX(self, address):
		self.register.X = self.memory.read(address)
		return

	def Op_LDY(self, address):
		self.register.Y = self.memory.read(address)
		return

	def Op_LSR(self, address):
		return

	def Op_NOP(self, address):
		return

	def Op_ROL(self, address):
		return

	def Op_ROR(self, address):
		return

	def Op_RTI(self, address):
		return

	def Op_RTS(self, address):
		return

	def Op_SBC(self, address):
		return

	def Op_STA(self, address):
		return

	def Op_STX(self, address):
		return

	def Op_STY(self, address):
		return

	def Op_BPL(self, address):
		return

	def Op_BMI(self, address):
		return

	def Op_BVC(self, address):
		return

	def Op_BVS(self, address):
		return

	def Op_BCC(self, address):
		return

	def Op_BCS(self, address):
		return

	def Op_BNE(self, address):
		return

	def Op_BEQ(self, address):
		return

	def Op_CLC(self, address):
		return

	def Op_SEC(self, address):
		return

	def Op_CLI(self, address):
		return

	def Op_SEI(self, address):
		return

	def Op_CLV(self, address):
		return

	def Op_CLD(self, address):
		return

	def Op_SED(self, address):
		return

	def Op_TAX(self, address):
		return

	def Op_TXA(self, address):
		return

	def Op_DEX(self, address):
		return

	def Op_INX(self, address):
		return

	def Op_TAY(self, address):
		return

	def Op_TYA(self, address):
		return

	def Op_DEY(self, address):
		return

	def Op_INY(self, address):
		return

	def Op_TXS(self, address):
		return

	def Op_TSX(self, address):
		return

	def Op_PHA(self, address):
		return
	
	def Op_PLA(self, address):
		return

	def Op_PHP(self, address):
		return

	def Op_PLP(self, address):
		return

	def Mode_IMMEDIATE(self):
		addr = self.register.PC
		self.inc_pc()
		return addr

	def Mode_ZERO_PAGE(self):
		zero_page_index = self.memory.read(self.register.PC)
		self.inc_pc()
		return zero_page_index

	def Mode_ZERO_PAGE_X(self):
		zero_page_index = self.memory.read(self.register.PC)
		addr = (zero_page_index + self.register.X) & 0xff
		return addr

	def Mode_ZERO_PAGE_Y(self):
		zero_page_index = self.memory.read(self.register.PC)
		addr = (zero_page_index + self.register.Y) & 0xff
		return addr

	def Mode_ABSOLUTE(self):
		addr_low = self.memory.read(self.register.PC)
		self.inc_pc()
		addr_high = self.memory.read(self.register.PC)
		self.inc_pc()
		return (addr_high << 8) | (addr_low)

	def Mode_ABSOLUTE_X(self):
		addr_low = self.memory.read(self.register.PC)
		self.inc_pc()
		addr_high = self.memory.read(self.register.PC)
		self.inc_pc()
		return ((addr_high << 8) | (addr_low)) + self.register.X

	def Mode_ABSOLUTE_Y(self):
		addr_low = self.memory.read(self.register.PC)
		self.inc_pc()
		addr_high = self.memory.read(self.register.PC)
		self.inc_pc()
		return ((addr_high << 8) | (addr_low)) + self.register.Y

	def Mode_INDIRECT(self):
		addr_low = self.memory.read(self.register.PC)
		self.inc_pc()
		addr_high = self.memory.read(self.register.PC)
		self.inc_pc()
		jmp_addr_low = self.memory.read(((addr_high << 8) | (addr_low)))
		jmp_addr_high = self.memory.read(((addr_high << 8) | (addr_low)) + 1)
		return (jmp_addr_high << 8) | (jmp_addr_low)

	def Mode_INDIRECT_X(self):
		zero_page_index = self.memory.read(self.register.PC)
		self.inc_pc()
		address = (zero_page_index + self.register.X) & 0xff
		jmp_addr_low = self.memory.read(address)
		jmp_addr_high = self.memory.read(address + 1)
		return (jmp_addr_high << 8) | (jmp_addr_low)

	def Mode_INDIRECT_Y(self):
		zero_page_index = self.memory.read(self.register.PC)
		self.inc_pc()
		address = (zero_page_index + self.register.Y) & 0xff
		jmp_addr_low = self.memory.read(address)
		jmp_addr_high = self.memory.read(address + 1)
		return (jmp_addr_high << 8) | (jmp_addr_low)

	def Mode_ACCUMULATOR(self):
		return self.register.A

	def Mode_RELATIVE(self):
		offset = self.memory.read(self.register.PC)
		self.inc_pc()
		if offset >> 7 == 1:
			return -(offset & 0x7f)
		else:
			return offset

	def Mode_IMPLIED(self):
		return 0

	# Determines what addressing mode and function
	# the instruction needs to utilize in execute
	def decode(self, opcode):
		if opcode is ADC_IMMEDIATE:
			return Instruction(IMMEDIATE, ADC)
		elif opcode is ADC_ZERO_PAGE:
			return Instruction(ZERO_PAGE, ADC)
		elif opcode is ADC_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, ADC)
		elif opcode is ADC_ABSOLUTE:
			return Instruction(ABSOLUTE, ADC)
		elif opcode is ADC_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, ADC)
		elif opcode is ADC_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, ADC)
		elif opcode is ADC_INDIRECT_X:
			return Instruction(INDIRECT_X, ADC)
		elif opcode is ADC_INDIRECT_Y:
			return Instruction(INDIRECT_Y, ADC)
		elif opcode is AND_IMMEDIATE:
			return Instruction(IMMEDIATE, AND)
		elif opcode is AND_ZERO_PAGE:
			return Instruction(ZERO_PAGE, AND)
		elif opcode is AND_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, AND)
		elif opcode is AND_ABSOLUTE:
			return Instruction(ABSOLUTE, AND)
		elif opcode is AND_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, AND)
		elif opcode is AND_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, AND)
		elif opcode is AND_INDIRECT_X:
			return Instruction(INDIRECT_X, AND)
		elif opcode is AND_INDIRECT_Y:
			return Instruction(INDIRECT_Y, AND)
		elif opcode is ASL_ACCUM:
			return Instruction(ACCUMULATOR, ASL)
		elif opcode is ASL_ZERO_PAGE:
			return Instruction(ZERO_PAGE, ASL)
		elif opcode is ASL_ZERO_PAGE_X:
			return Instruction(ASL_ZERO_PAGE_X, ASL)
		elif opcode is ASL_ABSOLUTE:
			return Instruction(ABSOLUTE, ASL)
		elif opcode is ASL_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, ASL)
		elif opcode is BIT_ZERO_PAGE:
			return Instruction(ZERO_PAGE, BIT)
		elif opcode is BIT_ABSOLUTE:
			return Instruction(ABSOLUTE, BIT)
		elif opcode is BRANCH_PLUS:
			return Instruction(RELATIVE, BPL)
		elif opcode is BRANCH_MINUS:
			return Instruction(RELATIVE, BMI)
		elif opcode is BRANCH_OVERFLOW_CLEAR:
			return Instruction(RELATIVE, BVC)
		elif opcode is BRANCH_OVERFLOW_SET:
			return Instruction(RELATIVE, BVS)
		elif opcode is BRANCH_CARRY_CLEAR:
			return Instruction(RELATIVE, BCC)
		elif opcode is BRANCH_CARRY_SET:
			return Instruction(RELATIVE, BCS)
		elif opcode is BRANCH_NOT_EQUAL:
			return Instruction(RELATIVE, BNE)
		elif opcode is BRANCH_EQUAL:
			return Instruction(RELATIVE, BEQ)
		elif opcode is BRK_IMPLIED:
			return Instruction(IMPLIED, BRK)
		elif opcode is CMP_ACCUM_IMMEDIATE:
			return Instruction(IMMEDIATE, CMP)
		elif opcode is CMP_ACCUM_ZERO_PAGE:
			return Instruction(ZERO_PAGE, CMP)
		elif opcode is CMP_ACCUM_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, CMP)
		elif opcode is CMP_ACCUM_ABSOLUTE:
			return Instruction(ABSOLUTE, CMP)
		elif opcode is CMP_ACCUM_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, CMP)
		elif opcode is CMP_ACCUM_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, CMP)
		elif opcode is CMP_ACCUM_INDIRECT_X:
			return Instruction(INDIRECT_X, CMP)
		elif opcode is CMP_ACCUM_INDIRECT_Y:
			return Instruction(INDIRECT_Y, CMP)
		elif opcode is CPX_IMMEDIATE:
			return Instruction(IMMEDIATE, CPX)
		elif opcode is CPX_ZERO_PAGE:
			return Instruction(ZERO_PAGE, CPX)
		elif opcode is CPX_ABSOLUTE:
			return Instruction(ABSOLUTE, CPX)
		elif opcode is CPY_IMMEDIATE:
			return Instruction(IMMEDIATE, CPY)
		elif opcode is CPY_ZERO_PAGE:
			return Instruction(ZERO_PAGE, CPY)
		elif opcode is CPY_ABSOLUTE:
			return Instruction(ABSOLUTE, CPY)
		elif opcode is  DEC_ZERO_PAGE:
			return Instruction(ZERO_PAGE, DEC)
		elif opcode is DEC_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, DEC)
		elif opcode is DEC_ABSOLUTE:
			return Instruction(ABSOLUTE, DEC)
		elif opcode is DEC_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, DEC)
		elif opcode is EOR_IMMEDIATE:
			return Instruction(IMMEDIATE, EOR)
		elif opcode is EOR_ZERO_PAGE:
			return Instruction(ZERO_PAGE, EOR)
		elif opcode is EOR_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, EOR)
		elif opcode is EOR_ABSOLUTE:
			return Instruction(ABSOLUTE, EOR)
		elif opcode is EOR_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, EOR)
		elif opcode is EOR_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, EOR)
		elif opcode is EOR_INDIRECT_X:
			return Instruction(INDIRECT_X, EOR)
		elif opcode is EOR_INDIRECT_Y:
			return Instruction(INDIRECT_Y, EOR)
		elif opcode is CLEAR_CARRY:
			return Instruction(IMPLIED, CLC)
		elif opcode is SET_CARRY:
			return Instruction(IMPLIED, SEC)
		elif opcode is CLEAR_INTERRUPT:
			return Instruction(IMPLIED, CLI)
		elif opcode is SET_INTERRUPT:
			return Instruction(IMPLIED, SEI)
		elif opcode is CLEAR_OVERFLOW:
			return Instruction(IMPLIED, CLV)
		elif opcode is CLEAR_DECIMAL:
			return Instruction(IMPLIED, CLD)
		elif opcode is SET_DECIMAL:
			return Instruction(IMMEDIATE, SED)
		elif opcode is INC_ZERO_PAGE:
			return Instruction(ZERO_PAGE, INC)
		elif opcode is INC_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, INC)
		elif opcode is INC_ABSOLUTE:
			return Instruction(ABSOLUTE, INC)
		elif opcode is INC_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, INC)
		elif opcode is JMP_ABSOLUTE:
			return Instruction(ABSOLUTE, JMP)
		elif opcode is JMP_INDIRECT:
			return Instruction(ABSOLUTE, INDIRECT)
		elif opcode is JSR_ABSOLUTE:
			return Instruction(ABSOLUTE, JSR)
		elif opcode is LDA_IMMEDIATE:
			return Instruction(IMMEDIATE, LDA)
		elif opcode is LDA_ZERO_PAGE:
			return Instruction(ZERO_PAGE, LDA)
		elif opcode is LDA_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, LDA)
		elif opcode is LDA_ABSOLUTE:
			return Instruction(ABSOLUTE, LDA)
		elif opcode is LDA_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, LDA)
		elif opcode is LDA_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, LDA)
		elif opcode is LDA_INDIRECT_X:
			return Instruction(LDA_INDIRECT_X, LDA)
		elif opcode is LDA_INDIRECT_Y:
			return Instruction(INDIRECT_Y, LDA)
		elif opcode is LDX_IMMEDIATE:
			return Instruction(IMMEDIATE, LDX)
		elif opcode is LDX_ZERO_PAGE:
			return Instruction(ZERO_PAGE, LDX)
		elif opcode is LDX_ZERO_PAGE_Y:
			return Instruction(ZERO_PAGE_Y, LDX)
		elif opcode is LDX_ABSOLUTE:
			return Instruction(ABSOLUTE, LDX)
		elif opcode is LDX_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, LDX)
		elif opcode is LDY_IMMEDIATE:
			return Instruction(IMMEDIATE, LDY)
		elif opcode is LDY_ZERO_PAGE:
			return Instruction(ZERO_PAGE, LDY)
		elif opcode is LDY_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, LDY)
		elif opcode is LDY_ABSOLUTE:
			return Instruction(ABSOLUTE, LDY)
		elif opcode is LDY_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, LDY)
		elif opcode is LSR_ACCUM:
			return Instruction(ACCUMULATOR, LSR)
		elif opcode is LSR_ZERO_PAGE:
			return Instruction(ZERO_PAGE, LSR)
		elif opcode is LSR_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, LSR)
		elif opcode is LSR_ABSOLUTE:
			return Instruction(ABSOLUTE, LSR)
		elif opcode is LSR_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, LSR)
		elif opcode is NO_OPERATION:
			return Instruction(IMPLIED, NOP)
		elif opcode is ORA_IMMEDIATE:
			return Instruction(IMMEDIATE, ORA)
		elif opcode is ORA_ZERO_PAGE:
			return Instruction(ZERO_PAGE, ORA)
		elif opcode is ORA_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, ORA)
		elif opcode is ORA_ABSOLUTE:
			return Instruction(ABSOLUTE, ORA)
		elif opcode is ORA_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, ORA)
		elif opcode is ORA_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, ORA)
		elif opcode is ORA_INDIRECT_X:
			return Instruction(INDIRECT_X, ORA)
		elif opcode is ORA_INDIRECT_Y:
			return Instruction(INDIRECT_Y, ORA)
		elif opcode is TRANSFER_A_X:
			return Instruction(IMPLIED, TAX)
		elif opcode is TRANSFER_X_A:
			return Instruction(IMPLIED, TXA)
		elif opcode is DECREMENT_X:
			return Instruction(IMPLIED, DEX)
		elif opcode is INCREMENT_X:
			return Instruction(IMPLIED, INX)
		elif opcode is TRANSFER_A_Y:
			return Instruction(IMPLIED, TAY)
		elif opcode is TRANSFER_Y_A:
			return Instruction(IMPLIED, TYA)
		elif opcode is DECREMENT_Y:
			return Instruction(IMPLIED, DEY)
		elif opcode is INCREMENT_Y:
			return Instruction(IMPLIED, INY)
		elif opcode is ROL_ACCUM:
			return Instruction(ACCUMULATOR, ROL)
		elif opcode is ROL_ZERO_PAGE:
			return Instruction(ZERO_PAGE, ROL)
		elif opcode is ROL_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, ROL)
		elif opcode is ROL_ABSOLUTE:
			return Instruction(ABSOLUTE, ROL)
		elif opcode is ROL_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, ROL)
		elif opcode is ROR_ACCUM:
			return Instruction(ACCUMULATOR, ROR)
		elif opcode is ROR_ZERO_PAGE:
			return Instruction(ZERO_PAGE, ROR)
		elif opcode is ROR_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, ROR)
		elif opcode is ROR_ABSOLUTE:
			return Instruction(ABSOLUTE, ROR)
		elif opcode is ROR_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, ROR)
		elif opcode is RET_FROM_INTERRUPT:
			return Instruction(IMPLIED, RTI)
		elif opcode is RET_FROM_SUBROUTINE:
			return Instruction(IMPLIED, RTS)
		elif opcode is SBC_IMMEDIATE:
			return Instruction(IMMEDIATE, SBC)
		elif opcode is SBC_ZERO_PAGE:
			return Instruction(ZERO_PAGE, SBC)
		elif opcode is SBC_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, SBC)
		elif opcode is SBC_ABSOLUTE:
			return Instruction(ABSOLUTE, SBC)
		elif opcode is SBC_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, SBC)
		elif opcode is SBC_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, SBC)
		elif opcode is SBC_INDIRECT_X:
			return Instruction(INDIRECT_X, SBC)
		elif opcode is SBC_INDIRECT_Y:
			return Instruction(INDIRECT_Y, SBC)
		elif opcode is STA_ZERO_PAGE:
			return Instruction(ZERO_PAGE, STA)
		elif opcode is STA_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, STA)
		elif opcode is STA_ABSOLUTE:
			return Instruction(ABSOLUTE, STA)
		elif opcode is STA_ABSOLUTE_X:
			return Instruction(ABSOLUTE_X, STA)
		elif opcode is STA_ABSOLUTE_Y:
			return Instruction(ABSOLUTE_Y, STA)
		elif opcode is STA_INDIRECT_X:
			return Instruction(INDIRECT_X, STA)
		elif opcode is STA_INDIRECT_Y:
			return Instruction(INDIRECT_Y, STA)
		elif opcode is TRANSFER_X_SP:
			return Instruction(IMPLIED, TXS)
		elif opcode is TRANSFER_SP_X:
			return Instruction(IMPLIED, TSX)
		elif opcode is PUSH_ACCUM:
			return Instruction(IMPLIED, PHA)
		elif opcode is PULL_ACCUM:
			return Instruction(IMPLIED, PLA)
		elif opcode is PUSH_PROC_STATUS:
			return Instruction(IMPLIED, PHP)
		elif opcode is PULL_PROC_STATUS:
			return Instruction(IMPLIED, PLP)
		elif opcode is STX_ZERO_PAGE:
			return Instruction(ZERO_PAGE, STX)
		elif opcode is STX_ZERO_PAGE_Y:
			return Instruction(ZERO_PAGE_Y, STX)
		elif opcode is STX_ABSOLUTE:
			return Instruction(ABSOLUTE, STX)
		elif opcode is STY_ZERO_PAGE:
			return Instruction(ZERO_PAGE, STY)
		elif opcode is STY_ZERO_PAGE_X:
			return Instruction(ZERO_PAGE_X, STY)
		elif opcode is STY_ABSOLUTE:
			return Instruction(ABSOLUTE, STY)

memory = Memory()
cpu = CPU(memory)
cpu.load_program()
#cpu.set_pc(0x0)
cpu.program_step()
