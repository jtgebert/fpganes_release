# FPGA Implementation of the Nintendo Entertainment System (NES)

#### *Four People Generating A Nintendo Entertainment System (FPGANES)*
#### *Eric Sullivan, Jonathan Ebert, Patrick Yang, Pavan Holla*

### Final Report

#### University of Wisconsin - Madison
#### ECE 554 Spring 2017

<span id="NES.xhtml"></span>

<span class="c138 c43"></span>
==============================

   <span>1. Introduction</span>
=====================================

<span class="c41 c28">Following the video game crash in the early 1980s, Nintendo released their first video game console, the Nintendo Entertainment System (NES). Following a slow release and early recalls, the console began to gain momentum in a market that many thought had died out, and the NES is still appreciated by enthusiasts today. A majority of its early success was due to the relationship that Nintendo created with third-party software developers. Nintendo required that restricted developers from publishing games without a license distributed by Nintendo. This decision led to higher quality games and helped to sway the public opinion on video games, which had been plagued by poor games for other gaming consoles. </span>

<span class="c41 c28">Our motivation is to better understand how the NES worked from a hardware perspective, as the NES was an extremely advanced console when it was released in 1985 (USA). The NES has been recreated multiple times in software emulators, but has rarely been done in a hardware design language, which makes this a unique project.  Nintendo chose to use the 6502 processor, also used by Apple in the Apple II, and chose to include a picture processing unit to provide a memory efficient way to output video to the TV. Our goal was to recreate the CPU and PPU in hardware, so that we could run games that were run on the original console. In order to exactly recreate the original console, we needed to include memory mappers, an audio processing unit, a DMA unit, a VGA interface, and a way to use a controller for input. In addition, we wrote our own assembler and tic-tac-toe game to test our implementation.   The following sections will explain the microarchitecture of the NES. Much of the information was gleaned from nesdev.com, and from other online forums that reverse engineered the NES.</span>

<span class="c41 c28"></span>

<span class="c41 c28"></span>

<span class="c41 c28"></span>

<span class="c41 c28"></span>

<span class="c41 c28"></span>

<span class="c28 c41"></span>

<span class="c41 c28"></span>

<span class="c41 c28"></span>

<span class="c41 c28"></span>

   <span class="c43 c138">2. Top Level Block Diagram</span>
============================================================

<!-- -->

   <span class="c42">Top level description</span>
----------------------------------------------------

<span class="c1">Here is an overview of each module in our design. Our report has a section dedicated for each of these modules.</span>

1.  <span class="c1">PPU - The PPU(Picture Processing Unit) is responsible for rendering graphics on screen. It receives memory mapped accesses from the CPU, and renders graphics from memory, providing RGB values.</span>
2.  <span class="c1">CPU - Our CPU is a 6502 implementation. It is responsible for controlling all other modules in the NES. At boot, CPU starts reading programs at the address 0xFFFC.</span>
3.  <span class="c1">DMA - The DMA transfers chunks of data from CPU address space to PPU address space. It is faster than performing repeated Loads and Stores in the CPU.</span>
4.  <span class="c1">Display Memory and VGA - The PPU writes to the display memory, which is subsequently read out by the VGA module. The VGA module produces the hsync, vsync and RGB values that a monitor requires.</span>
5.  <span class="c1">Controller - A program runs on a host computer which transfers serial data to the FPGA. The protocol used by the controller is UART in our case</span>
6.  <span class="c1">APU - Generates audio in the NES. However, we did not implement this module.</span>
7.  <span class="c1">CHAR RAM/ RAM - Used by the CPU and PPU to store temporary data</span>
8.  <span class="c1">PROG ROM/ CHAR ROM - PROG ROM contains the software(instructions) that runs the game. CHAR ROM on the other hand contains mostly image data and graphics used in the game.</span>

<!-- -->

   <span class="c42">Data Flow Diagram</span>
 -----------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 611.00px; height: 296.00px;"> ![](images/image3.png) </span>

<span class="c26">Figure 1: System level data flow diagram</span>

   <span class="c42">Control Flow Diagram</span>
 ----------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 356.00px;"> ![](images/image2.png) </span>

<span class="c26">Figure 2: System level control flow diagram.</span>

   <span class="c138 c43">3. CPU</span>
========================================

<span class="c42">CPU Registers</span>
-----------------------------------------

<span class="c1">The CPU of the NES is the MOS 6502. It is an  accumulator plus index register machine. There are five primary registers on which operations are performed: </span>

1.  <span class="c1">PC : Program Counter</span>
2.  <span class="c1">Accumulator(A) : Keeps track of results from ALU</span>
3.  <span class="c1">X : X index register</span>
4.  <span class="c1">Y  : Y index register</span>
5.  <span class="c1">Stack pointer</span>
6.  <span class="c1">Status Register : Negative, Overflow, Unused, Break, Decimal, Interrupt, Zero, Carry</span>

-   <span class="c1">Break means that the current interrupt is from software interrupt, BRK</span>
-   <span class="c1">Interrupt is high when maskable interrupts (IRQ) is to be ignored. Non-maskable interrupts (NMI) cannot be ignored.</span>

<span class="c1">There are 6 secondary registers:</span>

1.  <span class="c1">AD : Address Register</span>

-   <span class="c1">Stores where to jump to or where to get indirect access from.</span>

2.  <span class="c1">ADV : AD Value Register</span>

-   <span class="c1">Stores the value from indirect access by AD.</span>

3.  <span class="c1">BA : Base Address Register</span>

-   <span class="c1">Stores the base address before index calculation. After the calculation, the value is transferred to AD if needed.</span>

4.  <span class="c1">BAV : BA Value Register</span>

-   <span class="c1">Stores the value from indirect access by BA.</span>

5.  <span class="c1">IMM : Immediate Register</span>

-   <span class="c1">Stores the immediate value from the memory.</span>

6.  <span class="c1">Offset</span>

-   <span class="c1">Stores the offset value of branch from memory</span>

<span class="c42">CPU ISA</span>
--------------------------------

<span class="c1">The ISA may be classified into a few broad operations: </span>

-   <span class="c1">Load into A,X,Y registers from memory</span>
-   <span class="c1">Perform arithmetic operation on A,X or Y</span>
-   <span class="c1">Move data from one register to another</span>
-   <span class="c1">Program control instructions like Jump and Branch</span>
-   <span class="c1">Stack operations</span>
-   <span class="c1">Complex instructions that read, modify and write back memory.</span>

<span class="c42">CPU Addressing Modes</span>
---------------------------------------------

<span class="c1">Additionally, there are thirteen addressing modes which these operations can use. They are</span>

-   <span class="c43">Accumulator</span> <span class="c1"> – The data in the accumulator is used. </span>
-   <span class="c43">Immediate</span> <span class="c1"> - The byte in memory immediately following the instruction is used. </span>
-   <span class="c43">Zero Page</span> <span class="c1"> – The Nth byte in the first page of RAM is used where N is the byte in memory immediately following the instruction. </span>
-   <span class="c43">Zero Page, X Index</span> <span class="c1"> – The (N+X)th byte in the first page of RAM is used where N is the byte in memory immediately following the instruction and X is the contents of the X index register.</span>
-   <span class="c43">Zero Page, Y Index</span> <span class="c1"> – Same as above but with the Y index register </span>
-   <span class="c43">Absolute</span> <span class="c1"> – The two bytes in memory following the instruction specify the absolute address of the byte of data to be used. </span>
-   <span class="c43">Absolute, X Index</span> <span class="c1"> - The two bytes in memory following the instruction specify the base address. The contents of the X index register are then added to the base address to obtain the address of the byte of data to be used. </span>
-   <span class="c43">Absolute, Y Index</span> <span class="c1"> – Same as above but with the Y index register </span>
-   <span class="c43">Implied</span> <span class="c1"> – Data is either not needed or the location of the data is implied by the instruction. </span>
-   <span class="c43">Relative</span> <span class="c1"> – The content of  sum of (the program counter and the byte in memory immediately following the instruction) is used. </span>
-   <span class="c43">Absolute Indirect</span> <span class="c1"> - The two bytes in memory following the instruction specify the absolute address of the two bytes that contain the absolute address of the byte of data to be used.</span>
-   <span class="c43">(Indirect, X)</span> <span class="c1"> – A combination of Indirect Addressing and Indexed Addressing </span>
-   <span class="c43">(Indirect), Y</span> <span class="c1"> - A combination of Indirect Addressing and Indexed Addressing</span>

<span class="c42">CPU Interrupts</span>
---------------------------------------

<span class="c1">The 6502 supports three interrupts. The reset interrupt routine is called after a physical reset. The other two interrupts are the non\_maskable\_interrupt(NMI) and the general\_interrupt(IRQ). The general\_interrupt can be disabled by software whereas the others cannot. When interrupt occurs, the CPU finishes the current instruction then PC jumps to the specified interrupt vector then return when finished.  </span>

<span class="c42">CPU Opcode Matrix</span>
------------------------------------------

<span class="c1">The NES 6502 ISA is a CISC like ISA with 56 instructions. These 56 instructions can pair up with addressing modes to form various opcodes. The opcode is always 8 bits, however based on the addressing mode, upto 4 more memory location may need to be fetched.The memory is single cycle, i.e data\[7:0\] can be latched the cycle after address\[15:0\] is placed on the bus. The following tables summarize the instructions available and possible addressing modes:</span>

<span id="NES.xhtml#t.3cc61c11f8dce03b7ca8770afc1862c11a71fc7e"></span> <span id="NES.xhtml#t.0"></span>

<table class="c133">
<tbody>
<tr class="c6">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Storage</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">LDA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Load A with M</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">LDX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Load X with M</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">LDY</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Load Y with M</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">STA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Store A in M</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">STX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Store X in M</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">STY</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Store Y in M</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">TAX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Transfer A to X</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">TAY</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Transfer A to Y</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">TSX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Transfer Stack Pointer to X</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">TXA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Transfer X to A</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">TXS</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Transfer X to Stack Pointer</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">TYA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Transfer Y to A</span>

</td>
</tr>
<tr class="c207">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Arithmetic</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">ADC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Add M to A with Carry</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">DEC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Decrement M by One</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">DEX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Decrement X by One</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">DEY</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Decrement Y by One</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">INC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Increment M by One</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">INX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Increment X by One</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">INY</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Increment Y by One</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">SBC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Subtract M from A with Borrow</span>

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Bitwise</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">AND</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">AND M with A</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">ASL</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Shift Left One Bit (M or A)</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BIT</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Test Bits in M with A</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">EOR</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Exclusive-Or M with A</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">LSR</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Shift Right One Bit (M or A)</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">ORA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">OR M with A</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">ROL</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Rotate One Bit Left (M or A)</span>

</td>
</tr>
<tr class="c197">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">ROR</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Rotate One Bit Right (M or A)</span>

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Branch</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BCC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Carry Clear</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BCS</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Carry Set</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BEQ</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Result Zero</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BMI</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Result Minus</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BNE</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Result not Zero</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BPL</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Result Plus</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BVC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Overflow Clear</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BVS</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Branch on Overflow Set</span>

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Jump</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">JMP</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Jump to Location</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">JSR</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Jump to Location Save Return Address</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">RTI</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Return from Interrupt</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">RTS</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Return from Subroutine</span>

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Status Flags</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CLC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Clear Carry Flag</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CLD</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Clear Decimal Mode</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CLI</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Clear interrupt Disable Bit</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CLV</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Clear Overflow Flag</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CMP</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Compare M and A</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CPX</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Compare M and X</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">CPY</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Compare M and Y</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">SEC</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Set Carry Flag</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">SED</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Set Decimal Mode</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">SEI</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Set Interrupt Disable Status</span>

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">Stack</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">PHA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Push A on Stack</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">PHP</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Push Processor Status on Stack</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">PLA</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Pull A from Stack</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">PLP</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Pull Processor Status from Stack</span>

</td>
</tr>
<tr class="c82">
<td class="c88" colspan="2" rowspan="1">
<span class="c36">System</span>

</td>
</tr>
<tr class="c6">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">BRK</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">Force Break</span>

</td>
</tr>
<tr class="c189">
<td class="c4" colspan="1" rowspan="1">
<span class="c1">NOP</span>

</td>
<td class="c27" colspan="1" rowspan="1">
<span class="c1">No Operation</span>

</td>
</tr>
</tbody>
</table>
<span class="c1"></span>

<span>The specific opcode hex values are specified in the Assembler section.</span>

<span class="c1">For more information on the opcodes, please refer</span>

<span class="c157"> <a href="https://www.google.com/url?q=http://www.6502.org/tutorials/6502opcodes.html&amp;sa=D&amp;ust=1494576254773000&amp;usg=AFQjCNGzykU5lYlwzhVf-ANYhhU9ZHx0NQ" class="c40">http://www.6502.org/tutorials/6502opcodes.html</a> </span>

<span class="c1">or </span>

<span class="c157"> <a href="https://www.google.com/url?q=http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502_Opcodes&amp;sa=D&amp;ust=1494576254776000&amp;usg=AFQjCNE52nGakb-WzPTtZ-rC2JNJyirs9A" class="c40">http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502_Opcodes</a> </span>

<span>CPU Block Diagram</span> <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 389.33px;"> ![](images/image1.png) </span>
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<span class="c1"></span>

