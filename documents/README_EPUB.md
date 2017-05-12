---
identifier: '73241d50-37d2-4511-ad95-9f270dc53bd7'
language: 'en-US'
title: NES
---

[]{#NES.xhtml}

[FPGA Implementation of the Nintendo Entertainment System (NES)]{.c148 .c220}

[Four People Generating A Nintendo Entertainment System (FPGANES)]{.c162 .c28 .c148 .c205}

[Eric Sullivan, Jonathan Ebert, Patrick Yang, ]{.c162} [Pavan Holla]{.c142}

[]{.c142}

[]{.c142}

[]{.c1}

[]{.c1}

[]{.c1}

[]{.c1}

[]{.c1}

[]{.c1}

[Final Report ]{.c220 .c148}

[]{.c1}

[]{.c1}

[]{.c1}

[]{.c1}

[]{.c1}

[University of Wisconsin-Madison]{.c41 .c92}

[ECE 554]{.c41 .c92}

[Spring 2017]{.c41 .c92}

[]{.c1}

[]{.c148 .c160}

[]{.c138 .c43} {#NES.xhtml#h.azg267tas93b .c23 .c109 .c82}
==============

------------------------------------------------------------------------

[]{.c138 .c43} {#NES.xhtml#h.k888de58riy0 .c23 .c109 .c82}
==============

1.  [Introduction]{} {#NES.xhtml#h.g5jrstas8bb9 style="display:inline"}
    ================

[Following the video game crash in the early 1980s, Nintendo released their first video game console, the Nintendo Entertainment System (NES). Following a slow release and early recalls, the console began to gain momentum in a market that many thought had died out, and the NES is still appreciated by enthusiasts today. A majority of its early success was due to the relationship that Nintendo created with third-party software developers. Nintendo required that restricted developers from publishing games without a license distributed by Nintendo. This decision led to higher quality games and helped to sway the public opinion on video games, which had been plagued by poor games for other gaming consoles. ]{.c41 .c28}

[Our motivation is to better understand how the NES worked from a hardware perspective, as the NES was an extremely advanced console when it was released in 1985 (USA). The NES has been recreated multiple times in software emulators, but has rarely been done in a hardware design language, which makes this a unique project.  Nintendo chose to use the 6502 processor, also used by Apple in the Apple II, and chose to include a picture processing unit to provide a memory efficient way to output video to the TV. Our goal was to recreate the CPU and PPU in hardware, so that we could run games that were run on the original console. In order to exactly recreate the original console, we needed to include memory mappers, an audio processing unit, a DMA unit, a VGA interface, and a way to use a controller for input. In addition, we wrote our own assembler and tic-tac-toe game to test our implementation.   The following sections will explain the microarchitecture of the NES. Much of the information was gleaned from nesdev.com, and from other online forums that reverse engineered the NES.]{.c41 .c28}

[]{.c41 .c28}

[]{.c41 .c28}

[]{.c41 .c28}

[]{.c41 .c28}

[]{.c41 .c28}

[]{.c28 .c41}

[]{.c41 .c28}

[]{.c41 .c28}

[]{.c41 .c28}

2.  [Top Level Block Diagram]{.c43 .c138} {#NES.xhtml#h.1ayvkhk4vvmg style="display:inline"}
    =====================================

<!-- -->

1.  [Top level description]{.c42} {#NES.xhtml#h.8r6j63kwrjxl style="display:inline"}
    -----------------------------

[Here is an overview of each module in our design. Our report has a section dedicated for each of these modules.]{.c1}

1.  [PPU - The PPU(Picture Processing Unit) is responsible for rendering graphics on screen. It receives memory mapped accesses from the CPU, and renders graphics from memory, providing RGB values.]{.c1}
2.  [CPU - Our CPU is a 6502 implementation. It is responsible for controlling all other modules in the NES. At boot, CPU starts reading programs at the address 0xFFFC.]{.c1}
3.  [DMA - The DMA transfers chunks of data from CPU address space to PPU address space. It is faster than performing repeated Loads and Stores in the CPU.]{.c1}
4.  [Display Memory and VGA - The PPU writes to the display memory, which is subsequently read out by the VGA module. The VGA module produces the hsync, vsync and RGB values that a monitor requires.]{.c1}
5.  [Controller - A program runs on a host computer which transfers serial data to the FPGA. The protocol used by the controller is UART in our case]{.c1}
6.  [APU - Generates audio in the NES. However, we did not implement this module.]{.c1}
7.  [CHAR RAM/ RAM - Used by the CPU and PPU to store temporary data]{.c1}
8.  [PROG ROM/ CHAR ROM - PROG ROM contains the software(instructions) that runs the game. CHAR ROM on the other hand contains mostly image data and graphics used in the game.]{.c1}

<!-- -->

2.  [Data Flow Diagram]{.c42} {#NES.xhtml#h.a9ilbl8rkgkd style="display:inline"}
    -------------------------

[ ![](images/image3.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 611.00px; height: 296.00px;"}

[Figure 1: System level data flow diagram]{.c26}

3.  [ Control Flow Diagram]{.c42} {#NES.xhtml#h.m6jcsadip56s style="display:inline"}
    -----------------------------

[ ![](images/image2.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 356.00px;"}

[Figure 2: System level control flow diagram.]{.c26}

3.  [CPU]{.c138 .c43} {#NES.xhtml#h.rdm0fxe7s5y9 style="display:inline"}
    =================

[CPU Registers]{.c42} {#NES.xhtml#h.eftj2rjo9s1h .c0}
---------------------

[The CPU of the NES is the MOS 6502. It is an  accumulator plus index register machine. There are five primary registers on which operations are performed: ]{.c1}

1.  [PC : Program Counter]{.c1}
2.  [Accumulator(A) : Keeps track of results from ALU]{.c1}
3.  [X : X index register]{.c1}
4.  [Y  : Y index register]{.c1}
5.  [Stack pointer]{.c1}
6.  [Status Register : Negative, Overflow, Unused, Break, Decimal, Interrupt, Zero, Carry]{.c1}

-   [Break means that the current interrupt is from software interrupt, BRK]{.c1}
-   [Interrupt is high when maskable interrupts (IRQ) is to be ignored. Non-maskable interrupts (NMI) cannot be ignored.]{.c1}

[There are 6 secondary registers:]{.c1}

1.  [AD : Address Register]{.c1}

-   [Stores where to jump to or where to get indirect access from.]{.c1}

2.  [ADV : AD Value Register]{.c1}

-   [Stores the value from indirect access by AD.]{.c1}

3.  [BA : Base Address Register]{.c1}

-   [Stores the base address before index calculation. After the calculation, the value is transferred to AD if needed.]{.c1}

4.  [BAV : BA Value Register]{.c1}

-   [Stores the value from indirect access by BA.]{.c1}

5.  [IMM : Immediate Register]{.c1}

-   [Stores the immediate value from the memory.]{.c1}

6.  [Offset]{.c1}

-   [Stores the offset value of branch from memory]{.c1}

[CPU ISA]{.c42} {#NES.xhtml#h.wvvuysbh6ili .c0}
---------------

[The ISA may be classified into a few broad operations: ]{.c1}

-   [Load into A,X,Y registers from memory]{.c1}
-   [Perform arithmetic operation on A,X or Y]{.c1}
-   [Move data from one register to another]{.c1}
-   [Program control instructions like Jump and Branch]{.c1}
-   [Stack operations]{.c1}
-   [Complex instructions that read, modify and write back memory.]{.c1}

[CPU Addressing Modes]{.c42} {#NES.xhtml#h.9ie72e7qdon7 .c0}
----------------------------

[Additionally, there are thirteen addressing modes which these operations can use. They are]{.c1}

-   [Accumulator]{.c43} [ – The data in the accumulator is used. ]{.c1}
-   [Immediate]{.c43} [ - The byte in memory immediately following the instruction is used. ]{.c1}
-   [Zero Page]{.c43} [ – The Nth byte in the first page of RAM is used where N is the byte in memory immediately following the instruction. ]{.c1}
-   [Zero Page, X Index]{.c43} [ – The (N+X)th byte in the first page of RAM is used where N is the byte in memory immediately following the instruction and X is the contents of the X index register.]{.c1}
-   [Zero Page, Y Index]{.c43} [ – Same as above but with the Y index register ]{.c1}
-   [Absolute]{.c43} [ – The two bytes in memory following the instruction specify the absolute address of the byte of data to be used. ]{.c1}
-   [Absolute, X Index]{.c43} [ - The two bytes in memory following the instruction specify the base address. The contents of the X index register are then added to the base address to obtain the address of the byte of data to be used. ]{.c1}
-   [Absolute, Y Index]{.c43} [ – Same as above but with the Y index register ]{.c1}
-   [Implied]{.c43} [ – Data is either not needed or the location of the data is implied by the instruction. ]{.c1}
-   [Relative]{.c43} [ – The content of  sum of (the program counter and the byte in memory immediately following the instruction) is used. ]{.c1}
-   [Absolute Indirect]{.c43} [ - The two bytes in memory following the instruction specify the absolute address of the two bytes that contain the absolute address of the byte of data to be used.]{.c1}
-   [(Indirect, X)]{.c43} [ – A combination of Indirect Addressing and Indexed Addressing ]{.c1}
-   [(Indirect), Y]{.c43} [ - A combination of Indirect Addressing and Indexed Addressing]{.c1}

[CPU Interrupts]{.c42} {#NES.xhtml#h.b7loafaij831 .c0}
----------------------

[The 6502 supports three interrupts. The reset interrupt routine is called after a physical reset. The other two interrupts are the non\_maskable\_interrupt(NMI) and the general\_interrupt(IRQ). The general\_interrupt can be disabled by software whereas the others cannot. When interrupt occurs, the CPU finishes the current instruction then PC jumps to the specified interrupt vector then return when finished.  ]{.c1}

[CPU Opcode Matrix]{.c42} {#NES.xhtml#h.q77927r8c49e .c0}
-------------------------

[The NES 6502 ISA is a CISC like ISA with 56 instructions. These 56 instructions can pair up with addressing modes to form various opcodes. The opcode is always 8 bits, however based on the addressing mode, upto 4 more memory location may need to be fetched.The memory is single cycle, i.e data\[7:0\] can be latched the cycle after address\[15:0\] is placed on the bus. The following tables summarize the instructions available and possible addressing modes:]{.c1}

[]{#NES.xhtml#t.3cc61c11f8dce03b7ca8770afc1862c11a71fc7e} []{#NES.xhtml#t.0}

<table class="c133">
<tbody>
<tr class="c6">
<td class="c88" colspan="2" rowspan="1">
[Storage]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[LDA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Load A with M]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[LDX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Load X with M]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[LDY]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Load Y with M]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[STA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Store A in M]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[STX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Store X in M]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[STY]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Store Y in M]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[TAX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Transfer A to X]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[TAY]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Transfer A to Y]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[TSX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Transfer Stack Pointer to X]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[TXA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Transfer X to A]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[TXS]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Transfer X to Stack Pointer]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[TYA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Transfer Y to A]{.c1}

</td>
</tr>
<tr class="c207">
<td class="c88" colspan="2" rowspan="1">
[Arithmetic]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[ADC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Add M to A with Carry]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[DEC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Decrement M by One]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[DEX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Decrement X by One]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[DEY]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Decrement Y by One]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[INC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Increment M by One]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[INX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Increment X by One]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[INY]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Increment Y by One]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[SBC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Subtract M from A with Borrow]{.c1}

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
[Bitwise]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[AND]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[AND M with A]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[ASL]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Shift Left One Bit (M or A)]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BIT]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Test Bits in M with A]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[EOR]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Exclusive-Or M with A]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[LSR]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Shift Right One Bit (M or A)]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[ORA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[OR M with A]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[ROL]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Rotate One Bit Left (M or A)]{.c1}

</td>
</tr>
<tr class="c197">
<td class="c4" colspan="1" rowspan="1">
[ROR]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Rotate One Bit Right (M or A)]{.c1}

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
[Branch]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BCC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Carry Clear]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BCS]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Carry Set]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BEQ]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Result Zero]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BMI]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Result Minus]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BNE]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Result not Zero]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BPL]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Result Plus]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BVC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Overflow Clear]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BVS]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Branch on Overflow Set]{.c1}

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
[Jump]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[JMP]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Jump to Location]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[JSR]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Jump to Location Save Return Address]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[RTI]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Return from Interrupt]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[RTS]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Return from Subroutine]{.c1}

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
[Status Flags]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CLC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Clear Carry Flag]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CLD]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Clear Decimal Mode]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CLI]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Clear interrupt Disable Bit]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CLV]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Clear Overflow Flag]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CMP]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Compare M and A]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CPX]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Compare M and X]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[CPY]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Compare M and Y]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[SEC]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Set Carry Flag]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[SED]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Set Decimal Mode]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[SEI]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Set Interrupt Disable Status]{.c1}

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
[Stack]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[PHA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Push A on Stack]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[PHP]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Push Processor Status on Stack]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[PLA]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Pull A from Stack]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[PLP]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Pull Processor Status from Stack]{.c1}

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
[System]{.c36}

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
[BRK]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[Force Break]{.c1}

</td>
</tr>
<tr class="c189">
<td class="c4" colspan="1" rowspan="1">
[NOP]{.c1}

</td>
<td class="c27" colspan="1" rowspan="1">
[No Operation]{.c1}

</td>
</tr>
</tbody>
</table>
[]{.c1}

[The specific opcode hex values are specified in the Assembler section.]{}

[For more information on the opcodes, please refer]{.c1}

