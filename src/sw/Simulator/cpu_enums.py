#!/usr/bin/env python

# Addressing Modes
IMMEDIATE = 0
ZERO_PAGE = 1
ZERO_PAGE_X = 2
ZERO_PAGE_Y = 3
ABSOLUTE = 4
ABSOLUTE_X = 5
ABSOLUTE_Y = 6
INDIRECT = 7
INDIRECT_X = 8
INDIRECT_Y = 9
IMPLICIT = 10
ACCUMULATOR = 11
RELATIVE = 12	
IMPLIED = 13

ADDR_MODE_STR = [
    'IMMEDIATE',
    'ZERO_PAGE',
    'ZERO_PAGE_X',
    'ZERO_PAGE_Y',
    'ABSOLUTE',
    'ABSOLUTE_X',
    'ABSOLUTE_Y',
    'INDIRECT',
    'INDIRECT_X',
    'INDIRECT_Y',
    'IMPLICIT',
    'ACCUMULATOR',
    'RELATIVE',
    'IMPLIED',
]

# Instruction Type
ADC = 0
AND = 1
ASL = 2
BIT = 3
BRK = 4
CMP = 5
CPX = 6
CPY = 7	
DEC = 8
EOR = 9
INC = 10
JMP = 11	
JSR = 12
LDA = 13
LDX = 14
LDY = 15
LSR = 16
NOP = 17
ROL = 18
ROR = 19
RTI = 20
RTS = 21
SBC = 22
STA = 23
STX = 24
STY = 25
BPL = 26
BMI = 27
BVC = 28
BVS = 29
BCC = 30
BCS = 31
BNE = 32
BEQ = 33
CLC = 34
SEC = 35
CLI = 36
SEI = 37
CLV = 38
CLD = 39
SED = 40
TAX = 41
TXA = 42
DEX = 43
INX = 44
TAY = 45
TYA = 46
DEY = 47
INY = 48
TXS = 49
TSX = 50
PHA = 51
PLA = 52
PHP = 53
PLP = 54

INSTRUCTION_STR = [
    'ADC',
    'AND',
    'ASL',
    'BIT',
    'BRK',
    'CMP',
    'CPX',
    'CPY',	
    'DEC',
    'EOR',
    'INC',
    'JMP',	
    'JSR',
    'LDA',
    'LDX',
    'LDY',
    'LSR',
    'NOP',
    'ROL',
    'ROR',
    'RTI',
    'RTS',
    'SBC',
    'STA',
    'STX',
    'STY',
    'BPL',
    'BMI',
    'BVC',
    'BVS',
    'BCC',
    'BCS',
    'BNE',
    'BEQ',
    'CLC',
    'SEC',
    'CLI',
    'SEI',
    'CLV',
    'CLD',
    'SED',
    'TAX',
    'TXA',
    'DEX',
    'INX',
    'TAY',
    'TYA',
    'DEY',
    'INY',
    'TXS',
    'TSX',
    'PHA',
    'PLA',
    'PHP',
    'PLP',
]