<span id="NES.xhtml#t.3b03df5ff635ab55210457ca4172a1dbb6594ce9"></span> <span id="NES.xhtml#t.1"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c36">Block</span></p></td>
<td><p><span class="c36">Primary Function</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Decode</span></p></td>
<td><p><span class="c1">Decode the current instruction. Classifies the opcode into an instruction_type(arithmetic,ld etc) and addressing mode(immediate, indirect etc)</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">State machine that keeps track of current instruction stage, and generates signals to load registers.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Performs ALU ops and handles Status Flags</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Contains all registers. Register values change according to signals from processor control.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Mem</span></p></td>
<td><p><span class="c1">Acts as the interface between CPU and memory. Mem block thinks it’s communicating with the memory but the DMA can reroute the communication to any other blocks like PPU, controller</span></p></td>
</tr>
</tbody>
</table>

<span class="c36"></span>

<span class="c36">Instruction flow</span>

<span class="c1">The following table presents a high level overview of how each instruction is handled.</span>

<span id="NES.xhtml#t.c34310f1171abde1363919ba55d0bbfe4c032809"></span> <span id="NES.xhtml#t.2"></span>

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c36">Cycle Number</span></p></td>
<td><p><span class="c36">Blocks </span></p></td>
<td><p><span class="c36">Action</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0</span></p></td>
<td><p><span class="c1">Processor Control → Registers</span></p></td>
<td><p><span class="c1">Instruction Fetch </span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">1</span></p></td>
<td><p><span class="c1">Register →  Decode</span></p></td>
<td><p><span class="c1">Classify instruction and addressing mode</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">1</span></p></td>
<td><p><span class="c1">Decode → Processor Control</span></p></td>
<td><p><span class="c1">Init state machine for instruction type and addressing mode</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">2-6</span></p></td>
<td><p><span class="c1">Processor Control → Registers</span></p></td>
<td><p><span class="c1">Populate scratch registers based on addressing mode.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Last Cycle</span></p></td>
<td><p><span class="c1">Processor Control → ALU</span></p></td>
<td><p><span class="c1">Execute</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">Last Cycle</span></p></td>
<td><p><span class="c1">Processor Control → Registers</span></p></td>
<td><p><span class="c1">Instruction Fetch</span></p></td>
</tr>
</tbody>
</table>

<span class="c36"></span>

<span class="c36">State Machines</span>

<span class="c1">Each {instruction\_type, addressing\_mode} triggers its own state machine. In brief, this state machine is responsible for signalling the Registers module to load/store addresses from memory or from the ALU. </span>

<span>State machine spec for each instruction type and addressing mode can be found at </span> <span class="c157 c28 c117"> <a href="https://www.google.com/url?q=https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-_sEox-QsTjJSlt06lE/edit?usp%3Dsharing&amp;sa=D&amp;ust=1494576254814000&amp;usg=AFQjCNGca0yi6hqlKxIn-yYgAP_Xxx_mvQ" class="c40">https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-_sEox-QsTjJSlt06lE/edit?usp=sharing</a> </span>

<span class="c1">Considering one of the simplest instructions ADC immediate,which takes two cycles, the state machine is as follows:</span>

<span>Instruction\_type=ARITHMETIC, addressing mode= IMMEDIATE</span>

<span id="NES.xhtml#t.986d78169f9d35d012fa7f117a4e53d6949bf356"></span> <span id="NES.xhtml#t.3"></span>

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c1">state=0</span></p></td>
<td><p><span class="c1">state=1</span></p></td>
<td><p><span class="c1">state=2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ld_sel=LD_INSTR; //instr= memory_data</span></p>
<p><span class="c1">pc_sel=INC_PC; //pc++</span></p>
<p><span class="c1">next_state=state+1’b1</span></p>
<p><span class="c1"></span></p>
<p><span class="c1"></span></p></td>
<td><p><span class="c1">ld_sel=LD_IMM;</span></p>
<p><span class="c1">//imm=memory_data</span></p>
<p><span class="c1">pc_sel=INC_PC</span></p>
<p><span class="c1">next_state=state+1’b1</span></p></td>
<td><p><span class="c1">alu_ctrl=DO_OP_ADC // execute</span></p>
<p><span class="c1">src1_sel=SRC1_A</span></p>
<p><span class="c1">src2_sel=SRC2_IMM</span></p>
<p><span class="c1">dest_sel=DEST_A</span></p>
<p><span class="c1">ld_sel=LD_INSTR//fetch next instruction</span></p>
<p><span class="c1">pc_sel=INC_PC</span></p>
<p><span class="c1">next_state=1’b1</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c1">All instructions are classified into one of 55 state machines in the cpu specification sheet. The 6502 can take variable time for a single instructions based on certain conditions(page\_cross, branch\_taken etc). These corner case state transitions are also taken care of by processor control.</span>

<span>CPU </span> <span class="c42">Top Level Interface</span>
--------------------------------------------------------------

<span id="NES.xhtml#t.ec6e0cf4837ca798f6158bba27f8906dd57ddbdb"></span> <span id="NES.xhtml#t.4"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active high reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">nmi</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">Non maskable interrupt from PPU. Executes BRK instruction in CPU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">addr[15:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">Address for R/W issued by CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">dout[7:0]</span></p></td>
<td><p><span class="c1">input/</span></p>
<p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">Data from the RAM in case of reads and and to the RAM in case of writes</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">memory_read</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">read enable signal for RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">memory_write</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">write enable signal for RAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">CPU Instruction Decode Interface</span>
---------------------------------------------------------

<span class="c1">The decode module is responsible for classifying the instruction into one of the addressing modes and an instruction type. It also generates the signal that the ALU would eventually use if the instruction passed through the ALU.        </span>

<span id="NES.xhtml#t.f13182f9d70c3545bc3d4e1c8077ef6922fd108a"></span> <span id="NES.xhtml#t.5"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">instruction_register</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Opcode of the current instruction</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">nmi</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">cpu_top</span></p></td>
<td><p><span class="c1">Non maskable interrupt from PPU. Executes BRK instruction in CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">instruction_type</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Type of instruction. Belongs to enum ITYPE.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">addressing_mode</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Addressing mode of the opcode in instruction_register. Belongs to enum AMODE.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">alu_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">ALU operation expected to be performed by the opcode, eventually. Processor control chooses to use it at a cycle appropriate for the instruction. Belongs to enum DO_OP.</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">CPU MEM Interface</span>
------------------------------------------

<span class="c1">The MEM module is the interface between memory and CPU. It provides appropriate address and read/write signal for the memory. Controlled by the select signals</span>

<span id="NES.xhtml#t.60770ee16f74d493ac822410188b75f9a14e434b"></span> <span id="NES.xhtml#t.6"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">addr_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Selects which input to use as address to memory. Enum of ADDR</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">int_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Selects which interrupt address to jump to. Enum of INT_TYPE</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ld_sel,st_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Decides whether to read or write based on these signals</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ad, ba, sp, irql, irqh, pc</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Registers that are candidates of the address</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">addr</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Memory</span></p></td>
<td><p><span class="c1">Address of the memory to read/write</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">read,write</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Memory</span></p></td>
<td><p><span class="c1">Selects whether Memory should read or write</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">CPU ALU Interface</span>
------------------------------------------

<span class="c1">Performs arithmetic, logical operations and operations that involve status registers.</span>

<span id="NES.xhtml#t.74d7ae3809789a7579d3dd984c8cb1e6937f5c5b"></span> <span id="NES.xhtml#t.7"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">in1, in2</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">ALU Input Selector</span></p></td>
<td><p><span class="c1">Inputs to the ALU operations selected by ALU Input module.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">alu_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">ALU operation expected to be performed by the opcode, eventually. Processor control chooses to use it at a cycle appropriate for the instruction. Belongs to enum DO_OP.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk, rst</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock and active high reset</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">out</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">to all registers</span></p></td>
<td><p><span class="c1">Output of ALU operation. sent to all registers and registers decide whether to receive it or ignore it as its next value.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">n, z, v, c, b, d, i</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Status Register</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

### <span class="c85 c43">ALU Input Selector</span>

<span class="c1">Selects the input1 and input2 for the ALU</span>

<span id="NES.xhtml#t.962a520a35f5a47f155664eb3cba694a0b1b6dba"></span> <span id="NES.xhtml#t.8"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">src1_sel, src2_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Control signal that determines which sources to take in as inputs to ALU according to the instruction and addressing mode</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">a, bal, bah, adl, pcl, pch, imm, adv, x, bav, y, offset</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Registers that are candidates to the input to ALU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">temp_status</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Sometimes status information is required but we don’t want it to affect the status register. So we directly receive temp_status value from ALU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">in1, in2</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Selected input for the ALU</span></p></td>
</tr>
</tbody>
</table>

<span class="c42">CPU Registers Interface</span>
------------------------------------------------

<span class="c1">Holds all of the registers</span>

<span id="NES.xhtml#t.35d129561daa24a66b47c8945cde454ce8f2506d"></span> <span id="NES.xhtml#t.9"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk, rst</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clk and rst</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">dest_sel, pc_sel, sp_sel, ld_sel, st_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Selects which input to accept as new input. enum of DEST, PC, SP, LD, ST</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clr_adh, clr_bah</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Processor Control</span></p></td>
<td><p><span class="c1">Clears the high byte of ad, ba</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">alu_out, next_status</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Output from ALU and next status value. alu_out can be written to most of the registers</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">data</span></p></td>
<td><p><span class="c1">inout</span></p></td>
<td><p><span class="c1">Memory</span></p></td>
<td><p><span class="c1">Datapath to Memory. Either receives or sends data according to ld_sel and st_sel.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">a, x, y, ir, imm, adv, bav, offset, sp, pc, ad, ba, n, z, v, c, b, d, i, status</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Register outputs that can be used by different modules</span></p></td>
</tr>
</tbody>
</table>

<span class="c42">CPU Processor Control Interface</span>
--------------------------------------------------------

<span class="c1">The processor control module maintains the current state that the instruction is in and decides the control signals for the next state. Once the instruction type and addressing modes are decoded, the processor control block becomes aware of the number of cycles the instruction will take. Thereafter, at each clock cycle it generates the required control signals.</span>

<span id="NES.xhtml#t.b393916cb565d703d6fe7f4dbd36fb92b6b7db96"></span> <span id="NES.xhtml#t.10"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">instruction_type</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Decode</span></p></td>
<td><p><span class="c1">Type of instruction. Belongs to enum ITYPE.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">addressing_mode</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Decode</span></p></td>
<td><p><span class="c1">Addressing mode of the opcode in instruction_register. Belongs to enum AMODE.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">alu_ctrl</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Decode</span></p></td>
<td><p><span class="c1">ALU operation expected to be performed by the opcode, eventually. Processor control chooses to use it at a cycle appropriate for the instruction. Belongs to enum DO_OP.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">reset_adh</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Resets ADH register</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">reset_bah</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Resets BAH register</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">set_b</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Sets the B flag</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">addr_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Selects the value that needs to be set on the address bus. Belongs to enum ADDR</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">alu_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Selects the operation to be performed by the ALU in the current cycle. Belongs to enum DO_OP</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">dest_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Selects the register that receives the value from ALU output.Belongs to enum DEST</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ld_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Selects the register that will receive the value from Memory Bus. Belongs to enum LD</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">pc_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Selects the value that the PC will take next cycle. Belongs to enum PC</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">sp_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Selects the value that the SP  will take next cycle. Belongs to enum SP</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">src1_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Selects src1 for ALU. Belongs to enum SRC1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">src2_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">ALU</span></p></td>
<td><p><span class="c1">Selects src2 for ALU. Belongs to enum SRC2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">st_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
<td><p><span class="c1">Selects the register whose value will be placed on dout. Belongs to enum ST</span></p></td>
</tr>
</tbody>
</table>

<span class="c42">CPU Enums</span>
----------------------------------

<span id="NES.xhtml#t.d41042ffa22f98544df79c723d4fbbb413491765"></span> <span id="NES.xhtml#t.11"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Enum name</span></p></td>
<td><p><span class="c9">Legal Values</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ITYPE</span></p></td>
<td><p><span class="c1">ARITHMETIC,BRANCH,BREAK,CMPLDX,CMPLDY,INTERRUPT,JSR,JUMP,OTHER,PULL,PUSH,RMW,RTI,RTS,STA,STX,STY</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">AMODE</span></p></td>
<td><p><span class="c1">ABSOLUTE,ABSOLUTE_INDEX,ABSOLUTE_INDEX_Y,ACCUMULATOR,IMMEDIATE,IMPLIED,INDIRECT,INDIRECT_X,INDIRECT_Y,RELATIVE,SPECIAL,ZEROPAGE,ZEROPAGE_INDEX,ZEROPAGE_INDEX_Y</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">DO_OP</span></p></td>
<td><p><span class="c1">DO_OP_ADD,DO_OP_SUB,DO_OP_AND,DO_OP_OR,DO_OP_XOR,DO_OP_ASL,DO_OP_LSR,DO_OP_ROL,DO_OP_ROR,DO_OP_SRC2DO_OP_CLR_C,DO_OP_CLR_I,DO_OP_CLR_V,DO_OP_SET_C,DO_OP_SET_I,DO_OP_SET_V</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ADDR</span></p></td>
<td><p><span class="c1">ADDR_AD,ADDR_PC,ADDR_BA,ADDR_SP,ADDR_IRQL,ADDR_IRQH</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">LD</span></p></td>
<td><p><span class="c1">LD_INSTR,LD_ADL,LD_ADH,LD_BAL,LD_BAH,LD_IMM,LD_OFFSET,LD_ADV,LD_BAV,LD_PCL,LD_PCH</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">SRC1</span></p></td>
<td><p><span class="c1">SRC1_A,SRC1_BAL,SRC1_BAH,SRC1_ADL,SRC1_PCL,SRC1_PCH,SRC1_BAV,SRC1_1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">SRC2</span></p></td>
<td><p><span class="c1">SRC2_DC,SRC2_IMM,SRC2_ADV,SRC2_X,SRC2_BAV,SRC2_C,SRC2_1,SRC2_Y,SRC2_OFFSET</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">DEST</span></p></td>
<td><p><span class="c1">DEST_BAL,DEST_BAH,DEST_ADL,DEST_A,DEST_X,DEST_Y,DEST_PCL,DEST_PCH,DEST_NONE</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">PC</span></p></td>
<td><p><span class="c100 c148">AD_P_TO_PC,INC_PC,KEEP_PC</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">SP</span></p></td>
<td><p><span class="c100 c148">INC_SP,DEC_SP</span></p></td>
</tr>
</tbody>
</table>