[ [http://www.6502.org/tutorials/6502opcodes.html](https://www.google.com/url?q=http://www.6502.org/tutorials/6502opcodes.html&sa=D&ust=1494576254773000&usg=AFQjCNGzykU5lYlwzhVf-ANYhhU9ZHx0NQ){.c40} ]{.c157}

[or ]{.c1}

[ [http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502\_Opcodes](https://www.google.com/url?q=http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502_Opcodes&sa=D&ust=1494576254776000&usg=AFQjCNE52nGakb-WzPTtZ-rC2JNJyirs9A){.c40} ]{.c157}

[CPU Block Diagram]{} [ ![](images/image1.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 389.33px;"} {#NES.xhtml#h.ki2ushz1f0a3 .c0}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

[]{.c1}

[]{#NES.xhtml#t.3b03df5ff635ab55210457ca4172a1dbb6594ce9} []{#NES.xhtml#t.1}

+-----------------------------------+-----------------------------------+
| [Block]{.c36}                     | [Primary Function]{.c36}          |
+-----------------------------------+-----------------------------------+
| [Decode]{.c1}                     | [Decode the current instruction.  |
|                                   | Classifies the opcode into an     |
|                                   | instruction\_type(arithmetic,ld   |
|                                   | etc) and addressing               |
|                                   | mode(immediate, indirect          |
|                                   | etc)]{.c1}                        |
+-----------------------------------+-----------------------------------+
| [Processor Control]{.c1}          | [State machine that keeps track   |
|                                   | of current instruction stage, and |
|                                   | generates signals to load         |
|                                   | registers.]{.c1}                  |
+-----------------------------------+-----------------------------------+
| [ALU]{.c1}                        | [Performs ALU ops and handles     |
|                                   | Status Flags]{.c1}                |
+-----------------------------------+-----------------------------------+
| [Registers]{.c1}                  | [Contains all registers. Register |
|                                   | values change according to        |
|                                   | signals from processor            |
|                                   | control.]{.c1}                    |
+-----------------------------------+-----------------------------------+
| [Mem]{.c1}                        | [Acts as the interface between    |
|                                   | CPU and memory. Mem block thinks  |
|                                   | it’s communicating with the       |
|                                   | memory but the DMA can reroute    |
|                                   | the communication to any other    |
|                                   | blocks like PPU, controller]{.c1} |
+-----------------------------------+-----------------------------------+

[]{.c36}

[Instruction flow]{.c36}

[The following table presents a high level overview of how each instruction is handled.]{.c1}

[]{#NES.xhtml#t.c34310f1171abde1363919ba55d0bbfe4c032809} []{#NES.xhtml#t.2}

+-----------------------+-----------------------+-----------------------+
| [Cycle Number]{.c36}  | [Blocks ]{.c36}       | [Action]{.c36}        |
+-----------------------+-----------------------+-----------------------+
| [0]{.c1}              | [Processor Control →  | [Instruction Fetch    |
|                       | Registers]{.c1}       | ]{.c1}                |
+-----------------------+-----------------------+-----------------------+
| [1]{.c1}              | [Register →           | [Classify instruction |
|                       |  Decode]{.c1}         | and addressing        |
|                       |                       | mode]{.c1}            |
+-----------------------+-----------------------+-----------------------+
| [1]{.c1}              | [Decode → Processor   | [Init state machine   |
|                       | Control]{.c1}         | for instruction type  |
|                       |                       | and addressing        |
|                       |                       | mode]{.c1}            |
+-----------------------+-----------------------+-----------------------+
| [2-6]{.c1}            | [Processor Control →  | [Populate scratch     |
|                       | Registers]{.c1}       | registers based on    |
|                       |                       | addressing            |
|                       |                       | mode.]{.c1}           |
+-----------------------+-----------------------+-----------------------+
| [Last Cycle]{.c1}     | [Processor Control →  | [Execute]{.c1}        |
|                       | ALU]{.c1}             |                       |
+-----------------------+-----------------------+-----------------------+
| [Last Cycle]{.c1}     | [Processor Control →  | [Instruction          |
|                       | Registers]{.c1}       | Fetch]{.c1}           |
+-----------------------+-----------------------+-----------------------+

[]{.c36}

[State Machines]{.c36}

[Each {instruction\_type, addressing\_mode} triggers its own state machine. In brief, this state machine is responsible for signalling the Registers module to load/store addresses from memory or from the ALU. ]{.c1}

[State machine spec for each instruction type and addressing mode can be found at ]{} [ [https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-\_sEox-QsTjJSlt06lE/edit?usp=sharing](https://www.google.com/url?q=https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-_sEox-QsTjJSlt06lE/edit?usp%3Dsharing&sa=D&ust=1494576254814000&usg=AFQjCNGca0yi6hqlKxIn-yYgAP_Xxx_mvQ){.c40} ]{.c157 .c28 .c117}

[Considering one of the simplest instructions ADC immediate,which takes two cycles, the state machine is as follows:]{.c1}

[Instruction\_type=ARITHMETIC, addressing mode= IMMEDIATE]{}

[]{#NES.xhtml#t.986d78169f9d35d012fa7f117a4e53d6949bf356} []{#NES.xhtml#t.3}

+-----------------------+-----------------------+-----------------------+
| [state=0]{.c1}        | [state=1]{.c1}        | [state=2]{.c1}        |
+-----------------------+-----------------------+-----------------------+
| [ld\_sel=LD\_INSTR;   | [ld\_sel=LD\_IMM;]{.c | [alu\_ctrl=DO\_OP\_AD |
| //instr=              | 1}                    | C                     |
| memory\_data]{.c1}    |                       | // execute]{.c1}      |
|                       | [//imm=memory\_data]{ |                       |
| [pc\_sel=INC\_PC;     | .c1}                  | [src1\_sel=SRC1\_A]{. |
| //pc++]{.c1}          |                       | c1}                   |
|                       | [pc\_sel=INC\_PC]{.c1 |                       |
| [next\_state=state+1’ | }                     | [src2\_sel=SRC2\_IMM] |
| b1]{.c1}              |                       | {.c1}                 |
|                       | [next\_state=state+1’ |                       |
| []{.c1}               | b1]{.c1}              | [dest\_sel=DEST\_A]{. |
|                       |                       | c1}                   |
| []{.c1}               |                       |                       |
|                       |                       | [ld\_sel=LD\_INSTR//f |
|                       |                       | etch                  |
|                       |                       | next                  |
|                       |                       | instruction]{.c1}     |
|                       |                       |                       |
|                       |                       | [pc\_sel=INC\_PC]{.c1 |
|                       |                       | }                     |
|                       |                       |                       |
|                       |                       | [next\_state=1’b1]{.c |
|                       |                       | 1}                    |
+-----------------------+-----------------------+-----------------------+

[]{.c1}

[All instructions are classified into one of 55 state machines in the cpu specification sheet. The 6502 can take variable time for a single instructions based on certain conditions(page\_cross, branch\_taken etc). These corner case state transitions are also taken care of by processor control.]{.c1}

[CPU ]{} [Top Level Interface]{.c42} {#NES.xhtml#h.er7yq56tef4v .c0}
------------------------------------

[]{#NES.xhtml#t.ec6e0cf4837ca798f6158bba27f8906dd57ddbdb} []{#NES.xhtml#t.4}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst]{.c1}      | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | high            |
|                 |                 |                 | reset]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [nmi]{.c1}      | [input]{.c1}    | [PPU]{.c1}      | [Non maskable   |
|                 |                 |                 | interrupt from  |
|                 |                 |                 | PPU. Executes   |
|                 |                 |                 | BRK instruction |
|                 |                 |                 | in CPU]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [addr\[15:0\]]{ | [output]{.c1}   | [RAM]{.c1}      | [Address for    |
| .c1}            |                 |                 | R/W issued by   |
|                 |                 |                 | CPU]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [dout\[7:0\]]{. | [input/]{.c1}   | [RAM]{.c1}      | [Data from the  |
| c1}             |                 |                 | RAM in case of  |
|                 | [output]{.c1}   |                 | reads and and   |
|                 |                 |                 | to the RAM in   |
|                 |                 |                 | case of         |
|                 |                 |                 | writes]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [memory\_read]{ | [output]{.c1}   | [RAM]{.c1}      | [read enable    |
| .c1}            |                 |                 | signal for      |
|                 |                 |                 | RAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [memory\_write] | [output]{.c1}   | [RAM]{.c1}      | [write enable   |
| {.c1}           |                 |                 | signal for      |
|                 |                 |                 | RAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[CPU Instruction Decode Interface]{.c42} {#NES.xhtml#h.lomim8yvajg6 .c0}
----------------------------------------

[The decode module is responsible for classifying the instruction into one of the addressing modes and an instruction type. It also generates the signal that the ALU would eventually use if the instruction passed through the ALU.        ]{.c1}

[]{#NES.xhtml#t.f13182f9d70c3545bc3d4e1c8077ef6922fd108a} []{#NES.xhtml#t.5}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [instruction\_r | [input]{.c1}    | [Registers]{.c1 | [Opcode of the  |
| egister]{.c1}   |                 | }               | current         |
|                 |                 |                 | instruction]{.c |
|                 |                 |                 | 1}              |
+-----------------+-----------------+-----------------+-----------------+
| [nmi]{.c1}      | [input]{.c1}    | [cpu\_top]{.c1} | [Non maskable   |
|                 |                 |                 | interrupt from  |
|                 |                 |                 | PPU. Executes   |
|                 |                 |                 | BRK instruction |
|                 |                 |                 | in CPU]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [instruction\_t | [output]{.c1}   | [Processor      | [Type of        |
| ype]{.c1}       |                 | Control]{.c1}   | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | ITYPE.]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [addressing\_mo | [output]{.c1}   | [Processor      | [Addressing     |
| de]{.c1}        |                 | Control]{.c1}   | mode of the     |
|                 |                 |                 | opcode in       |
|                 |                 |                 | instruction\_re |
|                 |                 |                 | gister.         |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | AMODE.]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_sel]{.c1} | [output]{.c1}   | [ALU]{.c1}      | [ALU operation  |
|                 |                 |                 | expected to be  |
|                 |                 |                 | performed by    |
|                 |                 |                 | the opcode,     |
|                 |                 |                 | eventually.     |
|                 |                 |                 | Processor       |
|                 |                 |                 | control chooses |
|                 |                 |                 | to use it at a  |
|                 |                 |                 | cycle           |
|                 |                 |                 | appropriate for |
|                 |                 |                 | the             |
|                 |                 |                 | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | DO\_OP.]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[CPU MEM Interface]{.c42} {#NES.xhtml#h.b3lc7rd7ackr .c0}
-------------------------

[The MEM module is the interface between memory and CPU. It provides appropriate address and read/write signal for the memory. Controlled by the select signals]{.c1}

[]{#NES.xhtml#t.60770ee16f74d493ac822410188b75f9a14e434b} []{#NES.xhtml#t.6}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [addr\_sel]{.c1 | [input]{.c1}    | [Processor      | [Selects which  |
| }               |                 | Control]{.c1}   | input to use as |
|                 |                 |                 | address to      |
|                 |                 |                 | memory. Enum of |
|                 |                 |                 | ADDR]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [int\_sel]{.c1} | [input]{.c1}    | [Processor      | [Selects which  |
|                 |                 | Control]{.c1}   | interrupt       |
|                 |                 |                 | address to jump |
|                 |                 |                 | to. Enum of     |
|                 |                 |                 | INT\_TYPE]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [ld\_sel,st\_se | [input]{.c1}    | [Processor      | [Decides        |
| l]{.c1}         |                 | Control]{.c1}   | whether to read |
|                 |                 |                 | or write based  |
|                 |                 |                 | on these        |
|                 |                 |                 | signals]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [ad, ba, sp,    | [input]{.c1}    | [Registers]{.c1 | [Registers that |
| irql, irqh,     |                 | }               | are candidates  |
| pc]{.c1}        |                 |                 | of the          |
|                 |                 |                 | address]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c1}     | [output]{.c1}   | [Memory]{.c1}   | [Address of the |
|                 |                 |                 | memory to       |
|                 |                 |                 | read/write]{.c1 |
|                 |                 |                 | }               |
+-----------------+-----------------+-----------------+-----------------+
| [read,write]{.c | [output]{.c1}   | [Memory]{.c1}   | [Selects        |
| 1}              |                 |                 | whether Memory  |
|                 |                 |                 | should read or  |
|                 |                 |                 | write]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[CPU ALU Interface]{.c42} {#NES.xhtml#h.nexle64nrxxq .c0}
-------------------------

[Performs arithmetic, logical operations and operations that involve status registers.]{.c1}

[]{#NES.xhtml#t.74d7ae3809789a7579d3dd984c8cb1e6937f5c5b} []{#NES.xhtml#t.7}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [in1, in2]{.c1} | [input]{.c1}    | [ALU Input      | [Inputs to the  |
|                 |                 | Selector]{.c1}  | ALU operations  |
|                 |                 |                 | selected by ALU |
|                 |                 |                 | Input           |
|                 |                 |                 | module.]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_sel]{.c1} | [input]{.c1}    | [Processor      | [ALU operation  |
|                 |                 | Control]{.c1}   | expected to be  |
|                 |                 |                 | performed by    |
|                 |                 |                 | the opcode,     |
|                 |                 |                 | eventually.     |
|                 |                 |                 | Processor       |
|                 |                 |                 | control chooses |
|                 |                 |                 | to use it at a  |
|                 |                 |                 | cycle           |
|                 |                 |                 | appropriate for |
|                 |                 |                 | the             |
|                 |                 |                 | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | DO\_OP.]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [clk, rst]{.c1} | [input]{.c1}    | []{.c1}         | [System clock   |
|                 |                 |                 | and active high |
|                 |                 |                 | reset]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [out]{.c1}      | [output]{.c1}   | [to all         | [Output of ALU  |
|                 |                 | registers]{.c1} | operation. sent |
|                 |                 |                 | to all          |
|                 |                 |                 | registers and   |
|                 |                 |                 | registers       |
|                 |                 |                 | decide whether  |
|                 |                 |                 | to receive it   |
|                 |                 |                 | or ignore it as |
|                 |                 |                 | its next        |
|                 |                 |                 | value.]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [n, z, v, c, b, | [output]{.c1}   | []{.c1}         | [Status         |
| d, i]{.c1}      |                 |                 | Register]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

### [ALU Input Selector]{.c85 .c43} {#NES.xhtml#h.sprgfm6rx38x .c0}

[Selects the input1 and input2 for the ALU]{.c1}

[]{#NES.xhtml#t.962a520a35f5a47f155664eb3cba694a0b1b6dba} []{#NES.xhtml#t.8}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [src1\_sel,     | [input]{.c1}    | [Processor      | [Control signal |
| src2\_sel]{.c1} |                 | Control]{.c1}   | that determines |
|                 |                 |                 | which sources   |
|                 |                 |                 | to take in as   |
|                 |                 |                 | inputs to ALU   |
|                 |                 |                 | according to    |
|                 |                 |                 | the instruction |
|                 |                 |                 | and addressing  |
|                 |                 |                 | mode]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [a, bal, bah,   | [input]{.c1}    | [Registers]{.c1 | [Registers that |
| adl, pcl, pch,  |                 | }               | are candidates  |
| imm, adv, x,    |                 |                 | to the input to |
| bav, y,         |                 |                 | ALU]{.c1}       |
| offset]{.c1}    |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [temp\_status]{ | [input]{.c1}    | [ALU]{.c1}      | [Sometimes      |
| .c1}            |                 |                 | status          |
|                 |                 |                 | information is  |
|                 |                 |                 | required but we |
|                 |                 |                 | don’t want it   |
|                 |                 |                 | to affect the   |
|                 |                 |                 | status          |
|                 |                 |                 | register. So we |
|                 |                 |                 | directly        |
|                 |                 |                 | receive         |
|                 |                 |                 | temp\_status    |
|                 |                 |                 | value from      |
|                 |                 |                 | ALU]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [in1, in2]{.c1} | [output]{.c1}   | [ALU]{.c1}      | [Selected input |
|                 |                 |                 | for the         |
|                 |                 |                 | ALU]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+

[CPU Registers Interface]{.c42} {#NES.xhtml#h.5httww8vnv8g .c0}
-------------------------------

[Holds all of the registers]{.c1}

[]{#NES.xhtml#t.35d129561daa24a66b47c8945cde454ce8f2506d} []{#NES.xhtml#t.9}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk, rst]{.c1} | [input]{.c1}    | []{.c1}         | [System clk and |
|                 |                 |                 | rst]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [dest\_sel,     | [input]{.c1}    | [Processor      | [Selects which  |
| pc\_sel,        |                 | Control]{.c1}   | input to accept |
| sp\_sel,        |                 |                 | as new input.   |
| ld\_sel,        |                 |                 | enum of DEST,   |
| st\_sel]{.c1}   |                 |                 | PC, SP, LD,     |
|                 |                 |                 | ST]{.c1}        |
+-----------------+-----------------+-----------------+-----------------+
| [clr\_adh,      | [input]{.c1}    | [Processor      | [Clears the     |
| clr\_bah]{.c1}  |                 | Control]{.c1}   | high byte of    |
|                 |                 |                 | ad, ba]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_out,      | [input]{.c1}    | [ALU]{.c1}      | [Output from    |
| next\_status]{. |                 |                 | ALU and next    |
| c1}             |                 |                 | status value.   |
|                 |                 |                 | alu\_out can be |
|                 |                 |                 | written to most |
|                 |                 |                 | of the          |
|                 |                 |                 | registers]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [data]{.c1}     | [inout]{.c1}    | [Memory]{.c1}   | [Datapath to    |
|                 |                 |                 | Memory. Either  |
|                 |                 |                 | receives or     |
|                 |                 |                 | sends data      |
|                 |                 |                 | according to    |
|                 |                 |                 | ld\_sel and     |
|                 |                 |                 | st\_sel.]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [a, x, y, ir,   | [output]{.c1}   | []{.c1}         | [Register       |
| imm, adv, bav,  |                 |                 | outputs that    |
| offset, sp, pc, |                 |                 | can be used by  |
| ad, ba, n, z,   |                 |                 | different       |
| v, c, b, d, i,  |                 |                 | modules]{.c1}   |
| status]{.c1}    |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+

[CPU Processor Control Interface]{.c42} {#NES.xhtml#h.eiifcf5tv1l9 .c0}
---------------------------------------

[The processor control module maintains the current state that the instruction is in and decides the control signals for the next state. Once the instruction type and addressing modes are decoded, the processor control block becomes aware of the number of cycles the instruction will take. Thereafter, at each clock cycle it generates the required control signals.]{.c1}

[]{#NES.xhtml#t.b393916cb565d703d6fe7f4dbd36fb92b6b7db96} []{#NES.xhtml#t.10}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [instruction\_t | [input]{.c1}    | [Decode]{.c1}   | [Type of        |
| ype]{.c1}       |                 |                 | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | ITYPE.]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [addressing\_mo | [input]{.c1}    | [Decode]{.c1}   | [Addressing     |
| de]{.c1}        |                 |                 | mode of the     |
|                 |                 |                 | opcode in       |
|                 |                 |                 | instruction\_re |
|                 |                 |                 | gister.         |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | AMODE.]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_ctrl]{.c1 | [input]{.c1}    | [Decode]{.c1}   | [ALU operation  |
| }               |                 |                 | expected to be  |
|                 |                 |                 | performed by    |
|                 |                 |                 | the opcode,     |
|                 |                 |                 | eventually.     |
|                 |                 |                 | Processor       |
|                 |                 |                 | control chooses |
|                 |                 |                 | to use it at a  |
|                 |                 |                 | cycle           |
|                 |                 |                 | appropriate for |
|                 |                 |                 | the             |
|                 |                 |                 | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | DO\_OP.]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [reset\_adh]{.c | [output]{.c1}   | [Registers]{.c1 | [Resets ADH     |
| 1}              |                 | }               | register]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [reset\_bah]{.c | [output]{.c1}   | [Registers]{.c1 | [Resets BAH     |
| 1}              |                 | }               | register]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [set\_b]{.c1}   | [output]{.c1}   | [Registers]{.c1 | [Sets the B     |
|                 |                 | }               | flag]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [addr\_sel]{.c1 | [output]{.c1}   | [Registers]{.c1 | [Selects the    |
| }               |                 | }               | value that      |
|                 |                 |                 | needs to be set |
|                 |                 |                 | on the address  |
|                 |                 |                 | bus. Belongs to |
|                 |                 |                 | enum ADDR]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_sel]{.c1} | [output]{.c1}   | [ALU]{.c1}      | [Selects the    |
|                 |                 |                 | operation to be |
|                 |                 |                 | performed by    |
|                 |                 |                 | the ALU in the  |
|                 |                 |                 | current cycle.  |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | DO\_OP]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [dest\_sel]{.c1 | [output]{.c1}   | [Registers]{.c1 | [Selects the    |
| }               |                 | }               | register that   |
|                 |                 |                 | receives the    |
|                 |                 |                 | value from ALU  |
|                 |                 |                 | output.Belongs  |
|                 |                 |                 | to enum         |
|                 |                 |                 | DEST]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [ld\_sel]{.c1}  | [output]{.c1}   | [Registers]{.c1 | [Selects the    |
|                 |                 | }               | register that   |
|                 |                 |                 | will receive    |
|                 |                 |                 | the value from  |
|                 |                 |                 | Memory Bus.     |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | LD]{.c1}        |
+-----------------+-----------------+-----------------+-----------------+
| [pc\_sel]{.c1}  | [output]{.c1}   | [Registers]{.c1 | [Selects the    |
|                 |                 | }               | value that the  |
|                 |                 |                 | PC will take    |
|                 |                 |                 | next cycle.     |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | PC]{.c1}        |
+-----------------+-----------------+-----------------+-----------------+
| [sp\_sel]{.c1}  | [output]{.c1}   | [Registers]{.c1 | [Selects the    |
|                 |                 | }               | value that the  |
|                 |                 |                 | SP  will take   |
|                 |                 |                 | next cycle.     |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | SP]{.c1}        |
+-----------------+-----------------+-----------------+-----------------+
| [src1\_sel]{.c1 | [output]{.c1}   | [ALU]{.c1}      | [Selects src1   |
| }               |                 |                 | for ALU.        |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | SRC1]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [src2\_sel]{.c1 | [output]{.c1}   | [ALU]{.c1}      | [Selects src2   |
| }               |                 |                 | for ALU.        |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | SRC2]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [st\_sel]{.c1}  | [output]{.c1}   | [Registers]{.c1 | [Selects the    |
|                 |                 | }               | register whose  |
|                 |                 |                 | value will be   |
|                 |                 |                 | placed on dout. |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | ST]{.c1}        |
+-----------------+-----------------+-----------------+-----------------+

[CPU Enums]{.c42} {#NES.xhtml#h.3on9q42bqgrx .c0}
-----------------

[]{#NES.xhtml#t.d41042ffa22f98544df79c723d4fbbb413491765} []{#NES.xhtml#t.11}

+-----------------------------------+-----------------------------------+
| [Enum name]{.c9}                  | [Legal Values]{.c9}               |
+-----------------------------------+-----------------------------------+
| [ITYPE]{.c1}                      | [ARITHMETIC,BRANCH,BREAK,CMPLDX,C |
|                                   | MPLDY,INTERRUPT,JSR,JUMP,OTHER,PU |
|                                   | LL,PUSH,RMW,RTI,RTS,STA,STX,STY]{ |
|                                   | .c1}                              |
+-----------------------------------+-----------------------------------+
| [AMODE]{.c1}                      | [ABSOLUTE,ABSOLUTE\_INDEX,ABSOLUT |
|                                   | E\_INDEX\_Y,ACCUMULATOR,IMMEDIATE |
|                                   | ,IMPLIED,INDIRECT,INDIRECT\_X,IND |
|                                   | IRECT\_Y,RELATIVE,SPECIAL,ZEROPAG |
|                                   | E,ZEROPAGE\_INDEX,ZEROPAGE\_INDEX |
|                                   | \_Y]{.c1}                         |
+-----------------------------------+-----------------------------------+
| [DO\_OP]{.c1}                     | [DO\_OP\_ADD,DO\_OP\_SUB,DO\_OP\_ |
|                                   | AND,DO\_OP\_OR,DO\_OP\_XOR,DO\_OP |
|                                   | \_ASL,DO\_OP\_LSR,DO\_OP\_ROL,DO\ |
|                                   | _OP\_ROR,DO\_OP\_SRC2DO\_OP\_CLR\ |
|                                   | _C,DO\_OP\_CLR\_I,DO\_OP\_CLR\_V, |
|                                   | DO\_OP\_SET\_C,DO\_OP\_SET\_I,DO\ |
|                                   | _OP\_SET\_V]{.c1}                 |
+-----------------------------------+-----------------------------------+
| [ADDR]{.c1}                       | [ADDR\_AD,ADDR\_PC,ADDR\_BA,ADDR\ |
|                                   | _SP,ADDR\_IRQL,ADDR\_IRQH]{.c1}   |
+-----------------------------------+-----------------------------------+
| [LD]{.c1}                         | [LD\_INSTR,LD\_ADL,LD\_ADH,LD\_BA |
|                                   | L,LD\_BAH,LD\_IMM,LD\_OFFSET,LD\_ |
|                                   | ADV,LD\_BAV,LD\_PCL,LD\_PCH]{.c1} |
+-----------------------------------+-----------------------------------+
| [SRC1]{.c1}                       | [SRC1\_A,SRC1\_BAL,SRC1\_BAH,SRC1 |
|                                   | \_ADL,SRC1\_PCL,SRC1\_PCH,SRC1\_B |
|                                   | AV,SRC1\_1]{.c1}                  |
+-----------------------------------+-----------------------------------+
| [SRC2]{.c1}                       | [SRC2\_DC,SRC2\_IMM,SRC2\_ADV,SRC |
|                                   | 2\_X,SRC2\_BAV,SRC2\_C,SRC2\_1,SR |
|                                   | C2\_Y,SRC2\_OFFSET]{.c1}          |
+-----------------------------------+-----------------------------------+
| [DEST]{.c1}                       | [DEST\_BAL,DEST\_BAH,DEST\_ADL,DE |
|                                   | ST\_A,DEST\_X,DEST\_Y,DEST\_PCL,D |
|                                   | EST\_PCH,DEST\_NONE]{.c1}         |
+-----------------------------------+-----------------------------------+
| [PC]{.c1}                         | [AD\_P\_TO\_PC,INC\_PC,KEEP\_PC]{ |
|                                   | .c100                             |
|                                   | .c148}                            |
+-----------------------------------+-----------------------------------+
| [SP]{.c1}                         | [INC\_SP,DEC\_SP]{.c100 .c148}    |
+-----------------------------------+-----------------------------------+

[]{.c29}

4.  [Picture Processing Unit]{.c138 .c43} {#NES.xhtml#h.fb8snxockohd style="display:inline"}
    =====================================

[]{.c1}

[The NES picture processing unit or PPU is the unit responsible for handling all of the console's graphical workloads. Obviously this is useful to the CPU because it offloads the highly intensive task of rendering a frame. This means the CPU can spend more time performing the game logic. ]{.c94 .c52}

[]{.c94 .c52}

[The PPU renders a frame by reading in scene data from various memories the PPU has access to such as VRAM, the game cart, and object attribute memory and then outputting an NTSC compliant 256x240 video signal at 60 Hz. The PPU was a special custom designed IC for Nintendo, so no other devices use this specific chip. It operates at a clock speed of 5.32 MHz making it three times faster than the NES CPU. This is one of the areas of difficulty in creating the PPU because it is easy to get the CPU and PPU clock domains out of sync.]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[]{.c94 .c52}

[PPU Top Level Schematic]{.c42} {#NES.xhtml#h.bvqrg858z31w .c0}
-------------------------------

[ ![schemeit-project.png](images/image9.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 625.50px; height: 355.85px;"}

[6502: ]{.c43} [The CPU used in the NES. Communicates with the PPU through simple load/store instructions. This works because the PPU registers are memory mapped into the CPU's address space.]{.c1}

[Address Decoder:]{.c43} [ The address decoder is responsible for selecting the chip select of the device the CPU wants to talk to. In the case of the PPU the address decoder will activate if from addresses \[0x2000, 0x2007\].]{.c1}

[VRAM:]{.c43} [ The PPU video memory contains the data needed to render the scene, specifically it holds the name tables. VRAM is 2 Kb in size and depending on how the PPU VRAM address lines are configured, different mirroring schemes are possible. ]{.c1}

[Game Cart:]{.c43} [ The game cart has a special ROM on it called the character ROM, or char ROM for short. the char ROM contains the sprite and background tile pattern data. These are sometimes referred to as the pattern tables. ]{.c1}

[PPU Registers:]{.c43} [ These registers allow the CPU to modify the state of the PPU. It maintains all of the control signals that are sent to both the background and sprite renderers.]{.c1}

[Background Renderer:]{.c43} [ Responsible for drawing the background data for a scene. ]{.c1}

[Sprite Renderer:]{.c43} [ Responsible for drawing the sprite data for a scene, and maintaining object attribute memory.]{}

[Object Attribute Memory:]{.c43} [ Holds all of the data needed to know how to render a sprite. OAM is 256 bytes in size and each sprite utilizes 4 bytes of data. This means the PPU can support 64 sprites.]{.c1}

[Pixel Priority:]{.c43} [ During the visible pixel section of rendering, both the background and sprite renderers produce a single pixel each clock cycle. The pixel priority module looks at the priority values and color for each pixel and decides which one to draw to the screen. ]{.c1}

[VGA Interface:]{.c43} [ This is where all of the frame data is kept in a frame buffer. This data is then upscaled to 640x480 when it goes out to the monitor.]{}

[PPU Memory Map]{.c42} {#NES.xhtml#h.dkksbep8besq .c0}
----------------------

[ ![](images/image22.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 421.64px; height: 466.50px;"}

[The PPU memory map is broken up into three distinct regions, the pattern tables, name tables, and palettes. Each of these regions holds data the PPU need to obtain to render a given scanline. The functionality of each part is described in the PPU Rendering section.]{.c52}

[PPU CHAROM]{.c42} {#NES.xhtml#h.pa3j41hpauwc .c0}
------------------

-   [ROM from the cartridge is broken in two sections]{.c10}

<!-- -->

-   [Program ROM]{.c10}

<!-- -->

-   [Contains program code for the 6502]{.c10}
-   [Is mapped into the CPU address space by the mapper]{.c10}

<!-- -->

-   [Character ROM ]{.c10}

<!-- -->

-   [Contains sprite and background data for the PPU]{.c10}
-   [Is mapped into the PPU address space by the mapper]{.c10}

[PPU Rendering]{.c42} {#NES.xhtml#h.pg3as4rfwz9v .c0}
---------------------

-   [Pattern Tables]{.c10}

<!-- -->

-   [\$0000-\$2000 in VRAM]{.c10}

<!-- -->

-   [Pattern Table 0 (\$0000-\$0FFF)]{.c10}
-   [Pattern Table 1 (\$1000-\$2000)]{.c10}
-   [The program selects which one of these contains sprites and backgrounds]{.c10}
-   [Each pattern table is 16 bytes long and represents 1 8x8 pixel tile]{.c10}

<!-- -->

-   [Each 8x1 row is 2 bytes long]{.c10}
-   [Each bit in the byte represents a pixel and the corresponding bit for each byte is combined to create a 2 bit color.]{.c10}

<!-- -->

-   [Color\_pixel = {byte2\[0\], byte1\[0\]}]{.c10}

<!-- -->

-   [So there can only be 4 colors in any given tile]{.c10}
-   [Rightmost bit is leftmost pixel]{.c10}

<!-- -->

-   [Any pattern that has a value of 0 is transparent i.e. the background color]{.c10}

[]{.c10}

[ ![](images/image15.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 414.58px; height: 172.50px;"}

[]{.c10}

-   [Name Tables]{.c10}

<!-- -->

-   [\$2000-\$2FFF in VRAM with \$3000-\$3EFF as a mirror]{.c10}
-   [Laid out in memory in 32x30 fashion]{.c10}

<!-- -->

-   [Think of as a 2d array where each element specifies a tile in the pattern table.]{.c10}
-   [This results in a resolution of 256x240]{.c10}

<!-- -->

-   [Although the PPU supports 4 name tables the NES only supplied enough VRAM for 2 this results in 2 of the 4 name tables being mirror]{.c10}

<!-- -->

-   [Vertically = horizontal movement]{.c10}
-   [Horizontally = vertical movement]{.c10}

<!-- -->

-   [Each entry in the name table refers to one pattern table and is one byte. Since there are 32x30=960 entries each name table requires 960 bytes of space the left over 64 bytes are used for attribute tables]{.c10}
-   [Attribute tables]{.c10}

<!-- -->

-   [1 byte entries that contains the palette assignment for a 2x2 grid of tiles]{.c10}

[ ![](images/image10.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 216.00px; height: 254.72px;"}

[]{.c10}

-   [Sprites]{.c10}

<!-- -->

-   [Just like backgrounds sprite tile data is contained in one of the pattern tables]{.c10}
-   [But unlike backgrounds sprite information is not contained in name tables but in a special reserved 256 byte RAM called the object attribute memory (OAM)]{.c10}

<!-- -->

-   [Object Attribute Memory]{.c10}

<!-- -->

-   [256 bytes of dedicated RAM]{.c10}
-   [Each object is allocated 4 bytes of OAM so we can store data about 64 sprites at once]{.c10}
-   [Each object has the following information stored in OAM]{.c10}

<!-- -->

-   [X Coordinate]{.c10}
-   [Y Coordinate]{.c10}
-   [Pattern Table Index]{.c10}
-   [Palette Assignment]{.c10}
-   [Horizontal/Vertical Flip]{.c10}

<!-- -->

-   [Palette Table]{.c10}

<!-- -->

-   [Located at \$3F00-\$3F20]{.c10}

<!-- -->

-   [\$3F00-\$3F0F is background palettes]{.c10}
-   [\$3F10-\$3F1F is sprite palettes]{.c10}

<!-- -->

-   [Mirrored all the way to \$4000]{.c10}
-   [Each color takes one byte]{.c10}
-   [Every background tile and sprite needs a color palette.]{.c10}
-   [When the background or sprite is being rendered the the color for a specific table is looked up in the correct palette and sent to the draw select mux.]{.c10}

<!-- -->

-   [Rendering is broken into two parts which are done for each horizontal scanline]{.c10}

<!-- -->

-   [Background Rendering]{.c10}

<!-- -->

-   [The background enable register (\$2001) controls if the default background color is rendered (\$2001) or if background data from the background renderer.]{.c10}
-   [The background data is obtained for every pixel.]{.c10}

<!-- -->

-   [Sprite Rendering]{.c10}

<!-- -->

-   [The sprite renderer has room for 8 unique sprites on each scanline.]{.c10}
-   [For each scanline the renderer looks through the OAM for sprites that need to be drawn on the scanline. If this is the case the sprite is loaded into the scanline local sprites]{.c10}

<!-- -->

-   [If this number exceeds 8 a flag is set and the behavior is undefined.]{.c10}

<!-- -->

-   [If a sprite should be drawn for a pixel instead of the background the sprite renderer sets the sprite priority line to a mux that decides what to send to the screen and the mux selects the sprite color d]{.c52 .c134 .c117} [ata.]{.c52 .c117 .c134}

[PPU Memory Mapped Registers]{.c42} {#NES.xhtml#h.8bwwxukxxmnt .c0}
-----------------------------------

[The PPU register interface exists so the CPU can modify and fetch the state elements of the PPU. These state elements include registers that set control signals, VRAM, object attribute memory, and palettes. These state elements then determine how the background and sprite renderers will draw the scene. The PPU register module also contains the pixel mux and palette memory which are used to determine what pixel data to send to the VGA module.]{.c1}

[]{#NES.xhtml#t.2410c3dd563250403a6a2b073e837692eff20a19} []{#NES.xhtml#t.12}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [data\[7:0\]]{. | [inout]{.c1}    | [CPU]{.c1}      | [Bi directional |
| c1}             |                 |                 | data bus        |
|                 |                 |                 | between the     |
|                 |                 |                 | CPU/PPU]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [address\[2:0\] | [input]{.c1}    | [CPU]{.c1}      | [Register       |
| ]{.c1}          |                 |                 | select]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [rw]{.c1}       | [input]{.c1}    | [CPU]{.c1}      | [CPU read/write |
|                 |                 |                 | select]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [cs\_in]{.c1}   | [input]{.c1}    | [CPU]{.c1}      | [PPU chip       |
|                 |                 |                 | select]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [irq]{.c1}      | [output]{.c1}   | [CPU]{.c1}      | [Signal PPU     |
|                 |                 |                 | asserts to      |
|                 |                 |                 | trigger CPU     |
|                 |                 |                 | NMI]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [pixel\_data\[7 | [output]{.c1}   | [VGA]{.c1}      | [RGB pixel data |
| :0\]]{.c1}      |                 |                 | to be sent to   |
|                 |                 |                 | the             |
|                 |                 |                 | display]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\_ou | [output]{.c1}   | [VRAM]{.c1}     | [VRAM address   |
| t\[13:0\]]{.c1} |                 |                 | to read/write   |
|                 |                 |                 | from]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_rw\_sel] | [output]{.c1}   | [VRAM]{.c1}     | [Determines if  |
| {.c1}           |                 |                 | the current     |
|                 |                 |                 | vram operation  |
|                 |                 |                 | is a read or    |
|                 |                 |                 | write]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_ou | [output]{.c1}   | [VRAM]{.c1}     | [Data to write  |
| t\[7:0\]]{.c1}  |                 |                 | to VRAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_end]{.c | [output]{.c1}   | [VGA]{.c1}      | [Signals the    |
| 1}              |                 |                 | VGA interface   |
|                 |                 |                 | that this is    |
|                 |                 |                 | the end of a    |
|                 |                 |                 | frame]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_start]{ | [output]{.c1}   | [VGA]{.c1}      | [Signals the    |
| .c1}            |                 |                 | VGA interface   |
|                 |                 |                 | that a frame is |
|                 |                 |                 | starting to     |
|                 |                 |                 | keep the PPU    |
|                 |                 |                 | and VGA in      |
|                 |                 |                 | sync]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [rendering]{.c1 | [output]{.c1}   | [VGA]{.c1}      | [Signals the    |
| }               |                 |                 | VGA interface   |
|                 |                 |                 | that pixel data |
|                 |                 |                 | output is       |
|                 |                 |                 | valid]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[]{.c1}

[PPU Register Block Diagram]{.c42} {#NES.xhtml#h.h50m30h4jbfm .c78}
----------------------------------

[ ![Untitled Diagram.png](images/image20.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 370.50px; height: 351.34px;"}

[PPU Register Descriptions]{.c42} {#NES.xhtml#h.djradund7fk8 .c78}
---------------------------------

-   [Control registers are mapped into the CPUs address space (]{.c52} [\$2000 - \$2007)]{.c10}
-   [The registers are repeated every eight bytes until address \$3FF]{.c94 .c52 .c117}
-   [PPUCTRL\[7:0\] (]{.c43 .c134 .c149 .c117} [\$2000) WRITE]{.c10}

<!-- -->

-   [\[1:0\]: Base nametable address which is loaded at the start of a frame]{.c10}

<!-- -->

-   [0: \$2000]{.c10}
-   [1: \$2400]{.c10}
-   [2: \$2800]{.c10}
-   [3: \$2C00]{.c10}

<!-- -->

-   [\[2\]: VRAM address increment per CPU read/write of PPUDATA]{.c10}

<!-- -->

-   [0: Add 1 going across]{.c10}
-   [1: Add 32 going down]{.c10}

<!-- -->

-   [\[3\]: Sprite pattern table for 8x8 sprites]{.c10}

<!-- -->

-   [0: \$0000]{.c10}
-   [1: \$1000]{.c10}
-   [Ignored in 8x16 sprite mode]{.c10}

<!-- -->

-   [\[4\]: Background pattern table address]{.c10}

<!-- -->

-   [0: \$0000]{.c10}
-   [1: \$1000]{.c10}

<!-- -->

-   [\[5\]: Sprite size]{.c10}

<!-- -->

-   [0: 8x8]{.c10}
-   [1: 8x16]{.c10}

<!-- -->

-   [\[6\]: PPU master/slave select]{.c10}

<!-- -->

-   [0: Read backdrop from EXT pins]{.c10}
-   [1: Output color on EXT pins]{.c10}

<!-- -->

-   [\[7\]: Generate NMI interrupt at the start of vertical blanking interval]{.c10}

<!-- -->

-   [0: off]{.c10}
-   [1: on]{.c10}

<!-- -->

-   [PPUMASK\[7:0\] ]{.c43 .c134 .c117 .c149} [(\$2001) WRITE]{.c10}

<!-- -->

-   [\[0\]: Use grayscale image]{.c10}

<!-- -->

-   [0: Normal color]{.c10}
-   [1: Grayscale]{.c10}

<!-- -->

-   [\[1\]: Show left 8 pixels of background]{.c10}

<!-- -->

-   [0: Hide]{.c10}
-   [1: Show background in leftmost 8 pixels of screen]{.c10}

<!-- -->

-   [\[2\]: Show left 8 piexels of sprites]{.c10}

<!-- -->

-   [0: Hide]{.c10}
-   [1: Show sprites in leftmost 8 pixels of screen]{.c10}

<!-- -->

-   [\[3\]: Render the background]{.c10}

<!-- -->

-   [0: Don’t show background]{.c10}
-   [1: Show background]{.c10}

<!-- -->

-   [\[4\]: Render the sprites]{.c10}

<!-- -->

-   [0: Don’t show sprites]{.c10}
-   [1: Show sprites]{.c10}

<!-- -->

-   [\[5\]: Emphasize red]{.c10}
-   [\[6\]: Emphasize green]{.c10}
-   [\[7\]: Emphasize blue]{.c10}

<!-- -->

-   [PPUSTATUS\[7:0\] ]{.c43 .c134 .c149 .c117} [(\$2002) READ]{.c10}

<!-- -->

-   [\[4:0\]: Nothing?]{.c10}
-   [\[5\]: Set for sprite overflow which is when more than 8 sprites exist in one scanline (Is actually more complicated than this to do a hardware bug)]{.c10}
-   [\[6\]: Sprite 0 hit. This bit gets set when a non zero part of sprite zero overlaps a non zero background pixel]{.c10}
-   [\[7\]: Vertical blank status register]{.c10}

<!-- -->

-   [0: Not in vertical blank]{.c10}
-   [1: Currently in vertical blank]{.c10}

<!-- -->

-   [OAMADDR\[7:0\] ]{.c43 .c134 .c149 .c117} [(\$2003) WRITE]{.c10}

<!-- -->

-   [Address of the object attribute memory the program wants to access]{.c10}

<!-- -->

-   [OAMDATA\[7:0\] ]{.c43 .c134 .c149 .c117} [(\$2004) READ/WRITE]{.c10}

<!-- -->

-   [The CPU can read/write this register to read or write to the PPUs object attribute memory. The address should be specified by writing the OAMADDR register beforehand. Each write will increment the address by one, but a read will not modify the address]{.c10}

<!-- -->

-   [PPUSCROLL\[7:0\] ]{.c43 .c134 .c149 .c117} [(\$2005) WRITE]{.c10}

<!-- -->

-   [Tells the PPU what pixel of the nametable selected in PPUCTRL should be in the top left hand corner of the screen]{.c10}

<!-- -->

-   [PPUADDR\[7:0\] ]{.c43 .c134 .c149 .c117} [(\$2006) WRITE]{.c10}

<!-- -->

-   [Address the CPU wants to write to VRAM before writing a read of PPUSTATUS is required and then two bytes are written in first the high byte then the low byte]{.c10}

<!-- -->

-   [PPUDATA\[7:0\] ]{.c43 .c134 .c149 .c117} [(\$2007) READ/WRITE]{.c10}

<!-- -->

-   [Writes/Reads data from VRAM for the CPU. The value in PPUADDR is then incremented by the value specified in PPUCTRL]{.c10}

<!-- -->

-   [OAMDMA\[7:0\]]{.c43 .c134 .c149 .c117} [ (\$4014) WRITE]{.c10}

<!-- -->

-   [A write of \$XX to this register will result in the CPU memory page at \$XX00-\$XXFF being written into the PPU object attribute memory]{.c52 .c134 .c117}

[PPU Background Renderer]{.c42} {#NES.xhtml#h.qbi461d1fk95 .c0}
-------------------------------

[The background renderer is responsible for rendering the background for each frame that is output to the VGA interface. It does this by prefetching the data for two tiles at the end of the previous scanline. And then begins to continuously fetch tile data for every pixel of the visible frame. This allows the background renderer to produce a steady flow of output pixels despite the fact it takes 8 cycles to fetch 8 pixels of a scanline.]{.c1}

[]{#NES.xhtml#t.cfcc5323a0745a2d21a0d8ca697f3e16babd2727} []{#NES.xhtml#t.13}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_render\_en | [input]{.c1}    | [PPU            | [Background     |
| ]{.c1}          |                 | Register]{.c1}  | render          |
|                 |                 |                 | enable]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [x\_pos\[9:0\]] | [input]{.c1}    | [PPU            | [The current    |
| {.c1}           |                 | Register]{.c1}  | pixel for the   |
|                 |                 |                 | active          |
|                 |                 |                 | scanline]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [y\_pos\[9:0\]] | [input]{.c1}    | [PPU            | [The current    |
| {.c1}           |                 | Register]{.c1}  | scanline being  |
|                 |                 |                 | rendered]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_in | [input]{.c1}    | [PPU            | [The current    |
| \[7:0\]]{.c1}   |                 | Register]{.c1}  | data that has   |
|                 |                 |                 | been read in    |
|                 |                 |                 | from VRAM]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_pt\_sel]{. | [input]{.c1}    | [PPU            | [Selects the    |
| c1}             |                 | Register]{.c1}  | location of the |
|                 |                 |                 | background      |
|                 |                 |                 | renderer        |
|                 |                 |                 | pattern         |
|                 |                 |                 | table]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [show\_bg\_left | [input]{.c1}    | [PPU            | [Determines if  |
| \_col]{.c1}     |                 | Register]{.c1}  | the background  |
|                 |                 |                 | for the         |
|                 |                 |                 | leftmost 8      |
|                 |                 |                 | pixels of each  |
|                 |                 |                 | scanline will   |
|                 |                 |                 | be drawn]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [fine\_x\_scrol | [input]{.c1}    | [PPU            | [Selects the    |
| l\[2:0\]]{.c1}  |                 | Register]{.c1}  | pixel drawn on  |
|                 |                 |                 | the left hand   |
|                 |                 |                 | side of the     |
|                 |                 |                 | screen]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [coarse\_x\_scr | [input]{.c1}    | [PPU            | [Selects the    |
| oll\[4:0\]]{.c1 |                 | Register]{.c1}  | tile to start   |
| }               |                 |                 | rendering from  |
|                 |                 |                 | in the x        |
|                 |                 |                 | direction]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [fine\_y\_scrol | [input]{.c1}    | [PPU            | [Selects the    |
| l\[2:0\]]{.c1}  |                 | Register]{.c1}  | pixel drawn on  |
|                 |                 |                 | the top of the  |
|                 |                 |                 | screen]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [coarse\_y\_scr | [input]{.c1}    | [PPU            | [Selects the    |
| oll\[4:0\]]{.c1 |                 | Register]{.c1}  | tile to start   |
| }               |                 |                 | rendering from  |
|                 |                 |                 | in the y        |
|                 |                 |                 | direction]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [nametable\_sel | [input]{.c1}    | [PPU            | [Selects the    |
| \[1:0\]]{.c1}   |                 | Register]{.c1}  | nametable to    |
|                 |                 |                 | start rendering |
|                 |                 |                 | from]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [update\_loopy\ | [input]{.c1}    | [PPU            | [Signal to      |
| _v]{.c1}        |                 | Register]{.c1}  | update the      |
|                 |                 |                 | temporary vram  |
|                 |                 |                 | address]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_loopy\_v\ | [input]{.c1}    | [PPU            | [Signal to      |
| _inc]{.c1}      |                 | Register]{.c1}  | increment the   |
|                 |                 |                 | temporary vram  |
|                 |                 |                 | address by the  |
|                 |                 |                 | increment       |
|                 |                 |                 | amount]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_loopy\_v\ | [input]{.c1}    | [PPU            | [If this signal |
| _inc\_amt]{.c1} |                 | Register]{.c1}  | is set          |
|                 |                 |                 | increment the   |
|                 |                 |                 | temp vram       |
|                 |                 |                 | address by 32   |
|                 |                 |                 | on              |
|                 |                 |                 | cpu\_loopy\_v\_ |
|                 |                 |                 | inc,            |
|                 |                 |                 | and increment   |
|                 |                 |                 | by 1 if it is   |
|                 |                 |                 | not set on      |
|                 |                 |                 | cpu\_loopy\_v\_ |
|                 |                 |                 | inc]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [vblank\_out]{. | [output]{.c1}   | [PPU            | [Determines it  |
| c1}             |                 | Register]{.c1}  | the PPU is in   |
|                 |                 |                 | vertical        |
|                 |                 |                 | blank]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_rendering\ | [output]{.c1}   | [PPU            | [Determines if  |
| _out]{.c1}      |                 | Register]{.c1}  | the bg renderer |
|                 |                 |                 | is requesting   |
|                 |                 |                 | vram            |
|                 |                 |                 | reads]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_pal\_sel\[ | [output]{.c1}   | [Pixel          | [Selects the    |
| 3:0\]]{.c1}     |                 | Mux]{.c1}       | palette for the |
|                 |                 |                 | background      |
|                 |                 |                 | pixel]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [loopy\_v\_out\ | [output]{.c1}   | [PPU            | [The temporary  |
| [14:0\]]{.c1}   |                 | Register]{.c1}  | vram address    |
|                 |                 |                 | register for    |
|                 |                 |                 | vram            |
|                 |                 |                 | reads/writes]{. |
|                 |                 |                 | c1}             |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\_ou | [output]{.c1}   | [VRAM]{.c1}     | [The VRAM       |
| t\[13:0\]]{.c1} |                 |                 | address the     |
|                 |                 |                 | sprite renderer |
|                 |                 |                 | wants to read   |
|                 |                 |                 | from]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[PPU Background Renderer Diagram]{.c42} {#NES.xhtml#h.kqe8ry35ghh .c0}
---------------------------------------

[ ![Untitled Diagram.png](images/image18.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 326.64px; height: 420.71px;"}

[VRAM:]{.c43} [ The background renderer reads from two of the three major areas of address space available to the PPU, the pattern tables, and the name tables. First the background renderer needs the name table byte for a given tile to know which tile to draw in the background. Once it has this information is need the pattern to know how to draw the background tile.]{.c1}

[PPU Register Interface:]{.c43} [ All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.]{.c1}

[Scrolling Register:]{.c43} [ The scrolling register is responsible for keeping track of what tile is currently being drawn to the screen. ]{.c1}

[Scrolling Update Logic: ]{.c43} [Every time the data for a background tile is successfully fetched the scrolling register needs to be updated. Most of the time it is a simple increment, but more care has to be taken when the next tile falls in another name table. This logic allows the scrolling register to correctly update to be able to smoothly jump between name tables while rendering. ]{.c1}

[Background Renderer State Machine: ]{.c43} [The background renderer state machine is responsible for sending the correct control signals to all of the other modules as the background is rendering. ]{.c1}

[Background Shift Registers:]{.c43} [ These registers shift out the pixel data to be rendered on every clock cycle. They also implement the logic that makes fine one pixel scrolling possible by changing what index of the shift registers is the one being shifted out each cycle.]{.c1}

[Pixel Priority Mux: ]{.c43} [Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.]{.c1}

[PPU Sprite Renderer]{.c42} {#NES.xhtml#h.z1adjveqdhdo .c0}
---------------------------

[The PPU sprite renderer is used to render all of the sprite data for each scanline. The way the hardware was designed it only allows for 64 sprites to kept in object attribute memory at once. There are only 8 spots available to store the sprite data for each scanline so only 8 sprites can be rendered for each scanline. Sprite data in OAM is evaluated for the next scanline while the background renderer is mastering the VRAM bus. When rendering reaches horizontal blank the sprite renderer fetches the pattern data for all of the sprites to be rendered on the next scanline and places the data in the sprite shift registers. The sprite x position is also loaded into a down counter which determines when to make the sprite active and shift out the pattern data on the next scanline.]{.c1}

[]{#NES.xhtml#t.cdbc9e2f9b853601435427311431e91e21b12696} []{#NES.xhtml#t.14}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_render\_e | [input]{.c1}    | [PPU            | [Sprite         |
| n]{.c1}         |                 | Register]{.c1}  | renderer enable |
|                 |                 |                 | signal]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [x\_pos\[9:0\]] | [input]{.c1}    | [PPU            | [The current    |
| {.c1}           |                 | Register]{.c1}  | pixel for the   |
|                 |                 |                 | active          |
|                 |                 |                 | scanline]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [y\_pos\[9:0\]] | [input]{.c1}    | [PPU            | [The current    |
| {.c1}           |                 | Register]{.c1}  | scanline being  |
|                 |                 |                 | rendered]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_addr\_in\ | [input]{.c1}    | [PPU            | [The current    |
| [7:0\]]{.c1}    |                 | Register]{.c1}  | OAM address     |
|                 |                 |                 | being           |
|                 |                 |                 | read/written]{. |
|                 |                 |                 | c1}             |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_data\_in\ | [inout]{.c1}    | [PPU            | [The current    |
| [7:0\]]{.c1}    |                 | Register]{.c1}  | data being      |
|                 |                 |                 | read/written    |
|                 |                 |                 | from OAM]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_in | [input]{.c1}    | [VRAM]{.c1}     | [The data the   |
| \[7:0\]]{.c1}   |                 |                 | sprite renderer |
|                 |                 |                 | requested from  |
|                 |                 |                 | VRAM]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_oam\_rw]{ | [input]{.c1}    | [PPU            | [Selects if OAM |
| .c1}            |                 | Register]{.c1}  | is being read   |
|                 |                 |                 | from or written |
|                 |                 |                 | to from the     |
|                 |                 |                 | CPU]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_oam\_req] | [input]{.c1}    | [PPU            | [Signals the    |
| {.c1}           |                 | Register]{.c1}  | CPU wants to    |
|                 |                 |                 | read/write      |
|                 |                 |                 | OAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_pt\_sel]{ | [input]{.c1}    | [PPU            | [Determines the |
| .c1}            |                 | Register]{.c1}  | PPU pattern     |
|                 |                 |                 | table address   |
|                 |                 |                 | in VRAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_size\_sel | [input]{.c1}    | [PPU            | [Determines the |
| ]{.c1}          |                 | Register]{.c1}  | size of the     |
|                 |                 |                 | sprites to be   |
|                 |                 |                 | drawn]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [show\_spr\_lef | [input]{.c1}    | [PPU            | [Determines if  |
| t\_col]{.c1}    |                 | Register]{.c1}  | sprites on the  |
|                 |                 |                 | leftmost 8      |
|                 |                 |                 | pixels of each  |
|                 |                 |                 | scanline will   |
|                 |                 |                 | be drawn]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_overflow] | [output]{.c1}   | [PPU            | [If more than 8 |
| {.c1}           |                 | Register]{.c1}  | sprites fall on |
|                 |                 |                 | a single        |
|                 |                 |                 | scanline this   |
|                 |                 |                 | is set]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_pri\_out] | [output]{.c1}   | [Pixel          | [Determines the |
| {.c1}           |                 | Mux]{.c1}       | priority of the |
|                 |                 |                 | sprite pixel    |
|                 |                 |                 | data]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_data\_out | [output]{.c1}   | [PPU            | [returns oam    |
| \[7:0\]]{.c1}   |                 | Register]{.c1}  | data the CPU    |
|                 |                 |                 | requested]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_pal\_sel\ | [output]{.c1}   | [Pixel          | [Sprite pixel   |
| [3:0\]]{.c1}    |                 | Mux]{.c1}       | color data to   |
|                 |                 |                 | be drawn]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\_ou | [output]{.c1}   | [VRAM]{.c1}     | [Sprite vram    |
| t\[13:0\]]{.c1} |                 |                 | read            |
|                 |                 |                 | address]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_vram\_req | [output]{.c1}   | [VRAM]{.c1}     | [Signals the    |
| ]{.c1}          |                 |                 | sprite renderer |
|                 |                 |                 | is requesting a |
|                 |                 |                 | VRAM read]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_0\_render | [output]{.c1}   | [Pixel          | [Determines if  |
| ing]{.c1}       |                 | Mux]{.c1}       | the current     |
|                 |                 |                 | sprite that is  |
|                 |                 |                 | rendering is    |
|                 |                 |                 | sprite 0]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [inc\_oam\_addr | [output]{.c1}   | [PPU            | [Signals the    |
| ]{.c1}          |                 | Register]{.c1}  | OAM address in  |
|                 |                 |                 | the registers   |
|                 |                 |                 | to              |
|                 |                 |                 | increment]{.c1} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[PPU Sprite Renderer Diagram]{.c42} {#NES.xhtml#h.ouavojij313q .c0}
-----------------------------------

[ ![Untitled Diagram.png](images/image12.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 556.77px; height: 408.55px;"}

[]{.c36}

[]{.c36}

[]{.c36}

[VRAM:]{.c43} [ The sprite renderer need to be able to fetch the sprite pattern data from the character rom. This is why it can request VRAM reads from this region through the PPU Register Interface]{}

[PPU Register Interface:]{.c43} [ All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.]{} [ ]{.c36}

[Object Attribute Memory:]{.c43} [ OAM contains all of the data needed to render a sprite to the screen except the pattern data itself. For each sprite OAM holds its x position, y position, horizontal flip, vertical flip, and palette information. In total OAM supports 64 sprites.]{.c1}

[Sprite Renderer State Machine:]{.c43} [ The sprite renderer state machine is responsible for sending all of the control signals to each of the other units in the renderer. This includes procesing the data in OAM, move the correct sprites to secondary OAM, VRAM reads, and shifting out the sprite data when the sprite needs to be rendered to the screen.]{.c1}

[Sprite Shift Registers:]{.c43} [ The sprite shift registers hold the sprite pixel data for sprites on the current scanline. When a sprite becomes active its data is shifted out to the pixel priority mux.]{.c1}

[Pixel Priority Mux: ]{.c43} [Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.]{}

[Temporary Sprite Data:]{.c43} [ The temporary sprite data is where the state machine moves the current sprite being evaluated in OAM to. If the temporary sprite falls on the next scanline its data is moved into a slot in secondary OAM. If it does not the data is discarded.]{.c1}

[Secondary Object Attribute Memory:]{.c43} [ Secondary OAM holds the sprite data for sprites that fall on the next scanline. During hblank this data is used to load the sprite shift registers with the correct sprite pattern data.]{.c1}

[Sprite Counter and Priority Registers:]{.c43} [ These registers hold the priority information for each sprite in the sprite shift registers. It also holds a down counter for each sprite which is loaded with the sprite's x position. When the counter hits 0 the corresponding sprite becomes active and the sprite data needs to be shifted out to the screen.]{}

[PPU Object Attribute Memory]{.c42} {#NES.xhtml#h.ud4hcid0qc0t .c0}
-----------------------------------

[]{.c1}

[]{#NES.xhtml#t.c1d0725151e3ae45852fd0f9196d5e83cf527c44} []{#NES.xhtml#t.15}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [oam\_en]{.c1}  | [input]{.c1}    | [OAM]{.c1}      | [Determines if  |
|                 |                 |                 | the input data  |
|                 |                 |                 | is for a valid  |
|                 |                 |                 | read/write]{.c1 |
|                 |                 |                 | }               |
+-----------------+-----------------+-----------------+-----------------+
| [oam\_rw]{.c1}  | [input]{.c1}    | [OAM]{.c1}      | [Determines if  |
|                 |                 |                 | the current     |
|                 |                 |                 | operation is a  |
|                 |                 |                 | read or         |
|                 |                 |                 | write]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_select\[5 | [input]{.c1}    | [OAM]{.c1}      | [Determines     |
| :0\]]{.c1}      |                 |                 | which sprite is |
|                 |                 |                 | being           |
|                 |                 |                 | read/written]{. |
|                 |                 |                 | c1}             |
+-----------------+-----------------+-----------------+-----------------+
| [byte\_select\[ | [input]{.c1}    | [OAM]{.c1}      | [Determines     |
| 1:0\]]{.c1}     |                 |                 | which sprite    |
|                 |                 |                 | byte is being   |
|                 |                 |                 | read/written]{. |
|                 |                 |                 | c1}             |
+-----------------+-----------------+-----------------+-----------------+
| [data\_in\[7:0\ | [input]{.c1}    | [OAM]{.c1}      | [Data to write  |
| ]]{.c1}         |                 |                 | to the          |
|                 |                 |                 | specified OAM   |
|                 |                 |                 | address]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[7:0 | [output]{.c1}   | [PPU            | [Data that has  |
| \]]{.c1}        |                 | Register]{.c1}  | been read from  |
|                 |                 |                 | OAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[PPU Palette Memory]{.c42} {#NES.xhtml#h.unbqcwik0ikz .c0}
--------------------------

[]{.c1}

[]{#NES.xhtml#t.f1d3489e5c353600b2df513bca63b64f963856ac} []{#NES.xhtml#t.16}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [pal\_addr\[4:0 | [input]{.c1}    | [palette        | [Selects the    |
| \]]{.c1}        |                 | mem]{.c1}       | palette to      |
|                 |                 |                 | read/write in   |
|                 |                 |                 | the             |
|                 |                 |                 | memory]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [pal\_data\_in\ | [input]{.c1}    | [palette        | [Data to write  |
| [7:0\]]{.c1}    |                 | mem]{.c1}       | to the palette  |
|                 |                 |                 | memory]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [palette\_mem\_ | [input]{.c1}    | [palette        | [Determines if  |
| rw]{.c1}        |                 | mem]{.c1}       | the current     |
|                 |                 |                 | operation is a  |
|                 |                 |                 | read or         |
|                 |                 |                 | write]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [palette\_mem\_ | [input]{.c1}    | [palette        | [Determines if  |
| en]{.c1}        |                 | mem]{.c1}       | the palette mem |
|                 |                 |                 | inputs are      |
|                 |                 |                 | valid]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [color\_out\[7: | [output]{.c1}   | [VGA]{.c1}      | [Returns the    |
| 0\]]{.c1}       |                 |                 | selected        |
|                 |                 |                 | palette for a   |
|                 |                 |                 | given address   |
|                 |                 |                 | on a read]{.c1} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[VRAM Interface]{.c42} {#NES.xhtml#h.xlgt5p96mvki .c0}
----------------------

[The VRAM interface instantiates an Altera RAM IP core. Each read take 2 cycles one for the input and one for the output]{.c1}

[]{#NES.xhtml#t.40d96b8d3f361e8568937a45000f4fd566ca150c} []{#NES.xhtml#t.17}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\[10 | [input]{.c1}    | [PPU]{.c1}      | [Address from   |
| :0\]]{.c1}      |                 |                 | VRAM to read to |
|                 |                 |                 | or write        |
|                 |                 |                 | from]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_in | [input]{.c1}    | [PPU]{.c1}      | [The data to    |
| \[7:0\]]{.c1}   |                 |                 | write to        |
|                 |                 |                 | VRAM]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_en]{.c1} | [input]{.c1}    | [PPU]{.c1}      | [The VRAM       |
|                 |                 |                 | enable          |
|                 |                 |                 | signal]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_rw]{.c1} | [input]{.c1}    | [PPU]{.c1}      | [Selects if the |
|                 |                 |                 | current op is a |
|                 |                 |                 | read or         |
|                 |                 |                 | write]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_ou | [output]{.c1}   | [PPU]{.c1}      | [The data that  |
| t\[7:0\]]{.c1}  |                 |                 | was read from   |
|                 |                 |                 | VRAM on a       |
|                 |                 |                 | read]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[]{.c42} {#NES.xhtml#h.ezngvtvhun92 .c0 .c130}
--------

[DMA]{.c42} {#NES.xhtml#h.7oqgkdlshdds .c0}
-----------

[The DMA is used to copy 256 bytes of data from the CPU address space into the OAM (PPU address space). The DMA is 4x faster than it would be to use str and ldr instructions to copy the data. While copying data, the CPU is stalled.]{.c1}

[]{#NES.xhtml#t.529fd0b7b6c6112b07e37b86cf3de0f87c25e96e} []{#NES.xhtml#t.18}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [oamdma]{.c1}   | [input]{.c1}    | [PPU]{.c1}      | [When written   |
|                 |                 |                 | to, the DMA     |
|                 |                 |                 | will begin      |
|                 |                 |                 | copying data to |
|                 |                 |                 | the OAM. If the |
|                 |                 |                 | value written   |
|                 |                 |                 | here is XX then |
|                 |                 |                 | the data that   |
|                 |                 |                 | will be copied  |
|                 |                 |                 | begins at the   |
|                 |                 |                 | address XX00 in |
|                 |                 |                 | the CPU RAM and |
|                 |                 |                 | goes until the  |
|                 |                 |                 | address XXFF.   |
|                 |                 |                 | Data will be    |
|                 |                 |                 | copied to the   |
|                 |                 |                 | OAM starting at |
|                 |                 |                 | the OAM address |
|                 |                 |                 | specified in    |
|                 |                 |                 | the OAMADDR     |
|                 |                 |                 | register of the |
|                 |                 |                 | OAM.]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_ram\_q]{. | [input]{.c1}    | [CPU RAM]{.c1}  | [Data read in   |
| c1}             |                 |                 | from CPU RAM    |
|                 |                 |                 | will come       |
|                 |                 |                 | here]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_done]{.c1 | [output]{.c1}   | [CPU]{.c1}      | [Informs the    |
| }               |                 |                 | CPU to pause    |
|                 |                 |                 | while the DMA   |
|                 |                 |                 | copies OAM data |
|                 |                 |                 | from the CPU    |
|                 |                 |                 | RAM to the OAM  |
|                 |                 |                 | section of the  |
|                 |                 |                 | PPU RAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_ram\_addr | [output]{.c1}   | [CPU RAM]{.c1}  | [The address of |
| ]{.c1}          |                 |                 | the CPU RAM     |
|                 |                 |                 | where we are    |
|                 |                 |                 | reading         |
|                 |                 |                 | data]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_ram\_wr]{ | [output]{.c1}   | [CPU RAM]{.c1}  | [Read/write     |
| .c1}            |                 |                 | enable signal   |
|                 |                 |                 | for CPU         |
|                 |                 |                 | RAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [oam\_data]{.c1 | [output]{.c1}   | [OAM]{.c1}      | [The data that  |
| }               |                 |                 | will be written |
|                 |                 |                 | to the OAM at   |
|                 |                 |                 | the address     |
|                 |                 |                 | specified in    |
|                 |                 |                 | OAMADDR]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_req]{.c1} | [input]{.c1}    | [APU]{.c1}      | [High when the  |
|                 |                 |                 | DMC wants to    |
|                 |                 |                 | use the         |
|                 |                 |                 | DMA]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_ack]{.c1} | [output]{.c1}   | [APU]{.c1}      | [High when data |
|                 |                 |                 | on DMA]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_addr]{.c1 | [input]{.c1}    | [APU]{.c1}      | [Address for    |
| }               |                 |                 | DMA to read     |
|                 |                 |                 | from \*\*       |
|                 |                 |                 | CURRENTLY NOT   |
|                 |                 |                 | USED \*\*]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_data]{.c1 | [output]{.c1}   | [APU]{.c1}      | [Data from DMA  |
| }               |                 |                 | to apu memory   |
|                 |                 |                 | \*\* CURRENTLY  |
|                 |                 |                 | NOT USED        |
|                 |                 |                 | \*\*]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[]{.c1}

[PPU Testbench]{.c42} {#NES.xhtml#h.9f0tphgw8ifs .c0}
---------------------

[In a single frame the PPU outputs 61,440 pixels. Obviously this amount of information would be incredibly difficult for a human to verify as correct by looking at a simulation waveform. This is what drove me to create a testbench capable of rendering full PPU frames to an image. This allowed the process of debugging the PPU to proceed at a much faster rate than if I used waveforms alone. Essentially how the test bench works is the testbench sets the initial PPU state, it lets the PPU render a frame, and then the testbench receives the data for each pixel and generates a PPM file. The testbench can render multiple frames in a row, so the tester can see how the frame output changes as the PPU state changes.]{.c1}

[ ![Untitled Diagram.png](images/image14.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 409.38px; height: 165.80px;"}

[ ![Untitled Diagram.png](images/image17.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 388.22px; height: 240.99px;"}

[PPU Testbench PPM file format]{.c42} {#NES.xhtml#h.dgbwdleazq7q .c0}
-------------------------------------

[The PPM image format is one of the easiest to understand image formats available. This is mostly because of how it is a completely human readable format. A PPM file simply consists of a header, and then pixel data. The header consists of the text “P3” on the first line, followed by the image width and height on the next line, then a max value for each of the rgb components of a pixel on the final line of the header. After the header it is just width \* height rgb colors in row major order.]{.c1}

[]{.c42} {#NES.xhtml#h.bw6eh6f443qx .c0 .c130}
--------

[]{.c42} {#NES.xhtml#h.d1ra2gz6e3hd .c0 .c130}
--------

[PPU Testbench Example Renderings]{.c42} {#NES.xhtml#h.8ijczpvs4ut5 .c0}
----------------------------------------

[ ![test (1).png](images/image5.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 197.53px; height: 186.50px;"} [ ![test (2).png](images/image7.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 200.68px; height: 187.50px;"} [ ![test (3).png](images/image6.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 199.53px; height: 189.50px;"} [ ![test (4).png](images/image19.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 202.30px; height: 187.50px;"} [ ![test (5).png](images/image26.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 201.50px; height: 187.67px;"} [ ![test (10).png](images/image8.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 198.60px; height: 186.50px;"}

5.  [Memor]{} [y Maps]{} {#NES.xhtml#h.7c1koopsou4c style="display:inline"}
    ====================

[Cartridges are a Read-Only Memory that contains necessary data to run games. However, it is possible that in some cases that a cartridge holds more data than the CPU can address to. In this case, memory mapper comes into play and changes the mapping as needed so that one address can point to multiple locations in a cartridge. For our case, the end goal was to get the game Super Mario Bros. running on our FPGA. This game does not use a memory mapper, so we did not work on any memory mappers. In the future, we might add support for the other memory mapping systems so that we can play other games.]{.c1}

[These were two ip catalog ROM blocks that are created using MIF files for Super Mario Bros. They contained the information for the CPU and PPU RAM and VRAM respectively.]{.c1}

[]{.c42} {#NES.xhtml#h.zhfrfx8b7pvg .c0 .c130}
--------

[PPU ROM Memory Map]{.c42} {#NES.xhtml#h.o4bj1b7uzlbc .c0}
--------------------------

[This table shows how the PPU’s memory is laid out. The Registers are explained in greater detail in the Architecture Document.]{.c1}

[]{#NES.xhtml#t.d3aeb09ef995373f509588bfbe093c2a247a33be} []{#NES.xhtml#t.19}

+-----------------------------------+-----------------------------------+
| [Address Range]{.c9}              | [Description]{.c9}                |
+-----------------------------------+-----------------------------------+
| [0x0000 - 0x0FFF]{.c1}            | [Pattern Table 0]{.c1}            |
+-----------------------------------+-----------------------------------+
| [0x1000 - 0x1FFF]{.c1}            | [Pattern Table 1]{.c1}            |
+-----------------------------------+-----------------------------------+
| [0x2000 - 0x23BF]{.c1}            | [Name Table 0]{.c1}               |
+-----------------------------------+-----------------------------------+
| [0x23C0 - 0x23FF]{.c1}            | [Attribute Table 0]{.c1}          |
+-----------------------------------+-----------------------------------+
| [0x2400 - 0x27BF]{.c1}            | [Name Table 1]{.c1}               |
+-----------------------------------+-----------------------------------+
| [0x27C0 - 0x27FF]{.c1}            | [Attribute Table 1]{.c1}          |
+-----------------------------------+-----------------------------------+
| [0x2800 - 0x2BBF]{.c1}            | [Name Table 2]{.c1}               |
+-----------------------------------+-----------------------------------+
| [0x2BC0 - 0x2BFF]{.c1}            | [Attribute Table 2]{.c1}          |
+-----------------------------------+-----------------------------------+
| [0x2C00 - 0x2FBF]{.c1}            | [Name Table 3]{.c1}               |
+-----------------------------------+-----------------------------------+
| [0x2FC0 - 0x2FFF]{.c1}            | [Attribute Table 3]{.c1}          |
+-----------------------------------+-----------------------------------+
| [0x3000 - 0x3EFF]{.c1}            | [Mirrors 0x2000 - 0x2EFF]{.c1}    |
+-----------------------------------+-----------------------------------+
| [0x3F00 - 0x3F0F]{.c1}            | [Background Palettes]{.c1}        |
+-----------------------------------+-----------------------------------+
| [0x3F10 - 0x3F1F]{.c1}            | [Sprite Palettes]{.c1}            |
+-----------------------------------+-----------------------------------+
| [0x3F20 - 0x3FFF]{.c1}            | [Mirrors 0x3F00 - 0x3F1F]{.c1}    |
+-----------------------------------+-----------------------------------+
| [0x4000 - 0xFFFF]{.c1}            | [Mirrors 0x0000 - 0x3FFF]{.c1}    |
+-----------------------------------+-----------------------------------+

[]{.c1}

[CPU ROM Memory Map]{.c42} {#NES.xhtml#h.n5cypllda98c .c0}
--------------------------

[This table explains how the CPU’s memory is laid out. The Registers are explained in greater detail in the Architecture document.]{.c1}

[]{#NES.xhtml#t.3ea006ae6c40b543eff9ac9fa3559a879d0621f6} []{#NES.xhtml#t.20}

+-----------------------------------+-----------------------------------+
| [Address Range]{.c9}              | [Description]{.c9}                |
+-----------------------------------+-----------------------------------+
| [0x0000 - 0x00FF]{.c1}            | [Zero Page]{.c1}                  |
+-----------------------------------+-----------------------------------+
| [0x0100 - 0x1FF]{.c1}             | [Stack]{.c1}                      |
+-----------------------------------+-----------------------------------+
| [0x0200 - 0x07FF]{.c1}            | [RAM]{.c1}                        |
+-----------------------------------+-----------------------------------+
| [0x0800 - 0x1FFF]{.c1}            | [Mirrors 0x0000 - 0x07FF]{.c1}    |
+-----------------------------------+-----------------------------------+
| [0x2000 - 0x2007]{.c1}            | [Registers]{.c1}                  |
+-----------------------------------+-----------------------------------+
| [0x2008 - 0x3FFF]{.c1}            | [Mirrors 0x2000 - 0x2007]{.c1}    |
+-----------------------------------+-----------------------------------+
| [0x4000 - 0x401F]{.c1}            | [I/O Registers]{.c1}              |
+-----------------------------------+-----------------------------------+
| [0x4020 - 0x5FFF]{.c1}            | [Expansion ROM]{.c1}              |
+-----------------------------------+-----------------------------------+
| [0x6000 - 0x7FFF]{.c1}            | [SRAM]{.c1}                       |
+-----------------------------------+-----------------------------------+
| [0x8000 - 0xBFFF]{.c1}            | [Program ROM Lower Bank]{.c1}     |
+-----------------------------------+-----------------------------------+
| [0xC000 - 0xFFFF]{.c1}            | [Program ROM Upper Bank]{.c1}     |
+-----------------------------------+-----------------------------------+

[]{.c1}

[Memory Mappers Interface]{.c42} {#NES.xhtml#h.5cvhenp51lun .c0}
--------------------------------

[]{#NES.xhtml#t.a7c474da3306d0e8e99e8d3a20902e581a1043cc} []{#NES.xhtml#t.21}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [rd]{.c1}       | [input]{.c1}    | [CPU/PPU]{.c1}  | [Read           |
|                 |                 |                 | request]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c1}     | [input]{.c1}    | [CPU/PPU]{.c1}  | [Address to     |
|                 |                 |                 | read from]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [data]{.c1}     | [output]{.c1}   | [CPU/PPU]{.c1}  | [Data from the  |
|                 |                 |                 | address]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+

------------------------------------------------------------------------

[]{.c138 .c43} {#NES.xhtml#h.8bsdqknl6reb .c53}
==============

6.  [APU]{.c138 .c43} {#NES.xhtml#h.bryqhbcn7knu style="display:inline"}
    =================

[Due to limitations of our FPGA design board (no D2A converter) and time constraints, our group did not implement the APU. Instead, we created the register interface for the APU, so that the CPU could still read and write from the registers. The following section is provided for reference only.]{.c1}

[The NES included an Audio Processing Unit (APU) to control all sound output. The APU contains five audio channels: two pulse wave modulation channels, a triangle wave channel, a noise channel (fo]{} [r]{} [ random audio), and a delta modulation channel. Each channel is mapped to registers in the CPU’s address space and each channel runs independently of the others. The outputs of all five channels are then combined using a non-linear mixing scheme. The APU also has a dedicated APU Status register. A write to this register can enable/disable any of the five channels. A read to this register can tell you if each channel still has a positive count on their respective timers. In addition, a read to this register will reveal any DMC or frame interrupts.]{.c1}

[ APU Registers]{.c42} {#NES.xhtml#h.qk56hr19gphj .c0}
----------------------

[]{#NES.xhtml#t.ef2c0e3f9254f624e8fccd0f50ed51a04d039588} []{#NES.xhtml#t.22}

<table class="c98">
<tbody>
<tr class="c213">
<td class="c122 c174" colspan="4" rowspan="1">
[Registers]{.c9}

</td>
</tr>
<tr class="c6">
<td class="c48" colspan="1" rowspan="1">
[\$4000]{.c1}

</td>
<td class="c139" colspan="1" rowspan="1">
[First pulse wave]{.c1}

</td>
<td class="c128" colspan="1" rowspan="1">
[DDLC VVVV]{.c1}

</td>
<td class="c198" colspan="1" rowspan="1">
[Duty, Envelope Loop, Constant Volume, Volume]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4001]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[First pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[EPPP NSSS]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Enabled, Period, Negate, Shift]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4002]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[First pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[TTTT TTTT]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Timer low]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4003]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[First pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[LLLL LTTT]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Length counter load, Timer high]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4004]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Second pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[DDLC VVVV]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Duty, Envelope Loop, Constant Volume, Volume]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4005]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Second pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[EPPP NSSS]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Enabled, Period, Negate, Shift]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4006]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Second pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[TTTT TTTT]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Timer low]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4007]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Second pulse wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[LLLL LTTT]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Length counter load, Timer high]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4008]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Triangle wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[CRRR RRRR]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Length counter control, linear count load]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4009]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Triangle wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Unused]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$400A]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Triangle wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[TTTT TTTT]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Timer low]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$400B]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Triangle wave]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[LLLL LTTT]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Length counter load, Timer high]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$400C]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Noise Channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[--LC  VVVV]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Envelope Loop, Constant Volume, Volume]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$400D]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Noise Channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Unused]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$400E]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Noise Channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[L---  PPPP]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Loop Noise, Noise Period]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$400F]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Noise Channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[LLLL  L---]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Length counter load]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4010]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Delta modulation channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[IL-- FFFF]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[IRQ enable, Loop, Frequency]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4011]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Delta modulation channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[-LLL  LLLL]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Load counter]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4012]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Delta modulation channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[AAAA AAAA]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Sample Address]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4013]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Delta modulation channel]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[LLLL LLLL]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Sample Length]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4015 (write)]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[APU Status Register Writes]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[---D NT21]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Enable DMC, Enable Noise, Enable Triangle, Enable Pulse 2/1]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4015 (read)]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[APU Status Register Read]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[IF-D NT21]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[DMC Interrupt, Frame Interrupt, DMC Active, Length Counter &gt; 0 for Noise, Triangle, and Pulse Channels]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4017 (write)]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[APU Frame Counter]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[MI-- ----]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Mode (0 = 4 step, 1 = 5 step), IRQ inhibit flag]{.c1}

