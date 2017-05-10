WordConstant = $4000
ByteConstant = %10000000
Const = 127

_CPU:
	.db $80, $A1, $05
	.db %001, %111
	.dw $FF, $a5c4
	.dw %1101111011111010, %1111111100000000
	NOP
	.db $80, %01, <WordConstant + 1, >WordConstant - 5, ByteConstant + 127, Const - 1, $80
	.dw $70, %11, WordConstant, WordConstant + 1, WordConstant - 1, $70