<span class="c29"></span>

   <span class="c138 c43">4. Picture Processing Unit</span>
 =============================================================

<span class="c1"></span>

<span class="c94 c52">The NES picture processing unit or PPU is the unit responsible for handling all of the console's graphical workloads. Obviously this is useful to the CPU because it offloads the highly intensive task of rendering a frame. This means the CPU can spend more time performing the game logic. </span>

<span class="c94 c52"></span>

<span class="c94 c52">The PPU renders a frame by reading in scene data from various memories the PPU has access to such as VRAM, the game cart, and object attribute memory and then outputting an NTSC compliant 256x240 video signal at 60 Hz. The PPU was a special custom designed IC for Nintendo, so no other devices use this specific chip. It operates at a clock speed of 5.32 MHz making it three times faster than the NES CPU. This is one of the areas of difficulty in creating the PPU because it is easy to get the CPU and PPU clock domains out of sync.</span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c94 c52"></span>

<span class="c42">PPU Top Level Schematic</span>
------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 625.50px; height: 355.85px;"> ![schemeit-project.png](images/image9.png) </span>

<span class="c43">6502: </span> <span class="c1">The CPU used in the NES. Communicates with the PPU through simple load/store instructions. This works because the PPU registers are memory mapped into the CPU's address space.</span>

<span class="c43">Address Decoder:</span> <span class="c1"> The address decoder is responsible for selecting the chip select of the device the CPU wants to talk to. In the case of the PPU the address decoder will activate if from addresses \[0x2000, 0x2007\].</span>

<span class="c43">VRAM:</span> <span class="c1"> The PPU video memory contains the data needed to render the scene, specifically it holds the name tables. VRAM is 2 Kb in size and depending on how the PPU VRAM address lines are configured, different mirroring schemes are possible. </span>

<span class="c43">Game Cart:</span> <span class="c1"> The game cart has a special ROM on it called the character ROM, or char ROM for short. the char ROM contains the sprite and background tile pattern data. These are sometimes referred to as the pattern tables. </span>

<span class="c43">PPU Registers:</span> <span class="c1"> These registers allow the CPU to modify the state of the PPU. It maintains all of the control signals that are sent to both the background and sprite renderers.</span>

<span class="c43">Background Renderer:</span> <span class="c1"> Responsible for drawing the background data for a scene. </span>

<span class="c43">Sprite Renderer:</span> <span> Responsible for drawing the sprite data for a scene, and maintaining object attribute memory.</span>

<span class="c43">Object Attribute Memory:</span> <span class="c1"> Holds all of the data needed to know how to render a sprite. OAM is 256 bytes in size and each sprite utilizes 4 bytes of data. This means the PPU can support 64 sprites.</span>

<span class="c43">Pixel Priority:</span> <span class="c1"> During the visible pixel section of rendering, both the background and sprite renderers produce a single pixel each clock cycle. The pixel priority module looks at the priority values and color for each pixel and decides which one to draw to the screen. </span>

<span class="c43">VGA Interface:</span> <span> This is where all of the frame data is kept in a frame buffer. This data is then upscaled to 640x480 when it goes out to the monitor.</span>

<span class="c42">PPU Memory Map</span>
---------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 421.64px; height: 466.50px;"> ![](images/image22.png) </span>

<span class="c52">The PPU memory map is broken up into three distinct regions, the pattern tables, name tables, and palettes. Each of these regions holds data the PPU need to obtain to render a given scanline. The functionality of each part is described in the PPU Rendering section.</span>

<span class="c42">PPU CHAROM</span>
-----------------------------------

-   <span class="c10">ROM from the cartridge is broken in two sections</span>

<!-- -->

-   <span class="c10">Program ROM</span>

<!-- -->

-   <span class="c10">Contains program code for the 6502</span>
-   <span class="c10">Is mapped into the CPU address space by the mapper</span>

<!-- -->

-   <span class="c10">Character ROM </span>

<!-- -->

-   <span class="c10">Contains sprite and background data for the PPU</span>
-   <span class="c10">Is mapped into the PPU address space by the mapper</span>

<span class="c42">PPU Rendering</span>
--------------------------------------

-   <span class="c10">Pattern Tables</span>

<!-- -->

-   <span class="c10">$0000-$2000 in VRAM</span>

<!-- -->

-   <span class="c10">Pattern Table 0 ($0000-$0FFF)</span>
-   <span class="c10">Pattern Table 1 ($1000-$2000)</span>
-   <span class="c10">The program selects which one of these contains sprites and backgrounds</span>
-   <span class="c10">Each pattern table is 16 bytes long and represents 1 8x8 pixel tile</span>

<!-- -->

-   <span class="c10">Each 8x1 row is 2 bytes long</span>
-   <span class="c10">Each bit in the byte represents a pixel and the corresponding bit for each byte is combined to create a 2 bit color.</span>

<!-- -->

-   <span class="c10">Color\_pixel = {byte2\[0\], byte1\[0\]}</span>

<!-- -->

-   <span class="c10">So there can only be 4 colors in any given tile</span>
-   <span class="c10">Rightmost bit is leftmost pixel</span>

<!-- -->

-   <span class="c10">Any pattern that has a value of 0 is transparent i.e. the background color</span>

<span class="c10"></span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 414.58px; height: 172.50px;"> ![](images/image15.png) </span>

<span class="c10"></span>

-   <span class="c10">Name Tables</span>

<!-- -->

-   <span class="c10">$2000-$2FFF in VRAM with $3000-$3EFF as a mirror</span>
-   <span class="c10">Laid out in memory in 32x30 fashion</span>

<!-- -->

-   <span class="c10">Think of as a 2d array where each element specifies a tile in the pattern table.</span>
-   <span class="c10">This results in a resolution of 256x240</span>

<!-- -->

-   <span class="c10">Although the PPU supports 4 name tables the NES only supplied enough VRAM for 2 this results in 2 of the 4 name tables being mirror</span>

<!-- -->

-   <span class="c10">Vertically = horizontal movement</span>
-   <span class="c10">Horizontally = vertical movement</span>

<!-- -->

-   <span class="c10">Each entry in the name table refers to one pattern table and is one byte. Since there are 32x30=960 entries each name table requires 960 bytes of space the left over 64 bytes are used for attribute tables</span>
-   <span class="c10">Attribute tables</span>

<!-- -->

-   <span class="c10">1 byte entries that contains the palette assignment for a 2x2 grid of tiles</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 216.00px; height: 254.72px;"> ![](images/image10.png) </span>

<span class="c10"></span>

-   <span class="c10">Sprites</span>

<!-- -->

-   <span class="c10">Just like backgrounds sprite tile data is contained in one of the pattern tables</span>
-   <span class="c10">But unlike backgrounds sprite information is not contained in name tables but in a special reserved 256 byte RAM called the object attribute memory (OAM)</span>

<!-- -->

-   <span class="c10">Object Attribute Memory</span>

<!-- -->

-   <span class="c10">256 bytes of dedicated RAM</span>
-   <span class="c10">Each object is allocated 4 bytes of OAM so we can store data about 64 sprites at once</span>
-   <span class="c10">Each object has the following information stored in OAM</span>

<!-- -->

-   <span class="c10">X Coordinate</span>
-   <span class="c10">Y Coordinate</span>
-   <span class="c10">Pattern Table Index</span>
-   <span class="c10">Palette Assignment</span>
-   <span class="c10">Horizontal/Vertical Flip</span>

<!-- -->

-   <span class="c10">Palette Table</span>

<!-- -->

-   <span class="c10">Located at $3F00-$3F20</span>

<!-- -->

-   <span class="c10">$3F00-$3F0F is background palettes</span>
-   <span class="c10">$3F10-$3F1F is sprite palettes</span>

<!-- -->

-   <span class="c10">Mirrored all the way to $4000</span>
-   <span class="c10">Each color takes one byte</span>
-   <span class="c10">Every background tile and sprite needs a color palette.</span>
-   <span class="c10">When the background or sprite is being rendered the the color for a specific table is looked up in the correct palette and sent to the draw select mux.</span>

<!-- -->

-   <span class="c10">Rendering is broken into two parts which are done for each horizontal scanline</span>

<!-- -->

-   <span class="c10">Background Rendering</span>

<!-- -->

-   <span class="c10">The background enable register ($2001) controls if the default background color is rendered ($2001) or if background data from the background renderer.</span>
-   <span class="c10">The background data is obtained for every pixel.</span>

<!-- -->

-   <span class="c10">Sprite Rendering</span>

<!-- -->

-   <span class="c10">The sprite renderer has room for 8 unique sprites on each scanline.</span>
-   <span class="c10">For each scanline the renderer looks through the OAM for sprites that need to be drawn on the scanline. If this is the case the sprite is loaded into the scanline local sprites</span>

<!-- -->

-   <span class="c10">If this number exceeds 8 a flag is set and the behavior is undefined.</span>

<!-- -->

-   <span class="c52 c134 c117">If a sprite should be drawn for a pixel instead of the background the sprite renderer sets the sprite priority line to a mux that decides what to send to the screen and the mux selects the sprite color d</span> <span class="c52 c117 c134">ata.</span>

<span class="c42">PPU Memory Mapped Registers</span>
----------------------------------------------------

<span class="c1">The PPU register interface exists so the CPU can modify and fetch the state elements of the PPU. These state elements include registers that set control signals, VRAM, object attribute memory, and palettes. These state elements then determine how the background and sprite renderers will draw the scene. The PPU register module also contains the pixel mux and palette memory which are used to determine what pixel data to send to the VGA module.</span>