</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

[]{.c138 .c43} {#NES.xhtml#h.rssy9kfs4hbb .c53}
==============

7.  [Controllers (SPART)]{.c138 .c43} {#NES.xhtml#h.5fhzf7bk1zke style="display:inline"}
    =================================

[The controller module allows users to provide input to the FPGA. We opted to create a controller simulator program instead of using an actual NES joypad. This decision was made because the NES controllers used a proprietary port and because the available USB controllers lacked specification sheets. The simulator program communicates with the FPGA using the SPART interface, which is similar to UART. Our SPART module used 8 data bits, no parity, and 1 stop bit for serial communication. All data was received automatically into an 8 bit buffer by the SPART module at 2400 baud. In addition to the SPART module, we also needed a controller driver to allow the CPU to interface with the controllers. The controllers are memory mapped to \$4016 and \$4017 for CPU to read.]{.c1}

[When writing high to address \$4016 bit 0, the controllers are continuously loaded with the states of each button. Once address \$4016 bit 0 is cleared, the data from the controllers can be read by reading from address \$4016 for player 1 or \$4017 for player 2. The data will be read in serially on bit 0. The first read will return the state of button A, then B, Select, Start, Up, Down, Left, Right. It will read 1 if the button is pressed and 0 otherwise. Any read after clearing \$4016 bit 0 and after reading the first 8 button values, will be a 1. If the CPU reads when before clearing \$4016, the state of button A with be repeatedly returned.]{.c1}

[Debug Modification]{.c42} {#NES.xhtml#h.927n2dvl8df9 .c0}
--------------------------

[In order to provide an easy way to debug our top level design, we modified the controller to send an entire ram block out over SPART when it receives the send\_states signal. This later allowed us to record the PC, IR, A, X, Y, flags, and SP of the CPU into a RAM block every CPU clock cycle and print this out onto a terminal console when we reached a specific PC.]{.c1}

[Controller Registers]{.c42} {#NES.xhtml#h.917ivz4m4ziu .c39}
----------------------------

[]{#NES.xhtml#t.f48da44243cd4a3f2f9d86b2a46e440bbc5c870d} []{#NES.xhtml#t.23}

<table class="c98">
<tbody>
<tr class="c213">
<td class="c174 c122" colspan="4" rowspan="1">
[Registers]{.c9}

</td>
</tr>
<tr class="c6">
<td class="c48" colspan="1" rowspan="1">
[\$4016 (write)]{.c1}

</td>
<td class="c139" colspan="1" rowspan="1">
[Controller Update]{.c1}

</td>
<td class="c128" colspan="1" rowspan="1">
[---- ---C]{.c1}

</td>
<td class="c198" colspan="1" rowspan="1">
[Button states of both controllers are loaded]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4016 (read)]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Controller 1 Read]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[---- ---C]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Reads button states of controller 1 in the order A, B, Start, Select, Up, Down, Left, Right]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
[\$4017 (read)]{.c1}

</td>
<td class="c110" colspan="1" rowspan="1">
[Controller 2 Read]{.c1}

</td>
<td class="c3" colspan="1" rowspan="1">
[---- ---C]{.c1}

</td>
<td class="c50" colspan="1" rowspan="1">
[Reads button states of controller 2 in the order A, B, Start, Select, Up, Down, Left, Right]{.c1}

</td>
</tr>
</tbody>
</table>
[Controllers Wrapper]{.c42} {#NES.xhtml#h.bnnsrcv0r4jw .c0}
---------------------------

[The controllers wrapper acts as the top level interface for the controllers. It instantiates two Controller modules and connects each one to separate TxD RxD lines. In addition, the Controllers wrapper handles passing the cs, addr, and rw lines into the controllers correctly. Both controllers receive an address of 0 for controller writes, while controller 1 will receive address 0 for reads and controller 2 will receive address 1. ]{.c1}

### [Controller Wrapper Diagram]{.c85 .c43} {#NES.xhtml#h.o12jcpl1v6h2 .c78}

[ ![](images/image16.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 431.00px; height: 271.48px;"}

### [Controller Wrapper Interface]{.c85 .c43} {#NES.xhtml#h.b5ap3afv7f57 .c23 .c109}

[]{#NES.xhtml#t.547db5e3cba569b697a57d71bdba389e98fcd63f} []{#NES.xhtml#t.24}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c146}    | Type]{.c146}    | c146}           | c146}           |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [TxD1]{.c1}     | [output]{.c1}   | [UART]{.c1}     | [Transmit data  |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 1]{.c1}         |
+-----------------+-----------------+-----------------+-----------------+
| [TxD2]{.c1}     | [output]{.c1}   | [UART]{.c1}     | [Transmit data  |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 2]{.c1}         |
+-----------------+-----------------+-----------------+-----------------+
| [RxD1]{.c1}     | [input]{.c1}    | [UART]{.c1}     | [Receive data   |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 1]{.c1}         |
+-----------------+-----------------+-----------------+-----------------+
| [RxD2]{.c1}     | [input]{.c1}    | [UART]{.c1}     | [Receive data   |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 2]{.c1}         |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c1}     | [input]{.c1}    | [CPU]{.c1}      | [Controller     |
|                 |                 |                 | address, 0 for  |
|                 |                 |                 | \$4016, 1 for   |
|                 |                 |                 | \$4017]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [cpubus\[7:0\]] | [inout]{.c1}    | [CPU]{.c1}      | [Data from/to   |
| {.c1}           |                 |                 | the CPU]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [cs]{.c1}       | [input]{.c1}    | [CPU]{.c1}      | [Chip           |
|                 |                 |                 | select]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [rw]{.c1}       | [input]{.c1}    | [CPU]{.c1}      | [Read/Write     |
|                 |                 |                 | signal (high    |
|                 |                 |                 | for             |
|                 |                 |                 | reads)]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [rx\_data\_peek | [output]{.c1}   | [LEDR\[7:0\]]{. | [Output states  |
| ]{.c1}          |                 | c1}             | to the FPGA     |
|                 |                 |                 | LEDs to show    |
|                 |                 |                 | that input was  |
|                 |                 |                 | being           |
|                 |                 |                 | received]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [send\_states]{ | [input]{.c1}    | []{.c1}         | [When this      |
| .c1}            |                 |                 | signal goes     |
|                 |                 |                 | high, the       |
|                 |                 |                 | controller      |
|                 |                 |                 | begins          |
|                 |                 |                 | outputting RAM  |
|                 |                 |                 | data]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpuram\_q]{.c1 | [input]{.c1}    | [CPU RAM]{.c1}  | [Stored CPU     |
| }               |                 |                 | states from the |
|                 |                 |                 | RAM block]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_addr]{.c1} | [output]{.c1}   | [CPU RAM]{.c1}  | [The address    |
|                 |                 |                 | the controller  |
|                 |                 |                 | is writing out  |
|                 |                 |                 | to SPART]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd]{.c1}       | [output]{.c1}   | [CPU RAM]{.c1}  | [High when      |
|                 |                 |                 | controller is   |
|                 |                 |                 | reading from    |
|                 |                 |                 | CPU RAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[Controller]{.c42} {#NES.xhtml#h.ddzvq2rctlzt .c0}
------------------

[The controller module instantiates the Driver and SPART module’s.]{.c1}

### [Controller Diagram]{.c85 .c43} {#NES.xhtml#h.ml0lp3awxz0e .c0}

[ ![](images/image21.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 444.76px; height: 242.50px;"}

### [Controller Interface]{.c85 .c43} {#NES.xhtml#h.8148udv35isa .c0}

[]{#NES.xhtml#t.bb0222080501ccd3509902d3def0cd1f0ab3985c} []{#NES.xhtml#t.25}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [TxD]{.c1}      | [output]{.c1}   | [UART]{.c1}     | [Transmit data  |
|                 |                 |                 | line]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [RxD]{.c1}      | [input]{.c1}    | [UART]{.c1}     | [Receive data   |
|                 |                 |                 | line]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c1}     | [input]{.c1}    | [CPU]{.c1}      | [Controller     |
|                 |                 |                 | address 0 for   |
|                 |                 |                 | \$4016, 1 for   |
|                 |                 |                 | \$4017]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [dout\[7:0\]]{. | [inout]{.c1}    | [CPU]{.c1}      | [Data from/to   |
| c1}             |                 |                 | the CPU]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [cs]{.c1}       | [input]{.c1}    | [CPU]{.c1}      | [Chip           |
|                 |                 |                 | select]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [rw]{.c1}       | [input]{.c1}    | [CPU]{.c1}      | [Read write     |
|                 |                 |                 | signal (low for |
|                 |                 |                 | writes)]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [rx\_data\_peek | [output]{.c1}   | [LEDR]{.c1}     | [Outputs button |
| ]{.c1}          |                 |                 | states to FPGA  |
|                 |                 |                 | LEDs]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [send\_states]{ | [input]{.c1}    | []{.c1}         | [When this      |
| .c1}            |                 |                 | signal goes     |
|                 |                 |                 | high, the       |
|                 |                 |                 | controller      |
|                 |                 |                 | begins          |
|                 |                 |                 | outputting RAM  |
|                 |                 |                 | data]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpuram\_q]{.c1 | [input]{.c1}    | [CPU RAM]{.c1}  | [Stored CPU     |
| }               |                 |                 | states from the |
|                 |                 |                 | RAM block]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_addr]{.c1} | [output]{.c1}   | [CPU RAM]{.c1}  | [The address    |
|                 |                 |                 | the controller  |
|                 |                 |                 | is writing out  |
|                 |                 |                 | to SPART]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd]{.c1}       | [output]{.c1}   | [CPU RAM]{.c1}  | [High when      |
|                 |                 |                 | controller is   |
|                 |                 |                 | reading from    |
|                 |                 |                 | CPU RAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[Special Purpose Asynchronous Receiver and Transmitter (SPART)]{.c42} {#NES.xhtml#h.fna8vaz47pc1 .c23 .c109}
---------------------------------------------------------------------

[The SPART Module is used to receive serial data. The SPART and driver share many interconnections in order to control the reception and transmission of data. On the left, the SPART interfaces to an 8- bit, 3-state bidirectional bus, DATABUS\[7:0\]. This bus is used to transfer data and control information between the driver and the SPART. In addition, there is a 2-bit address bus, IOADDR\[1:0\] which is used to select the particular register that interacts with the DATABUS during an I/O operation. The IOR/W signal determines the direction of data transfer between the driver and SPART. For a Read (IOR/W=1), data is transferred from the SPART to the driver and for a Write (IOR/W=0), data is transferred from the driver to the SPART. IOCS and IOR/W are crucial signals in properly controlling the three-state buffer on DATABUS within the SPART. Receive Data Available (RDA), is a status signal which indicates that a byte of data has been received and is ready to be read from the SPART to the Processor. When the read operation is performed, RDA is reset. Transmit Buffer Ready (TBR) is a status signal which indicates that the transmit buffer in the SPART is ready to accept a byte for transmission. When a write operation is performed and the SPART is not ready for more transmission data, TBR is reset. The SPART is fully synchronous with the clock signal CLK; this implies that transfers between the driver and SPART can be controlled by applying IOCS, IOR/W, IOADDR, and DATABUS (in the case of a write operation) for a single clock cycle and capturing the transferred data on the next positive clock edge. The received data on RxD, however, is asynchronous with respect]{.c28} [ ]{} [to CLK. Also, the serial I/O port on the workstation which receives the transmitted data from TxD has no access to CLK. This interface thus constitutes the “A” for “Asynchronous” in SPART and requires an understanding of RS-232 signal timing and (re)synchronization.]{.c28}

<h3 class="c0" id="h.9khtivok6lhm">
[SPART Diagram & Interface]{}

------------------------------------------------------------------------

[ ![](images/image11.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 491.16px; height: 308.00px;"}

</h3>
[Controller Driver]{.c42} {#NES.xhtml#h.fxadt5ql4b59 .c23 .c109}
-------------------------

[The controller driver is tasked with reloading the controller button states from the SPART receiver buffer when address \$4016 (or \$0 from controller’s point of view) is set. In addition, the driver must grab the CPU databus on a read and place a button value on bit 0. On the first read, the button state of value A is placed on the databus, followed by B, Select, Start, Up, Down, Left, Right. The value will be 1 for pressed and 0 for not pressed. After reading the first 8 buttons, the driver will output a 0 on the databus. Lastly, the controller driver can also be used to control the SPART module to output to the UART port of the computer.]{.c1}

### [Controller Driver State Machine]{.c85 .c43} {#NES.xhtml#h.yma1hmwj1wcp .c0}

[ ![](images/image13.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 549.33px;"}

------------------------------------------------------------------------

[]{.c138 .c43} {#NES.xhtml#h.q1sq1qgr8jci .c53}
==============

8.  [VGA]{.c138 .c43} {#NES.xhtml#h.xrfacxsmruiq style="display:inline"}
    =================

[The VGA interface consists of sending the pixel data to the screen one row at a time from left to right. In between each row it requires a special signal called horizontal sync (hsync) to be asserted at a specific time when only black pixels are being sent, called the blanking interval. This happens until the bottom of the screen is reached when another blanking interval begins where the interface is only sending black pixels, but instead of hsync being asserted the vertical sync signal is asserted. ]{.c1}

[ ![](images/image23.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 350.00px; height: 266.00px;"}

[The main difficulty with the VGA interface will be designing a system to take the PPU output (a 256x240 image) and converting it into a native resolution of 640x480 or 1280x960. This was done by adding two RAM blocks to buffer the data.]{.c1}

[VGA Diagram]{.c42} {#NES.xhtml#h.7dmryvqi4l3b .c0}
-------------------

[ ![](images/image24.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 527.40px; height: 285.54px;"}

[VGA Interface]{.c42} {#NES.xhtml#h.7b41ivlnuec0 .c23 .c109}
---------------------

[]{#NES.xhtml#t.0b4df1c79bd101595fde9cf3c1fde60b0b71da17} []{#NES.xhtml#t.26}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [V\_BLANK\_N]{. | [output]{.c1}   | []{.c1}         | [Syncing each   |
| c1}             |                 |                 | pixel]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_R\[7:0\]] | [output]{.c1}   | []{.c1}         | [Red pixel      |
| {.c1}           |                 |                 | value]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_G\[7:0\]] | [output]{.c1}   | []{.c1}         | [Green pixel    |
| {.c1}           |                 |                 | value]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_B\[7:0\]] | [output]{.c1}   | []{.c1}         | [Blue pixel     |
| {.c1}           |                 |                 | value]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_CLK]{.c1} | [output]{.c1}   | []{.c1}         | [VGA            |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_HS]{.c1}  | [output]{.c1}   | []{.c1}         | [Horizontal     |
|                 |                 |                 | line sync]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_SYNC\_N]{ | [output]{.c1}   | []{.c1}         | [0]{.c1}        |
| .c1}            |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_VS]{.c1}  | [output]{.c1}   | []{.c1}         | [Vertical line  |
|                 |                 |                 | sync]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [pixel\_data\[7 | [input]{.c1}    | [PPU]{.c1}      | [Pixel data to  |
| :0\]]{.c1}      |                 |                 | be sent to the  |
|                 |                 |                 | display]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [ppu\_clock]{.c | [input]{.c1}    | [PPU]{.c1}      | [pixel data is  |
| 1}              |                 |                 | updated every   |
|                 |                 |                 | ppu clock       |
|                 |                 |                 | cycle]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rendering]{.c1 | [input]{.c1}    | [PPU]{.c1}      | [high when PPU  |
| }               |                 |                 | is              |
|                 |                 |                 | rendering]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_end]{.c | [input]{.c1}    | [PPU]{.c1}      | [high at the    |
| 1}              |                 |                 | end of a PPU    |
|                 |                 |                 | frame]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_start]{ | [input]{.c1}    | [PPU]{.c1}      | [high at start  |
| .c1}            |                 |                 | of PPU          |
|                 |                 |                 | frame]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

[VGA Clock Gen]{.c42} {#NES.xhtml#h.w1ger0jiy8bk .c0}
---------------------

[This module takes in a 50MHz system clock and creates a 25.175MHz clock, which is the standard VGA clock speed.]{.c1}

[]{#NES.xhtml#t.db67cd3b6f294595ac31a0aea59a47ead9f1be93} []{#NES.xhtml#t.27}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_CLK]{}    | [output]{}      | [VGA]{.c1}      | [Clock synced   |
|                 |                 |                 | to VGA          |
|                 |                 |                 | timing]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+
| [locked]{.c1}   | [output]{.c1}   | []{.c1}         | [Locks VGA      |
|                 |                 |                 | until clock is  |
|                 |                 |                 | ready]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+

[VGA Timing Gen]{.c42} {#NES.xhtml#h.pw3svolg7ia .c0}
----------------------

[This block is responsible for generating the timing signals for VGA with a screen resolution of 480x640. This includes the horizontal and vertical sync signals as well as the blank signal for each pixel.]{.c1}

[]{#NES.xhtml#t.479f40eaa1ae54a4dbe23dc6f8fb1ac9c0dbacf1} []{#NES.xhtml#t.28}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_CLK]{.c1} | [input]{.c1}    | [Clock          | [vga\_clk]{.c1} |
|                 |                 | Gen]{.c1}       |                 |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [V\_BLANK\_N]{. | [output]{.c1}   | [VGA, Ram       | [Syncing each   |
| c1}             |                 | Reader]{.c1}    | pixel]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_HS]{.c1}  | [output]{.c1}   | [VGA]{.c1}      | [Horizontal     |
|                 |                 |                 | line sync]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_VS]{.c1}  | [output]{.c1}   | [VGA]{.c1}      | [Vertical line  |
|                 |                 |                 | sync]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c42} {#NES.xhtml#h.37cy90rx7ygb .c0 .c130}
--------

[VGA Display Plane]{.c42} {#NES.xhtml#h.em4ktvbwfn8k .c0}
-------------------------

[The PPU will output sprite and background pixels to the VGA module, as well as enables for each. The display plane will update the RAM block at the appropriate address with the pixel data on every PPU clock cycle when the PPU is rendering.]{.c1}

[]{#NES.xhtml#t.5a3c07c6be733afbbfea8913bd13a94fa777ca2d} []{#NES.xhtml#t.29}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | [System         |
|                 |                 |                 | clock]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [ppu\_clock]{.c | [input]{.c1}    | [PPU]{.c1}      | [Clock speed    |
| 1}              |                 |                 | that the pixels |
|                 |                 |                 | from the PPU    |
|                 |                 |                 | come in]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_address]{. | [input]{.c1}    | [RAM]{.c1}      | [Address to     |
| c1}             |                 |                 | write to]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_req]{.c1}  | [output]{.c1}   | [RAM]{.c1}      | [Write data to  |
|                 |                 |                 | the RAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[7:0 | [output]{.c1}   | [RAM]{.c1}      | [The pixel data |
| \]]{.c1}        |                 |                 | to store in     |
|                 |                 |                 | RAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [pixel\_data\[7 | [input]{.c1}    | [PPU]{.c1}      | [Pixel data to  |
| :0\]]{.c1}      |                 |                 | be sent to the  |
|                 |                 |                 | display]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [rendering]{.c1 | [input]{.c1}    | [PPU]{.c1}      | [high when PPU  |
| }               |                 |                 | is              |
|                 |                 |                 | rendering]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_start]{ | [input]{.c1}    | [PPU]{.c1}      | [high at start  |
| .c1}            |                 |                 | of PPU          |
|                 |                 |                 | frame]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c42} {#NES.xhtml#h.df616f9pyhcf .c0 .c130}
--------

[VGA RAM Wrapper]{.c42} {#NES.xhtml#h.68btkfb1o5ru .c0}
-----------------------

[This module instantiates two 2-port RAM blocks and using control signals, it will have the PPU write to a specific RAM block, while the VGA reads from another RAM block. The goal of this module was to make sure that the PPU writes never overlap the VGA reads, because the PPU runs at a faster clock rate. ]{.c1}

[]{#NES.xhtml#t.73d8ab931bb1de11920ee6fbbb98ace8684a3d59} []{#NES.xhtml#t.30}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | []{.c1}         |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_address]{. | [input]{.c1}    | [Display        | [Address to     |
| c1}             |                 | Plane]{.c1}     | write to]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_req]{.c1}  | [input]{.c1}    | [Display        | [Request to     |
|                 |                 | Plane]{.c1}     | write           |
|                 |                 |                 | data]{.c1}      |
+-----------------+-----------------+-----------------+-----------------+
| [data\_in\[5:0\ | [input]{.c1}    | [Display        | [The data into  |
| ]]{.c1}         |                 | Plane]{.c1}     | the RAM]{.c1}   |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_req]{.c1}  | [input]{.c1}    | [RAM            | [Read data out  |
|                 |                 | Reader]{.c1}    | from RAM]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_address]{. | [input]{.c1}    | [RAM            | [Address to     |
| c1}             |                 | Reader]{.c1}    | read from]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[5:0 | [output]{.c1}   | [RAM            | [data out from  |
| \]]{.c1}        |                 | Reader]{.c1}    | RAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [ppu\_frame\_en | [input]{.c1}    | [PPU]{.c1}      | [high at the    |
| d]{.c1}         |                 |                 | end of a PPU    |
|                 |                 |                 | frame]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [vga\_frame\_en | [input]{.c1}    | [VGA]{.c1}      | [high at end of |
| d]{.c1}         |                 |                 | VGA frame]{.c1} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c42} {#NES.xhtml#h.jz3qq69r11pa .c0 .c130}
--------

[VGA RAM Reader]{.c42} {#NES.xhtml#h.1cvttmqqni8n .c39}
----------------------

[The RAM Reader is responsible for reading data from the correct address in the RAM block and outputting it as an RGB signal to the VGA. It will update the RGB signals every time the blank signal goes high. The NES supported a 256x240 image, which we will be converting to a 640x480 image. This means that the 256x240 image will be multiplied by 2, resulting in a 512x480 image. The remaining 128 pixels on the horizontal line will be filled with black pixels by this block. Lastly, this block will take use the pixel data from the PPU and the NES Palette RGB colors, to output the correct colors to the VGA.]{.c1}

[]{.c1}

[]{.c1}

[]{#NES.xhtml#t.42c807ab21e38b5395f49bf60866dd95219157f1} []{#NES.xhtml#t.31}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c9}      | Type]{.c9}      | c9}             | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c1}      | [input]{.c1}    | []{.c1}         | []{.c1}         |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c1}   | [input]{.c1}    | []{.c1}         | [System active  |
|                 |                 |                 | low reset]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_req]{.c1}  | [output]{.c1}   | [RAM]{.c1}      | [Read data out  |
|                 |                 |                 | from RAM]{.c1}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_address]{. | [output]{.c1}   | [RAM]{.c1}      | [Address to     |
| c1}             |                 |                 | read from]{.c1} |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[7:0 | [input]{.c1}    | [RAM]{.c1}      | [data out from  |
| \]]{.c1}        |                 |                 | RAM]{.c1}       |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_R\[7:0\]] | [output]{.c1}   | []{.c1}         | [VGA Red pixel  |
| {.c1}           |                 |                 | value]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_G\[7:0\]] | [output]{.c1}   | []{.c1}         | [VGA Green      |
| {.c1}           |                 |                 | pixel           |
|                 |                 |                 | value]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_B\[7:0\]] | [output]{.c1}   | []{.c1}         | [VGA Blue pixel |
| {.c1}           |                 |                 | value]{.c1}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_Blnk\[7:0 | [input]{.c1}    | [Time Gen]{.c1} | [VGA Blank      |
| \]]{.c1}        |                 |                 | signal (high    |
|                 |                 |                 | when we write   |
|                 |                 |                 | each new        |
|                 |                 |                 | pixel)]{.c1}    |
+-----------------+-----------------+-----------------+-----------------+