<span id="NES.xhtml#t.2410c3dd563250403a6a2b073e837692eff20a19"></span> <span id="NES.xhtml#t.12"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">data[7:0]</span></p></td>
<td><p><span class="c1">inout</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Bi directional data bus between the CPU/PPU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">address[2:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Register select</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">CPU read/write select</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">cs_in</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">PPU chip select</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">irq</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Signal PPU asserts to trigger CPU NMI</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">pixel_data[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">RGB pixel data to be sent to the display</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vram_addr_out[13:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">VRAM address to read/write from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vram_rw_sel</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">Determines if the current vram operation is a read or write</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vram_data_out[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">Data to write to VRAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">frame_end</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Signals the VGA interface that this is the end of a frame</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">frame_start</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Signals the VGA interface that a frame is starting to keep the PPU and VGA in sync</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rendering</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Signals the VGA interface that pixel data output is valid</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c1"></span>

<span class="c42">PPU Register Block Diagram</span>
---------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 370.50px; height: 351.34px;"> ![Untitled Diagram.png](images/image20.png) </span>

<span class="c42">PPU Register Descriptions</span>
--------------------------------------------------

-   <span class="c52">Control registers are mapped into the CPUs address space (</span> <span class="c10">$2000 - $2007)</span>
-   <span class="c94 c52 c117">The registers are repeated every eight bytes until address $3FF</span>
-   <span class="c43 c134 c149 c117">PPUCTRL\[7:0\] (</span> <span class="c10">$2000) WRITE</span>

<!-- -->

-   <span class="c10">\[1:0\]: Base nametable address which is loaded at the start of a frame</span>

<!-- -->

-   <span class="c10">0: $2000</span>
-   <span class="c10">1: $2400</span>
-   <span class="c10">2: $2800</span>
-   <span class="c10">3: $2C00</span>

<!-- -->

-   <span class="c10">\[2\]: VRAM address increment per CPU read/write of PPUDATA</span>

<!-- -->

-   <span class="c10">0: Add 1 going across</span>
-   <span class="c10">1: Add 32 going down</span>

<!-- -->

-   <span class="c10">\[3\]: Sprite pattern table for 8x8 sprites</span>

<!-- -->

-   <span class="c10">0: $0000</span>
-   <span class="c10">1: $1000</span>
-   <span class="c10">Ignored in 8x16 sprite mode</span>

<!-- -->

-   <span class="c10">\[4\]: Background pattern table address</span>

<!-- -->

-   <span class="c10">0: $0000</span>
-   <span class="c10">1: $1000</span>

<!-- -->

-   <span class="c10">\[5\]: Sprite size</span>

<!-- -->

-   <span class="c10">0: 8x8</span>
-   <span class="c10">1: 8x16</span>

<!-- -->

-   <span class="c10">\[6\]: PPU master/slave select</span>

<!-- -->

-   <span class="c10">0: Read backdrop from EXT pins</span>
-   <span class="c10">1: Output color on EXT pins</span>

<!-- -->

-   <span class="c10">\[7\]: Generate NMI interrupt at the start of vertical blanking interval</span>

<!-- -->

-   <span class="c10">0: off</span>
-   <span class="c10">1: on</span>

<!-- -->

-   <span class="c43 c134 c117 c149">PPUMASK\[7:0\] </span> <span class="c10">($2001) WRITE</span>

<!-- -->

-   <span class="c10">\[0\]: Use grayscale image</span>

<!-- -->

-   <span class="c10">0: Normal color</span>
-   <span class="c10">1: Grayscale</span>

<!-- -->

-   <span class="c10">\[1\]: Show left 8 pixels of background</span>

<!-- -->

-   <span class="c10">0: Hide</span>
-   <span class="c10">1: Show background in leftmost 8 pixels of screen</span>

<!-- -->

-   <span class="c10">\[2\]: Show left 8 piexels of sprites</span>

<!-- -->

-   <span class="c10">0: Hide</span>
-   <span class="c10">1: Show sprites in leftmost 8 pixels of screen</span>

<!-- -->

-   <span class="c10">\[3\]: Render the background</span>

<!-- -->

-   <span class="c10">0: Don’t show background</span>
-   <span class="c10">1: Show background</span>

<!-- -->

-   <span class="c10">\[4\]: Render the sprites</span>

<!-- -->

-   <span class="c10">0: Don’t show sprites</span>
-   <span class="c10">1: Show sprites</span>

<!-- -->

-   <span class="c10">\[5\]: Emphasize red</span>
-   <span class="c10">\[6\]: Emphasize green</span>
-   <span class="c10">\[7\]: Emphasize blue</span>

<!-- -->

-   <span class="c43 c134 c149 c117">PPUSTATUS\[7:0\] </span> <span class="c10">($2002) READ</span>

<!-- -->

-   <span class="c10">\[4:0\]: Nothing?</span>
-   <span class="c10">\[5\]: Set for sprite overflow which is when more than 8 sprites exist in one scanline (Is actually more complicated than this to do a hardware bug)</span>
-   <span class="c10">\[6\]: Sprite 0 hit. This bit gets set when a non zero part of sprite zero overlaps a non zero background pixel</span>
-   <span class="c10">\[7\]: Vertical blank status register</span>

<!-- -->

-   <span class="c10">0: Not in vertical blank</span>
-   <span class="c10">1: Currently in vertical blank</span>

<!-- -->

-   <span class="c43 c134 c149 c117">OAMADDR\[7:0\] </span> <span class="c10">($2003) WRITE</span>

<!-- -->

-   <span class="c10">Address of the object attribute memory the program wants to access</span>

<!-- -->

-   <span class="c43 c134 c149 c117">OAMDATA\[7:0\] </span> <span class="c10">($2004) READ/WRITE</span>

<!-- -->

-   <span class="c10">The CPU can read/write this register to read or write to the PPUs object attribute memory. The address should be specified by writing the OAMADDR register beforehand. Each write will increment the address by one, but a read will not modify the address</span>

<!-- -->

-   <span class="c43 c134 c149 c117">PPUSCROLL\[7:0\] </span> <span class="c10">($2005) WRITE</span>

<!-- -->

-   <span class="c10">Tells the PPU what pixel of the nametable selected in PPUCTRL should be in the top left hand corner of the screen</span>

<!-- -->

-   <span class="c43 c134 c149 c117">PPUADDR\[7:0\] </span> <span class="c10">($2006) WRITE</span>

<!-- -->

-   <span class="c10">Address the CPU wants to write to VRAM before writing a read of PPUSTATUS is required and then two bytes are written in first the high byte then the low byte</span>

<!-- -->

-   <span class="c43 c134 c149 c117">PPUDATA\[7:0\] </span> <span class="c10">($2007) READ/WRITE</span>

<!-- -->

-   <span class="c10">Writes/Reads data from VRAM for the CPU. The value in PPUADDR is then incremented by the value specified in PPUCTRL</span>

<!-- -->

-   <span class="c43 c134 c149 c117">OAMDMA\[7:0\]</span> <span class="c10"> ($4014) WRITE</span>

<!-- -->

-   <span class="c52 c134 c117">A write of $XX to this register will result in the CPU memory page at $XX00-$XXFF being written into the PPU object attribute memory</span>

<span class="c42">PPU Background Renderer</span>
------------------------------------------------

<span class="c1">The background renderer is responsible for rendering the background for each frame that is output to the VGA interface. It does this by prefetching the data for two tiles at the end of the previous scanline. And then begins to continuously fetch tile data for every pixel of the visible frame. This allows the background renderer to produce a steady flow of output pixels despite the fact it takes 8 cycles to fetch 8 pixels of a scanline.</span>

<span id="NES.xhtml#t.cfcc5323a0745a2d21a0d8ca697f3e16babd2727"></span> <span id="NES.xhtml#t.13"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">bg_render_en</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Background render enable</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">x_pos[9:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current pixel for the active scanline</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">y_pos[9:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current scanline being rendered</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vram_data_in[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current data that has been read in from VRAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">bg_pt_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects the location of the background renderer pattern table</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">show_bg_left_col</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Determines if the background for the leftmost 8 pixels of each scanline will be drawn</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">fine_x_scroll[2:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects the pixel drawn on the left hand side of the screen</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">coarse_x_scroll[4:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects the tile to start rendering from in the x direction</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">fine_y_scroll[2:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects the pixel drawn on the top of the screen</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">coarse_y_scroll[4:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects the tile to start rendering from in the y direction</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">nametable_sel[1:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects the nametable to start rendering from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">update_loopy_v</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Signal to update the temporary vram address</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cpu_loopy_v_inc</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Signal to increment the temporary vram address by the increment amount</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">cpu_loopy_v_inc_amt</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">If this signal is set increment the temp vram address by 32 on cpu_loopy_v_inc, and increment by 1 if it is not set on cpu_loopy_v_inc</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vblank_out</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Determines it the PPU is in vertical blank</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">bg_rendering_out</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Determines if the bg renderer is requesting vram reads</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">bg_pal_sel[3:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Pixel Mux</span></p></td>
<td><p><span class="c1">Selects the palette for the background pixel</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">loopy_v_out[14:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The temporary vram address register for vram reads/writes</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vram_addr_out[13:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">The VRAM address the sprite renderer wants to read from</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">PPU Background Renderer Diagram</span>
--------------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 326.64px; height: 420.71px;"> ![Untitled Diagram.png](images/image18.png) </span>

<span class="c43">VRAM:</span> <span class="c1"> The background renderer reads from two of the three major areas of address space available to the PPU, the pattern tables, and the name tables. First the background renderer needs the name table byte for a given tile to know which tile to draw in the background. Once it has this information is need the pattern to know how to draw the background tile.</span>

<span class="c43">PPU Register Interface:</span> <span class="c1"> All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.</span>

<span class="c43">Scrolling Register:</span> <span class="c1"> The scrolling register is responsible for keeping track of what tile is currently being drawn to the screen. </span>

<span class="c43">Scrolling Update Logic: </span> <span class="c1">Every time the data for a background tile is successfully fetched the scrolling register needs to be updated. Most of the time it is a simple increment, but more care has to be taken when the next tile falls in another name table. This logic allows the scrolling register to correctly update to be able to smoothly jump between name tables while rendering. </span>

<span class="c43">Background Renderer State Machine: </span> <span class="c1">The background renderer state machine is responsible for sending the correct control signals to all of the other modules as the background is rendering. </span>

<span class="c43">Background Shift Registers:</span> <span class="c1"> These registers shift out the pixel data to be rendered on every clock cycle. They also implement the logic that makes fine one pixel scrolling possible by changing what index of the shift registers is the one being shifted out each cycle.</span>

<span class="c43">Pixel Priority Mux: </span> <span class="c1">Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.</span>

<span class="c42">PPU Sprite Renderer</span>
--------------------------------------------

<span class="c1">The PPU sprite renderer is used to render all of the sprite data for each scanline. The way the hardware was designed it only allows for 64 sprites to kept in object attribute memory at once. There are only 8 spots available to store the sprite data for each scanline so only 8 sprites can be rendered for each scanline. Sprite data in OAM is evaluated for the next scanline while the background renderer is mastering the VRAM bus. When rendering reaches horizontal blank the sprite renderer fetches the pattern data for all of the sprites to be rendered on the next scanline and places the data in the sprite shift registers. The sprite x position is also loaded into a down counter which determines when to make the sprite active and shift out the pattern data on the next scanline.</span>

<span id="NES.xhtml#t.cdbc9e2f9b853601435427311431e91e21b12696"></span> <span id="NES.xhtml#t.14"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_render_en</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Sprite renderer enable signal</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">x_pos[9:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current pixel for the active scanline</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">y_pos[9:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current scanline being rendered</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">spr_addr_in[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current OAM address being read/written</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_data_in[7:0]</span></p></td>
<td><p><span class="c1">inout</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">The current data being read/written from OAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vram_data_in[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">The data the sprite renderer requested from VRAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cpu_oam_rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Selects if OAM is being read from or written to from the CPU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">cpu_oam_req</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Signals the CPU wants to read/write OAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_pt_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Determines the PPU pattern table address in VRAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">spr_size_sel</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Determines the size of the sprites to be drawn</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">show_spr_left_col</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Determines if sprites on the leftmost 8 pixels of each scanline will be drawn</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">spr_overflow</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">If more than 8 sprites fall on a single scanline this is set</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_pri_out</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Pixel Mux</span></p></td>
<td><p><span class="c1">Determines the priority of the sprite pixel data</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">spr_data_out[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">returns oam data the CPU requested</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_pal_sel[3:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Pixel Mux</span></p></td>
<td><p><span class="c1">Sprite pixel color data to be drawn</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vram_addr_out[13:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">Sprite vram read address</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_vram_req</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VRAM</span></p></td>
<td><p><span class="c1">Signals the sprite renderer is requesting a VRAM read</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">spr_0_rendering</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">Pixel Mux</span></p></td>
<td><p><span class="c1">Determines if the current sprite that is rendering is sprite 0</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">inc_oam_addr</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Signals the OAM address in the registers to increment</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">PPU Sprite Renderer Diagram</span>
----------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 556.77px; height: 408.55px;"> ![Untitled Diagram.png](images/image12.png) </span>

<span class="c36"></span>

<span class="c36"></span>

<span class="c36"></span>

<span class="c43">VRAM:</span> <span> The sprite renderer need to be able to fetch the sprite pattern data from the character rom. This is why it can request VRAM reads from this region through the PPU Register Interface</span>

<span class="c43">PPU Register Interface:</span> <span> All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.</span> <span class="c36"> </span>

<span class="c43">Object Attribute Memory:</span> <span class="c1"> OAM contains all of the data needed to render a sprite to the screen except the pattern data itself. For each sprite OAM holds its x position, y position, horizontal flip, vertical flip, and palette information. In total OAM supports 64 sprites.</span>

<span class="c43">Sprite Renderer State Machine:</span> <span class="c1"> The sprite renderer state machine is responsible for sending all of the control signals to each of the other units in the renderer. This includes procesing the data in OAM, move the correct sprites to secondary OAM, VRAM reads, and shifting out the sprite data when the sprite needs to be rendered to the screen.</span>

<span class="c43">Sprite Shift Registers:</span> <span class="c1"> The sprite shift registers hold the sprite pixel data for sprites on the current scanline. When a sprite becomes active its data is shifted out to the pixel priority mux.</span>

<span class="c43">Pixel Priority Mux: </span> <span>Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.</span>

<span class="c43">Temporary Sprite Data:</span> <span class="c1"> The temporary sprite data is where the state machine moves the current sprite being evaluated in OAM to. If the temporary sprite falls on the next scanline its data is moved into a slot in secondary OAM. If it does not the data is discarded.</span>

<span class="c43">Secondary Object Attribute Memory:</span> <span class="c1"> Secondary OAM holds the sprite data for sprites that fall on the next scanline. During hblank this data is used to load the sprite shift registers with the correct sprite pattern data.</span>

<span class="c43">Sprite Counter and Priority Registers:</span> <span> These registers hold the priority information for each sprite in the sprite shift registers. It also holds a down counter for each sprite which is loaded with the sprite's x position. When the counter hits 0 the corresponding sprite becomes active and the sprite data needs to be shifted out to the screen.</span>

<span class="c42">PPU Object Attribute Memory</span>
----------------------------------------------------

<span class="c1"></span>

<span id="NES.xhtml#t.c1d0725151e3ae45852fd0f9196d5e83cf527c44"></span> <span id="NES.xhtml#t.15"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">oam_en</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">OAM</span></p></td>
<td><p><span class="c1">Determines if the input data is for a valid read/write</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">oam_rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">OAM</span></p></td>
<td><p><span class="c1">Determines if the current operation is a read or write</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">spr_select[5:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">OAM</span></p></td>
<td><p><span class="c1">Determines which sprite is being read/written</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">byte_select[1:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">OAM</span></p></td>
<td><p><span class="c1">Determines which sprite byte is being read/written</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">data_in[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">OAM</span></p></td>
<td><p><span class="c1">Data to write to the specified OAM address</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">data_out[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU Register</span></p></td>
<td><p><span class="c1">Data that has been read from OAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">PPU Palette Memory</span>
-------------------------------------------

<span class="c1"></span>

<span id="NES.xhtml#t.f1d3489e5c353600b2df513bca63b64f963856ac"></span> <span id="NES.xhtml#t.16"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">pal_addr[4:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">palette mem</span></p></td>
<td><p><span class="c1">Selects the palette to read/write in the memory</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">pal_data_in[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">palette mem</span></p></td>
<td><p><span class="c1">Data to write to the palette memory</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">palette_mem_rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">palette mem</span></p></td>
<td><p><span class="c1">Determines if the current operation is a read or write</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">palette_mem_en</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">palette mem</span></p></td>
<td><p><span class="c1">Determines if the palette mem inputs are valid</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">color_out[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Returns the selected palette for a given address on a read</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">VRAM Interface</span>
---------------------------------------

<span class="c1">The VRAM interface instantiates an Altera RAM IP core. Each read take 2 cycles one for the input and one for the output</span>

<span id="NES.xhtml#t.40d96b8d3f361e8568937a45000f4fd566ca150c"></span> <span id="NES.xhtml#t.17"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vram_addr[10:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">Address from VRAM to read to or write from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vram_data_in[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">The data to write to VRAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vram_en</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">The VRAM enable signal</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vram_rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">Selects if the current op is a read or write</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">vram_data_out[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">The data that was read from VRAM on a read</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42"></span>
-------------------------

<span class="c42">DMA</span>
----------------------------

<span class="c1">The DMA is used to copy 256 bytes of data from the CPU address space into the OAM (PPU address space). The DMA is 4x faster than it would be to use str and ldr instructions to copy the data. While copying data, the CPU is stalled.</span>

<span id="NES.xhtml#t.529fd0b7b6c6112b07e37b86cf3de0f87c25e96e"></span> <span id="NES.xhtml#t.18"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">oamdma</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">When written to, the DMA will begin copying data to the OAM. If the value written here is XX then the data that will be copied begins at the address XX00 in the CPU RAM and goes until the address XXFF. Data will be copied to the OAM starting at the OAM address specified in the OAMADDR register of the OAM.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">cpu_ram_q</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">Data read in from CPU RAM will come here</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">dma_done</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Informs the CPU to pause while the DMA copies OAM data from the CPU RAM to the OAM section of the PPU RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">cpu_ram_addr</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">The address of the CPU RAM where we are reading data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cpu_ram_wr</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">Read/write enable signal for CPU RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">oam_data</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">OAM</span></p></td>
<td><p><span class="c1">The data that will be written to the OAM at the address specified in OAMADDR</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">dma_req</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">APU</span></p></td>
<td><p><span class="c1">High when the DMC wants to use the DMA</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">dma_ack</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">APU</span></p></td>
<td><p><span class="c1">High when data on DMA</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">dma_addr</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">APU</span></p></td>
<td><p><span class="c1">Address for DMA to read from ** CURRENTLY NOT USED **</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">dma_data</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">APU</span></p></td>
<td><p><span class="c1">Data from DMA to apu memory ** CURRENTLY NOT USED **</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c1"></span>

<span class="c42">PPU Testbench</span>
--------------------------------------

<span class="c1">In a single frame the PPU outputs 61,440 pixels. Obviously this amount of information would be incredibly difficult for a human to verify as correct by looking at a simulation waveform. This is what drove me to create a testbench capable of rendering full PPU frames to an image. This allowed the process of debugging the PPU to proceed at a much faster rate than if I used waveforms alone. Essentially how the test bench works is the testbench sets the initial PPU state, it lets the PPU render a frame, and then the testbench receives the data for each pixel and generates a PPM file. The testbench can render multiple frames in a row, so the tester can see how the frame output changes as the PPU state changes.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 409.38px; height: 165.80px;"> ![Untitled Diagram.png](images/image14.png) </span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 388.22px; height: 240.99px;"> ![Untitled Diagram.png](images/image17.png) </span>

<span class="c42">PPU Testbench PPM file format</span>
------------------------------------------------------

<span class="c1">The PPM image format is one of the easiest to understand image formats available. This is mostly because of how it is a completely human readable format. A PPM file simply consists of a header, and then pixel data. The header consists of the text “P3” on the first line, followed by the image width and height on the next line, then a max value for each of the rgb components of a pixel on the final line of the header. After the header it is just width \* height rgb colors in row major order.</span>

<span class="c42"></span>
-------------------------

<span class="c42"></span>
-------------------------

<span class="c42">PPU Testbench Example Renderings</span>
---------------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 197.53px; height: 186.50px;"> ![test (1).png](images/image5.png) </span> <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 200.68px; height: 187.50px;"> ![test (2).png](images/image7.png) </span> <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 199.53px; height: 189.50px;"> ![test (3).png](images/image6.png) </span> <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 202.30px; height: 187.50px;"> ![test (4).png](images/image19.png) </span> <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 201.50px; height: 187.67px;"> ![test (5).png](images/image26.png) </span> <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 198.60px; height: 186.50px;"> ![test (10).png](images/image8.png) </span>

   <span>5. Memory Maps</span>
============================================

<span class="c1">Cartridges are a Read-Only Memory that contains necessary data to run games. However, it is possible that in some cases that a cartridge holds more data than the CPU can address to. In this case, memory mapper comes into play and changes the mapping as needed so that one address can point to multiple locations in a cartridge. For our case, the end goal was to get the game Super Mario Bros. running on our FPGA. This game does not use a memory mapper, so we did not work on any memory mappers. In the future, we might add support for the other memory mapping systems so that we can play other games.</span>

<span class="c1">These were two ip catalog ROM blocks that are created using MIF files for Super Mario Bros. They contained the information for the CPU and PPU RAM and VRAM respectively.</span>

<span class="c42"></span>
-------------------------

<span class="c42">PPU ROM Memory Map</span>
-------------------------------------------

<span class="c1">This table shows how the PPU’s memory is laid out. The Registers are explained in greater detail in the Architecture Document.</span>

<span id="NES.xhtml#t.d3aeb09ef995373f509588bfbe093c2a247a33be"></span> <span id="NES.xhtml#t.19"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Address Range</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x0000 - 0x0FFF</span></p></td>
<td><p><span class="c1">Pattern Table 0</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x1000 - 0x1FFF</span></p></td>
<td><p><span class="c1">Pattern Table 1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x2000 - 0x23BF</span></p></td>
<td><p><span class="c1">Name Table 0</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x23C0 - 0x23FF</span></p></td>
<td><p><span class="c1">Attribute Table 0</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x2400 - 0x27BF</span></p></td>
<td><p><span class="c1">Name Table 1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x27C0 - 0x27FF</span></p></td>
<td><p><span class="c1">Attribute Table 1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x2800 - 0x2BBF</span></p></td>
<td><p><span class="c1">Name Table 2</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x2BC0 - 0x2BFF</span></p></td>
<td><p><span class="c1">Attribute Table 2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x2C00 - 0x2FBF</span></p></td>
<td><p><span class="c1">Name Table 3</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x2FC0 - 0x2FFF</span></p></td>
<td><p><span class="c1">Attribute Table 3</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x3000 - 0x3EFF</span></p></td>
<td><p><span class="c1">Mirrors 0x2000 - 0x2EFF</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x3F00 - 0x3F0F</span></p></td>
<td><p><span class="c1">Background Palettes</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x3F10 - 0x3F1F</span></p></td>
<td><p><span class="c1">Sprite Palettes</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x3F20 - 0x3FFF</span></p></td>
<td><p><span class="c1">Mirrors 0x3F00 - 0x3F1F</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x4000 - 0xFFFF</span></p></td>
<td><p><span class="c1">Mirrors 0x0000 - 0x3FFF</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">CPU ROM Memory Map</span>
-------------------------------------------

<span class="c1">This table explains how the CPU’s memory is laid out. The Registers are explained in greater detail in the Architecture document.</span>

<span id="NES.xhtml#t.3ea006ae6c40b543eff9ac9fa3559a879d0621f6"></span> <span id="NES.xhtml#t.20"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Address Range</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x0000 - 0x00FF</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x0100 - 0x1FF</span></p></td>
<td><p><span class="c1">Stack</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x0200 - 0x07FF</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x0800 - 0x1FFF</span></p></td>
<td><p><span class="c1">Mirrors 0x0000 - 0x07FF</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x2000 - 0x2007</span></p></td>
<td><p><span class="c1">Registers</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x2008 - 0x3FFF</span></p></td>
<td><p><span class="c1">Mirrors 0x2000 - 0x2007</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x4000 - 0x401F</span></p></td>
<td><p><span class="c1">I/O Registers</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x4020 - 0x5FFF</span></p></td>
<td><p><span class="c1">Expansion ROM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0x6000 - 0x7FFF</span></p></td>
<td><p><span class="c1">SRAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">0x8000 - 0xBFFF</span></p></td>
<td><p><span class="c1">Program ROM Lower Bank</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">0xC000 - 0xFFFF</span></p></td>
<td><p><span class="c1">Program ROM Upper Bank</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">Memory Mappers Interface</span>
-------------------------------------------------

<span id="NES.xhtml#t.a7c474da3306d0e8e99e8d3a20902e581a1043cc"></span> <span id="NES.xhtml#t.21"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rd</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU/PPU</span></p></td>
<td><p><span class="c1">Read request</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">addr</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU/PPU</span></p></td>
<td><p><span class="c1">Address to read from</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">data</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU/PPU</span></p></td>
<td><p><span class="c1">Data from the address</span></p></td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

<span class="c138 c43"></span>
==============================

<span class="c138 c43">6. Audio Processing Unit (APU)</span>
==============================================================

<span class="c1">Due to limitations of our FPGA design board (no D2A converter) and time constraints, our group did not implement the APU. Instead, we created the register interface for the APU, so that the CPU could still read and write from the registers. The following section is provided for reference only.</span>

<span>The NES included an Audio Processing Unit (APU) to control all sound output. The APU contains five audio channels: two pulse wave modulation channels, a triangle wave channel, a noise channel (fo</span> <span>r</span> <span class="c1"> random audio), and a delta modulation channel. Each channel is mapped to registers in the CPU’s address space and each channel runs independently of the others. The outputs of all five channels are then combined using a non-linear mixing scheme. The APU also has a dedicated APU Status register. A write to this register can enable/disable any of the five channels. A read to this register can tell you if each channel still has a positive count on their respective timers. In addition, a read to this register will reveal any DMC or frame interrupts.</span>

<span class="c42"> APU Registers</span>
---------------------------------------

<span id="NES.xhtml#t.ef2c0e3f9254f624e8fccd0f50ed51a04d039588"></span> <span id="NES.xhtml#t.22"></span>

<table class="c98">
<tbody>
<tr class="c213">
<td class="c122 c174" colspan="4" rowspan="1">
<span class="c9">Registers</span>

</td>
</tr>
<tr class="c6">
<td class="c48" colspan="1" rowspan="1">
<span class="c1">$4000</span>

</td>
<td class="c139" colspan="1" rowspan="1">
<span class="c1">First pulse wave</span>

</td>
<td class="c128" colspan="1" rowspan="1">
<span class="c1">DDLC VVVV</span>

</td>
<td class="c198" colspan="1" rowspan="1">
<span class="c1">Duty, Envelope Loop, Constant Volume, Volume</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4001</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">First pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">EPPP NSSS</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Enabled, Period, Negate, Shift</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4002</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">First pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">TTTT TTTT</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Timer low</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4003</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">First pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">LLLL LTTT</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Length counter load, Timer high</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4004</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Second pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">DDLC VVVV</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Duty, Envelope Loop, Constant Volume, Volume</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4005</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Second pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">EPPP NSSS</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Enabled, Period, Negate, Shift</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4006</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Second pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">TTTT TTTT</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Timer low</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4007</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Second pulse wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">LLLL LTTT</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Length counter load, Timer high</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4008</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Triangle wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">CRRR RRRR</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Length counter control, linear count load</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4009</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Triangle wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1"></span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Unused</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$400A</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Triangle wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">TTTT TTTT</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Timer low</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$400B</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Triangle wave</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">LLLL LTTT</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Length counter load, Timer high</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$400C</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Noise Channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">--LC  VVVV</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Envelope Loop, Constant Volume, Volume</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$400D</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Noise Channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1"></span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Unused</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$400E</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Noise Channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">L---  PPPP</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Loop Noise, Noise Period</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$400F</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Noise Channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">LLLL  L---</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Length counter load</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4010</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Delta modulation channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">IL-- FFFF</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">IRQ enable, Loop, Frequency</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4011</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Delta modulation channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">-LLL  LLLL</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Load counter</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4012</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Delta modulation channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">AAAA AAAA</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Sample Address</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4013</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Delta modulation channel</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">LLLL LLLL</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Sample Length</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4015 (write)</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">APU Status Register Writes</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">---D NT21</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Enable DMC, Enable Noise, Enable Triangle, Enable Pulse 2/1</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4015 (read)</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">APU Status Register Read</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">IF-D NT21</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">DMC Interrupt, Frame Interrupt, DMC Active, Length Counter &gt; 0 for Noise, Triangle, and Pulse Channels</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4017 (write)</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">APU Frame Counter</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">MI-- ----</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Mode (0 = 4 step, 1 = 5 step), IRQ inhibit flag</span>

</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

<span class="c138 c43"></span>
==============================

   <span class="c138 c43">7. Controllers (SPART)</span>
=====================================================

<span class="c1">The controller module allows users to provide input to the FPGA. We opted to create a controller simulator program instead of using an actual NES joypad. This decision was made because the NES controllers used a proprietary port and because the available USB controllers lacked specification sheets. The simulator program communicates with the FPGA using the SPART interface, which is similar to UART. Our SPART module used 8 data bits, no parity, and 1 stop bit for serial communication. All data was received automatically into an 8 bit buffer by the SPART module at 2400 baud. In addition to the SPART module, we also needed a controller driver to allow the CPU to interface with the controllers. The controllers are memory mapped to $4016 and $4017 for CPU to read.</span>

<span class="c1">When writing high to address $4016 bit 0, the controllers are continuously loaded with the states of each button. Once address $4016 bit 0 is cleared, the data from the controllers can be read by reading from address $4016 for player 1 or $4017 for player 2. The data will be read in serially on bit 0. The first read will return the state of button A, then B, Select, Start, Up, Down, Left, Right. It will read 1 if the button is pressed and 0 otherwise. Any read after clearing $4016 bit 0 and after reading the first 8 button values, will be a 1. If the CPU reads when before clearing $4016, the state of button A with be repeatedly returned.</span>

<span class="c42">Debug Modification</span>
-------------------------------------------

<span class="c1">In order to provide an easy way to debug our top level design, we modified the controller to send an entire ram block out over SPART when it receives the send\_states signal. This later allowed us to record the PC, IR, A, X, Y, flags, and SP of the CPU into a RAM block every CPU clock cycle and print this out onto a terminal console when we reached a specific PC.</span>

<span class="c42">Controller Registers</span>
---------------------------------------------

<span id="NES.xhtml#t.f48da44243cd4a3f2f9d86b2a46e440bbc5c870d"></span> <span id="NES.xhtml#t.23"></span>

<table class="c98">
<tbody>
<tr class="c213">
<td class="c174 c122" colspan="4" rowspan="1">
<span class="c9">Registers</span>

</td>
</tr>
<tr class="c6">
<td class="c48" colspan="1" rowspan="1">
<span class="c1">$4016 (write)</span>

</td>
<td class="c139" colspan="1" rowspan="1">
<span class="c1">Controller Update</span>

</td>
<td class="c128" colspan="1" rowspan="1">
<span class="c1">---- ---C</span>

</td>
<td class="c198" colspan="1" rowspan="1">
<span class="c1">Button states of both controllers are loaded</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4016 (read)</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Controller 1 Read</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">---- ---C</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Reads button states of controller 1 in the order A, B, Start, Select, Up, Down, Left, Right</span>

</td>
</tr>
<tr class="c6">
<td class="c69" colspan="1" rowspan="1">
<span class="c1">$4017 (read)</span>

</td>
<td class="c110" colspan="1" rowspan="1">
<span class="c1">Controller 2 Read</span>

</td>
<td class="c3" colspan="1" rowspan="1">
<span class="c1">---- ---C</span>

</td>
<td class="c50" colspan="1" rowspan="1">
<span class="c1">Reads button states of controller 2 in the order A, B, Start, Select, Up, Down, Left, Right</span>

</td>
</tr>
</tbody>
</table>
<span class="c42">Controllers Wrapper</span>
--------------------------------------------

<span class="c1">The controllers wrapper acts as the top level interface for the controllers. It instantiates two Controller modules and connects each one to separate TxD RxD lines. In addition, the Controllers wrapper handles passing the cs, addr, and rw lines into the controllers correctly. Both controllers receive an address of 0 for controller writes, while controller 1 will receive address 0 for reads and controller 2 will receive address 1. </span>

### <span class="c85 c43">Controller Wrapper Diagram</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 431.00px; height: 271.48px;"> ![](images/image16.png) </span>

### <span class="c85 c43">Controller Wrapper Interface</span>

<span id="NES.xhtml#t.547db5e3cba569b697a57d71bdba389e98fcd63f"></span> <span id="NES.xhtml#t.24"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c146">Signal name</span></p></td>
<td><p><span class="c146">Signal Type</span></p></td>
<td><p><span class="c146">Source/Dest</span></p></td>
<td><p><span class="c146">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">TxD1</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">UART</span></p></td>
<td><p><span class="c1">Transmit data line for controller 1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">TxD2</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">UART</span></p></td>
<td><p><span class="c1">Transmit data line for controller 2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">RxD1</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">UART</span></p></td>
<td><p><span class="c1">Receive data line for controller 1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">RxD2</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">UART</span></p></td>
<td><p><span class="c1">Receive data line for controller 2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">addr</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Controller address, 0 for $4016, 1 for $4017</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">cpubus[7:0]</span></p></td>
<td><p><span class="c1">inout</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Data from/to the CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cs</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Chip select</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Read/Write signal (high for reads)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rx_data_peek</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">LEDR[7:0]</span></p></td>
<td><p><span class="c1">Output states to the FPGA LEDs to show that input was being received</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">send_states</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">When this signal goes high, the controller begins outputting RAM data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cpuram_q</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">Stored CPU states from the RAM block</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rd_addr</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">The address the controller is writing out to SPART</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rd</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">High when controller is reading from CPU RAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">Controller</span>
-----------------------------------

<span class="c1">The controller module instantiates the Driver and SPART module’s.</span>

### <span class="c85 c43">Controller Diagram</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 444.76px; height: 242.50px;"> ![](images/image21.png) </span>

### <span class="c85 c43">Controller Interface</span>

<span id="NES.xhtml#t.bb0222080501ccd3509902d3def0cd1f0ab3985c"></span> <span id="NES.xhtml#t.25"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">TxD</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">UART</span></p></td>
<td><p><span class="c1">Transmit data line</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">RxD</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">UART</span></p></td>
<td><p><span class="c1">Receive data line</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">addr</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Controller address 0 for $4016, 1 for $4017</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">dout[7:0]</span></p></td>
<td><p><span class="c1">inout</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Data from/to the CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cs</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Chip select</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rw</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU</span></p></td>
<td><p><span class="c1">Read write signal (low for writes)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rx_data_peek</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">LEDR</span></p></td>
<td><p><span class="c1">Outputs button states to FPGA LEDs</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">send_states</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">When this signal goes high, the controller begins outputting RAM data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">cpuram_q</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">Stored CPU states from the RAM block</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rd_addr</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">The address the controller is writing out to SPART</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rd</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">CPU RAM</span></p></td>
<td><p><span class="c1">High when controller is reading from CPU RAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">Special Purpose Asynchronous Receiver and Transmitter (SPART)</span>
--------------------------------------------------------------------------------------

<span class="c28">The SPART Module is used to receive serial data. The SPART and driver share many interconnections in order to control the reception and transmission of data. On the left, the SPART interfaces to an 8- bit, 3-state bidirectional bus, DATABUS\[7:0\]. This bus is used to transfer data and control information between the driver and the SPART. In addition, there is a 2-bit address bus, IOADDR\[1:0\] which is used to select the particular register that interacts with the DATABUS during an I/O operation. The IOR/W signal determines the direction of data transfer between the driver and SPART. For a Read (IOR/W=1), data is transferred from the SPART to the driver and for a Write (IOR/W=0), data is transferred from the driver to the SPART. IOCS and IOR/W are crucial signals in properly controlling the three-state buffer on DATABUS within the SPART. Receive Data Available (RDA), is a status signal which indicates that a byte of data has been received and is ready to be read from the SPART to the Processor. When the read operation is performed, RDA is reset. Transmit Buffer Ready (TBR) is a status signal which indicates that the transmit buffer in the SPART is ready to accept a byte for transmission. When a write operation is performed and the SPART is not ready for more transmission data, TBR is reset. The SPART is fully synchronous with the clock signal CLK; this implies that transfers between the driver and SPART can be controlled by applying IOCS, IOR/W, IOADDR, and DATABUS (in the case of a write operation) for a single clock cycle and capturing the transferred data on the next positive clock edge. The received data on RxD, however, is asynchronous with respect</span> <span> </span> <span class="c28">to CLK. Also, the serial I/O port on the workstation which receives the transmitted data from TxD has no access to CLK. This interface thus constitutes the “A” for “Asynchronous” in SPART and requires an understanding of RS-232 signal timing and (re)synchronization.</span>

<h3 class="c0" id="h.9khtivok6lhm">
<span>SPART Diagram & Interface</span>

------------------------------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 491.16px; height: 308.00px;"> ![](images/image11.png) </span>

</h3>
<span class="c42">Controller Driver</span>
------------------------------------------

<span class="c1">The controller driver is tasked with reloading the controller button states from the SPART receiver buffer when address $4016 (or $0 from controller’s point of view) is set. In addition, the driver must grab the CPU databus on a read and place a button value on bit 0. On the first read, the button state of value A is placed on the databus, followed by B, Select, Start, Up, Down, Left, Right. The value will be 1 for pressed and 0 for not pressed. After reading the first 8 buttons, the driver will output a 0 on the databus. Lastly, the controller driver can also be used to control the SPART module to output to the UART port of the computer.</span>

### <span class="c85 c43">Controller Driver State Machine</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 549.33px;"> ![](images/image13.png) </span>

------------------------------------------------------------------------

<span class="c138 c43"></span>
==============================

   <span class="c138 c43">8. VGA</span>
========================================

<span class="c1">The VGA interface consists of sending the pixel data to the screen one row at a time from left to right. In between each row it requires a special signal called horizontal sync (hsync) to be asserted at a specific time when only black pixels are being sent, called the blanking interval. This happens until the bottom of the screen is reached when another blanking interval begins where the interface is only sending black pixels, but instead of hsync being asserted the vertical sync signal is asserted. </span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 350.00px; height: 266.00px;"> ![](images/image23.png) </span>

<span class="c1">The main difficulty with the VGA interface will be designing a system to take the PPU output (a 256x240 image) and converting it into a native resolution of 640x480 or 1280x960. This was done by adding two RAM blocks to buffer the data.</span>

<span class="c42">VGA Diagram</span>
------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 527.40px; height: 285.54px;"> ![](images/image24.png) </span>

<span class="c42">VGA Interface</span>
--------------------------------------

<span id="NES.xhtml#t.0b4df1c79bd101595fde9cf3c1fde60b0b71da17"></span> <span id="NES.xhtml#t.26"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">V_BLANK_N</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Syncing each pixel</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_R[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Red pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_G[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Green pixel value</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_B[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Blue pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_CLK</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">VGA clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_HS</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Horizontal line sync</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_SYNC_N</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">0</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_VS</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Vertical line sync</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">pixel_data[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">Pixel data to be sent to the display</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ppu_clock</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">pixel data is updated every ppu clock cycle</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rendering</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">high when PPU is rendering</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">frame_end</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">high at the end of a PPU frame</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">frame_start</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">high at start of PPU frame</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">VGA Clock Gen</span>
--------------------------------------

<span class="c1">This module takes in a 50MHz system clock and creates a 25.175MHz clock, which is the standard VGA clock speed.</span>

<span id="NES.xhtml#t.db67cd3b6f294595ac31a0aea59a47ead9f1be93"></span> <span id="NES.xhtml#t.27"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span>VGA_CLK</span></p></td>
<td><p><span>output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Clock synced to VGA timing</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">locked</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">Locks VGA until clock is ready</span></p></td>
</tr>
</tbody>
</table>

<span class="c42">VGA Timing Gen</span>
---------------------------------------

<span class="c1">This block is responsible for generating the timing signals for VGA with a screen resolution of 480x640. This includes the horizontal and vertical sync signals as well as the blank signal for each pixel.</span>

<span id="NES.xhtml#t.479f40eaa1ae54a4dbe23dc6f8fb1ac9c0dbacf1"></span> <span id="NES.xhtml#t.28"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_CLK</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Clock Gen</span></p></td>
<td><p><span class="c1">vga_clk</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">V_BLANK_N</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA, Ram Reader</span></p></td>
<td><p><span class="c1">Syncing each pixel</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_HS</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Horizontal line sync</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_VS</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">Vertical line sync</span></p></td>
</tr>
</tbody>
</table>

<span class="c42"></span>
-------------------------

<span class="c42">VGA Display Plane</span>
------------------------------------------

<span class="c1">The PPU will output sprite and background pixels to the VGA module, as well as enables for each. The display plane will update the RAM block at the appropriate address with the pixel data on every PPU clock cycle when the PPU is rendering.</span>

<span id="NES.xhtml#t.5a3c07c6be733afbbfea8913bd13a94fa777ca2d"></span> <span id="NES.xhtml#t.29"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ppu_clock</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">Clock speed that the pixels from the PPU come in</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">wr_address</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">Address to write to</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">wr_req</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">Write data to the RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">data_out[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">The pixel data to store in RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">pixel_data[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">Pixel data to be sent to the display</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rendering</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">high when PPU is rendering</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">frame_start</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">high at start of PPU frame</span></p></td>
</tr>
</tbody>
</table>

<span class="c42"></span>
-------------------------

<span class="c42">VGA RAM Wrapper</span>
----------------------------------------

<span class="c1">This module instantiates two 2-port RAM blocks and using control signals, it will have the PPU write to a specific RAM block, while the VGA reads from another RAM block. The goal of this module was to make sure that the PPU writes never overlap the VGA reads, because the PPU runs at a faster clock rate. </span>

<span id="NES.xhtml#t.73d8ab931bb1de11920ee6fbbb98ace8684a3d59"></span> <span id="NES.xhtml#t.30"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">wr_address</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Display Plane</span></p></td>
<td><p><span class="c1">Address to write to</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">wr_req</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Display Plane</span></p></td>
<td><p><span class="c1">Request to write data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">data_in[5:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Display Plane</span></p></td>
<td><p><span class="c1">The data into the RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rd_req</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">RAM Reader</span></p></td>
<td><p><span class="c1">Read data out from RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rd_address</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">RAM Reader</span></p></td>
<td><p><span class="c1">Address to read from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">data_out[5:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM Reader</span></p></td>
<td><p><span class="c1">data out from RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ppu_frame_end</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">PPU</span></p></td>
<td><p><span class="c1">high at the end of a PPU frame</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">vga_frame_end</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">VGA</span></p></td>
<td><p><span class="c1">high at end of VGA frame</span></p></td>
</tr>
</tbody>
</table>

<span class="c42"></span>
-------------------------

<span class="c42">VGA RAM Reader</span>
---------------------------------------

<span class="c1">The RAM Reader is responsible for reading data from the correct address in the RAM block and outputting it as an RGB signal to the VGA. It will update the RGB signals every time the blank signal goes high. The NES supported a 256x240 image, which we will be converting to a 640x480 image. This means that the 256x240 image will be multiplied by 2, resulting in a 512x480 image. The remaining 128 pixels on the horizontal line will be filled with black pixels by this block. Lastly, this block will take use the pixel data from the PPU and the NES Palette RGB colors, to output the correct colors to the VGA.</span>

<span class="c1"></span>

<span class="c1"></span>

<span id="NES.xhtml#t.42c807ab21e38b5395f49bf60866dd95219157f1"></span> <span id="NES.xhtml#t.31"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Signal name</span></p></td>
<td><p><span class="c9">Signal Type</span></p></td>
<td><p><span class="c9">Source/Dest</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">clk</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rst_n</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">rd_req</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">Read data out from RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">rd_address</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">Address to read from</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">data_out[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">RAM</span></p></td>
<td><p><span class="c1">data out from RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_R[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">VGA Red pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_G[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">VGA Green pixel value</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">VGA_B[7:0]</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">VGA Blue pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">VGA_Blnk[7:0]</span></p></td>
<td><p><span class="c1">input</span></p></td>
<td><p><span class="c1">Time Gen</span></p></td>
<td><p><span class="c1">VGA Blank signal (high when we write each new pixel)</span></p></td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

<span class="c138 c43"></span>
==============================

   <span class="c138 c43">9. Software</span>
=============================================

<span class="c42">Controller Simulator</span>
---------------------------------------------

<span class="c1">In order to play games on the NES and provide input to our FPGA, we will have a java program that uses the JSSC (Java Simple Serial Connector) library to read and write data serially using the SPART interface. The program will provides a GUI that was created using the JFrame library. This GUI will respond to mouse clicks as well as key presses when the window is in focus. When a button state on the simulator is changed, it will trigger the program to send serial data. When data is detected on the rx line, the simulator will read in the data (every time there is 8 bytes in the buffer) and will output this data as a CPU trace to an output file. Instructions to invoke this program can be found in the README file of our github directory.</span>

### <span class="c85 c43">Controller Simulator State Machine </span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 346.76px; height: 336.00px;"> ![](images/image25.png) </span>

### <span class="c85 c43">Controller Simulator Output Packet Format</span>

<span id="NES.xhtml#t.ad9e3dcf59b3c7f193497b3a552afdad72d4c697"></span> <span id="NES.xhtml#t.32"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Packet name</span></p></td>
<td><p><span class="c9">Packet type</span></p></td>
<td><p><span class="c9">Packet Format</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Controller Data</span></p></td>
<td><p><span class="c1">output</span></p></td>
<td><p><span class="c1">ABST-UDLR</span></p></td>
<td><p><span class="c1">This packet indicates which buttons are being pressed. A 1 indicates pressed, a 0 indicates not pressed. </span></p>
<p><span class="c1">(A) A button, (B) B button, (S) Select button, (T) Start button, (U) Up, (D) Down, (L) Left, (R) Right</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

### <span class="c43 c85">Controller Simulator GUI and Button Map</span>

<span class="c1">The NES controller had a total of 8 buttons, as shown below.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 257.33px;"> ![](images/image4.png) </span>

<span class="c1">The NES buttons will be mapped to specific keys on the keyboard. The keyboard information will be obtained using KeyListeners in the java.awt.\* library. The following table indicates how the buttons are mapped and their function in Super Mario Bros.</span>

<span id="NES.xhtml#t.ad380988598047a9ceb5cfe38e7d802123c4d7be"></span> <span id="NES.xhtml#t.33"></span>

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Keyboard button</span></p></td>
<td><p><span class="c9">NES Equivalent</span></p></td>
<td><p><span class="c9">Super Mario Bros. Function</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">X Key</span></p></td>
<td><p><span class="c1">A Button</span></p></td>
<td><p><span class="c1">Jump (Hold to jump higher)</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">Z Key</span></p></td>
<td><p><span class="c1">B Button</span></p></td>
<td><p><span class="c1">Sprint (Hold and use arrow keys)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Tab Key</span></p></td>
<td><p><span class="c1">Select Button</span></p></td>
<td><p><span class="c1">Pause Game</span></p></td>
</tr>
<tr class="odd">
<td><p><span>Enter Key</span></p></td>
<td><p><span>Start Button</span></p></td>
<td><p><span>Start Game</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Up Arrow</span></p></td>
<td><p><span class="c1">Up on D-Pad</span></p></td>
<td><p><span class="c1">No function</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">Down Arrow</span></p></td>
<td><p><span class="c1">Down on D-Pad</span></p></td>
<td><p><span class="c1">Enter pipe (only works on some pipes)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">Left Arrow</span></p></td>
<td><p><span class="c1">Left on D-Pad</span></p></td>
<td><p><span class="c1">Move left</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">Right Arrow</span></p></td>
<td><p><span class="c1">Right on D-Pad</span></p></td>
<td><p><span class="c1">Move right</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42">Assembler</span>
----------------------------------

<span class="c1">We will include an assembler that allows custom software to be developed for our console. This assembler will convert assembly code to machine code for the NES on .mif files that we can load into our FPGA. It will include support for labels and commenting.The ISA is specified in the table below:</span>

<span class="c1"></span>

### <span class="c85 c43">Opcode Table</span>

<span id="NES.xhtml#t.a78dffae99888f28a7d901ca905aed1ef15fecc7"></span> <span id="NES.xhtml#t.34"></span>

<table style="width:100%;">
<colgroup>
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
<col width="11%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c112 c43">Opcode</span></p></td>
<td><p><span class="c112 c43">Mode</span></p></td>
<td><p><span class="c112 c43">Hex</span></p></td>
<td><p><span class="c43 c112">Opcode</span></p></td>
<td><p><span class="c112 c43">Mode</span></p></td>
<td><p><span class="c112 c43">Hex</span></p></td>
<td><p><span class="c112 c43">Opcode</span></p></td>
<td><p><span class="c112 c43">Mode</span></p></td>
<td><p><span class="c112 c43">Hex</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">69</span></p></td>
<td><p><span class="c1">DEC</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">C6</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">0D</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">65</span></p></td>
<td><p><span class="c1">DEC</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">D6</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">1D</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">75</span></p></td>
<td><p><span class="c1">DEC</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">CE</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">19</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">6D</span></p></td>
<td><p><span class="c1">DEC</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">DE</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">01</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">7D</span></p></td>
<td><p><span class="c1">DEX</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">CA</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">11</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">79</span></p></td>
<td><p><span class="c1">DEY</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">88</span></p></td>
<td><p><span class="c1">PHA</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">48</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">61</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">49</span></p></td>
<td><p><span class="c1">PHP</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">08</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ADC</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">71</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">45</span></p></td>
<td><p><span class="c1">PLA</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">68</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">29</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">55</span></p></td>
<td><p><span class="c1">PLP</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">28</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">25</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">4D</span></p></td>
<td><p><span class="c1">ROL</span></p></td>
<td><p><span class="c1">Accumulator</span></p></td>
<td><p><span class="c1">2A</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">35</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">5D</span></p></td>
<td><p><span class="c1">ROL</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">26</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">2D</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">59</span></p></td>
<td><p><span class="c1">ROL</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">36</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">3D</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">41</span></p></td>
<td><p><span class="c1">ROL</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">2E</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">39</span></p></td>
<td><p><span class="c1">EOR</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">51</span></p></td>
<td><p><span class="c1">ROL</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">3E</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">21</span></p></td>
<td><p><span class="c1">INC</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">E6</span></p></td>
<td><p><span class="c1">ROR</span></p></td>
<td><p><span class="c1">Accumulator</span></p></td>
<td><p><span class="c1">6A</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">AND</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">31</span></p></td>
<td><p><span class="c1">INC</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">F6</span></p></td>
<td><p><span class="c1">ROR</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">66</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ASL</span></p></td>
<td><p><span class="c1">Accumulator</span></p></td>
<td><p><span class="c1">0A</span></p></td>
<td><p><span class="c1">INC</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">EE</span></p></td>
<td><p><span class="c1">ROR</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">76</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ASL</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">06</span></p></td>
<td><p><span class="c1">INC</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">FE</span></p></td>
<td><p><span class="c1">ROR</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">6E</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ASL</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">16</span></p></td>
<td><p><span class="c1">INX</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">E8</span></p></td>
<td><p><span class="c1">ROR</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">7E</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">ASL</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">0E</span></p></td>
<td><p><span class="c1">INY</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">C8</span></p></td>
<td><p><span class="c1">RTI</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">40</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">ASL</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">1E</span></p></td>
<td><p><span class="c1">JMP</span></p></td>
<td><p><span class="c1">Indirect</span></p></td>
<td><p><span class="c1">6C</span></p></td>
<td><p><span class="c1">RTS</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">60</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">BCC</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">90</span></p></td>
<td><p><span class="c1">JMP</span></p></td>
<td><p><span class="c1">Absolute </span></p></td>
<td><p><span class="c1">4C</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">E9</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">BCS</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">B0</span></p></td>
<td><p><span class="c1">JSR</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">20</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">E5</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">BEQ</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">F0</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">A9</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">F5</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">BIT</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">24</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">A5</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">ED</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">BIT</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">2C</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">B5</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">FD</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">BMI</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">30</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">AD</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">F9</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">BNE</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">D0</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">BD</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">E1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">BPL</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">10</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">B9</span></p></td>
<td><p><span class="c1">SBC</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">F1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">BRK</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">00</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">A1</span></p></td>
<td><p><span class="c1">SEC</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">38</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">BVC</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">50</span></p></td>
<td><p><span class="c1">LDA</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">B1</span></p></td>
<td><p><span class="c1">SED</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">F8</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">BVS</span></p></td>
<td><p><span class="c1">Relative</span></p></td>
<td><p><span class="c1">70</span></p></td>
<td><p><span class="c1">LDX</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">A2</span></p></td>
<td><p><span class="c1">SEI</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">78</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CLC</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">18</span></p></td>
<td><p><span class="c1">LDX</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">A6</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">85</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CLD</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">D8</span></p></td>
<td><p><span class="c1">LDX</span></p></td>
<td><p><span class="c1">Zero Page, Y</span></p></td>
<td><p><span class="c1">B6</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">95</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CLI</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">58</span></p></td>
<td><p><span class="c1">LDX</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">AE</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">8D</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CLV</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">B8</span></p></td>
<td><p><span class="c1">LDX</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">BE</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">9D</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">C9</span></p></td>
<td><p><span class="c1">LDY</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">A0</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">99</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">C5</span></p></td>
<td><p><span class="c1">LDY</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">A4</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">81</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">D5</span></p></td>
<td><p><span class="c1">LDY</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">B4</span></p></td>
<td><p><span class="c1">STA</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">91</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">CD</span></p></td>
<td><p><span class="c1">LDY</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">AC</span></p></td>
<td><p><span class="c1">STX</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">86</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">DD</span></p></td>
<td><p><span class="c1">LDY</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">BC</span></p></td>
<td><p><span class="c1">STX</span></p></td>
<td><p><span class="c1">Zero Page, Y</span></p></td>
<td><p><span class="c1">96</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Absolute, Y</span></p></td>
<td><p><span class="c1">D9</span></p></td>
<td><p><span class="c1">LSR</span></p></td>
<td><p><span class="c1">Accumulator</span></p></td>
<td><p><span class="c1">4A</span></p></td>
<td><p><span class="c1">STX</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">8E</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Indirect, X</span></p></td>
<td><p><span class="c1">C1</span></p></td>
<td><p><span class="c1">LSR</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">46</span></p></td>
<td><p><span class="c1">STY</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">84</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CMP</span></p></td>
<td><p><span class="c1">Indirect, Y</span></p></td>
<td><p><span class="c1">D1</span></p></td>
<td><p><span class="c1">LSR</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">56</span></p></td>
<td><p><span class="c1">STY</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">94</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CPX</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">E0</span></p></td>
<td><p><span class="c1">LSR</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">4E</span></p></td>
<td><p><span class="c1">STY</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">8C</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CPX</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">E4</span></p></td>
<td><p><span class="c1">LSR</span></p></td>
<td><p><span class="c1">Absolute, X</span></p></td>
<td><p><span class="c1">5E</span></p></td>
<td><p><span class="c1">TAX</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">AA</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CPX</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">EC</span></p></td>
<td><p><span class="c1">NOP</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">EA</span></p></td>
<td><p><span class="c1">TAY</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">A8</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CPY</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">C0</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Immediate</span></p></td>
<td><p><span class="c1">09</span></p></td>
<td><p><span class="c1">TSX</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">BA</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">CPY</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">C4</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Zero Page</span></p></td>
<td><p><span class="c1">05</span></p></td>
<td><p><span class="c1">TXA</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">8A</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c1">CPY</span></p></td>
<td><p><span class="c1">Absolute</span></p></td>
<td><p><span class="c1">CC</span></p></td>
<td><p><span class="c1">ORA</span></p></td>
<td><p><span class="c1">Zero Page, X</span></p></td>
<td><p><span class="c1">15</span></p></td>
<td><p><span class="c1">TXS</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">9A</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1"></span></p></td>
<td><p><span class="c1">TYA</span></p></td>
<td><p><span class="c1">Implied</span></p></td>
<td><p><span class="c1">98</span></p></td>
</tr>
</tbody>
</table>

### <span class="c85 c43">NES Assembly Formats</span>

<span class="c1">Our assembler will allow the following input format, each instruction/label will be on its own line. In addition unlimited whitespace is allowed:</span>

<span id="NES.xhtml#t.785c03daa4e813953d8cbf70f3d9e2ff7a6c8246"></span> <span id="NES.xhtml#t.35"></span>

<table class="c223">
<tbody>
<tr class="c143">
<td class="c122 c155" colspan="3" rowspan="1">
<span class="c9">Instruction Formats</span>

</td>
</tr>
<tr class="c6">
<td class="c122 c180" colspan="1" rowspan="1">
<span class="c9">Instruction Type</span>

</td>
<td class="c122 c136" colspan="1" rowspan="1">
<span class="c9">Format</span>

</td>
<td class="c122 c216" colspan="1" rowspan="1">
<span class="c9">Description</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Constant</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">Constant\_Name = &lt;Constant Value&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Must be declared before CPU\_Start</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Label</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">Label\_Name:</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Cannot be the same as an opcode name. Allows reference from branch opcodes.</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Comment</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">; Comment goes here</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Anything after the ; will be ignored</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">CPU Start</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">\_CPU:</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Signals the start of CPU memory</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Accumulator</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Accumulator is value affected by Opcode</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Implied</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Operands implied by opcode. ie. TXA has X as source and Accumulator as destination</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Immediate</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; \#&lt;Immediate&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">The decimal number will be converted to binary and used as operand</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Absolute</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; $&lt;ADDR/LABEL&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">The byte at the specified address is used as operand</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Zero Page</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; $&lt;BYTE OFFSET&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">The byte at address $00XX is used as operand.</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Relative</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; $&lt;BYTE OFFSET/LABEL&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">The byte at address PC +/- Offset is used as operand. Offset can range -128 to +127</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Absolute Index</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; $&lt;ADDR/LABEL&gt;,&lt;X or Y&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Absolute but value in register added to address.</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Zero Page Index</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; $&lt;BYTE OFFSET&gt;,&lt;X or Y&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Zero page but value in register added to offset.</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Zero Page X Indexed Indirect</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; ($&lt;BYTE OFFSET&gt;,X)</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">Value in X added to offset. Address in $00XX (where XX is new offset) is used as the address for the operand.</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Zero Page Y Indexed Indirect</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;OPCODE&gt; ($&lt;BYTE OFFSET&gt;),Y</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">The address in $00XX, where XX is byte offset, is added to the value in Y and is used as the address for the operand.</span>

</td>
</tr>
<tr class="c6">
<td class="c81" colspan="1" rowspan="1">
<span class="c1">Data instruction</span>

</td>
<td class="c56" colspan="1" rowspan="1">
<span class="c1">&lt;.DB or .DW&gt; &lt;data values&gt;</span>

</td>
<td class="c63" colspan="1" rowspan="1">
<span class="c1">If .db then the data values must be bytes, if .dw then the data values must be 2 bytes. Multiple comma separated data values can be include for each instruction. Constants are valid.</span>

</td>
</tr>
</tbody>
</table>
<span class="c1"></span>

<span class="c1"></span>

<span id="NES.xhtml#t.1cff97851711fad7eb43d3937b11aea5c574f346"></span> <span id="NES.xhtml#t.36"></span>

<table class="c133">
<tbody>
<tr class="c213">
<td class="c122 c144" colspan="3" rowspan="1">
<span class="c9">Number Formats</span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Immediate Decimal (Signed)</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">\#&lt;(-)DDD&gt;</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1">Max 127, Min -128</span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Immediate Hexadecimal (Signed)</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">\#$&lt;HH&gt;</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1"></span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Immediate Binary (Signed)</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">\#%&lt;BBBB.BBBB&gt;</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1">Allows ‘.’ in between bits</span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Address/Offset Hex</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">$&lt;Addr/Offset&gt;</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1">8 bits offset, 16 bits address</span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Address/Offset Binary</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">$%&lt;Addr/Offset&gt;</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1">8 bits offset, 16 bits address</span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Offset Decimal (Relative only)</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">\#&lt;(-)DDD&gt;</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1">Relative instructions can’t be Immediate, so this is allowed.</span>

<span class="c1">Max 127, Min -128</span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Constant first byte</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">&lt;Constant\_Name</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1"></span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Constant second byte</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">&gt;Constant\_Name</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1"></span>

</td>
</tr>
<tr class="c6">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Constant</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">Constant\_Name</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1"></span>

</td>
</tr>
<tr class="c185">
<td class="c62" colspan="1" rowspan="1">
<span class="c1">Label</span>

</td>
<td class="c86" colspan="1" rowspan="1">
<span class="c1">Label\_Name</span>

</td>
<td class="c123" colspan="1" rowspan="1">
<span class="c1">Not valid for data instructions</span>

</td>
</tr>
</tbody>
</table>
### <span class="c85 c43"></span>

### <span class="c85 c43">Invoking Assembler</span>

<span id="NES.xhtml#t.6f668fdd16c4e436778a938b5c4f34d93bcf4744"></span> <span id="NES.xhtml#t.37"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Usage</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">java NESAssemble &lt;input file&gt; &lt;cpuouput.mif&gt; &lt;ppuoutput.mif&gt;</span></p></td>
<td><p><span class="c1">Reads the input file and outputs the CPU ROM to cpuoutput.mif and the PPU ROM to ppuoutput.mif</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42"> iNES ROM Converter</span>
--------------------------------------------

<span class="c1">Most NES games are currently available online in files of the iNES format, a header format used by most software NES emulators. Our NES will not support this file format. Instead, we will write a java program that takes an iNES file as input and outputs two .mif files that contain the CPU RAM and the PPU VRAM. These files will be used to instantiate the ROM’s of the CPU and PPU in our FPGA.</span>

<span id="NES.xhtml#t.634ae5c55415151724744d13c7cc9c9a4d7dbd40"></span> <span id="NES.xhtml#t.38"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c9">Usage</span></p></td>
<td><p><span class="c9">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c1">java NEStoMIF &lt;input.nes&gt; &lt;cpuouput.mif&gt; &lt;ppuoutput.mif&gt;</span></p></td>
<td><p><span class="c1">Reads the input file and outputs the CPU RAM to cpuoutput.mif and the PPU VRAM to ppuoutput.mif</span></p></td>
</tr>
</tbody>
</table>

<span class="c1"></span>

<span class="c42"> Tic Tac Toe</span>
-------------------------------------

<span class="c1">We also implemented Tic Tac Toe in assembly for initial integration tests. We bundled it into a NES ROM, and thus can run it on existing emulators as well as our own hardware.</span>

   <span class="c138 c43">10. Testing & Debug</span>
======================================================

<span class="c1">Our debugging process had multiple steps</span>

<span class="c42">Simulation</span>
-----------------------------------

<span class="c1">For basic sanity check, we simulated each module independently to make sure the signals behave as expected.</span>

<span class="c42">Test</span>
-----------------------------

<span>For detailed check, we wrote an automated testbench to confirm the functionality. The CPU test suite was from </span> <span class="c157"> <a href="https://www.google.com/url?q=https://github.com/Klaus2m5/&amp;sa=D&amp;ust=1494576256694000&amp;usg=AFQjCNH5C2c6mP2PLu8ndy--7mzFJquIMg" class="c40">https://github.com/Klaus2m5/</a> </span> <span> and we modified the test suite to run on the fceux NES emulator.</span>

<span class="c42">Integrated Simulation</span>
------------------------------------------------------------

<span class="c1">After integration, we simulated the whole system with the ROM installed. We were able to get a detailed information at each cycle but the simulation took too long. It took about 30 minutes to simulate CPU operation for one second. Thus we designed a debug and trace module in hardware that could output CPU traces during actual gameplay..</span>

<span class="c42">Tracer</span>
-------------------------------

<span>We added additional code in Controller so that the Controller can store information at every cycle and dump them back to the serial console under some condition. At first, we used a button as the trigger, but after</span> <span> we analyzed the exact problem, we used a conditional statement(for e.g. when PC reached a certain address) to trigger the dump. When the condition was met, the Controller would stall the CPU and start dumping what the CPU has been doing, in the opposite order of execution. The technique was extremely useful because we came to the conclusion that there must be a design defect when Mario crashed, such as using don’t cares or high impedance. After we corrected the defect, we were able to run Mario.</span>

------------------------------------------------------------------------

</p>
   <span>11. Results</span>
==============================

<span class="c1">We were able to get NES working, thanks to our rigorous verification process, and onboard debug methodology. Some of the games we got working include Super Mario Bros, Galaga, Tennis, Golf, Donkey Kong, Ms Pacman, Defender II, Pinball, and Othello.  </span>

   <span class="c138 c43">12. Possible Improvements</span>
 ===========================================================

-   <span class="c1">Create a working audio processing unit</span>
-   <span class="c1">More advanced memory mapper support</span>
-   <span class="c1">Better image upscaling such as hqx</span>
-   <span class="c1">Support for actual NES game carts</span>
-   <span class="c1">HDMI</span>
-   <span class="c1">VGA buffer instead of two RAM blocks to save space</span>

   <span>13. References and Links</span>
 ===========================================

<span class="c117">Ferguson, Scott. "PPU Tutorial." N.p., n.d. Web. &lt;</span> <span class="c117 c157"> <a href="https://www.google.com/url?q=https://opcode-defined.quora.com&amp;sa=D&amp;ust=1494576256706000&amp;usg=AFQjCNFS78o1vjYXTL61EsEMFxU5j_Gjng" class="c40">https://opcode-defined.quora.com</a> </span> <span class="c1 c117">&gt;.</span>

<span class="c117"> "6502 Specification." </span> <span class="c117">NesDev</span> <span class="c117">. N.p., n.d. Web. 10 May 2017. &lt;</span> <span class="c157 c117"> <a href="https://www.google.com/url?q=http://nesdev.com/6502.txt&amp;sa=D&amp;ust=1494576256708000&amp;usg=AFQjCNG1WXeRKeqTfUHDgKV-5FQjRaJ6ZA" class="c40">http://nesdev.com/6502.txt</a> </span> <span class="c1 c117">&gt;.</span>

<span class="c117">Dormann, Klaus. "6502 Functional Test Suite." </span> <span class="c51">GitHub</span> <span class="c117">. N.p., n.d. Web. 10 May 2017.        &lt;</span> <span class="c157 c117"> <a href="https://www.google.com/url?q=https://github.com/Klaus2m5/&amp;sa=D&amp;ust=1494576256709000&amp;usg=AFQjCNHWJMoDucP2FPYVItxakHrFUpNWwA" class="c40">https://github.com/Klaus2m5/</a> </span> <span class="c1 c117">&gt;.</span>

<span class="c117">"NES Reference Guide." </span> <span class="c117">Nesdev</span> <span class="c117">. N.p., n.d. Web. 10 May 2017. &lt;</span> <span class="c157 c117"> <a href="https://www.google.com/url?q=http://wiki.nesdev.com/w/index.php/NES_reference_guide&amp;sa=D&amp;ust=1494576256711000&amp;usg=AFQjCNEItpqnvGAfcsBgj1ecuKQhir_vLg" class="c40">http://wiki.nesdev.com/w/index.php/NES_reference_guide</a> </span> <span class="c1 c117">&gt;.</span>

<span class="c117">Java Simple Serial Connector library: &lt;</span> <span class="c157 c117"> <a href="https://www.google.com/url?q=https://github.com/scream3r/java-simple-serial-connector&amp;sa=D&amp;ust=1494576256713000&amp;usg=AFQjCNHvXqe3iyWaw4NfUc5f-uSDzSX0XA" class="c40">https://github.com/scream3r/java-simple-serial-connector</a> </span> <span class="c1 c117">&gt;</span>

<span class="c117">Final Github release: &lt;</span> <span class="c157 c117"> <a href="https://www.google.com/url?q=https://github.com/jtgebert/fpganes_release&amp;sa=D&amp;ust=1494576256714000&amp;usg=AFQjCNFkbDC9GDGTJBqGTwnRVWLYt-KUpw" class="c40">https://github.com/jtgebert/fpganes_release</a> </span> <span class="c1 c117">&gt;</span>

<span class="c1 c117"></span>

<span class="c1 c117"></span>

<span class="c1 c117"></span>

<span class="c138 c43"></span>
==============================

<span class="c1"></span>

<span class="c1"></span>

  <span class="c138 c43">14. Contributions</span>
=========================================================

<span class="c42">Eric Sullivan</span>
--------------------------------------

<span>Designed and debugged the NES picture processing unit, created a comprehensive set of PPU testbenches to verify functionality, Integrated the VGA to the PPU, implemented the DMA and dummy APU, started a CPU simulator in python, Helped debug the integrated system.</span>

<span class="c42">Patrick Yang</span>
-------------------------------------

<span>Specified the CPU microarchitecture along with Pavan, designed the ALU, registers, and memory interface unit, wrote a self checking testbench, responsible for CPU debug, integrated all modules on top level file, and debugged of the integrated system. Helped Jon to modify controller driver to also be an onboard CPU trace module.</span>

<span class="c42">Pavan Holla</span>
------------------------------------

<span class="c1">Specified the CPU microarchitecture along with Patrick, designed the decoder and interrupt handler, and wrote the script that generates the processor control module. Modified a testsuite and provided the infrastructure for CPU verification. Wrote tic tac toe in assembly as a fail-safe game.  Also, worked on a parallel effort to integrate undocumented third party NES IP.</span>

<span>Jonathan Ebert</span>
---------------------------

<span>Modified the VGA to interface with the PPU. W</span> <span>rote a new driver to control our existing SPART module to act as a NES controller and as an onboard CPU trace module. Wrote Java program to communicate with the SPART module using the JSSC library. Wrote memory wrappers, hardware decoder, and generated all game ROMs. Helped debug the integrated system. Wrote a very simple assembler. Wrote script to convert NES ROMs to MIF files. Also, worked on a parallel effort to integrate undocumented third party NES IP</span> <span>.</span>