------------------------------------------------------------------------

[]{.c138 .c43} {#NES.xhtml#h.mtl1jtr6nihn .c53}
==============

9.  [Software]{.c138 .c43} {#NES.xhtml#h.zbj1aj20rigt style="display:inline"}
    ======================

[Controller Simulator]{.c42} {#NES.xhtml#h.ik7f7bcto722 .c0}
----------------------------

[In order to play games on the NES and provide input to our FPGA, we will have a java program that uses the JSSC (Java Simple Serial Connector) library to read and write data serially using the SPART interface. The program will provides a GUI that was created using the JFrame library. This GUI will respond to mouse clicks as well as key presses when the window is in focus. When a button state on the simulator is changed, it will trigger the program to send serial data. When data is detected on the rx line, the simulator will read in the data (every time there is 8 bytes in the buffer) and will output this data as a CPU trace to an output file. Instructions to invoke this program can be found in the README file of our github directory.]{.c1}

### [Controller Simulator State Machine ]{.c85 .c43} {#NES.xhtml#h.ev3eyvc4m806 .c0}

[ ![](images/image25.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 346.76px; height: 336.00px;"}

### [Controller Simulator Output Packet Format]{.c85 .c43} {#NES.xhtml#h.xqfqy7n0dj86 .c39}

[]{#NES.xhtml#t.ad9e3dcf59b3c7f193497b3a552afdad72d4c697} []{#NES.xhtml#t.32}

+-----------------+-----------------+-----------------+-----------------+
| [Packet         | [Packet         | [Packet         | [Description]{. |
| name]{.c9}      | type]{.c9}      | Format]{.c9}    | c9}             |
+-----------------+-----------------+-----------------+-----------------+
| [Controller     | [output]{.c1}   | [ABST-UDLR]{.c1 | [This packet    |
| Data]{.c1}      |                 | }               | indicates which |
|                 |                 |                 | buttons are     |
|                 |                 |                 | being pressed.  |
|                 |                 |                 | A 1 indicates   |
|                 |                 |                 | pressed, a 0    |
|                 |                 |                 | indicates not   |
|                 |                 |                 | pressed. ]{.c1} |
|                 |                 |                 |                 |
|                 |                 |                 | [(A) A button,  |
|                 |                 |                 | (B) B button,   |
|                 |                 |                 | (S) Select      |
|                 |                 |                 | button, (T)     |
|                 |                 |                 | Start button,   |
|                 |                 |                 | (U) Up, (D)     |
|                 |                 |                 | Down, (L) Left, |
|                 |                 |                 | (R) Right]{.c1} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c1}

### [Controller Simulator GUI and Button Map]{.c43 .c85} {#NES.xhtml#h.wqujxd9v8i1y .c39}

[The NES controller had a total of 8 buttons, as shown below.]{.c1}

[ ![](images/image4.png) ]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 257.33px;"}

[The NES buttons will be mapped to specific keys on the keyboard. The keyboard information will be obtained using KeyListeners in the java.awt.\* library. The following table indicates how the buttons are mapped and their function in Super Mario Bros.]{.c1}

[]{#NES.xhtml#t.ad380988598047a9ceb5cfe38e7d802123c4d7be} []{#NES.xhtml#t.33}

+-----------------------+-----------------------+-----------------------+
| [Keyboard             | [NES Equivalent]{.c9} | [Super Mario Bros.    |
| button]{.c9}          |                       | Function]{.c9}        |
+-----------------------+-----------------------+-----------------------+
| [X Key]{.c1}          | [A Button]{.c1}       | [Jump (Hold to jump   |
|                       |                       | higher)]{.c1}         |
+-----------------------+-----------------------+-----------------------+
| [Z Key]{.c1}          | [B Button]{.c1}       | [Sprint (Hold and use |
|                       |                       | arrow keys)]{.c1}     |
+-----------------------+-----------------------+-----------------------+
| [Tab Key]{.c1}        | [Select Button]{.c1}  | [Pause Game]{.c1}     |
+-----------------------+-----------------------+-----------------------+
| [Enter Key]{}         | [Start Button]{}      | [Start Game]{}        |
+-----------------------+-----------------------+-----------------------+
| [Up Arrow]{.c1}       | [Up on D-Pad]{.c1}    | [No function]{.c1}    |
+-----------------------+-----------------------+-----------------------+
| [Down Arrow]{.c1}     | [Down on D-Pad]{.c1}  | [Enter pipe (only     |
|                       |                       | works on some         |
|                       |                       | pipes)]{.c1}          |
+-----------------------+-----------------------+-----------------------+
| [Left Arrow]{.c1}     | [Left on D-Pad]{.c1}  | [Move left]{.c1}      |
+-----------------------+-----------------------+-----------------------+
| [Right Arrow]{.c1}    | [Right on D-Pad]{.c1} | [Move right]{.c1}     |
+-----------------------+-----------------------+-----------------------+

[]{.c1}

[Assembler]{.c42} {#NES.xhtml#h.t5xpa0jvlbyf .c0}
-----------------

[We will include an assembler that allows custom software to be developed for our console. This assembler will convert assembly code to machine code for the NES on .mif files that we can load into our FPGA. It will include support for labels and commenting.The ISA is specified in the table below:]{.c1}

[]{.c1}

### [Opcode Table]{.c85 .c43} {#NES.xhtml#h.rp3i11uarg1 .c0}

[]{#NES.xhtml#t.a78dffae99888f28a7d901ca905aed1ef15fecc7} []{#NES.xhtml#t.34}

+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [Opco | [Mode | [Hex] | [Opco | [Mode | [Hex] | [Opco | [Mode | [Hex] |
| de]{. | ]{.c1 | {.c11 | de]{. | ]{.c1 | {.c11 | de]{. | ]{.c1 | {.c11 |
| c112  | 12    | 2     | c43   | 12    | 2     | c112  | 12    | 2     |
| .c43} | .c43} | .c43} | .c112 | .c43} | .c43} | .c43} | .c43} | .c43} |
|       |       |       | }     |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Imme | [69]{ | [DEC] | [Zero | [C6]{ | [ORA] | [Abso | [0D]{ |
| {.c1} | diate | .c1}  | {.c1} | Page] | .c1}  | {.c1} | lute] | .c1}  |
|       | ]{.c1 |       |       | {.c1} |       |       | {.c1} |       |
|       | }     |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Zero | [65]{ | [DEC] | [Zero | [D6]{ | [ORA] | [Abso | [1D]{ |
| {.c1} | Page] | .c1}  | {.c1} | Page, | .c1}  | {.c1} | lute, | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Zero | [75]{ | [DEC] | [Abso | [CE]{ | [ORA] | [Abso | [19]{ |
| {.c1} | Page, | .c1}  | {.c1} | lute] | .c1}  | {.c1} | lute, | .c1}  |
|       | X]{.c |       |       | {.c1} |       |       | Y]{.c |       |
|       | 1}    |       |       |       |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Abso | [6D]{ | [DEC] | [Abso | [DE]{ | [ORA] | [Indi | [01]{ |
| {.c1} | lute] | .c1}  | {.c1} | lute, | .c1}  | {.c1} | rect, | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Abso | [7D]{ | [DEX] | [Impl | [CA]{ | [ORA] | [Indi | [11]{ |
| {.c1} | lute, | .c1}  | {.c1} | ied]{ | .c1}  | {.c1} | rect, | .c1}  |
|       | X]{.c |       |       | .c1}  |       |       | Y]{.c |       |
|       | 1}    |       |       |       |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Abso | [79]{ | [DEY] | [Impl | [88]{ | [PHA] | [Impl | [48]{ |
| {.c1} | lute, | .c1}  | {.c1} | ied]{ | .c1}  | {.c1} | ied]{ | .c1}  |
|       | Y]{.c |       |       | .c1}  |       |       | .c1}  |       |
|       | 1}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Indi | [61]{ | [EOR] | [Imme | [49]{ | [PHP] | [Impl | [08]{ |
| {.c1} | rect, | .c1}  | {.c1} | diate | .c1}  | {.c1} | ied]{ | .c1}  |
|       | X]{.c |       |       | ]{.c1 |       |       | .c1}  |       |
|       | 1}    |       |       | }     |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Indi | [71]{ | [EOR] | [Zero | [45]{ | [PLA] | [Impl | [68]{ |
| {.c1} | rect, | .c1}  | {.c1} | Page] | .c1}  | {.c1} | ied]{ | .c1}  |
|       | Y]{.c |       |       | {.c1} |       |       | .c1}  |       |
|       | 1}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Imme | [29]{ | [EOR] | [Zero | [55]{ | [PLP] | [Impl | [28]{ |
| {.c1} | diate | .c1}  | {.c1} | Page, | .c1}  | {.c1} | ied]{ | .c1}  |
|       | ]{.c1 |       |       | X]{.c |       |       | .c1}  |       |
|       | }     |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Zero | [25]{ | [EOR] | [Abso | [4D]{ | [ROL] | [Accu | [2A]{ |
| {.c1} | Page] | .c1}  | {.c1} | lute] | .c1}  | {.c1} | mulat | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | or]{. |       |
|       |       |       |       |       |       |       | c1}   |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Zero | [35]{ | [EOR] | [Abso | [5D]{ | [ROL] | [Zero | [26]{ |
| {.c1} | Page, | .c1}  | {.c1} | lute, | .c1}  | {.c1} | Page] | .c1}  |
|       | X]{.c |       |       | X]{.c |       |       | {.c1} |       |
|       | 1}    |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Abso | [2D]{ | [EOR] | [Abso | [59]{ | [ROL] | [Zero | [36]{ |
| {.c1} | lute] | .c1}  | {.c1} | lute, | .c1}  | {.c1} | Page, | .c1}  |
|       | {.c1} |       |       | Y]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Abso | [3D]{ | [EOR] | [Indi | [41]{ | [ROL] | [Abso | [2E]{ |
| {.c1} | lute, | .c1}  | {.c1} | rect, | .c1}  | {.c1} | lute] | .c1}  |
|       | X]{.c |       |       | X]{.c |       |       | {.c1} |       |
|       | 1}    |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Abso | [39]{ | [EOR] | [Indi | [51]{ | [ROL] | [Abso | [3E]{ |
| {.c1} | lute, | .c1}  | {.c1} | rect, | .c1}  | {.c1} | lute, | .c1}  |
|       | Y]{.c |       |       | Y]{.c |       |       | X]{.c |       |
|       | 1}    |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Indi | [21]{ | [INC] | [Zero | [E6]{ | [ROR] | [Accu | [6A]{ |
| {.c1} | rect, | .c1}  | {.c1} | Page] | .c1}  | {.c1} | mulat | .c1}  |
|       | X]{.c |       |       | {.c1} |       |       | or]{. |       |
|       | 1}    |       |       |       |       |       | c1}   |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Indi | [31]{ | [INC] | [Zero | [F6]{ | [ROR] | [Zero | [66]{ |
| {.c1} | rect, | .c1}  | {.c1} | Page, | .c1}  | {.c1} | Page] | .c1}  |
|       | Y]{.c |       |       | X]{.c |       |       | {.c1} |       |
|       | 1}    |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Accu | [0A]{ | [INC] | [Abso | [EE]{ | [ROR] | [Zero | [76]{ |
| {.c1} | mulat | .c1}  | {.c1} | lute] | .c1}  | {.c1} | Page, | .c1}  |
|       | or]{. |       |       | {.c1} |       |       | X]{.c |       |
|       | c1}   |       |       |       |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Zero | [06]{ | [INC] | [Abso | [FE]{ | [ROR] | [Abso | [6E]{ |
| {.c1} | Page] | .c1}  | {.c1} | lute, | .c1}  | {.c1} | lute] | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | {.c1} |       |
|       |       |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Zero | [16]{ | [INX] | [Impl | [E8]{ | [ROR] | [Abso | [7E]{ |
| {.c1} | Page, | .c1}  | {.c1} | ied]{ | .c1}  | {.c1} | lute, | .c1}  |
|       | X]{.c |       |       | .c1}  |       |       | X]{.c |       |
|       | 1}    |       |       |       |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Abso | [0E]{ | [INY] | [Impl | [C8]{ | [RTI] | [Impl | [40]{ |
| {.c1} | lute] | .c1}  | {.c1} | ied]{ | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | .c1}  |       |       | .c1}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Abso | [1E]{ | [JMP] | [Indi | [6C]{ | [RTS] | [Impl | [60]{ |
| {.c1} | lute, | .c1}  | {.c1} | rect] | .c1}  | {.c1} | ied]{ | .c1}  |
|       | X]{.c |       |       | {.c1} |       |       | .c1}  |       |
|       | 1}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BCC] | [Rela | [90]{ | [JMP] | [Abso | [4C]{ | [SBC] | [Imme | [E9]{ |
| {.c1} | tive] | .c1}  | {.c1} | lute  | .c1}  | {.c1} | diate | .c1}  |
|       | {.c1} |       |       | ]{.c1 |       |       | ]{.c1 |       |
|       |       |       |       | }     |       |       | }     |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BCS] | [Rela | [B0]{ | [JSR] | [Abso | [20]{ | [SBC] | [Zero | [E5]{ |
| {.c1} | tive] | .c1}  | {.c1} | lute] | .c1}  | {.c1} | Page] | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | {.c1} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BEQ] | [Rela | [F0]{ | [LDA] | [Imme | [A9]{ | [SBC] | [Zero | [F5]{ |
| {.c1} | tive] | .c1}  | {.c1} | diate | .c1}  | {.c1} | Page, | .c1}  |
|       | {.c1} |       |       | ]{.c1 |       |       | X]{.c |       |
|       |       |       |       | }     |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BIT] | [Zero | [24]{ | [LDA] | [Zero | [A5]{ | [SBC] | [Abso | [ED]{ |
| {.c1} | Page] | .c1}  | {.c1} | Page] | .c1}  | {.c1} | lute] | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | {.c1} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BIT] | [Abso | [2C]{ | [LDA] | [Zero | [B5]{ | [SBC] | [Abso | [FD]{ |
| {.c1} | lute] | .c1}  | {.c1} | Page, | .c1}  | {.c1} | lute, | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BMI] | [Rela | [30]{ | [LDA] | [Abso | [AD]{ | [SBC] | [Abso | [F9]{ |
| {.c1} | tive] | .c1}  | {.c1} | lute] | .c1}  | {.c1} | lute, | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | Y]{.c |       |
|       |       |       |       |       |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BNE] | [Rela | [D0]{ | [LDA] | [Abso | [BD]{ | [SBC] | [Indi | [E1]{ |
| {.c1} | tive] | .c1}  | {.c1} | lute, | .c1}  | {.c1} | rect, | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BPL] | [Rela | [10]{ | [LDA] | [Abso | [B9]{ | [SBC] | [Indi | [F1]{ |
| {.c1} | tive] | .c1}  | {.c1} | lute, | .c1}  | {.c1} | rect, | .c1}  |
|       | {.c1} |       |       | Y]{.c |       |       | Y]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BRK] | [Impl | [00]{ | [LDA] | [Indi | [A1]{ | [SEC] | [Impl | [38]{ |
| {.c1} | ied]{ | .c1}  | {.c1} | rect, | .c1}  | {.c1} | ied]{ | .c1}  |
|       | .c1}  |       |       | X]{.c |       |       | .c1}  |       |
|       |       |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BVC] | [Rela | [50]{ | [LDA] | [Indi | [B1]{ | [SED] | [Impl | [F8]{ |
| {.c1} | tive] | .c1}  | {.c1} | rect, | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | Y]{.c |       |       | .c1}  |       |
|       |       |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BVS] | [Rela | [70]{ | [LDX] | [Imme | [A2]{ | [SEI] | [Impl | [78]{ |
| {.c1} | tive] | .c1}  | {.c1} | diate | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | ]{.c1 |       |       | .c1}  |       |
|       |       |       |       | }     |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLC] | [Impl | [18]{ | [LDX] | [Zero | [A6]{ | [STA] | [Zero | [85]{ |
| {.c1} | ied]{ | .c1}  | {.c1} | Page] | .c1}  | {.c1} | Page] | .c1}  |
|       | .c1}  |       |       | {.c1} |       |       | {.c1} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLD] | [Impl | [D8]{ | [LDX] | [Zero | [B6]{ | [STA] | [Zero | [95]{ |
| {.c1} | ied]{ | .c1}  | {.c1} | Page, | .c1}  | {.c1} | Page, | .c1}  |
|       | .c1}  |       |       | Y]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLI] | [Impl | [58]{ | [LDX] | [Abso | [AE]{ | [STA] | [Abso | [8D]{ |
| {.c1} | ied]{ | .c1}  | {.c1} | lute] | .c1}  | {.c1} | lute] | .c1}  |
|       | .c1}  |       |       | {.c1} |       |       | {.c1} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLV] | [Impl | [B8]{ | [LDX] | [Abso | [BE]{ | [STA] | [Abso | [9D]{ |
| {.c1} | ied]{ | .c1}  | {.c1} | lute, | .c1}  | {.c1} | lute, | .c1}  |
|       | .c1}  |       |       | Y]{.c |       |       | X]{.c |       |
|       |       |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Imme | [C9]{ | [LDY] | [Imme | [A0]{ | [STA] | [Abso | [99]{ |
| {.c1} | diate | .c1}  | {.c1} | diate | .c1}  | {.c1} | lute, | .c1}  |
|       | ]{.c1 |       |       | ]{.c1 |       |       | Y]{.c |       |
|       | }     |       |       | }     |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Zero | [C5]{ | [LDY] | [Zero | [A4]{ | [STA] | [Indi | [81]{ |
| {.c1} | Page] | .c1}  | {.c1} | Page] | .c1}  | {.c1} | rect, | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | X]{.c |       |
|       |       |       |       |       |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Zero | [D5]{ | [LDY] | [Zero | [B4]{ | [STA] | [Indi | [91]{ |
| {.c1} | Page, | .c1}  | {.c1} | Page, | .c1}  | {.c1} | rect, | .c1}  |
|       | X]{.c |       |       | X]{.c |       |       | Y]{.c |       |
|       | 1}    |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Abso | [CD]{ | [LDY] | [Abso | [AC]{ | [STX] | [Zero | [86]{ |
| {.c1} | lute] | .c1}  | {.c1} | lute] | .c1}  | {.c1} | Page] | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | {.c1} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Abso | [DD]{ | [LDY] | [Abso | [BC]{ | [STX] | [Zero | [96]{ |
| {.c1} | lute, | .c1}  | {.c1} | lute, | .c1}  | {.c1} | Page, | .c1}  |
|       | X]{.c |       |       | X]{.c |       |       | Y]{.c |       |
|       | 1}    |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Abso | [D9]{ | [LSR] | [Accu | [4A]{ | [STX] | [Abso | [8E]{ |
| {.c1} | lute, | .c1}  | {.c1} | mulat | .c1}  | {.c1} | lute] | .c1}  |
|       | Y]{.c |       |       | or]{. |       |       | {.c1} |       |
|       | 1}    |       |       | c1}   |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Indi | [C1]{ | [LSR] | [Zero | [46]{ | [STY] | [Zero | [84]{ |
| {.c1} | rect, | .c1}  | {.c1} | Page] | .c1}  | {.c1} | Page] | .c1}  |
|       | X]{.c |       |       | {.c1} |       |       | {.c1} |       |
|       | 1}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Indi | [D1]{ | [LSR] | [Zero | [56]{ | [STY] | [Zero | [94]{ |
| {.c1} | rect, | .c1}  | {.c1} | Page, | .c1}  | {.c1} | Page, | .c1}  |
|       | Y]{.c |       |       | X]{.c |       |       | X]{.c |       |
|       | 1}    |       |       | 1}    |       |       | 1}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPX] | [Imme | [E0]{ | [LSR] | [Abso | [4E]{ | [STY] | [Abso | [8C]{ |
| {.c1} | diate | .c1}  | {.c1} | lute] | .c1}  | {.c1} | lute] | .c1}  |
|       | ]{.c1 |       |       | {.c1} |       |       | {.c1} |       |
|       | }     |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPX] | [Zero | [E4]{ | [LSR] | [Abso | [5E]{ | [TAX] | [Impl | [AA]{ |
| {.c1} | Page] | .c1}  | {.c1} | lute, | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | .c1}  |       |
|       |       |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPX] | [Abso | [EC]{ | [NOP] | [Impl | [EA]{ | [TAY] | [Impl | [A8]{ |
| {.c1} | lute] | .c1}  | {.c1} | ied]{ | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | .c1}  |       |       | .c1}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPY] | [Imme | [C0]{ | [ORA] | [Imme | [09]{ | [TSX] | [Impl | [BA]{ |
| {.c1} | diate | .c1}  | {.c1} | diate | .c1}  | {.c1} | ied]{ | .c1}  |
|       | ]{.c1 |       |       | ]{.c1 |       |       | .c1}  |       |
|       | }     |       |       | }     |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPY] | [Zero | [C4]{ | [ORA] | [Zero | [05]{ | [TXA] | [Impl | [8A]{ |
| {.c1} | Page] | .c1}  | {.c1} | Page] | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | {.c1} |       |       | .c1}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPY] | [Abso | [CC]{ | [ORA] | [Zero | [15]{ | [TXS] | [Impl | [9A]{ |
| {.c1} | lute] | .c1}  | {.c1} | Page, | .c1}  | {.c1} | ied]{ | .c1}  |
|       | {.c1} |       |       | X]{.c |       |       | .c1}  |       |
|       |       |       |       | 1}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| []{.c | []{.c | []{.c | []{.c | []{.c | []{.c | [TYA] | [Impl | [98]{ |
| 1}    | 1}    | 1}    | 1}    | 1}    | 1}    | {.c1} | ied]{ | .c1}  |
|       |       |       |       |       |       |       | .c1}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+

### [NES Assembly Formats]{.c85 .c43} {#NES.xhtml#h.fji30zo8qmh .c0}

[Our assembler will allow the following input format, each instruction/label will be on its own line. In addition unlimited whitespace is allowed:]{.c1}

[]{#NES.xhtml#t.785c03daa4e813953d8cbf70f3d9e2ff7a6c8246} []{#NES.xhtml#t.35}

<table class="c223">
<tbody>
<tr class="c143">
<td class="c122 c155" colspan="3" rowspan="1">
[Instruction Formats]{.c9}

</td>
</tr>
<tr class="c6">
<td class="c122 c180" colspan="1" rowspan="1">
[Instruction Type]{.c9}

</td>
<td class="c122 c136" colspan="1" rowspan="1">
[Format]{.c9}

</td>
<td class="c122 c216" colspan="1" rowspan="1">
[Description]{.c9}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Constant]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[Constant\_Name = &lt;Constant Value&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Must be declared before CPU\_Start]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Label]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[Label\_Name:]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Cannot be the same as an opcode name. Allows reference from branch opcodes.]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Comment]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[; Comment goes here]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Anything after the ; will be ignored]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[CPU Start]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[\_CPU:]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Signals the start of CPU memory]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Accumulator]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Accumulator is value affected by Opcode]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Implied]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Operands implied by opcode. ie. TXA has X as source and Accumulator as destination]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Immediate]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; \#&lt;Immediate&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[The decimal number will be converted to binary and used as operand]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Absolute]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; \$&lt;ADDR/LABEL&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[The byte at the specified address is used as operand]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Zero Page]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; \$&lt;BYTE OFFSET&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[The byte at address \$00XX is used as operand.]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Relative]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; \$&lt;BYTE OFFSET/LABEL&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[The byte at address PC +/- Offset is used as operand. Offset can range -128 to +127]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Absolute Index]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; \$&lt;ADDR/LABEL&gt;,&lt;X or Y&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Absolute but value in register added to address.]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Zero Page Index]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; \$&lt;BYTE OFFSET&gt;,&lt;X or Y&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Zero page but value in register added to offset.]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Zero Page X Indexed Indirect]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; (\$&lt;BYTE OFFSET&gt;,X)]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[Value in X added to offset. Address in \$00XX (where XX is new offset) is used as the address for the operand.]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Zero Page Y Indexed Indirect]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;OPCODE&gt; (\$&lt;BYTE OFFSET&gt;),Y]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[The address in \$00XX, where XX is byte offset, is added to the value in Y and is used as the address for the operand.]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
[Data instruction]{.c1}

</td>
<td class="c56" colspan="1" rowspan="1">
[&lt;.DB or .DW&gt; &lt;data values&gt;]{.c1}

</td>
<td class="c63" colspan="1" rowspan="1">
[If .db then the data values must be bytes, if .dw then the data values must be 2 bytes. Multiple comma separated data values can be include for each instruction. Constants are valid.]{.c1}

</td>
</tr>
</tbody>
</table>
[]{.c1}

[]{.c1}

[]{#NES.xhtml#t.1cff97851711fad7eb43d3937b11aea5c574f346} []{#NES.xhtml#t.36}

<table class="c133">
<tbody>
<tr class="c213">
<td class="c122 c144" colspan="3" rowspan="1">
[Number Formats]{.c9}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Immediate Decimal (Signed)]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[\#&lt;(-)DDD&gt;]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[Max 127, Min -128]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Immediate Hexadecimal (Signed)]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[\#\$&lt;HH&gt;]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Immediate Binary (Signed)]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[\#%&lt;BBBB.BBBB&gt;]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[Allows ‘.’ in between bits]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Address/Offset Hex]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[\$&lt;Addr/Offset&gt;]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[8 bits offset, 16 bits address]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Address/Offset Binary]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[\$%&lt;Addr/Offset&gt;]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[8 bits offset, 16 bits address]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Offset Decimal (Relative only)]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[\#&lt;(-)DDD&gt;]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[Relative instructions can’t be Immediate, so this is allowed.]{.c1}

[Max 127, Min -128]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Constant first byte]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[&lt;Constant\_Name]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Constant second byte]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[&gt;Constant\_Name]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[]{.c1}

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
[Constant]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[Constant\_Name]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[]{.c1}

</td>
</tr>
<tr class="c185">
<td class="c62" colspan="1" rowspan="1">
[Label]{.c1}

</td>
<td class="c86" colspan="1" rowspan="1">
[Label\_Name]{.c1}

</td>
<td class="c123" colspan="1" rowspan="1">
[Not valid for data instructions]{.c1}

</td>
</tr>
</tbody>
</table>
### []{.c85 .c43} {#NES.xhtml#h.vf2hcrvkp1k3 .c39 .c31}

### [Invoking Assembler]{.c85 .c43} {#NES.xhtml#h.1ftppbjfbpv9 .c39}

[]{#NES.xhtml#t.6f668fdd16c4e436778a938b5c4f34d93bcf4744} []{#NES.xhtml#t.37}

+-----------------------------------+-----------------------------------+
| [Usage]{.c9}                      | [Description]{.c9}                |
+-----------------------------------+-----------------------------------+
| [java NESAssemble &lt;input       | [Reads the input file and outputs |
| file&gt; &lt;cpuouput.mif&gt;     | the CPU ROM to cpuoutput.mif and  |
| &lt;ppuoutput.mif&gt;]{.c1}       | the PPU ROM to                    |
|                                   | ppuoutput.mif]{.c1}               |
+-----------------------------------+-----------------------------------+

[]{.c1}

[ iNES ROM Converter]{.c42} {#NES.xhtml#h.ekqczej5ygn6 .c0}
---------------------------

[Most NES games are currently available online in files of the iNES format, a header format used by most software NES emulators. Our NES will not support this file format. Instead, we will write a java program that takes an iNES file as input and outputs two .mif files that contain the CPU RAM and the PPU VRAM. These files will be used to instantiate the ROM’s of the CPU and PPU in our FPGA.]{.c1}

[]{#NES.xhtml#t.634ae5c55415151724744d13c7cc9c9a4d7dbd40} []{#NES.xhtml#t.38}

+-----------------------------------+-----------------------------------+
| [Usage]{.c9}                      | [Description]{.c9}                |
+-----------------------------------+-----------------------------------+
| [java NEStoMIF &lt;input.nes&gt;  | [Reads the input file and outputs |
| &lt;cpuouput.mif&gt;              | the CPU RAM to cpuoutput.mif and  |
| &lt;ppuoutput.mif&gt;]{.c1}       | the PPU VRAM to                   |
|                                   | ppuoutput.mif]{.c1}               |
+-----------------------------------+-----------------------------------+

[]{.c1}

[ Tic Tac Toe]{.c42} {#NES.xhtml#h.syub5w8xzigk .c78}
--------------------

[We also implemented Tic Tac Toe in assembly for initial integration tests. We bundled it into a NES ROM, and thus can run it on existing emulators as well as our own hardware.]{.c1}

10. [Testing & Debug]{.c138 .c43} {#NES.xhtml#h.pefw11g7x04z style="display:inline"}
    =============================

[Our debugging process had multiple steps]{.c1}

[Simulation]{.c42} {#NES.xhtml#h.i9v97r1jowjk .c0}
------------------

[For basic sanity check, we simulated each module independently to make sure the signals behave as expected.]{.c1}

[Test]{.c42} {#NES.xhtml#h.s28dapnuwz93 .c0}
------------

[For detailed check, we wrote an automated testbench to confirm the functionality. The CPU test suite was from ]{} [ [https://github.com/Klaus2m5/](https://www.google.com/url?q=https://github.com/Klaus2m5/&sa=D&ust=1494576256694000&usg=AFQjCNH5C2c6mP2PLu8ndy--7mzFJquIMg){.c40} ]{.c157} [ and we modified the test suite to run on the fceux NES emulator.]{}

[I]{} [ntegrated Simulation]{.c42} {#NES.xhtml#h.mv68y8tja9lo .c0}
----------------------------------

[After integration, we simulated the whole system with the ROM installed. We were able to get a detailed information at each cycle but the simulation took too long. It took about 30 minutes to simulate CPU operation for one second. Thus we designed a debug and trace module in hardware that could output CPU traces during actual gameplay..]{.c1}

[Tracer]{.c42} {#NES.xhtml#h.xldwn1zb9fzw .c0}
--------------

[We added additional code in Controller so that the Controller can store information at every cycle and dump them back to the serial console under some condition. At first, we used a button as the trigger, but after]{} [ we analyzed the exact problem, we used a conditional statement(for e.g. when PC reached a certain address) to trigger the dump. When the condition was met, the Controller would stall the CPU and start dumping what the CPU has been doing, in the opposite order of execution. The technique was extremely useful because we came to the conclusion that there must be a design defect when Mario crashed, such as using don’t cares or high impedance. After we corrected the defect, we were able to run Mario.]{}

------------------------------------------------------------------------

</p>
11. [Results]{} {#NES.xhtml#h.6zhnn81o27us style="display:inline"}
    ===========

[We were able to get NES working, thanks to our rigorous verification process, and onboard debug methodology. Some of the games we got working include Super Mario Bros, Galaga, Tennis, Golf, Donkey Kong, Ms Pacman, Defender II, Pinball, and Othello.  ]{.c1}

12. [Possible Improvements]{.c138 .c43} {#NES.xhtml#h.g7qfxmufg3ij style="display:inline"}
    ===================================

-   [Create a working audio processing unit]{.c1}
-   [More advanced memory mapper support]{.c1}
-   [Better image upscaling such as hqx]{.c1}
-   [Support for actual NES game carts]{.c1}
-   [HDMI]{.c1}
-   [VGA buffer instead of two RAM blocks to save space]{.c1}

13. [References and Links]{} {#NES.xhtml#h.9xwc48i9bi3r style="display:inline"}
    ========================

[Ferguson, Scott. "PPU Tutorial." N.p., n.d. Web. &lt;]{.c117} [ [https://opcode-defined.quora.com](https://www.google.com/url?q=https://opcode-defined.quora.com&sa=D&ust=1494576256706000&usg=AFQjCNFS78o1vjYXTL61EsEMFxU5j_Gjng){.c40} ]{.c117 .c157} [&gt;.]{.c1 .c117}

[ "6502 Specification." ]{.c117} [NesDev]{.c117} [. N.p., n.d. Web. 10 May 2017. &lt;]{.c117} [ [http://nesdev.com/6502.txt](https://www.google.com/url?q=http://nesdev.com/6502.txt&sa=D&ust=1494576256708000&usg=AFQjCNG1WXeRKeqTfUHDgKV-5FQjRaJ6ZA){.c40} ]{.c157 .c117} [&gt;.]{.c1 .c117}

[Dormann, Klaus. "6502 Functional Test Suite." ]{.c117} [GitHub]{.c51} [. N.p., n.d. Web. 10 May 2017.        &lt;]{.c117} [ [https://github.com/Klaus2m5/](https://www.google.com/url?q=https://github.com/Klaus2m5/&sa=D&ust=1494576256709000&usg=AFQjCNHWJMoDucP2FPYVItxakHrFUpNWwA){.c40} ]{.c157 .c117} [&gt;.]{.c1 .c117}

["NES Reference Guide." ]{.c117} [Nesdev]{.c117} [. N.p., n.d. Web. 10 May 2017. &lt;]{.c117} [ [http://wiki.nesdev.com/w/index.php/NES\_reference\_guide](https://www.google.com/url?q=http://wiki.nesdev.com/w/index.php/NES_reference_guide&sa=D&ust=1494576256711000&usg=AFQjCNEItpqnvGAfcsBgj1ecuKQhir_vLg){.c40} ]{.c157 .c117} [&gt;.]{.c1 .c117}

[Java Simple Serial Connector library: &lt;]{.c117} [ [https://github.com/scream3r/java-simple-serial-connector](https://www.google.com/url?q=https://github.com/scream3r/java-simple-serial-connector&sa=D&ust=1494576256713000&usg=AFQjCNHvXqe3iyWaw4NfUc5f-uSDzSX0XA){.c40} ]{.c157 .c117} [&gt;]{.c1 .c117}

[Final Github release: &lt;]{.c117} [ [https://github.com/jtgebert/fpganes\_release](https://www.google.com/url?q=https://github.com/jtgebert/fpganes_release&sa=D&ust=1494576256714000&usg=AFQjCNFkbDC9GDGTJBqGTwnRVWLYt-KUpw){.c40} ]{.c157 .c117} [&gt;]{.c1 .c117}

[]{.c1 .c117}

[]{.c1 .c117}

[]{.c1 .c117}

[]{.c138 .c43} {#NES.xhtml#h.kehh6src6j2q .c53}
==============

[]{.c1}

[]{.c1}

14. [Co]{} [ntributions]{.c138 .c43} {#NES.xhtml#h.vkgt15aadvpx style="display:inline"}
    ================================

[Eric Sullivan]{.c42} {#NES.xhtml#h.riv717lhxryl .c0}
---------------------

[Designed and debugged the NES picture processing unit, created a comprehensive set of PPU testbenches to verify functionality, Integrated the VGA to the PPU, implemented the DMA and dummy APU, started a CPU simulator in python, Helped debug the integrated system.]{}

[Patrick Yang]{.c42} {#NES.xhtml#h.fpooysc4oemr .c0}
--------------------

[Specified the CPU microarchitecture along with Pavan, designed the ALU, registers, and memory interface unit, wrote a self checking testbench, responsible for CPU debug, integrated all modules on top level file, and debugged of the integrated system. Helped Jon to modify controller driver to also be an onboard CPU trace module.]{}

[Pavan Holla]{.c42} {#NES.xhtml#h.7pjbrnhfuduw .c0}
-------------------

[Specified the CPU microarchitecture along with Patrick, designed the decoder and interrupt handler, and wrote the script that generates the processor control module. Modified a testsuite and provided the infrastructure for CPU verification. Wrote tic tac toe in assembly as a fail-safe game.  Also, worked on a parallel effort to integrate undocumented third party NES IP.]{.c1}

[Jonathan Ebert]{} {#NES.xhtml#h.jaedjh5lps0t .c0}
------------------

[Modified the VGA to interface with the PPU. W]{} [rote a new driver to control our existing SPART module to act as a NES controller and as an onboard CPU trace module. Wrote Java program to communicate with the SPART module using the JSSC library. Wrote memory wrappers, hardware decoder, and generated all game ROMs. Helped debug the integrated system. Wrote a very simple assembler. Wrote script to convert NES ROMs to MIF files. Also, worked on a parallel effort to integrate undocumented third party NES IP]{} [.]{}
