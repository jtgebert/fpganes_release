<div>

[]{.c7}

</div>

[FPGA Implementation of the Nintendo Entertainment System (NES)]{.c148}

[Four People Generating A Nintendo Entertainment System (FPGANES)]{.c42}

[Eric Sullivan, Jonathan Ebert, Patrick Yang, ]{.c128}[Pavan Holla]{.c114}

[]{.c114}

[]{.c114}

[]{.c7}

[]{.c7}

[]{.c7}

[]{.c7}

[]{.c7}

[]{.c7}

[Final Report ]{.c148}

[]{.c7}

[]{.c7}

[]{.c7}

[]{.c7}

[]{.c7}

[University of Wisconsin-Madison]{.c176}

[ECE 554]{.c176}

[Spring 2017]{.c176}

[]{.c7}

[[Introduction](#h.g5jrstas8bb9){.c24}]{.c23}[        ]{.c23}[[6](#h.g5jrstas8bb9){.c24}]{.c23}

[[Top Level Block Diagram](#h.1ayvkhk4vvmg){.c24}]{.c23}[        ]{.c23}[[7](#h.1ayvkhk4vvmg){.c24}]{.c23}

[[Top level description](#h.8r6j63kwrjxl){.c24}]{}[        ]{}[[7](#h.8r6j63kwrjxl){.c24}]{}

[[Data Flow Diagram](#h.a9ilbl8rkgkd){.c24}]{}[        ]{}[[8](#h.a9ilbl8rkgkd){.c24}]{}

[[Control Flow Diagram](#h.m6jcsadip56s){.c24}]{}[        ]{}[[8](#h.m6jcsadip56s){.c24}]{}

[[CPU](#h.rdm0fxe7s5y9){.c24}]{.c23}[        ]{.c23}[[9](#h.rdm0fxe7s5y9){.c24}]{.c23}

[[CPU Registers](#h.eftj2rjo9s1h){.c24}]{}[        ]{}[[9](#h.eftj2rjo9s1h){.c24}]{}

[[CPU ISA](#h.wvvuysbh6ili){.c24}]{}[        ]{}[[9](#h.wvvuysbh6ili){.c24}]{}

[[CPU Addressing Modes](#h.9ie72e7qdon7){.c24}]{}[        ]{}[[10](#h.9ie72e7qdon7){.c24}]{}

[[CPU Interrupts](#h.b7loafaij831){.c24}]{}[        ]{}[[10](#h.b7loafaij831){.c24}]{}

[[CPU Opcode Matrix](#h.q77927r8c49e){.c24}]{}[        ]{}[[10](#h.q77927r8c49e){.c24}]{}

[[CPU Block Diagram](#h.ki2ushz1f0a3){.c24}]{}[        ]{}[[13](#h.ki2ushz1f0a3){.c24}]{}

[[CPU Top Level Interface](#h.er7yq56tef4v){.c24}]{}[        ]{}[[15](#h.er7yq56tef4v){.c24}]{}

[[CPU Instruction Decode Interface](#h.lomim8yvajg6){.c24}]{}[        ]{}[[15](#h.lomim8yvajg6){.c24}]{}

[[CPU MEM Interface](#h.b3lc7rd7ackr){.c24}]{}[        ]{}[[16](#h.b3lc7rd7ackr){.c24}]{}

[[CPU ALU Interface](#h.nexle64nrxxq){.c24}]{}[        ]{}[[16](#h.nexle64nrxxq){.c24}]{}

[[ALU Input Selector](#h.sprgfm6rx38x){.c24}]{}[        ]{}[[17](#h.sprgfm6rx38x){.c24}]{}

[[CPU Registers Interface](#h.5httww8vnv8g){.c24}]{}[        ]{}[[17](#h.5httww8vnv8g){.c24}]{}

[[CPU Processor Control Interface](#h.eiifcf5tv1l9){.c24}]{}[        ]{}[[18](#h.eiifcf5tv1l9){.c24}]{}

[[CPU Enums](#h.3on9q42bqgrx){.c24}]{}[        ]{}[[19](#h.3on9q42bqgrx){.c24}]{}

[[Picture Processing Unit](#h.fb8snxockohd){.c24}]{.c23}[        ]{.c23}[[20](#h.fb8snxockohd){.c24}]{.c23}

[[PPU Top Level Schematic](#h.bvqrg858z31w){.c24}]{}[        ]{}[[21](#h.bvqrg858z31w){.c24}]{}

[[PPU Memory Map](#h.dkksbep8besq){.c24}]{}[        ]{}[[22](#h.dkksbep8besq){.c24}]{}

[[PPU CHAROM](#h.pa3j41hpauwc){.c24}]{}[        ]{}[[22](#h.pa3j41hpauwc){.c24}]{}

[[PPU Rendering](#h.pg3as4rfwz9v){.c24}]{}[        ]{}[[23](#h.pg3as4rfwz9v){.c24}]{}

[[PPU Memory Mapped Registers](#h.8bwwxukxxmnt){.c24}]{}[        ]{}[[25](#h.8bwwxukxxmnt){.c24}]{}

[[PPU Register Block Diagram](#h.h50m30h4jbfm){.c24}]{}[        ]{}[[26](#h.h50m30h4jbfm){.c24}]{}

[[PPU Register Descriptions](#h.djradund7fk8){.c24}]{}[        ]{}[[26](#h.djradund7fk8){.c24}]{}

[[PPU Background Renderer](#h.qbi461d1fk95){.c24}]{}[        ]{}[[28](#h.qbi461d1fk95){.c24}]{}

[[PPU Background Renderer Diagram](#h.kqe8ry35ghh){.c24}]{}[        ]{}[[29](#h.kqe8ry35ghh){.c24}]{}

[[PPU Sprite Renderer](#h.z1adjveqdhdo){.c24}]{}[        ]{}[[30](#h.z1adjveqdhdo){.c24}]{}

[[PPU Sprite Renderer Diagram](#h.ouavojij313q){.c24}]{}[        ]{}[[32](#h.ouavojij313q){.c24}]{}

[[PPU Object Attribute Memory](#h.ud4hcid0qc0t){.c24}]{}[        ]{}[[33](#h.ud4hcid0qc0t){.c24}]{}

[[PPU Palette Memory](#h.unbqcwik0ikz){.c24}]{}[        ]{}[[33](#h.unbqcwik0ikz){.c24}]{}

[[VRAM Interface](#h.xlgt5p96mvki){.c24}]{}[        ]{}[[34](#h.xlgt5p96mvki){.c24}]{}

[[DMA](#h.7oqgkdlshdds){.c24}]{}[        ]{}[[34](#h.7oqgkdlshdds){.c24}]{}

[[PPU Testbench](#h.9f0tphgw8ifs){.c24}]{}[        ]{}[[35](#h.9f0tphgw8ifs){.c24}]{}

[[PPU Testbench PPM file format](#h.dgbwdleazq7q){.c24}]{}[        ]{}[[36](#h.dgbwdleazq7q){.c24}]{}

[[PPU Testbench Example Renderings](#h.8ijczpvs4ut5){.c24}]{}[        ]{}[[37](#h.8ijczpvs4ut5){.c24}]{}

[[Memory Maps](#h.7c1koopsou4c){.c24}]{.c23}[        ]{.c23}[[37](#h.7c1koopsou4c){.c24}]{.c23}

[[PPU ROM Memory Map](#h.o4bj1b7uzlbc){.c24}]{}[        ]{}[[37](#h.o4bj1b7uzlbc){.c24}]{}

[[CPU ROM Memory Map](#h.n5cypllda98c){.c24}]{}[        ]{}[[38](#h.n5cypllda98c){.c24}]{}

[[Memory Mappers Interface](#h.5cvhenp51lun){.c24}]{}[        ]{}[[39](#h.5cvhenp51lun){.c24}]{}

[[APU](#h.bryqhbcn7knu){.c24}]{.c23}[        ]{.c23}[[40](#h.bryqhbcn7knu){.c24}]{.c23}

[[APU Registers](#h.qk56hr19gphj){.c24}]{}[        ]{}[[40](#h.qk56hr19gphj){.c24}]{}

[[Controllers (SPART)](#h.5fhzf7bk1zke){.c24}]{.c23}[        ]{.c23}[[42](#h.5fhzf7bk1zke){.c24}]{.c23}

[[Debug Modification](#h.927n2dvl8df9){.c24}]{}[        ]{}[[42](#h.927n2dvl8df9){.c24}]{}

[[Controller Registers](#h.917ivz4m4ziu){.c24}]{}[        ]{}[[42](#h.917ivz4m4ziu){.c24}]{}

[[Controllers Wrapper](#h.bnnsrcv0r4jw){.c24}]{}[        ]{}[[42](#h.bnnsrcv0r4jw){.c24}]{}

[[Controller Wrapper Diagram](#h.o12jcpl1v6h2){.c24}]{}[        ]{}[[43](#h.o12jcpl1v6h2){.c24}]{}

[[Controller Wrapper Interface](#h.b5ap3afv7f57){.c24}]{}[        ]{}[[43](#h.b5ap3afv7f57){.c24}]{}

[[Controller](#h.ddzvq2rctlzt){.c24}]{}[        ]{}[[44](#h.ddzvq2rctlzt){.c24}]{}

[[Controller Diagram](#h.ml0lp3awxz0e){.c24}]{}[        ]{}[[44](#h.ml0lp3awxz0e){.c24}]{}

[[Controller Interface](#h.8148udv35isa){.c24}]{}[        ]{}[[44](#h.8148udv35isa){.c24}]{}

[[Special Purpose Asynchronous Receiver and Transmitter (SPART)](#h.fna8vaz47pc1){.c24}]{}[        ]{}[[45](#h.fna8vaz47pc1){.c24}]{}

[[SPART Diagram & Interface](#h.9khtivok6lhm){.c24}]{}[        ]{}[[45](#h.9khtivok6lhm){.c24}]{}

[[Controller Driver](#h.fxadt5ql4b59){.c24}]{}[        ]{}[[46](#h.fxadt5ql4b59){.c24}]{}

[[Controller Driver State Machine](#h.yma1hmwj1wcp){.c24}]{}[        ]{}[[46](#h.yma1hmwj1wcp){.c24}]{}

[[VGA](#h.xrfacxsmruiq){.c24}]{.c23}[        ]{.c23}[[47](#h.xrfacxsmruiq){.c24}]{.c23}

[[VGA Diagram](#h.7dmryvqi4l3b){.c24}]{}[        ]{}[[47](#h.7dmryvqi4l3b){.c24}]{}

[[VGA Interface](#h.7b41ivlnuec0){.c24}]{}[        ]{}[[48](#h.7b41ivlnuec0){.c24}]{}

[[VGA Clock Gen](#h.w1ger0jiy8bk){.c24}]{}[        ]{}[[48](#h.w1ger0jiy8bk){.c24}]{}

[[VGA Timing Gen](#h.pw3svolg7ia){.c24}]{}[        ]{}[[49](#h.pw3svolg7ia){.c24}]{}

[[VGA Display Plane](#h.em4ktvbwfn8k){.c24}]{}[        ]{}[[49](#h.em4ktvbwfn8k){.c24}]{}

[[VGA RAM Wrapper](#h.68btkfb1o5ru){.c24}]{}[        ]{}[[50](#h.68btkfb1o5ru){.c24}]{}

[[VGA RAM Reader](#h.1cvttmqqni8n){.c24}]{}[        ]{}[[50](#h.1cvttmqqni8n){.c24}]{}

[[Software](#h.zbj1aj20rigt){.c24}]{.c23}[        ]{.c23}[[52](#h.zbj1aj20rigt){.c24}]{.c23}

[[Controller Simulator](#h.ik7f7bcto722){.c24}]{}[        ]{}[[52](#h.ik7f7bcto722){.c24}]{}

[[Controller Simulator State Machine](#h.ev3eyvc4m806){.c24}]{}[        ]{}[[52](#h.ev3eyvc4m806){.c24}]{}

[[Controller Simulator Output Packet Format](#h.xqfqy7n0dj86){.c24}]{}[        ]{}[[52](#h.xqfqy7n0dj86){.c24}]{}

[[Controller Simulator GUI and Button Map](#h.wqujxd9v8i1y){.c24}]{}[        ]{}[[53](#h.wqujxd9v8i1y){.c24}]{}

[[Assembler](#h.t5xpa0jvlbyf){.c24}]{}[        ]{}[[53](#h.t5xpa0jvlbyf){.c24}]{}

[[Opcode Table](#h.rp3i11uarg1){.c24}]{}[        ]{}[[54](#h.rp3i11uarg1){.c24}]{}

[[NES Assembly Formats](#h.fji30zo8qmh){.c24}]{}[        ]{}[[56](#h.fji30zo8qmh){.c24}]{}

[[Invoking Assembler](#h.1ftppbjfbpv9){.c24}]{}[        ]{}[[57](#h.1ftppbjfbpv9){.c24}]{}

[[iNES ROM Converter](#h.ekqczej5ygn6){.c24}]{}[        ]{}[[57](#h.ekqczej5ygn6){.c24}]{}

[[Tic Tac Toe](#h.syub5w8xzigk){.c24}]{}[        ]{}[[57](#h.syub5w8xzigk){.c24}]{}

[[Testing & Debug](#h.pefw11g7x04z){.c24}]{.c23}[        ]{.c23}[[58](#h.pefw11g7x04z){.c24}]{.c23}

[[Simulation](#h.i9v97r1jowjk){.c24}]{}[        ]{}[[58](#h.i9v97r1jowjk){.c24}]{}

[[Test](#h.s28dapnuwz93){.c24}]{}[        ]{}[[58](#h.s28dapnuwz93){.c24}]{}

[[Integrated Simulation](#h.mv68y8tja9lo){.c24}]{}[        ]{}[[58](#h.mv68y8tja9lo){.c24}]{}

[[Tracer](#h.xldwn1zb9fzw){.c24}]{}[        ]{}[[58](#h.xldwn1zb9fzw){.c24}]{}

[[Results](#h.6zhnn81o27us){.c24}]{.c23}[        ]{.c23}[[59](#h.6zhnn81o27us){.c24}]{.c23}

[[Possible Improvements](#h.g7qfxmufg3ij){.c24}]{.c23}[        ]{.c23}[[59](#h.g7qfxmufg3ij){.c24}]{.c23}

[[References and Links](#h.9xwc48i9bi3r){.c24}]{.c23}[        ]{.c23}[[59](#h.9xwc48i9bi3r){.c24}]{.c23}

[[Contributions](#h.vkgt15aadvpx){.c24}]{.c23}[        ]{.c23}[[60](#h.vkgt15aadvpx){.c24}]{.c23}

[[Eric Sullivan](#h.riv717lhxryl){.c24}]{}[        ]{}[[60](#h.riv717lhxryl){.c24}]{}

[[Patrick Yang](#h.fpooysc4oemr){.c24}]{}[        ]{}[[60](#h.fpooysc4oemr){.c24}]{}

[[Pavan Holla](#h.7pjbrnhfuduw){.c24}]{}[        ]{}[[60](#h.7pjbrnhfuduw){.c24}]{}

[[Jonathan Ebert](#h.jaedjh5lps0t){.c24}]{}[        ]{}[[60](#h.jaedjh5lps0t){.c24}]{}

[]{.c186 .c230}

[]{.c109 .c23} {#h.azg267tas93b .c15 .c123 .c162}
==============

------------------------------------------------------------------------

[]{.c109 .c23} {#h.k888de58riy0 .c15 .c123 .c162}
==============

1.  [Introduction]{} {#h.g5jrstas8bb9 style="display:inline"}
    ================

[Following the video game crash in the early 1980s, Nintendo released their first video game console, the Nintendo Entertainment System (NES). Following a slow release and early recalls, the console began to gain momentum in a market that many thought had died out, and the NES is still appreciated by enthusiasts today. A majority of its early success was due to the relationship that Nintendo created with third-party software developers. Nintendo required that restricted developers from publishing games without a license distributed by Nintendo. This decision led to higher quality games and helped to sway the public opinion on video games, which had been plagued by poor games for other gaming consoles. ]{.c68}

[Our motivation is to better understand how the NES worked from a hardware perspective, as the NES was an extremely advanced console when it was released in 1985 (USA). The NES has been recreated multiple times in software emulators, but has rarely been done in a hardware design language, which makes this a unique project.  Nintendo chose to use the 6502 processor, also used by Apple in the Apple II, and chose to include a picture processing unit to provide a memory efficient way to output video to the TV. Our goal was to recreate the CPU and PPU in hardware, so that we could run games that were run on the original console. In order to exactly recreate the original console, we needed to include memory mappers, an audio processing unit, a DMA unit, a VGA interface, and a way to use a controller for input. In addition, we wrote our own assembler and tic-tac-toe game to test our implementation.   The following sections will explain the microarchitecture of the NES. Much of the information was gleaned from nesdev.com, and from other online forums that reverse engineered the NES.]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

[]{.c68}

2.  [Top Level Block Diagram]{.c109 .c23} {#h.1ayvkhk4vvmg style="display:inline"}
    =====================================

<!-- -->

1.  [Top level description]{.c22} {#h.8r6j63kwrjxl style="display:inline"}
    -----------------------------

[Here is an overview of each module in our design. Our report has a section dedicated for each of these modules.]{.c7}

1.  [PPU - The PPU(Picture Processing Unit) is responsible for rendering graphics on screen. It receives memory mapped accesses from the CPU, and renders graphics from memory, providing RGB values.]{.c7}
2.  [CPU - Our CPU is a 6502 implementation. It is responsible for controlling all other modules in the NES. At boot, CPU starts reading programs at the address 0xFFFC.]{.c7}
3.  [DMA - The DMA transfers chunks of data from CPU address space to PPU address space. It is faster than performing repeated Loads and Stores in the CPU.]{.c7}
4.  [Display Memory and VGA - The PPU writes to the display memory, which is subsequently read out by the VGA module. The VGA module produces the hsync, vsync and RGB values that a monitor requires.]{.c7}
5.  [Controller - A program runs on a host computer which transfers serial data to the FPGA. The protocol used by the controller is UART in our case]{.c7}
6.  [APU - Generates audio in the NES. However, we did not implement this module.]{.c7}
7.  [CHAR RAM/ RAM - Used by the CPU and PPU to store temporary data]{.c7}
8.  [PROG ROM/ CHAR ROM - PROG ROM contains the software(instructions) that runs the game. CHAR ROM on the other hand contains mostly image data and graphics used in the game.]{.c7}

<!-- -->

2.  [Data Flow Diagram]{.c22} {#h.a9ilbl8rkgkd style="display:inline"}
    -------------------------

[![](images/image3.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 611.00px; height: 296.00px;"}

[Figure 1: System level data flow diagram]{.c81}

3.  [ Control Flow Diagram]{.c22} {#h.m6jcsadip56s style="display:inline"}
    -----------------------------

[![](images/image2.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 356.00px;"}

[Figure 2: System level control flow diagram.]{.c81}

3.  [CPU]{.c109 .c23} {#h.rdm0fxe7s5y9 style="display:inline"}
    =================

[CPU Registers]{.c22} {#h.eftj2rjo9s1h .c35}
---------------------

[The CPU of the NES is the MOS 6502. It is an  accumulator plus index register machine. There are five primary registers on which operations are performed: ]{.c7}

1.  [PC : Program Counter]{.c7}
2.  [Accumulator(A) : Keeps track of results from ALU]{.c7}
3.  [X : X index register]{.c7}
4.  [Y  : Y index register]{.c7}
5.  [Stack pointer]{.c7}
6.  [Status Register : Negative, Overflow, Unused, Break, Decimal, Interrupt, Zero, Carry]{.c7}

-   [Break means that the current interrupt is from software interrupt, BRK]{.c7}
-   [Interrupt is high when maskable interrupts (IRQ) is to be ignored. Non-maskable interrupts (NMI) cannot be ignored.]{.c7}

[There are 6 secondary registers:]{.c7}

1.  [AD : Address Register]{.c7}

-   [Stores where to jump to or where to get indirect access from.]{.c7}

2.  [ADV : AD Value Register]{.c7}

-   [Stores the value from indirect access by AD.]{.c7}

3.  [BA : Base Address Register]{.c7}

-   [Stores the base address before index calculation. After the calculation, the value is transferred to AD if needed.]{.c7}

4.  [BAV : BA Value Register]{.c7}

-   [Stores the value from indirect access by BA.]{.c7}

5.  [IMM : Immediate Register]{.c7}

-   [Stores the immediate value from the memory.]{.c7}

6.  [Offset]{.c7}

-   [Stores the offset value of branch from memory]{.c7}

[CPU ISA]{.c22} {#h.wvvuysbh6ili .c35}
---------------

[The ISA may be classified into a few broad operations: ]{.c7}

-   [Load into A,X,Y registers from memory]{.c7}
-   [Perform arithmetic operation on A,X or Y]{.c7}
-   [Move data from one register to another]{.c7}
-   [Program control instructions like Jump and Branch]{.c7}
-   [Stack operations]{.c7}
-   [Complex instructions that read, modify and write back memory.]{.c7}

[CPU Addressing Modes]{.c22} {#h.9ie72e7qdon7 .c35}
----------------------------

[Additionally, there are thirteen addressing modes which these operations can use. They are]{.c7}

-   [Accumulator]{.c23}[ – The data in the accumulator is used. ]{.c7}
-   [Immediate]{.c23}[ - The byte in memory immediately following the instruction is used. ]{.c7}
-   [Zero Page]{.c23}[ – The Nth byte in the first page of RAM is used where N is the byte in memory immediately following the instruction. ]{.c7}
-   [Zero Page, X Index]{.c23}[ – The (N+X)th byte in the first page of RAM is used where N is the byte in memory immediately following the instruction and X is the contents of the X index register.]{.c7}
-   [Zero Page, Y Index]{.c23}[ – Same as above but with the Y index register ]{.c7}
-   [Absolute]{.c23}[ – The two bytes in memory following the instruction specify the absolute address of the byte of data to be used. ]{.c7}
-   [Absolute, X Index]{.c23}[ - The two bytes in memory following the instruction specify the base address. The contents of the X index register are then added to the base address to obtain the address of the byte of data to be used. ]{.c7}
-   [Absolute, Y Index]{.c23}[ – Same as above but with the Y index register ]{.c7}
-   [Implied]{.c23}[ – Data is either not needed or the location of the data is implied by the instruction. ]{.c7}
-   [Relative]{.c23}[ – The content of  sum of (the program counter and the byte in memory immediately following the instruction) is used. ]{.c7}
-   [Absolute Indirect]{.c23}[ - The two bytes in memory following the instruction specify the absolute address of the two bytes that contain the absolute address of the byte of data to be used.]{.c7}
-   [(Indirect, X)]{.c23}[ – A combination of Indirect Addressing and Indexed Addressing ]{.c7}
-   [(Indirect), Y]{.c23}[ - A combination of Indirect Addressing and Indexed Addressing]{.c7}

[CPU Interrupts]{.c22} {#h.b7loafaij831 .c35}
----------------------

[The 6502 supports three interrupts. The reset interrupt routine is called after a physical reset. The other two interrupts are the non\_maskable\_interrupt(NMI) and the general\_interrupt(IRQ). The general\_interrupt can be disabled by software whereas the others cannot. When interrupt occurs, the CPU finishes the current instruction then PC jumps to the specified interrupt vector then return when finished.  ]{.c7}

[CPU Opcode Matrix]{.c22} {#h.q77927r8c49e .c35}
-------------------------

[The NES 6502 ISA is a CISC like ISA with 56 instructions. These 56 instructions can pair up with addressing modes to form various opcodes. The opcode is always 8 bits, however based on the addressing mode, upto 4 more memory location may need to be fetched.The memory is single cycle, i.e data\[7:0\] can be latched the cycle after address\[15:0\] is placed on the bus. The following tables summarize the instructions available and possible addressing modes:]{.c7}

[]{#t.3cc61c11f8dce03b7ca8770afc1862c11a71fc7e}[]{#t.0}

[Storage]{.c76 .c23}

[LDA]{.c7}

[Load A with M]{.c7}

[LDX]{.c7}

[Load X with M]{.c7}

[LDY]{.c7}

[Load Y with M]{.c7}

[STA]{.c7}

[Store A in M]{.c7}

[STX]{.c7}

[Store X in M]{.c7}

[STY]{.c7}

[Store Y in M]{.c7}

[TAX]{.c7}

[Transfer A to X]{.c7}

[TAY]{.c7}

[Transfer A to Y]{.c7}

[TSX]{.c7}

[Transfer Stack Pointer to X]{.c7}

[TXA]{.c7}

[Transfer X to A]{.c7}

[TXS]{.c7}

[Transfer X to Stack Pointer]{.c7}

[TYA]{.c7}

[Transfer Y to A]{.c7}

[Arithmetic]{.c76 .c23}

[ADC]{.c7}

[Add M to A with Carry]{.c7}

[DEC]{.c7}

[Decrement M by One]{.c7}

[DEX]{.c7}

[Decrement X by One]{.c7}

[DEY]{.c7}

[Decrement Y by One]{.c7}

[INC]{.c7}

[Increment M by One]{.c7}

[INX]{.c7}

[Increment X by One]{.c7}

[INY]{.c7}

[Increment Y by One]{.c7}

[SBC]{.c7}

[Subtract M from A with Borrow]{.c7}

[Bitwise]{.c76 .c23}

[AND]{.c7}

[AND M with A]{.c7}

[ASL]{.c7}

[Shift Left One Bit (M or A)]{.c7}

[BIT]{.c7}

[Test Bits in M with A]{.c7}

[EOR]{.c7}

[Exclusive-Or M with A]{.c7}

[LSR]{.c7}

[Shift Right One Bit (M or A)]{.c7}

[ORA]{.c7}

[OR M with A]{.c7}

[ROL]{.c7}

[Rotate One Bit Left (M or A)]{.c7}

[ROR]{.c7}

[Rotate One Bit Right (M or A)]{.c7}

[Branch]{.c76 .c23}

[BCC]{.c7}

[Branch on Carry Clear]{.c7}

[BCS]{.c7}

[Branch on Carry Set]{.c7}

[BEQ]{.c7}

[Branch on Result Zero]{.c7}

[BMI]{.c7}

[Branch on Result Minus]{.c7}

[BNE]{.c7}

[Branch on Result not Zero]{.c7}

[BPL]{.c7}

[Branch on Result Plus]{.c7}

[BVC]{.c7}

[Branch on Overflow Clear]{.c7}

[BVS]{.c7}

[Branch on Overflow Set]{.c7}

[Jump]{.c76 .c23}

[JMP]{.c7}

[Jump to Location]{.c7}

[JSR]{.c7}

[Jump to Location Save Return Address]{.c7}

[RTI]{.c7}

[Return from Interrupt]{.c7}

[RTS]{.c7}

[Return from Subroutine]{.c7}

[Status Flags]{.c76 .c23}

[CLC]{.c7}

[Clear Carry Flag]{.c7}

[CLD]{.c7}

[Clear Decimal Mode]{.c7}

[CLI]{.c7}

[Clear interrupt Disable Bit]{.c7}

[CLV]{.c7}

[Clear Overflow Flag]{.c7}

[CMP]{.c7}

[Compare M and A]{.c7}

[CPX]{.c7}

[Compare M and X]{.c7}

[CPY]{.c7}

[Compare M and Y]{.c7}

[SEC]{.c7}

[Set Carry Flag]{.c7}

[SED]{.c7}

[Set Decimal Mode]{.c7}

[SEI]{.c7}

[Set Interrupt Disable Status]{.c7}

[Stack]{.c76 .c23}

[PHA]{.c7}

[Push A on Stack]{.c7}

[PHP]{.c7}

[Push Processor Status on Stack]{.c7}

[PLA]{.c7}

[Pull A from Stack]{.c7}

[PLP]{.c7}

[Pull Processor Status from Stack]{.c7}

[System]{.c76 .c23}

[BRK]{.c7}

[Force Break]{.c7}

[NOP]{.c7}

[No Operation]{.c7}

[]{.c7}

[The specific opcode hex values are specified in the Assembler section.]{}

[For more information on the opcodes, please refer]{.c7}

[[http://www.6502.org/tutorials/6502opcodes.html](https://www.google.com/url?q=http://www.6502.org/tutorials/6502opcodes.html&sa=D&ust=1494576242985000&usg=AFQjCNEBeKqowaqwPg9HG_5qMJJCemVN9Q){.c24}]{.c62}

[or ]{.c7}

[[http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502\_Opcodes](https://www.google.com/url?q=http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502_Opcodes&sa=D&ust=1494576242986000&usg=AFQjCNHWwLgjADTnuMa3o9CZ5cr83kwE8A){.c24}]{.c62}

[CPU Block Diagram]{}[![](images/image1.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 389.33px;"} {#h.ki2ushz1f0a3 .c35}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

[]{.c7}

[]{#t.3b03df5ff635ab55210457ca4172a1dbb6594ce9}[]{#t.1}

+-----------------------------------+-----------------------------------+
| [Block]{.c76 .c23}                | [Primary Function]{.c76 .c23}     |
+-----------------------------------+-----------------------------------+
| [Decode]{.c7}                     | [Decode the current instruction.  |
|                                   | Classifies the opcode into an     |
|                                   | instruction\_type(arithmetic,ld   |
|                                   | etc) and addressing               |
|                                   | mode(immediate, indirect          |
|                                   | etc)]{.c7}                        |
+-----------------------------------+-----------------------------------+
| [Processor Control]{.c7}          | [State machine that keeps track   |
|                                   | of current instruction stage, and |
|                                   | generates signals to load         |
|                                   | registers.]{.c7}                  |
+-----------------------------------+-----------------------------------+
| [ALU]{.c7}                        | [Performs ALU ops and handles     |
|                                   | Status Flags]{.c7}                |
+-----------------------------------+-----------------------------------+
| [Registers]{.c7}                  | [Contains all registers. Register |
|                                   | values change according to        |
|                                   | signals from processor            |
|                                   | control.]{.c7}                    |
+-----------------------------------+-----------------------------------+
| [Mem]{.c7}                        | [Acts as the interface between    |
|                                   | CPU and memory. Mem block thinks  |
|                                   | it’s communicating with the       |
|                                   | memory but the DMA can reroute    |
|                                   | the communication to any other    |
|                                   | blocks like PPU, controller]{.c7} |
+-----------------------------------+-----------------------------------+

[]{.c76 .c23}

[Instruction flow]{.c76 .c23}

[The following table presents a high level overview of how each instruction is handled.]{.c7}

[]{#t.c34310f1171abde1363919ba55d0bbfe4c032809}[]{#t.2}

+-----------------------+-----------------------+-----------------------+
| [Cycle Number]{.c23   | [Blocks ]{.c76 .c23}  | [Action]{.c76 .c23}   |
| .c76}                 |                       |                       |
+-----------------------+-----------------------+-----------------------+
| [0]{.c7}              | [Processor Control →  | [Instruction Fetch    |
|                       | Registers]{.c7}       | ]{.c7}                |
+-----------------------+-----------------------+-----------------------+
| [1]{.c7}              | [Register →           | [Classify instruction |
|                       |  Decode]{.c7}         | and addressing        |
|                       |                       | mode]{.c7}            |
+-----------------------+-----------------------+-----------------------+
| [1]{.c7}              | [Decode → Processor   | [Init state machine   |
|                       | Control]{.c7}         | for instruction type  |
|                       |                       | and addressing        |
|                       |                       | mode]{.c7}            |
+-----------------------+-----------------------+-----------------------+
| [2-6]{.c7}            | [Processor Control →  | [Populate scratch     |
|                       | Registers]{.c7}       | registers based on    |
|                       |                       | addressing            |
|                       |                       | mode.]{.c7}           |
+-----------------------+-----------------------+-----------------------+
| [Last Cycle]{.c7}     | [Processor Control →  | [Execute]{.c7}        |
|                       | ALU]{.c7}             |                       |
+-----------------------+-----------------------+-----------------------+
| [Last Cycle]{.c7}     | [Processor Control →  | [Instruction          |
|                       | Registers]{.c7}       | Fetch]{.c7}           |
+-----------------------+-----------------------+-----------------------+

[]{.c76 .c23}

[State Machines]{.c76 .c23}

[Each {instruction\_type, addressing\_mode} triggers its own state machine. In brief, this state machine is responsible for signalling the Registers module to load/store addresses from memory or from the ALU. ]{.c7}

[State machine spec for each instruction type and addressing mode can be found at ]{}[[https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-\_sEox-QsTjJSlt06lE/edit?usp=sharing](https://www.google.com/url?q=https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-_sEox-QsTjJSlt06lE/edit?usp%3Dsharing&sa=D&ust=1494576243018000&usg=AFQjCNGRWTa2F9IkuDjlOnKv-jo9f3MhSQ){.c24}]{.c62 .c69 .c188}

[Considering one of the simplest instructions ADC immediate,which takes two cycles, the state machine is as follows:]{.c7}

[Instruction\_type=ARITHMETIC, addressing mode= IMMEDIATE]{}

[]{#t.986d78169f9d35d012fa7f117a4e53d6949bf356}[]{#t.3}

+-----------------------+-----------------------+-----------------------+
| [state=0]{.c7}        | [state=1]{.c7}        | [state=2]{.c7}        |
+-----------------------+-----------------------+-----------------------+
| [ld\_sel=LD\_INSTR;   | [ld\_sel=LD\_IMM;]{.c | [alu\_ctrl=DO\_OP\_AD |
| //instr=              | 7}                    | C                     |
| memory\_data]{.c7}    |                       | // execute]{.c7}      |
|                       | [//imm=memory\_data]{ |                       |
| [pc\_sel=INC\_PC;     | .c7}                  | [src1\_sel=SRC1\_A]{. |
| //pc++]{.c7}          |                       | c7}                   |
|                       | [pc\_sel=INC\_PC]{.c7 |                       |
| [next\_state=state+1’ | }                     | [src2\_sel=SRC2\_IMM] |
| b1]{.c7}              |                       | {.c7}                 |
|                       | [next\_state=state+1’ |                       |
| []{.c7}               | b1]{.c7}              | [dest\_sel=DEST\_A]{. |
|                       |                       | c7}                   |
| []{.c7}               |                       |                       |
|                       |                       | [ld\_sel=LD\_INSTR//f |
|                       |                       | etch                  |
|                       |                       | next                  |
|                       |                       | instruction]{.c7}     |
|                       |                       |                       |
|                       |                       | [pc\_sel=INC\_PC]{.c7 |
|                       |                       | }                     |
|                       |                       |                       |
|                       |                       | [next\_state=1’b1]{.c |
|                       |                       | 7}                    |
+-----------------------+-----------------------+-----------------------+

[]{.c7}

[All instructions are classified into one of 55 state machines in the cpu specification sheet. The 6502 can take variable time for a single instructions based on certain conditions(page\_cross, branch\_taken etc). These corner case state transitions are also taken care of by processor control.]{.c7}

[CPU ]{}[Top Level Interface]{.c22} {#h.er7yq56tef4v .c35}
-----------------------------------

[]{#t.ec6e0cf4837ca798f6158bba27f8906dd57ddbdb}[]{#t.4}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst]{.c7}      | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | high            |
|                 |                 |                 | reset]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [nmi]{.c7}      | [input]{.c7}    | [PPU]{.c7}      | [Non maskable   |
|                 |                 |                 | interrupt from  |
|                 |                 |                 | PPU. Executes   |
|                 |                 |                 | BRK instruction |
|                 |                 |                 | in CPU]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [addr\[15:0\]]{ | [output]{.c7}   | [RAM]{.c7}      | [Address for    |
| .c7}            |                 |                 | R/W issued by   |
|                 |                 |                 | CPU]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [dout\[7:0\]]{. | [input/]{.c7}   | [RAM]{.c7}      | [Data from the  |
| c7}             |                 |                 | RAM in case of  |
|                 | [output]{.c7}   |                 | reads and and   |
|                 |                 |                 | to the RAM in   |
|                 |                 |                 | case of         |
|                 |                 |                 | writes]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [memory\_read]{ | [output]{.c7}   | [RAM]{.c7}      | [read enable    |
| .c7}            |                 |                 | signal for      |
|                 |                 |                 | RAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [memory\_write] | [output]{.c7}   | [RAM]{.c7}      | [write enable   |
| {.c7}           |                 |                 | signal for      |
|                 |                 |                 | RAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[CPU Instruction Decode Interface]{.c22} {#h.lomim8yvajg6 .c35}
----------------------------------------

[The decode module is responsible for classifying the instruction into one of the addressing modes and an instruction type. It also generates the signal that the ALU would eventually use if the instruction passed through the ALU.        ]{.c7}

[]{#t.f13182f9d70c3545bc3d4e1c8077ef6922fd108a}[]{#t.5}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [instruction\_r | [input]{.c7}    | [Registers]{.c7 | [Opcode of the  |
| egister]{.c7}   |                 | }               | current         |
|                 |                 |                 | instruction]{.c |
|                 |                 |                 | 7}              |
+-----------------+-----------------+-----------------+-----------------+
| [nmi]{.c7}      | [input]{.c7}    | [cpu\_top]{.c7} | [Non maskable   |
|                 |                 |                 | interrupt from  |
|                 |                 |                 | PPU. Executes   |
|                 |                 |                 | BRK instruction |
|                 |                 |                 | in CPU]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [instruction\_t | [output]{.c7}   | [Processor      | [Type of        |
| ype]{.c7}       |                 | Control]{.c7}   | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | ITYPE.]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [addressing\_mo | [output]{.c7}   | [Processor      | [Addressing     |
| de]{.c7}        |                 | Control]{.c7}   | mode of the     |
|                 |                 |                 | opcode in       |
|                 |                 |                 | instruction\_re |
|                 |                 |                 | gister.         |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | AMODE.]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_sel]{.c7} | [output]{.c7}   | [ALU]{.c7}      | [ALU operation  |
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
|                 |                 |                 | DO\_OP.]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[CPU MEM Interface]{.c22} {#h.b3lc7rd7ackr .c35}
-------------------------

[The MEM module is the interface between memory and CPU. It provides appropriate address and read/write signal for the memory. Controlled by the select signals]{.c7}

[]{#t.60770ee16f74d493ac822410188b75f9a14e434b}[]{#t.6}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [addr\_sel]{.c7 | [input]{.c7}    | [Processor      | [Selects which  |
| }               |                 | Control]{.c7}   | input to use as |
|                 |                 |                 | address to      |
|                 |                 |                 | memory. Enum of |
|                 |                 |                 | ADDR]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [int\_sel]{.c7} | [input]{.c7}    | [Processor      | [Selects which  |
|                 |                 | Control]{.c7}   | interrupt       |
|                 |                 |                 | address to jump |
|                 |                 |                 | to. Enum of     |
|                 |                 |                 | INT\_TYPE]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [ld\_sel,st\_se | [input]{.c7}    | [Processor      | [Decides        |
| l]{.c7}         |                 | Control]{.c7}   | whether to read |
|                 |                 |                 | or write based  |
|                 |                 |                 | on these        |
|                 |                 |                 | signals]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [ad, ba, sp,    | [input]{.c7}    | [Registers]{.c7 | [Registers that |
| irql, irqh,     |                 | }               | are candidates  |
| pc]{.c7}        |                 |                 | of the          |
|                 |                 |                 | address]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c7}     | [output]{.c7}   | [Memory]{.c7}   | [Address of the |
|                 |                 |                 | memory to       |
|                 |                 |                 | read/write]{.c7 |
|                 |                 |                 | }               |
+-----------------+-----------------+-----------------+-----------------+
| [read,write]{.c | [output]{.c7}   | [Memory]{.c7}   | [Selects        |
| 7}              |                 |                 | whether Memory  |
|                 |                 |                 | should read or  |
|                 |                 |                 | write]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[CPU ALU Interface]{.c22} {#h.nexle64nrxxq .c35}
-------------------------

[Performs arithmetic, logical operations and operations that involve status registers.]{.c7}

[]{#t.74d7ae3809789a7579d3dd984c8cb1e6937f5c5b}[]{#t.7}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [in1, in2]{.c7} | [input]{.c7}    | [ALU Input      | [Inputs to the  |
|                 |                 | Selector]{.c7}  | ALU operations  |
|                 |                 |                 | selected by ALU |
|                 |                 |                 | Input           |
|                 |                 |                 | module.]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_sel]{.c7} | [input]{.c7}    | [Processor      | [ALU operation  |
|                 |                 | Control]{.c7}   | expected to be  |
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
|                 |                 |                 | DO\_OP.]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [clk, rst]{.c7} | [input]{.c7}    | []{.c7}         | [System clock   |
|                 |                 |                 | and active high |
|                 |                 |                 | reset]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [out]{.c7}      | [output]{.c7}   | [to all         | [Output of ALU  |
|                 |                 | registers]{.c7} | operation. sent |
|                 |                 |                 | to all          |
|                 |                 |                 | registers and   |
|                 |                 |                 | registers       |
|                 |                 |                 | decide whether  |
|                 |                 |                 | to receive it   |
|                 |                 |                 | or ignore it as |
|                 |                 |                 | its next        |
|                 |                 |                 | value.]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [n, z, v, c, b, | [output]{.c7}   | []{.c7}         | [Status         |
| d, i]{.c7}      |                 |                 | Register]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

### [ALU Input Selector]{.c57 .c23} {#h.sprgfm6rx38x .c35}

[Selects the input1 and input2 for the ALU]{.c7}

[]{#t.962a520a35f5a47f155664eb3cba694a0b1b6dba}[]{#t.8}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [src1\_sel,     | [input]{.c7}    | [Processor      | [Control signal |
| src2\_sel]{.c7} |                 | Control]{.c7}   | that determines |
|                 |                 |                 | which sources   |
|                 |                 |                 | to take in as   |
|                 |                 |                 | inputs to ALU   |
|                 |                 |                 | according to    |
|                 |                 |                 | the instruction |
|                 |                 |                 | and addressing  |
|                 |                 |                 | mode]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [a, bal, bah,   | [input]{.c7}    | [Registers]{.c7 | [Registers that |
| adl, pcl, pch,  |                 | }               | are candidates  |
| imm, adv, x,    |                 |                 | to the input to |
| bav, y,         |                 |                 | ALU]{.c7}       |
| offset]{.c7}    |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [temp\_status]{ | [input]{.c7}    | [ALU]{.c7}      | [Sometimes      |
| .c7}            |                 |                 | status          |
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
|                 |                 |                 | ALU]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [in1, in2]{.c7} | [output]{.c7}   | [ALU]{.c7}      | [Selected input |
|                 |                 |                 | for the         |
|                 |                 |                 | ALU]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+

[CPU Registers Interface]{.c22} {#h.5httww8vnv8g .c35}
-------------------------------

[Holds all of the registers]{.c7}

[]{#t.35d129561daa24a66b47c8945cde454ce8f2506d}[]{#t.9}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk, rst]{.c7} | [input]{.c7}    | []{.c7}         | [System clk and |
|                 |                 |                 | rst]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [dest\_sel,     | [input]{.c7}    | [Processor      | [Selects which  |
| pc\_sel,        |                 | Control]{.c7}   | input to accept |
| sp\_sel,        |                 |                 | as new input.   |
| ld\_sel,        |                 |                 | enum of DEST,   |
| st\_sel]{.c7}   |                 |                 | PC, SP, LD,     |
|                 |                 |                 | ST]{.c7}        |
+-----------------+-----------------+-----------------+-----------------+
| [clr\_adh,      | [input]{.c7}    | [Processor      | [Clears the     |
| clr\_bah]{.c7}  |                 | Control]{.c7}   | high byte of    |
|                 |                 |                 | ad, ba]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_out,      | [input]{.c7}    | [ALU]{.c7}      | [Output from    |
| next\_status]{. |                 |                 | ALU and next    |
| c7}             |                 |                 | status value.   |
|                 |                 |                 | alu\_out can be |
|                 |                 |                 | written to most |
|                 |                 |                 | of the          |
|                 |                 |                 | registers]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [data]{.c7}     | [inout]{.c7}    | [Memory]{.c7}   | [Datapath to    |
|                 |                 |                 | Memory. Either  |
|                 |                 |                 | receives or     |
|                 |                 |                 | sends data      |
|                 |                 |                 | according to    |
|                 |                 |                 | ld\_sel and     |
|                 |                 |                 | st\_sel.]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [a, x, y, ir,   | [output]{.c7}   | []{.c7}         | [Register       |
| imm, adv, bav,  |                 |                 | outputs that    |
| offset, sp, pc, |                 |                 | can be used by  |
| ad, ba, n, z,   |                 |                 | different       |
| v, c, b, d, i,  |                 |                 | modules]{.c7}   |
| status]{.c7}    |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+

[CPU Processor Control Interface]{.c22} {#h.eiifcf5tv1l9 .c35}
---------------------------------------

[The processor control module maintains the current state that the instruction is in and decides the control signals for the next state. Once the instruction type and addressing modes are decoded, the processor control block becomes aware of the number of cycles the instruction will take. Thereafter, at each clock cycle it generates the required control signals.]{.c7}

[]{#t.b393916cb565d703d6fe7f4dbd36fb92b6b7db96}[]{#t.10}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [instruction\_t | [input]{.c7}    | [Decode]{.c7}   | [Type of        |
| ype]{.c7}       |                 |                 | instruction.    |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | ITYPE.]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [addressing\_mo | [input]{.c7}    | [Decode]{.c7}   | [Addressing     |
| de]{.c7}        |                 |                 | mode of the     |
|                 |                 |                 | opcode in       |
|                 |                 |                 | instruction\_re |
|                 |                 |                 | gister.         |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | AMODE.]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_ctrl]{.c7 | [input]{.c7}    | [Decode]{.c7}   | [ALU operation  |
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
|                 |                 |                 | DO\_OP.]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [reset\_adh]{.c | [output]{.c7}   | [Registers]{.c7 | [Resets ADH     |
| 7}              |                 | }               | register]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [reset\_bah]{.c | [output]{.c7}   | [Registers]{.c7 | [Resets BAH     |
| 7}              |                 | }               | register]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [set\_b]{.c7}   | [output]{.c7}   | [Registers]{.c7 | [Sets the B     |
|                 |                 | }               | flag]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [addr\_sel]{.c7 | [output]{.c7}   | [Registers]{.c7 | [Selects the    |
| }               |                 | }               | value that      |
|                 |                 |                 | needs to be set |
|                 |                 |                 | on the address  |
|                 |                 |                 | bus. Belongs to |
|                 |                 |                 | enum ADDR]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [alu\_sel]{.c7} | [output]{.c7}   | [ALU]{.c7}      | [Selects the    |
|                 |                 |                 | operation to be |
|                 |                 |                 | performed by    |
|                 |                 |                 | the ALU in the  |
|                 |                 |                 | current cycle.  |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | DO\_OP]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [dest\_sel]{.c7 | [output]{.c7}   | [Registers]{.c7 | [Selects the    |
| }               |                 | }               | register that   |
|                 |                 |                 | receives the    |
|                 |                 |                 | value from ALU  |
|                 |                 |                 | output.Belongs  |
|                 |                 |                 | to enum         |
|                 |                 |                 | DEST]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [ld\_sel]{.c7}  | [output]{.c7}   | [Registers]{.c7 | [Selects the    |
|                 |                 | }               | register that   |
|                 |                 |                 | will receive    |
|                 |                 |                 | the value from  |
|                 |                 |                 | Memory Bus.     |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | LD]{.c7}        |
+-----------------+-----------------+-----------------+-----------------+
| [pc\_sel]{.c7}  | [output]{.c7}   | [Registers]{.c7 | [Selects the    |
|                 |                 | }               | value that the  |
|                 |                 |                 | PC will take    |
|                 |                 |                 | next cycle.     |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | PC]{.c7}        |
+-----------------+-----------------+-----------------+-----------------+
| [sp\_sel]{.c7}  | [output]{.c7}   | [Registers]{.c7 | [Selects the    |
|                 |                 | }               | value that the  |
|                 |                 |                 | SP  will take   |
|                 |                 |                 | next cycle.     |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | SP]{.c7}        |
+-----------------+-----------------+-----------------+-----------------+
| [src1\_sel]{.c7 | [output]{.c7}   | [ALU]{.c7}      | [Selects src1   |
| }               |                 |                 | for ALU.        |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | SRC1]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [src2\_sel]{.c7 | [output]{.c7}   | [ALU]{.c7}      | [Selects src2   |
| }               |                 |                 | for ALU.        |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | SRC2]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [st\_sel]{.c7}  | [output]{.c7}   | [Registers]{.c7 | [Selects the    |
|                 |                 | }               | register whose  |
|                 |                 |                 | value will be   |
|                 |                 |                 | placed on dout. |
|                 |                 |                 | Belongs to enum |
|                 |                 |                 | ST]{.c7}        |
+-----------------+-----------------+-----------------+-----------------+

[CPU Enums]{.c22} {#h.3on9q42bqgrx .c35}
-----------------

[]{#t.d41042ffa22f98544df79c723d4fbbb413491765}[]{#t.11}

+-----------------------------------+-----------------------------------+
| [Enum name]{.c30}                 | [Legal Values]{.c30}              |
+-----------------------------------+-----------------------------------+
| [ITYPE]{.c7}                      | [ARITHMETIC,BRANCH,BREAK,CMPLDX,C |
|                                   | MPLDY,INTERRUPT,JSR,JUMP,OTHER,PU |
|                                   | LL,PUSH,RMW,RTI,RTS,STA,STX,STY]{ |
|                                   | .c7}                              |
+-----------------------------------+-----------------------------------+
| [AMODE]{.c7}                      | [ABSOLUTE,ABSOLUTE\_INDEX,ABSOLUT |
|                                   | E\_INDEX\_Y,ACCUMULATOR,IMMEDIATE |
|                                   | ,IMPLIED,INDIRECT,INDIRECT\_X,IND |
|                                   | IRECT\_Y,RELATIVE,SPECIAL,ZEROPAG |
|                                   | E,ZEROPAGE\_INDEX,ZEROPAGE\_INDEX |
|                                   | \_Y]{.c7}                         |
+-----------------------------------+-----------------------------------+
| [DO\_OP]{.c7}                     | [DO\_OP\_ADD,DO\_OP\_SUB,DO\_OP\_ |
|                                   | AND,DO\_OP\_OR,DO\_OP\_XOR,DO\_OP |
|                                   | \_ASL,DO\_OP\_LSR,DO\_OP\_ROL,DO\ |
|                                   | _OP\_ROR,DO\_OP\_SRC2DO\_OP\_CLR\ |
|                                   | _C,DO\_OP\_CLR\_I,DO\_OP\_CLR\_V, |
|                                   | DO\_OP\_SET\_C,DO\_OP\_SET\_I,DO\ |
|                                   | _OP\_SET\_V]{.c7}                 |
+-----------------------------------+-----------------------------------+
| [ADDR]{.c7}                       | [ADDR\_AD,ADDR\_PC,ADDR\_BA,ADDR\ |
|                                   | _SP,ADDR\_IRQL,ADDR\_IRQH]{.c7}   |
+-----------------------------------+-----------------------------------+
| [LD]{.c7}                         | [LD\_INSTR,LD\_ADL,LD\_ADH,LD\_BA |
|                                   | L,LD\_BAH,LD\_IMM,LD\_OFFSET,LD\_ |
|                                   | ADV,LD\_BAV,LD\_PCL,LD\_PCH]{.c7} |
+-----------------------------------+-----------------------------------+
| [SRC1]{.c7}                       | [SRC1\_A,SRC1\_BAL,SRC1\_BAH,SRC1 |
|                                   | \_ADL,SRC1\_PCL,SRC1\_PCH,SRC1\_B |
|                                   | AV,SRC1\_1]{.c7}                  |
+-----------------------------------+-----------------------------------+
| [SRC2]{.c7}                       | [SRC2\_DC,SRC2\_IMM,SRC2\_ADV,SRC |
|                                   | 2\_X,SRC2\_BAV,SRC2\_C,SRC2\_1,SR |
|                                   | C2\_Y,SRC2\_OFFSET]{.c7}          |
+-----------------------------------+-----------------------------------+
| [DEST]{.c7}                       | [DEST\_BAL,DEST\_BAH,DEST\_ADL,DE |
|                                   | ST\_A,DEST\_X,DEST\_Y,DEST\_PCL,D |
|                                   | EST\_PCH,DEST\_NONE]{.c7}         |
+-----------------------------------+-----------------------------------+
| [PC]{.c7}                         | [AD\_P\_TO\_PC,INC\_PC,KEEP\_PC]{ |
|                                   | .c50}                             |
+-----------------------------------+-----------------------------------+
| [SP]{.c7}                         | [INC\_SP,DEC\_SP]{.c50}           |
+-----------------------------------+-----------------------------------+

[]{.c173}

4.  [Picture Processing Unit]{.c109 .c23} {#h.fb8snxockohd style="display:inline"}
    =====================================

[]{.c7}

[The NES picture processing unit or PPU is the unit responsible for handling all of the console's graphical workloads. Obviously this is useful to the CPU because it offloads the highly intensive task of rendering a frame. This means the CPU can spend more time performing the game logic. ]{.c2}

[]{.c2}

[The PPU renders a frame by reading in scene data from various memories the PPU has access to such as VRAM, the game cart, and object attribute memory and then outputting an NTSC compliant 256x240 video signal at 60 Hz. The PPU was a special custom designed IC for Nintendo, so no other devices use this specific chip. It operates at a clock speed of 5.32 MHz making it three times faster than the NES CPU. This is one of the areas of difficulty in creating the PPU because it is easy to get the CPU and PPU clock domains out of sync.]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[]{.c2}

[PPU Top Level Schematic]{.c22} {#h.bvqrg858z31w .c35}
-------------------------------

[![schemeit-project.png](images/image9.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 625.50px; height: 355.85px;"}

[6502: ]{.c23}[The CPU used in the NES. Communicates with the PPU through simple load/store instructions. This works because the PPU registers are memory mapped into the CPU's address space.]{.c7}

[Address Decoder:]{.c23}[ The address decoder is responsible for selecting the chip select of the device the CPU wants to talk to. In the case of the PPU the address decoder will activate if from addresses \[0x2000, 0x2007\].]{.c7}

[VRAM:]{.c23}[ The PPU video memory contains the data needed to render the scene, specifically it holds the name tables. VRAM is 2 Kb in size and depending on how the PPU VRAM address lines are configured, different mirroring schemes are possible. ]{.c7}

[Game Cart:]{.c23}[ The game cart has a special ROM on it called the character ROM, or char ROM for short. the char ROM contains the sprite and background tile pattern data. These are sometimes referred to as the pattern tables. ]{.c7}

[PPU Registers:]{.c23}[ These registers allow the CPU to modify the state of the PPU. It maintains all of the control signals that are sent to both the background and sprite renderers.]{.c7}

[Background Renderer:]{.c23}[ Responsible for drawing the background data for a scene. ]{.c7}

[Sprite Renderer:]{.c23}[ Responsible for drawing the sprite data for a scene, and maintaining object attribute memory.]{}

[Object Attribute Memory:]{.c23}[ Holds all of the data needed to know how to render a sprite. OAM is 256 bytes in size and each sprite utilizes 4 bytes of data. This means the PPU can support 64 sprites.]{.c7}

[Pixel Priority:]{.c23}[ During the visible pixel section of rendering, both the background and sprite renderers produce a single pixel each clock cycle. The pixel priority module looks at the priority values and color for each pixel and decides which one to draw to the screen. ]{.c7}

[VGA Interface:]{.c23}[ This is where all of the frame data is kept in a frame buffer. This data is then upscaled to 640x480 when it goes out to the monitor.]{}

[PPU Memory Map]{.c22} {#h.dkksbep8besq .c35}
----------------------

[![](images/image22.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 421.64px; height: 466.50px;"}

[The PPU memory map is broken up into three distinct regions, the pattern tables, name tables, and palettes. Each of these regions holds data the PPU need to obtain to render a given scanline. The functionality of each part is described in the PPU Rendering section.]{.c134}

[PPU CHAROM]{.c22} {#h.pa3j41hpauwc .c35}
------------------

-   [ROM from the cartridge is broken in two sections]{.c18}

<!-- -->

-   [Program ROM]{.c18}

<!-- -->

-   [Contains program code for the 6502]{.c18}
-   [Is mapped into the CPU address space by the mapper]{.c18}

<!-- -->

-   [Character ROM ]{.c18}

<!-- -->

-   [Contains sprite and background data for the PPU]{.c18}
-   [Is mapped into the PPU address space by the mapper]{.c18}

[PPU Rendering]{.c22} {#h.pg3as4rfwz9v .c35}
---------------------

-   [Pattern Tables]{.c18}

<!-- -->

-   [\$0000-\$2000 in VRAM]{.c18}

<!-- -->

-   [Pattern Table 0 (\$0000-\$0FFF)]{.c18}
-   [Pattern Table 1 (\$1000-\$2000)]{.c18}
-   [The program selects which one of these contains sprites and backgrounds]{.c18}
-   [Each pattern table is 16 bytes long and represents 1 8x8 pixel tile]{.c18}

<!-- -->

-   [Each 8x1 row is 2 bytes long]{.c18}
-   [Each bit in the byte represents a pixel and the corresponding bit for each byte is combined to create a 2 bit color.]{.c18}

<!-- -->

-   [Color\_pixel = {byte2\[0\], byte1\[0\]}]{.c18}

<!-- -->

-   [So there can only be 4 colors in any given tile]{.c18}
-   [Rightmost bit is leftmost pixel]{.c18}

<!-- -->

-   [Any pattern that has a value of 0 is transparent i.e. the background color]{.c18}

[]{.c18}

[![](images/image15.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 414.58px; height: 172.50px;"}

[]{.c18}

-   [Name Tables]{.c18}

<!-- -->

-   [\$2000-\$2FFF in VRAM with \$3000-\$3EFF as a mirror]{.c18}
-   [Laid out in memory in 32x30 fashion]{.c18}

<!-- -->

-   [Think of as a 2d array where each element specifies a tile in the pattern table.]{.c18}
-   [This results in a resolution of 256x240]{.c18}

<!-- -->

-   [Although the PPU supports 4 name tables the NES only supplied enough VRAM for 2 this results in 2 of the 4 name tables being mirror]{.c18}

<!-- -->

-   [Vertically = horizontal movement]{.c18}
-   [Horizontally = vertical movement]{.c18}

<!-- -->

-   [Each entry in the name table refers to one pattern table and is one byte. Since there are 32x30=960 entries each name table requires 960 bytes of space the left over 64 bytes are used for attribute tables]{.c18}
-   [Attribute tables]{.c18}

<!-- -->

-   [1 byte entries that contains the palette assignment for a 2x2 grid of tiles]{.c18}

[![](images/image10.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 216.00px; height: 254.72px;"}

[]{.c18}

-   [Sprites]{.c18}

<!-- -->

-   [Just like backgrounds sprite tile data is contained in one of the pattern tables]{.c18}
-   [But unlike backgrounds sprite information is not contained in name tables but in a special reserved 256 byte RAM called the object attribute memory (OAM)]{.c18}

<!-- -->

-   [Object Attribute Memory]{.c18}

<!-- -->

-   [256 bytes of dedicated RAM]{.c18}
-   [Each object is allocated 4 bytes of OAM so we can store data about 64 sprites at once]{.c18}
-   [Each object has the following information stored in OAM]{.c18}

<!-- -->

-   [X Coordinate]{.c18}
-   [Y Coordinate]{.c18}
-   [Pattern Table Index]{.c18}
-   [Palette Assignment]{.c18}
-   [Horizontal/Vertical Flip]{.c18}

<!-- -->

-   [Palette Table]{.c18}

<!-- -->

-   [Located at \$3F00-\$3F20]{.c18}

<!-- -->

-   [\$3F00-\$3F0F is background palettes]{.c18}
-   [\$3F10-\$3F1F is sprite palettes]{.c18}

<!-- -->

-   [Mirrored all the way to \$4000]{.c18}
-   [Each color takes one byte]{.c18}
-   [Every background tile and sprite needs a color palette.]{.c18}
-   [When the background or sprite is being rendered the the color for a specific table is looked up in the correct palette and sent to the draw select mux.]{.c18}

<!-- -->

-   [Rendering is broken into two parts which are done for each horizontal scanline]{.c18}

<!-- -->

-   [Background Rendering]{.c18}

<!-- -->

-   [The background enable register (\$2001) controls if the default background color is rendered (\$2001) or if background data from the background renderer.]{.c18}
-   [The background data is obtained for every pixel.]{.c18}

<!-- -->

-   [Sprite Rendering]{.c18}

<!-- -->

-   [The sprite renderer has room for 8 unique sprites on each scanline.]{.c18}
-   [For each scanline the renderer looks through the OAM for sprites that need to be drawn on the scanline. If this is the case the sprite is loaded into the scanline local sprites]{.c18}

<!-- -->

-   [If this number exceeds 8 a flag is set and the behavior is undefined.]{.c18}

<!-- -->

-   [If a sprite should be drawn for a pixel instead of the background the sprite renderer sets the sprite priority line to a mux that decides what to send to the screen and the mux selects the sprite color d]{.c144 .c69 .c186}[ata.]{.c144 .c69 .c186}

[PPU Memory Mapped Registers]{.c22} {#h.8bwwxukxxmnt .c35}
-----------------------------------

[The PPU register interface exists so the CPU can modify and fetch the state elements of the PPU. These state elements include registers that set control signals, VRAM, object attribute memory, and palettes. These state elements then determine how the background and sprite renderers will draw the scene. The PPU register module also contains the pixel mux and palette memory which are used to determine what pixel data to send to the VGA module.]{.c7}

[]{#t.2410c3dd563250403a6a2b073e837692eff20a19}[]{#t.12}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [data\[7:0\]]{. | [inout]{.c7}    | [CPU]{.c7}      | [Bi directional |
| c7}             |                 |                 | data bus        |
|                 |                 |                 | between the     |
|                 |                 |                 | CPU/PPU]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [address\[2:0\] | [input]{.c7}    | [CPU]{.c7}      | [Register       |
| ]{.c7}          |                 |                 | select]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [rw]{.c7}       | [input]{.c7}    | [CPU]{.c7}      | [CPU read/write |
|                 |                 |                 | select]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [cs\_in]{.c7}   | [input]{.c7}    | [CPU]{.c7}      | [PPU chip       |
|                 |                 |                 | select]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [irq]{.c7}      | [output]{.c7}   | [CPU]{.c7}      | [Signal PPU     |
|                 |                 |                 | asserts to      |
|                 |                 |                 | trigger CPU     |
|                 |                 |                 | NMI]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [pixel\_data\[7 | [output]{.c7}   | [VGA]{.c7}      | [RGB pixel data |
| :0\]]{.c7}      |                 |                 | to be sent to   |
|                 |                 |                 | the             |
|                 |                 |                 | display]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\_ou | [output]{.c7}   | [VRAM]{.c7}     | [VRAM address   |
| t\[13:0\]]{.c7} |                 |                 | to read/write   |
|                 |                 |                 | from]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_rw\_sel] | [output]{.c7}   | [VRAM]{.c7}     | [Determines if  |
| {.c7}           |                 |                 | the current     |
|                 |                 |                 | vram operation  |
|                 |                 |                 | is a read or    |
|                 |                 |                 | write]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_ou | [output]{.c7}   | [VRAM]{.c7}     | [Data to write  |
| t\[7:0\]]{.c7}  |                 |                 | to VRAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_end]{.c | [output]{.c7}   | [VGA]{.c7}      | [Signals the    |
| 7}              |                 |                 | VGA interface   |
|                 |                 |                 | that this is    |
|                 |                 |                 | the end of a    |
|                 |                 |                 | frame]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_start]{ | [output]{.c7}   | [VGA]{.c7}      | [Signals the    |
| .c7}            |                 |                 | VGA interface   |
|                 |                 |                 | that a frame is |
|                 |                 |                 | starting to     |
|                 |                 |                 | keep the PPU    |
|                 |                 |                 | and VGA in      |
|                 |                 |                 | sync]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [rendering]{.c7 | [output]{.c7}   | [VGA]{.c7}      | [Signals the    |
| }               |                 |                 | VGA interface   |
|                 |                 |                 | that pixel data |
|                 |                 |                 | output is       |
|                 |                 |                 | valid]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[]{.c7}

[PPU Register Block Diagram]{.c22} {#h.h50m30h4jbfm .c19}
----------------------------------

[![Untitled Diagram.png](images/image20.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 370.50px; height: 351.34px;"}

[PPU Register Descriptions]{.c22} {#h.djradund7fk8 .c19}
---------------------------------

-   [Control registers are mapped into the CPUs address space (]{.c134}[\$2000 - \$2007)]{.c18}
-   [The registers are repeated every eight bytes until address \$3FF]{.c2 .c69}
-   [PPUCTRL\[7:0\] (]{.c69 .c23 .c144}[\$2000) WRITE]{.c18}

<!-- -->

-   [\[1:0\]: Base nametable address which is loaded at the start of a frame]{.c18}

<!-- -->

-   [0: \$2000]{.c18}
-   [1: \$2400]{.c18}
-   [2: \$2800]{.c18}
-   [3: \$2C00]{.c18}

<!-- -->

-   [\[2\]: VRAM address increment per CPU read/write of PPUDATA]{.c18}

<!-- -->

-   [0: Add 1 going across]{.c18}
-   [1: Add 32 going down]{.c18}

<!-- -->

-   [\[3\]: Sprite pattern table for 8x8 sprites]{.c18}

<!-- -->

-   [0: \$0000]{.c18}
-   [1: \$1000]{.c18}
-   [Ignored in 8x16 sprite mode]{.c18}

<!-- -->

-   [\[4\]: Background pattern table address]{.c18}

<!-- -->

-   [0: \$0000]{.c18}
-   [1: \$1000]{.c18}

<!-- -->

-   [\[5\]: Sprite size]{.c18}

<!-- -->

-   [0: 8x8]{.c18}
-   [1: 8x16]{.c18}

<!-- -->

-   [\[6\]: PPU master/slave select]{.c18}

<!-- -->

-   [0: Read backdrop from EXT pins]{.c18}
-   [1: Output color on EXT pins]{.c18}

<!-- -->

-   [\[7\]: Generate NMI interrupt at the start of vertical blanking interval]{.c18}

<!-- -->

-   [0: off]{.c18}
-   [1: on]{.c18}

<!-- -->

-   [PPUMASK\[7:0\] ]{.c144 .c69 .c23}[(\$2001) WRITE]{.c18}

<!-- -->

-   [\[0\]: Use grayscale image]{.c18}

<!-- -->

-   [0: Normal color]{.c18}
-   [1: Grayscale]{.c18}

<!-- -->

-   [\[1\]: Show left 8 pixels of background]{.c18}

<!-- -->

-   [0: Hide]{.c18}
-   [1: Show background in leftmost 8 pixels of screen]{.c18}

<!-- -->

-   [\[2\]: Show left 8 piexels of sprites]{.c18}

<!-- -->

-   [0: Hide]{.c18}
-   [1: Show sprites in leftmost 8 pixels of screen]{.c18}

<!-- -->

-   [\[3\]: Render the background]{.c18}

<!-- -->

-   [0: Don’t show background]{.c18}
-   [1: Show background]{.c18}

<!-- -->

-   [\[4\]: Render the sprites]{.c18}

<!-- -->

-   [0: Don’t show sprites]{.c18}
-   [1: Show sprites]{.c18}

<!-- -->

-   [\[5\]: Emphasize red]{.c18}
-   [\[6\]: Emphasize green]{.c18}
-   [\[7\]: Emphasize blue]{.c18}

<!-- -->

-   [PPUSTATUS\[7:0\] ]{.c144 .c69 .c23}[(\$2002) READ]{.c18}

<!-- -->

-   [\[4:0\]: Nothing?]{.c18}
-   [\[5\]: Set for sprite overflow which is when more than 8 sprites exist in one scanline (Is actually more complicated than this to do a hardware bug)]{.c18}
-   [\[6\]: Sprite 0 hit. This bit gets set when a non zero part of sprite zero overlaps a non zero background pixel]{.c18}
-   [\[7\]: Vertical blank status register]{.c18}

<!-- -->

-   [0: Not in vertical blank]{.c18}
-   [1: Currently in vertical blank]{.c18}

<!-- -->

-   [OAMADDR\[7:0\] ]{.c144 .c69 .c23}[(\$2003) WRITE]{.c18}

<!-- -->

-   [Address of the object attribute memory the program wants to access]{.c18}

<!-- -->

-   [OAMDATA\[7:0\] ]{.c144 .c69 .c23}[(\$2004) READ/WRITE]{.c18}

<!-- -->

-   [The CPU can read/write this register to read or write to the PPUs object attribute memory. The address should be specified by writing the OAMADDR register beforehand. Each write will increment the address by one, but a read will not modify the address]{.c18}

<!-- -->

-   [PPUSCROLL\[7:0\] ]{.c144 .c69 .c23}[(\$2005) WRITE]{.c18}

<!-- -->

-   [Tells the PPU what pixel of the nametable selected in PPUCTRL should be in the top left hand corner of the screen]{.c18}

<!-- -->

-   [PPUADDR\[7:0\] ]{.c144 .c69 .c23}[(\$2006) WRITE]{.c18}

<!-- -->

-   [Address the CPU wants to write to VRAM before writing a read of PPUSTATUS is required and then two bytes are written in first the high byte then the low byte]{.c18}

<!-- -->

-   [PPUDATA\[7:0\] ]{.c144 .c69 .c23}[(\$2007) READ/WRITE]{.c18}

<!-- -->

-   [Writes/Reads data from VRAM for the CPU. The value in PPUADDR is then incremented by the value specified in PPUCTRL]{.c18}

<!-- -->

-   [OAMDMA\[7:0\]]{.c144 .c69 .c23}[ (\$4014) WRITE]{.c18}

<!-- -->

-   [A write of \$XX to this register will result in the CPU memory page at \$XX00-\$XXFF being written into the PPU object attribute memory]{.c144 .c69 .c186}

[PPU Background Renderer]{.c22} {#h.qbi461d1fk95 .c35}
-------------------------------

[The background renderer is responsible for rendering the background for each frame that is output to the VGA interface. It does this by prefetching the data for two tiles at the end of the previous scanline. And then begins to continuously fetch tile data for every pixel of the visible frame. This allows the background renderer to produce a steady flow of output pixels despite the fact it takes 8 cycles to fetch 8 pixels of a scanline.]{.c7}

[]{#t.cfcc5323a0745a2d21a0d8ca697f3e16babd2727}[]{#t.13}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_render\_en | [input]{.c7}    | [PPU            | [Background     |
| ]{.c7}          |                 | Register]{.c7}  | render          |
|                 |                 |                 | enable]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [x\_pos\[9:0\]] | [input]{.c7}    | [PPU            | [The current    |
| {.c7}           |                 | Register]{.c7}  | pixel for the   |
|                 |                 |                 | active          |
|                 |                 |                 | scanline]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [y\_pos\[9:0\]] | [input]{.c7}    | [PPU            | [The current    |
| {.c7}           |                 | Register]{.c7}  | scanline being  |
|                 |                 |                 | rendered]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_in | [input]{.c7}    | [PPU            | [The current    |
| \[7:0\]]{.c7}   |                 | Register]{.c7}  | data that has   |
|                 |                 |                 | been read in    |
|                 |                 |                 | from VRAM]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_pt\_sel]{. | [input]{.c7}    | [PPU            | [Selects the    |
| c7}             |                 | Register]{.c7}  | location of the |
|                 |                 |                 | background      |
|                 |                 |                 | renderer        |
|                 |                 |                 | pattern         |
|                 |                 |                 | table]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [show\_bg\_left | [input]{.c7}    | [PPU            | [Determines if  |
| \_col]{.c7}     |                 | Register]{.c7}  | the background  |
|                 |                 |                 | for the         |
|                 |                 |                 | leftmost 8      |
|                 |                 |                 | pixels of each  |
|                 |                 |                 | scanline will   |
|                 |                 |                 | be drawn]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [fine\_x\_scrol | [input]{.c7}    | [PPU            | [Selects the    |
| l\[2:0\]]{.c7}  |                 | Register]{.c7}  | pixel drawn on  |
|                 |                 |                 | the left hand   |
|                 |                 |                 | side of the     |
|                 |                 |                 | screen]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [coarse\_x\_scr | [input]{.c7}    | [PPU            | [Selects the    |
| oll\[4:0\]]{.c7 |                 | Register]{.c7}  | tile to start   |
| }               |                 |                 | rendering from  |
|                 |                 |                 | in the x        |
|                 |                 |                 | direction]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [fine\_y\_scrol | [input]{.c7}    | [PPU            | [Selects the    |
| l\[2:0\]]{.c7}  |                 | Register]{.c7}  | pixel drawn on  |
|                 |                 |                 | the top of the  |
|                 |                 |                 | screen]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [coarse\_y\_scr | [input]{.c7}    | [PPU            | [Selects the    |
| oll\[4:0\]]{.c7 |                 | Register]{.c7}  | tile to start   |
| }               |                 |                 | rendering from  |
|                 |                 |                 | in the y        |
|                 |                 |                 | direction]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [nametable\_sel | [input]{.c7}    | [PPU            | [Selects the    |
| \[1:0\]]{.c7}   |                 | Register]{.c7}  | nametable to    |
|                 |                 |                 | start rendering |
|                 |                 |                 | from]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [update\_loopy\ | [input]{.c7}    | [PPU            | [Signal to      |
| _v]{.c7}        |                 | Register]{.c7}  | update the      |
|                 |                 |                 | temporary vram  |
|                 |                 |                 | address]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_loopy\_v\ | [input]{.c7}    | [PPU            | [Signal to      |
| _inc]{.c7}      |                 | Register]{.c7}  | increment the   |
|                 |                 |                 | temporary vram  |
|                 |                 |                 | address by the  |
|                 |                 |                 | increment       |
|                 |                 |                 | amount]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_loopy\_v\ | [input]{.c7}    | [PPU            | [If this signal |
| _inc\_amt]{.c7} |                 | Register]{.c7}  | is set          |
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
|                 |                 |                 | inc]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [vblank\_out]{. | [output]{.c7}   | [PPU            | [Determines it  |
| c7}             |                 | Register]{.c7}  | the PPU is in   |
|                 |                 |                 | vertical        |
|                 |                 |                 | blank]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_rendering\ | [output]{.c7}   | [PPU            | [Determines if  |
| _out]{.c7}      |                 | Register]{.c7}  | the bg renderer |
|                 |                 |                 | is requesting   |
|                 |                 |                 | vram            |
|                 |                 |                 | reads]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [bg\_pal\_sel\[ | [output]{.c7}   | [Pixel          | [Selects the    |
| 3:0\]]{.c7}     |                 | Mux]{.c7}       | palette for the |
|                 |                 |                 | background      |
|                 |                 |                 | pixel]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [loopy\_v\_out\ | [output]{.c7}   | [PPU            | [The temporary  |
| [14:0\]]{.c7}   |                 | Register]{.c7}  | vram address    |
|                 |                 |                 | register for    |
|                 |                 |                 | vram            |
|                 |                 |                 | reads/writes]{. |
|                 |                 |                 | c7}             |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\_ou | [output]{.c7}   | [VRAM]{.c7}     | [The VRAM       |
| t\[13:0\]]{.c7} |                 |                 | address the     |
|                 |                 |                 | sprite renderer |
|                 |                 |                 | wants to read   |
|                 |                 |                 | from]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[PPU Background Renderer Diagram]{.c22} {#h.kqe8ry35ghh .c35}
---------------------------------------

[![Untitled Diagram.png](images/image18.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 326.64px; height: 420.71px;"}

[VRAM:]{.c23}[ The background renderer reads from two of the three major areas of address space available to the PPU, the pattern tables, and the name tables. First the background renderer needs the name table byte for a given tile to know which tile to draw in the background. Once it has this information is need the pattern to know how to draw the background tile.]{.c7}

[PPU Register Interface:]{.c23}[ All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.]{.c7}

[Scrolling Register:]{.c23}[ The scrolling register is responsible for keeping track of what tile is currently being drawn to the screen. ]{.c7}

[Scrolling Update Logic: ]{.c23}[Every time the data for a background tile is successfully fetched the scrolling register needs to be updated. Most of the time it is a simple increment, but more care has to be taken when the next tile falls in another name table. This logic allows the scrolling register to correctly update to be able to smoothly jump between name tables while rendering. ]{.c7}

[Background Renderer State Machine: ]{.c23}[The background renderer state machine is responsible for sending the correct control signals to all of the other modules as the background is rendering. ]{.c7}

[Background Shift Registers:]{.c23}[ These registers shift out the pixel data to be rendered on every clock cycle. They also implement the logic that makes fine one pixel scrolling possible by changing what index of the shift registers is the one being shifted out each cycle.]{.c7}

[Pixel Priority Mux: ]{.c23}[Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.]{.c7}

[PPU Sprite Renderer]{.c22} {#h.z1adjveqdhdo .c35}
---------------------------

[The PPU sprite renderer is used to render all of the sprite data for each scanline. The way the hardware was designed it only allows for 64 sprites to kept in object attribute memory at once. There are only 8 spots available to store the sprite data for each scanline so only 8 sprites can be rendered for each scanline. Sprite data in OAM is evaluated for the next scanline while the background renderer is mastering the VRAM bus. When rendering reaches horizontal blank the sprite renderer fetches the pattern data for all of the sprites to be rendered on the next scanline and places the data in the sprite shift registers. The sprite x position is also loaded into a down counter which determines when to make the sprite active and shift out the pattern data on the next scanline.]{.c7}

[]{#t.cdbc9e2f9b853601435427311431e91e21b12696}[]{#t.14}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_render\_e | [input]{.c7}    | [PPU            | [Sprite         |
| n]{.c7}         |                 | Register]{.c7}  | renderer enable |
|                 |                 |                 | signal]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [x\_pos\[9:0\]] | [input]{.c7}    | [PPU            | [The current    |
| {.c7}           |                 | Register]{.c7}  | pixel for the   |
|                 |                 |                 | active          |
|                 |                 |                 | scanline]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [y\_pos\[9:0\]] | [input]{.c7}    | [PPU            | [The current    |
| {.c7}           |                 | Register]{.c7}  | scanline being  |
|                 |                 |                 | rendered]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_addr\_in\ | [input]{.c7}    | [PPU            | [The current    |
| [7:0\]]{.c7}    |                 | Register]{.c7}  | OAM address     |
|                 |                 |                 | being           |
|                 |                 |                 | read/written]{. |
|                 |                 |                 | c7}             |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_data\_in\ | [inout]{.c7}    | [PPU            | [The current    |
| [7:0\]]{.c7}    |                 | Register]{.c7}  | data being      |
|                 |                 |                 | read/written    |
|                 |                 |                 | from OAM]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_in | [input]{.c7}    | [VRAM]{.c7}     | [The data the   |
| \[7:0\]]{.c7}   |                 |                 | sprite renderer |
|                 |                 |                 | requested from  |
|                 |                 |                 | VRAM]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_oam\_rw]{ | [input]{.c7}    | [PPU            | [Selects if OAM |
| .c7}            |                 | Register]{.c7}  | is being read   |
|                 |                 |                 | from or written |
|                 |                 |                 | to from the     |
|                 |                 |                 | CPU]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_oam\_req] | [input]{.c7}    | [PPU            | [Signals the    |
| {.c7}           |                 | Register]{.c7}  | CPU wants to    |
|                 |                 |                 | read/write      |
|                 |                 |                 | OAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_pt\_sel]{ | [input]{.c7}    | [PPU            | [Determines the |
| .c7}            |                 | Register]{.c7}  | PPU pattern     |
|                 |                 |                 | table address   |
|                 |                 |                 | in VRAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_size\_sel | [input]{.c7}    | [PPU            | [Determines the |
| ]{.c7}          |                 | Register]{.c7}  | size of the     |
|                 |                 |                 | sprites to be   |
|                 |                 |                 | drawn]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [show\_spr\_lef | [input]{.c7}    | [PPU            | [Determines if  |
| t\_col]{.c7}    |                 | Register]{.c7}  | sprites on the  |
|                 |                 |                 | leftmost 8      |
|                 |                 |                 | pixels of each  |
|                 |                 |                 | scanline will   |
|                 |                 |                 | be drawn]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_overflow] | [output]{.c7}   | [PPU            | [If more than 8 |
| {.c7}           |                 | Register]{.c7}  | sprites fall on |
|                 |                 |                 | a single        |
|                 |                 |                 | scanline this   |
|                 |                 |                 | is set]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_pri\_out] | [output]{.c7}   | [Pixel          | [Determines the |
| {.c7}           |                 | Mux]{.c7}       | priority of the |
|                 |                 |                 | sprite pixel    |
|                 |                 |                 | data]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_data\_out | [output]{.c7}   | [PPU            | [returns oam    |
| \[7:0\]]{.c7}   |                 | Register]{.c7}  | data the CPU    |
|                 |                 |                 | requested]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_pal\_sel\ | [output]{.c7}   | [Pixel          | [Sprite pixel   |
| [3:0\]]{.c7}    |                 | Mux]{.c7}       | color data to   |
|                 |                 |                 | be drawn]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\_ou | [output]{.c7}   | [VRAM]{.c7}     | [Sprite vram    |
| t\[13:0\]]{.c7} |                 |                 | read            |
|                 |                 |                 | address]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_vram\_req | [output]{.c7}   | [VRAM]{.c7}     | [Signals the    |
| ]{.c7}          |                 |                 | sprite renderer |
|                 |                 |                 | is requesting a |
|                 |                 |                 | VRAM read]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_0\_render | [output]{.c7}   | [Pixel          | [Determines if  |
| ing]{.c7}       |                 | Mux]{.c7}       | the current     |
|                 |                 |                 | sprite that is  |
|                 |                 |                 | rendering is    |
|                 |                 |                 | sprite 0]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [inc\_oam\_addr | [output]{.c7}   | [PPU            | [Signals the    |
| ]{.c7}          |                 | Register]{.c7}  | OAM address in  |
|                 |                 |                 | the registers   |
|                 |                 |                 | to              |
|                 |                 |                 | increment]{.c7} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[PPU Sprite Renderer Diagram]{.c22} {#h.ouavojij313q .c35}
-----------------------------------

[![Untitled Diagram.png](images/image12.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 556.77px; height: 408.55px;"}

[]{.c76 .c23}

[]{.c76 .c23}

[]{.c76 .c23}

[VRAM:]{.c23}[ The sprite renderer need to be able to fetch the sprite pattern data from the character rom. This is why it can request VRAM reads from this region through the PPU Register Interface]{}

[PPU Register Interface:]{.c23}[ All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.]{}[ ]{.c76 .c23}

[Object Attribute Memory:]{.c23}[ OAM contains all of the data needed to render a sprite to the screen except the pattern data itself. For each sprite OAM holds its x position, y position, horizontal flip, vertical flip, and palette information. In total OAM supports 64 sprites.]{.c7}

[Sprite Renderer State Machine:]{.c23}[ The sprite renderer state machine is responsible for sending all of the control signals to each of the other units in the renderer. This includes procesing the data in OAM, move the correct sprites to secondary OAM, VRAM reads, and shifting out the sprite data when the sprite needs to be rendered to the screen.]{.c7}

[Sprite Shift Registers:]{.c23}[ The sprite shift registers hold the sprite pixel data for sprites on the current scanline. When a sprite becomes active its data is shifted out to the pixel priority mux.]{.c7}

[Pixel Priority Mux: ]{.c23}[Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.]{}

[Temporary Sprite Data:]{.c23}[ The temporary sprite data is where the state machine moves the current sprite being evaluated in OAM to. If the temporary sprite falls on the next scanline its data is moved into a slot in secondary OAM. If it does not the data is discarded.]{.c7}

[Secondary Object Attribute Memory:]{.c23}[ Secondary OAM holds the sprite data for sprites that fall on the next scanline. During hblank this data is used to load the sprite shift registers with the correct sprite pattern data.]{.c7}

[Sprite Counter and Priority Registers:]{.c23}[ These registers hold the priority information for each sprite in the sprite shift registers. It also holds a down counter for each sprite which is loaded with the sprite's x position. When the counter hits 0 the corresponding sprite becomes active and the sprite data needs to be shifted out to the screen.]{}

[PPU Object Attribute Memory]{.c22} {#h.ud4hcid0qc0t .c35}
-----------------------------------

[]{.c7}

[]{#t.c1d0725151e3ae45852fd0f9196d5e83cf527c44}[]{#t.15}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [oam\_en]{.c7}  | [input]{.c7}    | [OAM]{.c7}      | [Determines if  |
|                 |                 |                 | the input data  |
|                 |                 |                 | is for a valid  |
|                 |                 |                 | read/write]{.c7 |
|                 |                 |                 | }               |
+-----------------+-----------------+-----------------+-----------------+
| [oam\_rw]{.c7}  | [input]{.c7}    | [OAM]{.c7}      | [Determines if  |
|                 |                 |                 | the current     |
|                 |                 |                 | operation is a  |
|                 |                 |                 | read or         |
|                 |                 |                 | write]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [spr\_select\[5 | [input]{.c7}    | [OAM]{.c7}      | [Determines     |
| :0\]]{.c7}      |                 |                 | which sprite is |
|                 |                 |                 | being           |
|                 |                 |                 | read/written]{. |
|                 |                 |                 | c7}             |
+-----------------+-----------------+-----------------+-----------------+
| [byte\_select\[ | [input]{.c7}    | [OAM]{.c7}      | [Determines     |
| 1:0\]]{.c7}     |                 |                 | which sprite    |
|                 |                 |                 | byte is being   |
|                 |                 |                 | read/written]{. |
|                 |                 |                 | c7}             |
+-----------------+-----------------+-----------------+-----------------+
| [data\_in\[7:0\ | [input]{.c7}    | [OAM]{.c7}      | [Data to write  |
| ]]{.c7}         |                 |                 | to the          |
|                 |                 |                 | specified OAM   |
|                 |                 |                 | address]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[7:0 | [output]{.c7}   | [PPU            | [Data that has  |
| \]]{.c7}        |                 | Register]{.c7}  | been read from  |
|                 |                 |                 | OAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[PPU Palette Memory]{.c22} {#h.unbqcwik0ikz .c35}
--------------------------

[]{.c7}

[]{#t.f1d3489e5c353600b2df513bca63b64f963856ac}[]{#t.16}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [pal\_addr\[4:0 | [input]{.c7}    | [palette        | [Selects the    |
| \]]{.c7}        |                 | mem]{.c7}       | palette to      |
|                 |                 |                 | read/write in   |
|                 |                 |                 | the             |
|                 |                 |                 | memory]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [pal\_data\_in\ | [input]{.c7}    | [palette        | [Data to write  |
| [7:0\]]{.c7}    |                 | mem]{.c7}       | to the palette  |
|                 |                 |                 | memory]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [palette\_mem\_ | [input]{.c7}    | [palette        | [Determines if  |
| rw]{.c7}        |                 | mem]{.c7}       | the current     |
|                 |                 |                 | operation is a  |
|                 |                 |                 | read or         |
|                 |                 |                 | write]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [palette\_mem\_ | [input]{.c7}    | [palette        | [Determines if  |
| en]{.c7}        |                 | mem]{.c7}       | the palette mem |
|                 |                 |                 | inputs are      |
|                 |                 |                 | valid]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [color\_out\[7: | [output]{.c7}   | [VGA]{.c7}      | [Returns the    |
| 0\]]{.c7}       |                 |                 | selected        |
|                 |                 |                 | palette for a   |
|                 |                 |                 | given address   |
|                 |                 |                 | on a read]{.c7} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[VRAM Interface]{.c22} {#h.xlgt5p96mvki .c35}
----------------------

[The VRAM interface instantiates an Altera RAM IP core. Each read take 2 cycles one for the input and one for the output]{.c7}

[]{#t.40d96b8d3f361e8568937a45000f4fd566ca150c}[]{#t.17}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_addr\[10 | [input]{.c7}    | [PPU]{.c7}      | [Address from   |
| :0\]]{.c7}      |                 |                 | VRAM to read to |
|                 |                 |                 | or write        |
|                 |                 |                 | from]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_in | [input]{.c7}    | [PPU]{.c7}      | [The data to    |
| \[7:0\]]{.c7}   |                 |                 | write to        |
|                 |                 |                 | VRAM]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_en]{.c7} | [input]{.c7}    | [PPU]{.c7}      | [The VRAM       |
|                 |                 |                 | enable          |
|                 |                 |                 | signal]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_rw]{.c7} | [input]{.c7}    | [PPU]{.c7}      | [Selects if the |
|                 |                 |                 | current op is a |
|                 |                 |                 | read or         |
|                 |                 |                 | write]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [vram\_data\_ou | [output]{.c7}   | [PPU]{.c7}      | [The data that  |
| t\[7:0\]]{.c7}  |                 |                 | was read from   |
|                 |                 |                 | VRAM on a       |
|                 |                 |                 | read]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[]{.c22} {#h.ezngvtvhun92 .c35 .c60}
--------

[DMA]{.c22} {#h.7oqgkdlshdds .c35}
-----------

[The DMA is used to copy 256 bytes of data from the CPU address space into the OAM (PPU address space). The DMA is 4x faster than it would be to use str and ldr instructions to copy the data. While copying data, the CPU is stalled.]{.c7}

[]{#t.529fd0b7b6c6112b07e37b86cf3de0f87c25e96e}[]{#t.18}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [oamdma]{.c7}   | [input]{.c7}    | [PPU]{.c7}      | [When written   |
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
|                 |                 |                 | OAM.]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_ram\_q]{. | [input]{.c7}    | [CPU RAM]{.c7}  | [Data read in   |
| c7}             |                 |                 | from CPU RAM    |
|                 |                 |                 | will come       |
|                 |                 |                 | here]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_done]{.c7 | [output]{.c7}   | [CPU]{.c7}      | [Informs the    |
| }               |                 |                 | CPU to pause    |
|                 |                 |                 | while the DMA   |
|                 |                 |                 | copies OAM data |
|                 |                 |                 | from the CPU    |
|                 |                 |                 | RAM to the OAM  |
|                 |                 |                 | section of the  |
|                 |                 |                 | PPU RAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_ram\_addr | [output]{.c7}   | [CPU RAM]{.c7}  | [The address of |
| ]{.c7}          |                 |                 | the CPU RAM     |
|                 |                 |                 | where we are    |
|                 |                 |                 | reading         |
|                 |                 |                 | data]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpu\_ram\_wr]{ | [output]{.c7}   | [CPU RAM]{.c7}  | [Read/write     |
| .c7}            |                 |                 | enable signal   |
|                 |                 |                 | for CPU         |
|                 |                 |                 | RAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [oam\_data]{.c7 | [output]{.c7}   | [OAM]{.c7}      | [The data that  |
| }               |                 |                 | will be written |
|                 |                 |                 | to the OAM at   |
|                 |                 |                 | the address     |
|                 |                 |                 | specified in    |
|                 |                 |                 | OAMADDR]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_req]{.c7} | [input]{.c7}    | [APU]{.c7}      | [High when the  |
|                 |                 |                 | DMC wants to    |
|                 |                 |                 | use the         |
|                 |                 |                 | DMA]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_ack]{.c7} | [output]{.c7}   | [APU]{.c7}      | [High when data |
|                 |                 |                 | on DMA]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_addr]{.c7 | [input]{.c7}    | [APU]{.c7}      | [Address for    |
| }               |                 |                 | DMA to read     |
|                 |                 |                 | from \*\*       |
|                 |                 |                 | CURRENTLY NOT   |
|                 |                 |                 | USED \*\*]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [dma\_data]{.c7 | [output]{.c7}   | [APU]{.c7}      | [Data from DMA  |
| }               |                 |                 | to apu memory   |
|                 |                 |                 | \*\* CURRENTLY  |
|                 |                 |                 | NOT USED        |
|                 |                 |                 | \*\*]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[]{.c7}

[PPU Testbench]{.c22} {#h.9f0tphgw8ifs .c35}
---------------------

[In a single frame the PPU outputs 61,440 pixels. Obviously this amount of information would be incredibly difficult for a human to verify as correct by looking at a simulation waveform. This is what drove me to create a testbench capable of rendering full PPU frames to an image. This allowed the process of debugging the PPU to proceed at a much faster rate than if I used waveforms alone. Essentially how the test bench works is the testbench sets the initial PPU state, it lets the PPU render a frame, and then the testbench receives the data for each pixel and generates a PPM file. The testbench can render multiple frames in a row, so the tester can see how the frame output changes as the PPU state changes.]{.c7}

[![Untitled Diagram.png](images/image14.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 409.38px; height: 165.80px;"}

[![Untitled Diagram.png](images/image17.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 388.22px; height: 240.99px;"}

[PPU Testbench PPM file format]{.c22} {#h.dgbwdleazq7q .c35}
-------------------------------------

[The PPM image format is one of the easiest to understand image formats available. This is mostly because of how it is a completely human readable format. A PPM file simply consists of a header, and then pixel data. The header consists of the text “P3” on the first line, followed by the image width and height on the next line, then a max value for each of the rgb components of a pixel on the final line of the header. After the header it is just width \* height rgb colors in row major order.]{.c7}

[]{.c22} {#h.bw6eh6f443qx .c35 .c60}
--------

[]{.c22} {#h.d1ra2gz6e3hd .c35 .c60}
--------

[PPU Testbench Example Renderings]{.c22} {#h.8ijczpvs4ut5 .c35}
----------------------------------------

[![test (1).png](images/image5.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 197.53px; height: 186.50px;"}[![test (2).png](images/image7.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 200.68px; height: 187.50px;"}[![test (3).png](images/image6.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 199.53px; height: 189.50px;"}[![test (4).png](images/image19.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 202.30px; height: 187.50px;"}[![test (5).png](images/image26.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 201.50px; height: 187.67px;"}[![test (10).png](images/image8.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 198.60px; height: 186.50px;"}

5.  [Memor]{}[y Maps]{} {#h.7c1koopsou4c style="display:inline"}
    ===================

[Cartridges are a Read-Only Memory that contains necessary data to run games. However, it is possible that in some cases that a cartridge holds more data than the CPU can address to. In this case, memory mapper comes into play and changes the mapping as needed so that one address can point to multiple locations in a cartridge. For our case, the end goal was to get the game Super Mario Bros. running on our FPGA. This game does not use a memory mapper, so we did not work on any memory mappers. In the future, we might add support for the other memory mapping systems so that we can play other games.]{.c7}

[These were two ip catalog ROM blocks that are created using MIF files for Super Mario Bros. They contained the information for the CPU and PPU RAM and VRAM respectively.]{.c7}

[]{.c22} {#h.zhfrfx8b7pvg .c35 .c60}
--------

[PPU ROM Memory Map]{.c22} {#h.o4bj1b7uzlbc .c35}
--------------------------

[This table shows how the PPU’s memory is laid out. The Registers are explained in greater detail in the Architecture Document.]{.c7}

[]{#t.d3aeb09ef995373f509588bfbe093c2a247a33be}[]{#t.19}

+-----------------------------------+-----------------------------------+
| [Address Range]{.c30}             | [Description]{.c30}               |
+-----------------------------------+-----------------------------------+
| [0x0000 - 0x0FFF]{.c7}            | [Pattern Table 0]{.c7}            |
+-----------------------------------+-----------------------------------+
| [0x1000 - 0x1FFF]{.c7}            | [Pattern Table 1]{.c7}            |
+-----------------------------------+-----------------------------------+
| [0x2000 - 0x23BF]{.c7}            | [Name Table 0]{.c7}               |
+-----------------------------------+-----------------------------------+
| [0x23C0 - 0x23FF]{.c7}            | [Attribute Table 0]{.c7}          |
+-----------------------------------+-----------------------------------+
| [0x2400 - 0x27BF]{.c7}            | [Name Table 1]{.c7}               |
+-----------------------------------+-----------------------------------+
| [0x27C0 - 0x27FF]{.c7}            | [Attribute Table 1]{.c7}          |
+-----------------------------------+-----------------------------------+
| [0x2800 - 0x2BBF]{.c7}            | [Name Table 2]{.c7}               |
+-----------------------------------+-----------------------------------+
| [0x2BC0 - 0x2BFF]{.c7}            | [Attribute Table 2]{.c7}          |
+-----------------------------------+-----------------------------------+
| [0x2C00 - 0x2FBF]{.c7}            | [Name Table 3]{.c7}               |
+-----------------------------------+-----------------------------------+
| [0x2FC0 - 0x2FFF]{.c7}            | [Attribute Table 3]{.c7}          |
+-----------------------------------+-----------------------------------+
| [0x3000 - 0x3EFF]{.c7}            | [Mirrors 0x2000 - 0x2EFF]{.c7}    |
+-----------------------------------+-----------------------------------+
| [0x3F00 - 0x3F0F]{.c7}            | [Background Palettes]{.c7}        |
+-----------------------------------+-----------------------------------+
| [0x3F10 - 0x3F1F]{.c7}            | [Sprite Palettes]{.c7}            |
+-----------------------------------+-----------------------------------+
| [0x3F20 - 0x3FFF]{.c7}            | [Mirrors 0x3F00 - 0x3F1F]{.c7}    |
+-----------------------------------+-----------------------------------+
| [0x4000 - 0xFFFF]{.c7}            | [Mirrors 0x0000 - 0x3FFF]{.c7}    |
+-----------------------------------+-----------------------------------+

[]{.c7}

[CPU ROM Memory Map]{.c22} {#h.n5cypllda98c .c35}
--------------------------

[This table explains how the CPU’s memory is laid out. The Registers are explained in greater detail in the Architecture document.]{.c7}

[]{#t.3ea006ae6c40b543eff9ac9fa3559a879d0621f6}[]{#t.20}

+-----------------------------------+-----------------------------------+
| [Address Range]{.c30}             | [Description]{.c30}               |
+-----------------------------------+-----------------------------------+
| [0x0000 - 0x00FF]{.c7}            | [Zero Page]{.c7}                  |
+-----------------------------------+-----------------------------------+
| [0x0100 - 0x1FF]{.c7}             | [Stack]{.c7}                      |
+-----------------------------------+-----------------------------------+
| [0x0200 - 0x07FF]{.c7}            | [RAM]{.c7}                        |
+-----------------------------------+-----------------------------------+
| [0x0800 - 0x1FFF]{.c7}            | [Mirrors 0x0000 - 0x07FF]{.c7}    |
+-----------------------------------+-----------------------------------+
| [0x2000 - 0x2007]{.c7}            | [Registers]{.c7}                  |
+-----------------------------------+-----------------------------------+
| [0x2008 - 0x3FFF]{.c7}            | [Mirrors 0x2000 - 0x2007]{.c7}    |
+-----------------------------------+-----------------------------------+
| [0x4000 - 0x401F]{.c7}            | [I/O Registers]{.c7}              |
+-----------------------------------+-----------------------------------+
| [0x4020 - 0x5FFF]{.c7}            | [Expansion ROM]{.c7}              |
+-----------------------------------+-----------------------------------+
| [0x6000 - 0x7FFF]{.c7}            | [SRAM]{.c7}                       |
+-----------------------------------+-----------------------------------+
| [0x8000 - 0xBFFF]{.c7}            | [Program ROM Lower Bank]{.c7}     |
+-----------------------------------+-----------------------------------+
| [0xC000 - 0xFFFF]{.c7}            | [Program ROM Upper Bank]{.c7}     |
+-----------------------------------+-----------------------------------+

[]{.c7}

[Memory Mappers Interface]{.c22} {#h.5cvhenp51lun .c35}
--------------------------------

[]{#t.a7c474da3306d0e8e99e8d3a20902e581a1043cc}[]{#t.21}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [rd]{.c7}       | [input]{.c7}    | [CPU/PPU]{.c7}  | [Read           |
|                 |                 |                 | request]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c7}     | [input]{.c7}    | [CPU/PPU]{.c7}  | [Address to     |
|                 |                 |                 | read from]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [data]{.c7}     | [output]{.c7}   | [CPU/PPU]{.c7}  | [Data from the  |
|                 |                 |                 | address]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+

------------------------------------------------------------------------

[]{.c109 .c23} {#h.8bsdqknl6reb .c132 .c123}
==============

6.  [APU]{.c109 .c23} {#h.bryqhbcn7knu style="display:inline"}
    =================

[Due to limitations of our FPGA design board (no D2A converter) and time constraints, our group did not implement the APU. Instead, we created the register interface for the APU, so that the CPU could still read and write from the registers. The following section is provided for reference only.]{.c7}

[The NES included an Audio Processing Unit (APU) to control all sound output. The APU contains five audio channels: two pulse wave modulation channels, a triangle wave channel, a noise channel (fo]{}[r]{}[ random audio), and a delta modulation channel. Each channel is mapped to registers in the CPU’s address space and each channel runs independently of the others. The outputs of all five channels are then combined using a non-linear mixing scheme. The APU also has a dedicated APU Status register. A write to this register can enable/disable any of the five channels. A read to this register can tell you if each channel still has a positive count on their respective timers. In addition, a read to this register will reveal any DMC or frame interrupts.]{.c7}

[ APU Registers]{.c22} {#h.qk56hr19gphj .c35}
----------------------

[]{#t.ef2c0e3f9254f624e8fccd0f50ed51a04d039588}[]{#t.22}

[Registers]{.c30}

[\$4000]{.c7}

[First pulse wave]{.c7}

[DDLC VVVV]{.c7}

[Duty, Envelope Loop, Constant Volume, Volume]{.c7}

[\$4001]{.c7}

[First pulse wave]{.c7}

[EPPP NSSS]{.c7}

[Enabled, Period, Negate, Shift]{.c7}

[\$4002]{.c7}

[First pulse wave]{.c7}

[TTTT TTTT]{.c7}

[Timer low]{.c7}

[\$4003]{.c7}

[First pulse wave]{.c7}

[LLLL LTTT]{.c7}

[Length counter load, Timer high]{.c7}

[\$4004]{.c7}

[Second pulse wave]{.c7}

[DDLC VVVV]{.c7}

[Duty, Envelope Loop, Constant Volume, Volume]{.c7}

[\$4005]{.c7}

[Second pulse wave]{.c7}

[EPPP NSSS]{.c7}

[Enabled, Period, Negate, Shift]{.c7}

[\$4006]{.c7}

[Second pulse wave]{.c7}

[TTTT TTTT]{.c7}

[Timer low]{.c7}

[\$4007]{.c7}

[Second pulse wave]{.c7}

[LLLL LTTT]{.c7}

[Length counter load, Timer high]{.c7}

[\$4008]{.c7}

[Triangle wave]{.c7}

[CRRR RRRR]{.c7}

[Length counter control, linear count load]{.c7}

[\$4009]{.c7}

[Triangle wave]{.c7}

[]{.c7}

[Unused]{.c7}

[\$400A]{.c7}

[Triangle wave]{.c7}

[TTTT TTTT]{.c7}

[Timer low]{.c7}

[\$400B]{.c7}

[Triangle wave]{.c7}

[LLLL LTTT]{.c7}

[Length counter load, Timer high]{.c7}

[\$400C]{.c7}

[Noise Channel]{.c7}

[--LC  VVVV]{.c7}

[Envelope Loop, Constant Volume, Volume]{.c7}

[\$400D]{.c7}

[Noise Channel]{.c7}

[]{.c7}

[Unused]{.c7}

[\$400E]{.c7}

[Noise Channel]{.c7}

[L---  PPPP]{.c7}

[Loop Noise, Noise Period]{.c7}

[\$400F]{.c7}

[Noise Channel]{.c7}

[LLLL  L---]{.c7}

[Length counter load]{.c7}

[\$4010]{.c7}

[Delta modulation channel]{.c7}

[IL-- FFFF]{.c7}

[IRQ enable, Loop, Frequency]{.c7}

[\$4011]{.c7}

[Delta modulation channel]{.c7}

[-LLL  LLLL]{.c7}

[Load counter]{.c7}

[\$4012]{.c7}

[Delta modulation channel]{.c7}

[AAAA AAAA]{.c7}

[Sample Address]{.c7}

[\$4013]{.c7}

[Delta modulation channel]{.c7}

[LLLL LLLL]{.c7}

[Sample Length]{.c7}

[\$4015 (write)]{.c7}

[APU Status Register Writes]{.c7}

[---D NT21]{.c7}

[Enable DMC, Enable Noise, Enable Triangle, Enable Pulse 2/1]{.c7}

[\$4015 (read)]{.c7}

[APU Status Register Read]{.c7}

[IF-D NT21]{.c7}

[DMC Interrupt, Frame Interrupt, DMC Active, Length Counter &gt; 0 for Noise, Triangle, and Pulse Channels]{.c7}

[\$4017 (write)]{.c7}

[APU Frame Counter]{.c7}

[MI-- ----]{.c7}

[Mode (0 = 4 step, 1 = 5 step), IRQ inhibit flag]{.c7}

------------------------------------------------------------------------

[]{.c109 .c23} {#h.rssy9kfs4hbb .c123 .c132}
==============

7.  [Controllers (SPART)]{.c109 .c23} {#h.5fhzf7bk1zke style="display:inline"}
    =================================

[The controller module allows users to provide input to the FPGA. We opted to create a controller simulator program instead of using an actual NES joypad. This decision was made because the NES controllers used a proprietary port and because the available USB controllers lacked specification sheets. The simulator program communicates with the FPGA using the SPART interface, which is similar to UART. Our SPART module used 8 data bits, no parity, and 1 stop bit for serial communication. All data was received automatically into an 8 bit buffer by the SPART module at 2400 baud. In addition to the SPART module, we also needed a controller driver to allow the CPU to interface with the controllers. The controllers are memory mapped to \$4016 and \$4017 for CPU to read.]{.c7}

[When writing high to address \$4016 bit 0, the controllers are continuously loaded with the states of each button. Once address \$4016 bit 0 is cleared, the data from the controllers can be read by reading from address \$4016 for player 1 or \$4017 for player 2. The data will be read in serially on bit 0. The first read will return the state of button A, then B, Select, Start, Up, Down, Left, Right. It will read 1 if the button is pressed and 0 otherwise. Any read after clearing \$4016 bit 0 and after reading the first 8 button values, will be a 1. If the CPU reads when before clearing \$4016, the state of button A with be repeatedly returned.]{.c7}

[Debug Modification]{.c22} {#h.927n2dvl8df9 .c35}
--------------------------

[In order to provide an easy way to debug our top level design, we modified the controller to send an entire ram block out over SPART when it receives the send\_states signal. This later allowed us to record the PC, IR, A, X, Y, flags, and SP of the CPU into a RAM block every CPU clock cycle and print this out onto a terminal console when we reached a specific PC.]{.c7}

[Controller Registers]{.c22} {#h.917ivz4m4ziu .c139 .c123}
----------------------------

[]{#t.f48da44243cd4a3f2f9d86b2a46e440bbc5c870d}[]{#t.23}

[Registers]{.c30}

[\$4016 (write)]{.c7}

[Controller Update]{.c7}

[---- ---C]{.c7}

[Button states of both controllers are loaded]{.c7}

[\$4016 (read)]{.c7}

[Controller 1 Read]{.c7}

[---- ---C]{.c7}

[Reads button states of controller 1 in the order A, B, Start, Select, Up, Down, Left, Right]{.c7}

[\$4017 (read)]{.c7}

[Controller 2 Read]{.c7}

[---- ---C]{.c7}

[Reads button states of controller 2 in the order A, B, Start, Select, Up, Down, Left, Right]{.c7}

[Controllers Wrapper]{.c22} {#h.bnnsrcv0r4jw .c35}
---------------------------

[The controllers wrapper acts as the top level interface for the controllers. It instantiates two Controller modules and connects each one to separate TxD RxD lines. In addition, the Controllers wrapper handles passing the cs, addr, and rw lines into the controllers correctly. Both controllers receive an address of 0 for controller writes, while controller 1 will receive address 0 for reads and controller 2 will receive address 1. ]{.c7}

### [Controller Wrapper Diagram]{.c57 .c23} {#h.o12jcpl1v6h2 .c19}

[![](images/image16.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 431.00px; height: 271.48px;"}

### [Controller Wrapper Interface]{.c57 .c23} {#h.b5ap3afv7f57 .c15 .c123}

[]{#t.547db5e3cba569b697a57d71bdba389e98fcd63f}[]{#t.24}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c135}    | Type]{.c135}    | c135}           | c135}           |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [TxD1]{.c7}     | [output]{.c7}   | [UART]{.c7}     | [Transmit data  |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 1]{.c7}         |
+-----------------+-----------------+-----------------+-----------------+
| [TxD2]{.c7}     | [output]{.c7}   | [UART]{.c7}     | [Transmit data  |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 2]{.c7}         |
+-----------------+-----------------+-----------------+-----------------+
| [RxD1]{.c7}     | [input]{.c7}    | [UART]{.c7}     | [Receive data   |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 1]{.c7}         |
+-----------------+-----------------+-----------------+-----------------+
| [RxD2]{.c7}     | [input]{.c7}    | [UART]{.c7}     | [Receive data   |
|                 |                 |                 | line for        |
|                 |                 |                 | controller      |
|                 |                 |                 | 2]{.c7}         |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c7}     | [input]{.c7}    | [CPU]{.c7}      | [Controller     |
|                 |                 |                 | address, 0 for  |
|                 |                 |                 | \$4016, 1 for   |
|                 |                 |                 | \$4017]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [cpubus\[7:0\]] | [inout]{.c7}    | [CPU]{.c7}      | [Data from/to   |
| {.c7}           |                 |                 | the CPU]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [cs]{.c7}       | [input]{.c7}    | [CPU]{.c7}      | [Chip           |
|                 |                 |                 | select]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [rw]{.c7}       | [input]{.c7}    | [CPU]{.c7}      | [Read/Write     |
|                 |                 |                 | signal (high    |
|                 |                 |                 | for             |
|                 |                 |                 | reads)]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [rx\_data\_peek | [output]{.c7}   | [LEDR\[7:0\]]{. | [Output states  |
| ]{.c7}          |                 | c7}             | to the FPGA     |
|                 |                 |                 | LEDs to show    |
|                 |                 |                 | that input was  |
|                 |                 |                 | being           |
|                 |                 |                 | received]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [send\_states]{ | [input]{.c7}    | []{.c7}         | [When this      |
| .c7}            |                 |                 | signal goes     |
|                 |                 |                 | high, the       |
|                 |                 |                 | controller      |
|                 |                 |                 | begins          |
|                 |                 |                 | outputting RAM  |
|                 |                 |                 | data]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpuram\_q]{.c7 | [input]{.c7}    | [CPU RAM]{.c7}  | [Stored CPU     |
| }               |                 |                 | states from the |
|                 |                 |                 | RAM block]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_addr]{.c7} | [output]{.c7}   | [CPU RAM]{.c7}  | [The address    |
|                 |                 |                 | the controller  |
|                 |                 |                 | is writing out  |
|                 |                 |                 | to SPART]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd]{.c7}       | [output]{.c7}   | [CPU RAM]{.c7}  | [High when      |
|                 |                 |                 | controller is   |
|                 |                 |                 | reading from    |
|                 |                 |                 | CPU RAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[Controller]{.c22} {#h.ddzvq2rctlzt .c35}
------------------

[The controller module instantiates the Driver and SPART module’s.]{.c7}

### [Controller Diagram]{.c57 .c23} {#h.ml0lp3awxz0e .c35}

[![](images/image21.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 444.76px; height: 242.50px;"}

### [Controller Interface]{.c57 .c23} {#h.8148udv35isa .c35}

[]{#t.bb0222080501ccd3509902d3def0cd1f0ab3985c}[]{#t.25}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [TxD]{.c7}      | [output]{.c7}   | [UART]{.c7}     | [Transmit data  |
|                 |                 |                 | line]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [RxD]{.c7}      | [input]{.c7}    | [UART]{.c7}     | [Receive data   |
|                 |                 |                 | line]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [addr]{.c7}     | [input]{.c7}    | [CPU]{.c7}      | [Controller     |
|                 |                 |                 | address 0 for   |
|                 |                 |                 | \$4016, 1 for   |
|                 |                 |                 | \$4017]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [dout\[7:0\]]{. | [inout]{.c7}    | [CPU]{.c7}      | [Data from/to   |
| c7}             |                 |                 | the CPU]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [cs]{.c7}       | [input]{.c7}    | [CPU]{.c7}      | [Chip           |
|                 |                 |                 | select]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [rw]{.c7}       | [input]{.c7}    | [CPU]{.c7}      | [Read write     |
|                 |                 |                 | signal (low for |
|                 |                 |                 | writes)]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [rx\_data\_peek | [output]{.c7}   | [LEDR]{.c7}     | [Outputs button |
| ]{.c7}          |                 |                 | states to FPGA  |
|                 |                 |                 | LEDs]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [send\_states]{ | [input]{.c7}    | []{.c7}         | [When this      |
| .c7}            |                 |                 | signal goes     |
|                 |                 |                 | high, the       |
|                 |                 |                 | controller      |
|                 |                 |                 | begins          |
|                 |                 |                 | outputting RAM  |
|                 |                 |                 | data]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [cpuram\_q]{.c7 | [input]{.c7}    | [CPU RAM]{.c7}  | [Stored CPU     |
| }               |                 |                 | states from the |
|                 |                 |                 | RAM block]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_addr]{.c7} | [output]{.c7}   | [CPU RAM]{.c7}  | [The address    |
|                 |                 |                 | the controller  |
|                 |                 |                 | is writing out  |
|                 |                 |                 | to SPART]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd]{.c7}       | [output]{.c7}   | [CPU RAM]{.c7}  | [High when      |
|                 |                 |                 | controller is   |
|                 |                 |                 | reading from    |
|                 |                 |                 | CPU RAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[Special Purpose Asynchronous Receiver and Transmitter (SPART)]{.c22} {#h.fna8vaz47pc1 .c15 .c123}
---------------------------------------------------------------------

[The SPART Module is used to receive serial data. The SPART and driver share many interconnections in order to control the reception and transmission of data. On the left, the SPART interfaces to an 8- bit, 3-state bidirectional bus, DATABUS\[7:0\]. This bus is used to transfer data and control information between the driver and the SPART. In addition, there is a 2-bit address bus, IOADDR\[1:0\] which is used to select the particular register that interacts with the DATABUS during an I/O operation. The IOR/W signal determines the direction of data transfer between the driver and SPART. For a Read (IOR/W=1), data is transferred from the SPART to the driver and for a Write (IOR/W=0), data is transferred from the driver to the SPART. IOCS and IOR/W are crucial signals in properly controlling the three-state buffer on DATABUS within the SPART. Receive Data Available (RDA), is a status signal which indicates that a byte of data has been received and is ready to be read from the SPART to the Processor. When the read operation is performed, RDA is reset. Transmit Buffer Ready (TBR) is a status signal which indicates that the transmit buffer in the SPART is ready to accept a byte for transmission. When a write operation is performed and the SPART is not ready for more transmission data, TBR is reset. The SPART is fully synchronous with the clock signal CLK; this implies that transfers between the driver and SPART can be controlled by applying IOCS, IOR/W, IOADDR, and DATABUS (in the case of a write operation) for a single clock cycle and capturing the transferred data on the next positive clock edge. The received data on RxD, however, is asynchronous with respect]{.c188}[ ]{}[to CLK. Also, the serial I/O port on the workstation which receives the transmitted data from TxD has no access to CLK. This interface thus constitutes the “A” for “Asynchronous” in SPART and requires an understanding of RS-232 signal timing and (re)synchronization.]{.c188}

[SPART Diagram & Interface]{}

------------------------------------------------------------------------

[![](images/image11.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 491.16px; height: 308.00px;"}

[Controller Driver]{.c22} {#h.fxadt5ql4b59 .c15 .c123}
-------------------------

[The controller driver is tasked with reloading the controller button states from the SPART receiver buffer when address \$4016 (or \$0 from controller’s point of view) is set. In addition, the driver must grab the CPU databus on a read and place a button value on bit 0. On the first read, the button state of value A is placed on the databus, followed by B, Select, Start, Up, Down, Left, Right. The value will be 1 for pressed and 0 for not pressed. After reading the first 8 buttons, the driver will output a 0 on the databus. Lastly, the controller driver can also be used to control the SPART module to output to the UART port of the computer.]{.c7}

### [Controller Driver State Machine]{.c57 .c23} {#h.yma1hmwj1wcp .c35}

[![](images/image13.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 549.33px;"}

------------------------------------------------------------------------

[]{.c109 .c23} {#h.q1sq1qgr8jci .c132 .c123}
==============

8.  [VGA]{.c109 .c23} {#h.xrfacxsmruiq style="display:inline"}
    =================

[The VGA interface consists of sending the pixel data to the screen one row at a time from left to right. In between each row it requires a special signal called horizontal sync (hsync) to be asserted at a specific time when only black pixels are being sent, called the blanking interval. This happens until the bottom of the screen is reached when another blanking interval begins where the interface is only sending black pixels, but instead of hsync being asserted the vertical sync signal is asserted. ]{.c7}

[![](images/image23.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 350.00px; height: 266.00px;"}

[The main difficulty with the VGA interface will be designing a system to take the PPU output (a 256x240 image) and converting it into a native resolution of 640x480 or 1280x960. This was done by adding two RAM blocks to buffer the data.]{.c7}

[VGA Diagram]{.c22} {#h.7dmryvqi4l3b .c35}
-------------------

[![](images/image24.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 527.40px; height: 285.54px;"}

[VGA Interface]{.c22} {#h.7b41ivlnuec0 .c15 .c123}
---------------------

[]{#t.0b4df1c79bd101595fde9cf3c1fde60b0b71da17}[]{#t.26}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [V\_BLANK\_N]{. | [output]{.c7}   | []{.c7}         | [Syncing each   |
| c7}             |                 |                 | pixel]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_R\[7:0\]] | [output]{.c7}   | []{.c7}         | [Red pixel      |
| {.c7}           |                 |                 | value]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_G\[7:0\]] | [output]{.c7}   | []{.c7}         | [Green pixel    |
| {.c7}           |                 |                 | value]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_B\[7:0\]] | [output]{.c7}   | []{.c7}         | [Blue pixel     |
| {.c7}           |                 |                 | value]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_CLK]{.c7} | [output]{.c7}   | []{.c7}         | [VGA            |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_HS]{.c7}  | [output]{.c7}   | []{.c7}         | [Horizontal     |
|                 |                 |                 | line sync]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_SYNC\_N]{ | [output]{.c7}   | []{.c7}         | [0]{.c7}        |
| .c7}            |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_VS]{.c7}  | [output]{.c7}   | []{.c7}         | [Vertical line  |
|                 |                 |                 | sync]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [pixel\_data\[7 | [input]{.c7}    | [PPU]{.c7}      | [Pixel data to  |
| :0\]]{.c7}      |                 |                 | be sent to the  |
|                 |                 |                 | display]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [ppu\_clock]{.c | [input]{.c7}    | [PPU]{.c7}      | [pixel data is  |
| 7}              |                 |                 | updated every   |
|                 |                 |                 | ppu clock       |
|                 |                 |                 | cycle]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rendering]{.c7 | [input]{.c7}    | [PPU]{.c7}      | [high when PPU  |
| }               |                 |                 | is              |
|                 |                 |                 | rendering]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_end]{.c | [input]{.c7}    | [PPU]{.c7}      | [high at the    |
| 7}              |                 |                 | end of a PPU    |
|                 |                 |                 | frame]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_start]{ | [input]{.c7}    | [PPU]{.c7}      | [high at start  |
| .c7}            |                 |                 | of PPU          |
|                 |                 |                 | frame]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

[VGA Clock Gen]{.c22} {#h.w1ger0jiy8bk .c35}
---------------------

[This module takes in a 50MHz system clock and creates a 25.175MHz clock, which is the standard VGA clock speed.]{.c7}

[]{#t.db67cd3b6f294595ac31a0aea59a47ead9f1be93}[]{#t.27}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_CLK]{}    | [output]{}      | [VGA]{.c7}      | [Clock synced   |
|                 |                 |                 | to VGA          |
|                 |                 |                 | timing]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+
| [locked]{.c7}   | [output]{.c7}   | []{.c7}         | [Locks VGA      |
|                 |                 |                 | until clock is  |
|                 |                 |                 | ready]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+

[VGA Timing Gen]{.c22} {#h.pw3svolg7ia .c35}
----------------------

[This block is responsible for generating the timing signals for VGA with a screen resolution of 480x640. This includes the horizontal and vertical sync signals as well as the blank signal for each pixel.]{.c7}

[]{#t.479f40eaa1ae54a4dbe23dc6f8fb1ac9c0dbacf1}[]{#t.28}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_CLK]{.c7} | [input]{.c7}    | [Clock          | [vga\_clk]{.c7} |
|                 |                 | Gen]{.c7}       |                 |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [V\_BLANK\_N]{. | [output]{.c7}   | [VGA, Ram       | [Syncing each   |
| c7}             |                 | Reader]{.c7}    | pixel]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_HS]{.c7}  | [output]{.c7}   | [VGA]{.c7}      | [Horizontal     |
|                 |                 |                 | line sync]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_VS]{.c7}  | [output]{.c7}   | [VGA]{.c7}      | [Vertical line  |
|                 |                 |                 | sync]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+

[]{.c22} {#h.37cy90rx7ygb .c35 .c60}
--------

[VGA Display Plane]{.c22} {#h.em4ktvbwfn8k .c35}
-------------------------

[The PPU will output sprite and background pixels to the VGA module, as well as enables for each. The display plane will update the RAM block at the appropriate address with the pixel data on every PPU clock cycle when the PPU is rendering.]{.c7}

[]{#t.5a3c07c6be733afbbfea8913bd13a94fa777ca2d}[]{#t.29}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | [System         |
|                 |                 |                 | clock]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [ppu\_clock]{.c | [input]{.c7}    | [PPU]{.c7}      | [Clock speed    |
| 7}              |                 |                 | that the pixels |
|                 |                 |                 | from the PPU    |
|                 |                 |                 | come in]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_address]{. | [input]{.c7}    | [RAM]{.c7}      | [Address to     |
| c7}             |                 |                 | write to]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_req]{.c7}  | [output]{.c7}   | [RAM]{.c7}      | [Write data to  |
|                 |                 |                 | the RAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[7:0 | [output]{.c7}   | [RAM]{.c7}      | [The pixel data |
| \]]{.c7}        |                 |                 | to store in     |
|                 |                 |                 | RAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [pixel\_data\[7 | [input]{.c7}    | [PPU]{.c7}      | [Pixel data to  |
| :0\]]{.c7}      |                 |                 | be sent to the  |
|                 |                 |                 | display]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [rendering]{.c7 | [input]{.c7}    | [PPU]{.c7}      | [high when PPU  |
| }               |                 |                 | is              |
|                 |                 |                 | rendering]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [frame\_start]{ | [input]{.c7}    | [PPU]{.c7}      | [high at start  |
| .c7}            |                 |                 | of PPU          |
|                 |                 |                 | frame]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+

[]{.c22} {#h.df616f9pyhcf .c35 .c60}
--------

[VGA RAM Wrapper]{.c22} {#h.68btkfb1o5ru .c35}
-----------------------

[This module instantiates two 2-port RAM blocks and using control signals, it will have the PPU write to a specific RAM block, while the VGA reads from another RAM block. The goal of this module was to make sure that the PPU writes never overlap the VGA reads, because the PPU runs at a faster clock rate. ]{.c7}

[]{#t.73d8ab931bb1de11920ee6fbbb98ace8684a3d59}[]{#t.30}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | []{.c7}         |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_address]{. | [input]{.c7}    | [Display        | [Address to     |
| c7}             |                 | Plane]{.c7}     | write to]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [wr\_req]{.c7}  | [input]{.c7}    | [Display        | [Request to     |
|                 |                 | Plane]{.c7}     | write           |
|                 |                 |                 | data]{.c7}      |
+-----------------+-----------------+-----------------+-----------------+
| [data\_in\[5:0\ | [input]{.c7}    | [Display        | [The data into  |
| ]]{.c7}         |                 | Plane]{.c7}     | the RAM]{.c7}   |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_req]{.c7}  | [input]{.c7}    | [RAM            | [Read data out  |
|                 |                 | Reader]{.c7}    | from RAM]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_address]{. | [input]{.c7}    | [RAM            | [Address to     |
| c7}             |                 | Reader]{.c7}    | read from]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[5:0 | [output]{.c7}   | [RAM            | [data out from  |
| \]]{.c7}        |                 | Reader]{.c7}    | RAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [ppu\_frame\_en | [input]{.c7}    | [PPU]{.c7}      | [high at the    |
| d]{.c7}         |                 |                 | end of a PPU    |
|                 |                 |                 | frame]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [vga\_frame\_en | [input]{.c7}    | [VGA]{.c7}      | [high at end of |
| d]{.c7}         |                 |                 | VGA frame]{.c7} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c22} {#h.jz3qq69r11pa .c35 .c60}
--------

[VGA RAM Reader]{.c22} {#h.1cvttmqqni8n .c123 .c139}
----------------------

[The RAM Reader is responsible for reading data from the correct address in the RAM block and outputting it as an RGB signal to the VGA. It will update the RGB signals every time the blank signal goes high. The NES supported a 256x240 image, which we will be converting to a 640x480 image. This means that the 256x240 image will be multiplied by 2, resulting in a 512x480 image. The remaining 128 pixels on the horizontal line will be filled with black pixels by this block. Lastly, this block will take use the pixel data from the PPU and the NES Palette RGB colors, to output the correct colors to the VGA.]{.c7}

[]{.c7}

[]{.c7}

[]{#t.42c807ab21e38b5395f49bf60866dd95219157f1}[]{#t.31}

+-----------------+-----------------+-----------------+-----------------+
| [Signal         | [Signal         | [Source/Dest]{. | [Description]{. |
| name]{.c30}     | Type]{.c30}     | c30}            | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [clk]{.c7}      | [input]{.c7}    | []{.c7}         | []{.c7}         |
+-----------------+-----------------+-----------------+-----------------+
| [rst\_n]{.c7}   | [input]{.c7}    | []{.c7}         | [System active  |
|                 |                 |                 | low reset]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_req]{.c7}  | [output]{.c7}   | [RAM]{.c7}      | [Read data out  |
|                 |                 |                 | from RAM]{.c7}  |
+-----------------+-----------------+-----------------+-----------------+
| [rd\_address]{. | [output]{.c7}   | [RAM]{.c7}      | [Address to     |
| c7}             |                 |                 | read from]{.c7} |
+-----------------+-----------------+-----------------+-----------------+
| [data\_out\[7:0 | [input]{.c7}    | [RAM]{.c7}      | [data out from  |
| \]]{.c7}        |                 |                 | RAM]{.c7}       |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_R\[7:0\]] | [output]{.c7}   | []{.c7}         | [VGA Red pixel  |
| {.c7}           |                 |                 | value]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_G\[7:0\]] | [output]{.c7}   | []{.c7}         | [VGA Green      |
| {.c7}           |                 |                 | pixel           |
|                 |                 |                 | value]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_B\[7:0\]] | [output]{.c7}   | []{.c7}         | [VGA Blue pixel |
| {.c7}           |                 |                 | value]{.c7}     |
+-----------------+-----------------+-----------------+-----------------+
| [VGA\_Blnk\[7:0 | [input]{.c7}    | [Time Gen]{.c7} | [VGA Blank      |
| \]]{.c7}        |                 |                 | signal (high    |
|                 |                 |                 | when we write   |
|                 |                 |                 | each new        |
|                 |                 |                 | pixel)]{.c7}    |
+-----------------+-----------------+-----------------+-----------------+

------------------------------------------------------------------------

[]{.c109 .c23} {#h.mtl1jtr6nihn .c132 .c123}
==============

9.  [Software]{.c109 .c23} {#h.zbj1aj20rigt style="display:inline"}
    ======================

[Controller Simulator]{.c22} {#h.ik7f7bcto722 .c35}
----------------------------

[In order to play games on the NES and provide input to our FPGA, we will have a java program that uses the JSSC (Java Simple Serial Connector) library to read and write data serially using the SPART interface. The program will provides a GUI that was created using the JFrame library. This GUI will respond to mouse clicks as well as key presses when the window is in focus. When a button state on the simulator is changed, it will trigger the program to send serial data. When data is detected on the rx line, the simulator will read in the data (every time there is 8 bytes in the buffer) and will output this data as a CPU trace to an output file. Instructions to invoke this program can be found in the README file of our github directory.]{.c7}

### [Controller Simulator State Machine ]{.c57 .c23} {#h.ev3eyvc4m806 .c35}

[![](images/image25.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 346.76px; height: 336.00px;"}

### [Controller Simulator Output Packet Format]{.c57 .c23} {#h.xqfqy7n0dj86 .c139 .c123}

[]{#t.ad9e3dcf59b3c7f193497b3a552afdad72d4c697}[]{#t.32}

+-----------------+-----------------+-----------------+-----------------+
| [Packet         | [Packet         | [Packet         | [Description]{. |
| name]{.c30}     | type]{.c30}     | Format]{.c30}   | c30}            |
+-----------------+-----------------+-----------------+-----------------+
| [Controller     | [output]{.c7}   | [ABST-UDLR]{.c7 | [This packet    |
| Data]{.c7}      |                 | }               | indicates which |
|                 |                 |                 | buttons are     |
|                 |                 |                 | being pressed.  |
|                 |                 |                 | A 1 indicates   |
|                 |                 |                 | pressed, a 0    |
|                 |                 |                 | indicates not   |
|                 |                 |                 | pressed. ]{.c7} |
|                 |                 |                 |                 |
|                 |                 |                 | [(A) A button,  |
|                 |                 |                 | (B) B button,   |
|                 |                 |                 | (S) Select      |
|                 |                 |                 | button, (T)     |
|                 |                 |                 | Start button,   |
|                 |                 |                 | (U) Up, (D)     |
|                 |                 |                 | Down, (L) Left, |
|                 |                 |                 | (R) Right]{.c7} |
+-----------------+-----------------+-----------------+-----------------+

[]{.c7}

### [Controller Simulator GUI and Button Map]{.c57 .c23} {#h.wqujxd9v8i1y .c139 .c123}

[The NES controller had a total of 8 buttons, as shown below.]{.c7}

[![](images/image4.png)]{style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 257.33px;"}

[The NES buttons will be mapped to specific keys on the keyboard. The keyboard information will be obtained using KeyListeners in the java.awt.\* library. The following table indicates how the buttons are mapped and their function in Super Mario Bros.]{.c7}

[]{#t.ad380988598047a9ceb5cfe38e7d802123c4d7be}[]{#t.33}

+-----------------------+-----------------------+-----------------------+
| [Keyboard             | [NES                  | [Super Mario Bros.    |
| button]{.c30}         | Equivalent]{.c30}     | Function]{.c30}       |
+-----------------------+-----------------------+-----------------------+
| [X Key]{.c7}          | [A Button]{.c7}       | [Jump (Hold to jump   |
|                       |                       | higher)]{.c7}         |
+-----------------------+-----------------------+-----------------------+
| [Z Key]{.c7}          | [B Button]{.c7}       | [Sprint (Hold and use |
|                       |                       | arrow keys)]{.c7}     |
+-----------------------+-----------------------+-----------------------+
| [Tab Key]{.c7}        | [Select Button]{.c7}  | [Pause Game]{.c7}     |
+-----------------------+-----------------------+-----------------------+
| [Enter Key]{}         | [Start Button]{}      | [Start Game]{}        |
+-----------------------+-----------------------+-----------------------+
| [Up Arrow]{.c7}       | [Up on D-Pad]{.c7}    | [No function]{.c7}    |
+-----------------------+-----------------------+-----------------------+
| [Down Arrow]{.c7}     | [Down on D-Pad]{.c7}  | [Enter pipe (only     |
|                       |                       | works on some         |
|                       |                       | pipes)]{.c7}          |
+-----------------------+-----------------------+-----------------------+
| [Left Arrow]{.c7}     | [Left on D-Pad]{.c7}  | [Move left]{.c7}      |
+-----------------------+-----------------------+-----------------------+
| [Right Arrow]{.c7}    | [Right on D-Pad]{.c7} | [Move right]{.c7}     |
+-----------------------+-----------------------+-----------------------+

[]{.c7}

[Assembler]{.c22} {#h.t5xpa0jvlbyf .c35}
-----------------

[We will include an assembler that allows custom software to be developed for our console. This assembler will convert assembly code to machine code for the NES on .mif files that we can load into our FPGA. It will include support for labels and commenting.The ISA is specified in the table below:]{.c7}

[]{.c7}

### [Opcode Table]{.c57 .c23} {#h.rp3i11uarg1 .c35}

[]{#t.a78dffae99888f28a7d901ca905aed1ef15fecc7}[]{#t.34}

+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [Opco | [Mode | [Hex] | [Opco | [Mode | [Hex] | [Opco | [Mode | [Hex] |
| de]{. | ]{.c1 | {.c23 | de]{. | ]{.c1 | {.c12 | de]{. | ]{.c1 | {.c12 |
| c122  | 22    | .c122 | c122  | 22    | 2     | c122  | 22    | 2     |
| .c23} | .c23} | }     | .c23} | .c23} | .c23} | .c23} | .c23} | .c23} |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Imme | [69]{ | [DEC] | [Zero | [C6]{ | [ORA] | [Abso | [0D]{ |
| {.c7} | diate | .c7}  | {.c7} | Page] | .c7}  | {.c7} | lute] | .c7}  |
|       | ]{.c7 |       |       | {.c7} |       |       | {.c7} |       |
|       | }     |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Zero | [65]{ | [DEC] | [Zero | [D6]{ | [ORA] | [Abso | [1D]{ |
| {.c7} | Page] | .c7}  | {.c7} | Page, | .c7}  | {.c7} | lute, | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Zero | [75]{ | [DEC] | [Abso | [CE]{ | [ORA] | [Abso | [19]{ |
| {.c7} | Page, | .c7}  | {.c7} | lute] | .c7}  | {.c7} | lute, | .c7}  |
|       | X]{.c |       |       | {.c7} |       |       | Y]{.c |       |
|       | 7}    |       |       |       |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Abso | [6D]{ | [DEC] | [Abso | [DE]{ | [ORA] | [Indi | [01]{ |
| {.c7} | lute] | .c7}  | {.c7} | lute, | .c7}  | {.c7} | rect, | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Abso | [7D]{ | [DEX] | [Impl | [CA]{ | [ORA] | [Indi | [11]{ |
| {.c7} | lute, | .c7}  | {.c7} | ied]{ | .c7}  | {.c7} | rect, | .c7}  |
|       | X]{.c |       |       | .c7}  |       |       | Y]{.c |       |
|       | 7}    |       |       |       |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Abso | [79]{ | [DEY] | [Impl | [88]{ | [PHA] | [Impl | [48]{ |
| {.c7} | lute, | .c7}  | {.c7} | ied]{ | .c7}  | {.c7} | ied]{ | .c7}  |
|       | Y]{.c |       |       | .c7}  |       |       | .c7}  |       |
|       | 7}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Indi | [61]{ | [EOR] | [Imme | [49]{ | [PHP] | [Impl | [08]{ |
| {.c7} | rect, | .c7}  | {.c7} | diate | .c7}  | {.c7} | ied]{ | .c7}  |
|       | X]{.c |       |       | ]{.c7 |       |       | .c7}  |       |
|       | 7}    |       |       | }     |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ADC] | [Indi | [71]{ | [EOR] | [Zero | [45]{ | [PLA] | [Impl | [68]{ |
| {.c7} | rect, | .c7}  | {.c7} | Page] | .c7}  | {.c7} | ied]{ | .c7}  |
|       | Y]{.c |       |       | {.c7} |       |       | .c7}  |       |
|       | 7}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Imme | [29]{ | [EOR] | [Zero | [55]{ | [PLP] | [Impl | [28]{ |
| {.c7} | diate | .c7}  | {.c7} | Page, | .c7}  | {.c7} | ied]{ | .c7}  |
|       | ]{.c7 |       |       | X]{.c |       |       | .c7}  |       |
|       | }     |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Zero | [25]{ | [EOR] | [Abso | [4D]{ | [ROL] | [Accu | [2A]{ |
| {.c7} | Page] | .c7}  | {.c7} | lute] | .c7}  | {.c7} | mulat | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | or]{. |       |
|       |       |       |       |       |       |       | c7}   |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Zero | [35]{ | [EOR] | [Abso | [5D]{ | [ROL] | [Zero | [26]{ |
| {.c7} | Page, | .c7}  | {.c7} | lute, | .c7}  | {.c7} | Page] | .c7}  |
|       | X]{.c |       |       | X]{.c |       |       | {.c7} |       |
|       | 7}    |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Abso | [2D]{ | [EOR] | [Abso | [59]{ | [ROL] | [Zero | [36]{ |
| {.c7} | lute] | .c7}  | {.c7} | lute, | .c7}  | {.c7} | Page, | .c7}  |
|       | {.c7} |       |       | Y]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Abso | [3D]{ | [EOR] | [Indi | [41]{ | [ROL] | [Abso | [2E]{ |
| {.c7} | lute, | .c7}  | {.c7} | rect, | .c7}  | {.c7} | lute] | .c7}  |
|       | X]{.c |       |       | X]{.c |       |       | {.c7} |       |
|       | 7}    |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Abso | [39]{ | [EOR] | [Indi | [51]{ | [ROL] | [Abso | [3E]{ |
| {.c7} | lute, | .c7}  | {.c7} | rect, | .c7}  | {.c7} | lute, | .c7}  |
|       | Y]{.c |       |       | Y]{.c |       |       | X]{.c |       |
|       | 7}    |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Indi | [21]{ | [INC] | [Zero | [E6]{ | [ROR] | [Accu | [6A]{ |
| {.c7} | rect, | .c7}  | {.c7} | Page] | .c7}  | {.c7} | mulat | .c7}  |
|       | X]{.c |       |       | {.c7} |       |       | or]{. |       |
|       | 7}    |       |       |       |       |       | c7}   |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [AND] | [Indi | [31]{ | [INC] | [Zero | [F6]{ | [ROR] | [Zero | [66]{ |
| {.c7} | rect, | .c7}  | {.c7} | Page, | .c7}  | {.c7} | Page] | .c7}  |
|       | Y]{.c |       |       | X]{.c |       |       | {.c7} |       |
|       | 7}    |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Accu | [0A]{ | [INC] | [Abso | [EE]{ | [ROR] | [Zero | [76]{ |
| {.c7} | mulat | .c7}  | {.c7} | lute] | .c7}  | {.c7} | Page, | .c7}  |
|       | or]{. |       |       | {.c7} |       |       | X]{.c |       |
|       | c7}   |       |       |       |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Zero | [06]{ | [INC] | [Abso | [FE]{ | [ROR] | [Abso | [6E]{ |
| {.c7} | Page] | .c7}  | {.c7} | lute, | .c7}  | {.c7} | lute] | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | {.c7} |       |
|       |       |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Zero | [16]{ | [INX] | [Impl | [E8]{ | [ROR] | [Abso | [7E]{ |
| {.c7} | Page, | .c7}  | {.c7} | ied]{ | .c7}  | {.c7} | lute, | .c7}  |
|       | X]{.c |       |       | .c7}  |       |       | X]{.c |       |
|       | 7}    |       |       |       |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Abso | [0E]{ | [INY] | [Impl | [C8]{ | [RTI] | [Impl | [40]{ |
| {.c7} | lute] | .c7}  | {.c7} | ied]{ | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | .c7}  |       |       | .c7}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [ASL] | [Abso | [1E]{ | [JMP] | [Indi | [6C]{ | [RTS] | [Impl | [60]{ |
| {.c7} | lute, | .c7}  | {.c7} | rect] | .c7}  | {.c7} | ied]{ | .c7}  |
|       | X]{.c |       |       | {.c7} |       |       | .c7}  |       |
|       | 7}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BCC] | [Rela | [90]{ | [JMP] | [Abso | [4C]{ | [SBC] | [Imme | [E9]{ |
| {.c7} | tive] | .c7}  | {.c7} | lute  | .c7}  | {.c7} | diate | .c7}  |
|       | {.c7} |       |       | ]{.c7 |       |       | ]{.c7 |       |
|       |       |       |       | }     |       |       | }     |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BCS] | [Rela | [B0]{ | [JSR] | [Abso | [20]{ | [SBC] | [Zero | [E5]{ |
| {.c7} | tive] | .c7}  | {.c7} | lute] | .c7}  | {.c7} | Page] | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | {.c7} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BEQ] | [Rela | [F0]{ | [LDA] | [Imme | [A9]{ | [SBC] | [Zero | [F5]{ |
| {.c7} | tive] | .c7}  | {.c7} | diate | .c7}  | {.c7} | Page, | .c7}  |
|       | {.c7} |       |       | ]{.c7 |       |       | X]{.c |       |
|       |       |       |       | }     |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BIT] | [Zero | [24]{ | [LDA] | [Zero | [A5]{ | [SBC] | [Abso | [ED]{ |
| {.c7} | Page] | .c7}  | {.c7} | Page] | .c7}  | {.c7} | lute] | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | {.c7} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BIT] | [Abso | [2C]{ | [LDA] | [Zero | [B5]{ | [SBC] | [Abso | [FD]{ |
| {.c7} | lute] | .c7}  | {.c7} | Page, | .c7}  | {.c7} | lute, | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BMI] | [Rela | [30]{ | [LDA] | [Abso | [AD]{ | [SBC] | [Abso | [F9]{ |
| {.c7} | tive] | .c7}  | {.c7} | lute] | .c7}  | {.c7} | lute, | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | Y]{.c |       |
|       |       |       |       |       |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BNE] | [Rela | [D0]{ | [LDA] | [Abso | [BD]{ | [SBC] | [Indi | [E1]{ |
| {.c7} | tive] | .c7}  | {.c7} | lute, | .c7}  | {.c7} | rect, | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BPL] | [Rela | [10]{ | [LDA] | [Abso | [B9]{ | [SBC] | [Indi | [F1]{ |
| {.c7} | tive] | .c7}  | {.c7} | lute, | .c7}  | {.c7} | rect, | .c7}  |
|       | {.c7} |       |       | Y]{.c |       |       | Y]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BRK] | [Impl | [00]{ | [LDA] | [Indi | [A1]{ | [SEC] | [Impl | [38]{ |
| {.c7} | ied]{ | .c7}  | {.c7} | rect, | .c7}  | {.c7} | ied]{ | .c7}  |
|       | .c7}  |       |       | X]{.c |       |       | .c7}  |       |
|       |       |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BVC] | [Rela | [50]{ | [LDA] | [Indi | [B1]{ | [SED] | [Impl | [F8]{ |
| {.c7} | tive] | .c7}  | {.c7} | rect, | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | Y]{.c |       |       | .c7}  |       |
|       |       |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [BVS] | [Rela | [70]{ | [LDX] | [Imme | [A2]{ | [SEI] | [Impl | [78]{ |
| {.c7} | tive] | .c7}  | {.c7} | diate | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | ]{.c7 |       |       | .c7}  |       |
|       |       |       |       | }     |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLC] | [Impl | [18]{ | [LDX] | [Zero | [A6]{ | [STA] | [Zero | [85]{ |
| {.c7} | ied]{ | .c7}  | {.c7} | Page] | .c7}  | {.c7} | Page] | .c7}  |
|       | .c7}  |       |       | {.c7} |       |       | {.c7} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLD] | [Impl | [D8]{ | [LDX] | [Zero | [B6]{ | [STA] | [Zero | [95]{ |
| {.c7} | ied]{ | .c7}  | {.c7} | Page, | .c7}  | {.c7} | Page, | .c7}  |
|       | .c7}  |       |       | Y]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLI] | [Impl | [58]{ | [LDX] | [Abso | [AE]{ | [STA] | [Abso | [8D]{ |
| {.c7} | ied]{ | .c7}  | {.c7} | lute] | .c7}  | {.c7} | lute] | .c7}  |
|       | .c7}  |       |       | {.c7} |       |       | {.c7} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CLV] | [Impl | [B8]{ | [LDX] | [Abso | [BE]{ | [STA] | [Abso | [9D]{ |
| {.c7} | ied]{ | .c7}  | {.c7} | lute, | .c7}  | {.c7} | lute, | .c7}  |
|       | .c7}  |       |       | Y]{.c |       |       | X]{.c |       |
|       |       |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Imme | [C9]{ | [LDY] | [Imme | [A0]{ | [STA] | [Abso | [99]{ |
| {.c7} | diate | .c7}  | {.c7} | diate | .c7}  | {.c7} | lute, | .c7}  |
|       | ]{.c7 |       |       | ]{.c7 |       |       | Y]{.c |       |
|       | }     |       |       | }     |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Zero | [C5]{ | [LDY] | [Zero | [A4]{ | [STA] | [Indi | [81]{ |
| {.c7} | Page] | .c7}  | {.c7} | Page] | .c7}  | {.c7} | rect, | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | X]{.c |       |
|       |       |       |       |       |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Zero | [D5]{ | [LDY] | [Zero | [B4]{ | [STA] | [Indi | [91]{ |
| {.c7} | Page, | .c7}  | {.c7} | Page, | .c7}  | {.c7} | rect, | .c7}  |
|       | X]{.c |       |       | X]{.c |       |       | Y]{.c |       |
|       | 7}    |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Abso | [CD]{ | [LDY] | [Abso | [AC]{ | [STX] | [Zero | [86]{ |
| {.c7} | lute] | .c7}  | {.c7} | lute] | .c7}  | {.c7} | Page] | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | {.c7} |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Abso | [DD]{ | [LDY] | [Abso | [BC]{ | [STX] | [Zero | [96]{ |
| {.c7} | lute, | .c7}  | {.c7} | lute, | .c7}  | {.c7} | Page, | .c7}  |
|       | X]{.c |       |       | X]{.c |       |       | Y]{.c |       |
|       | 7}    |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Abso | [D9]{ | [LSR] | [Accu | [4A]{ | [STX] | [Abso | [8E]{ |
| {.c7} | lute, | .c7}  | {.c7} | mulat | .c7}  | {.c7} | lute] | .c7}  |
|       | Y]{.c |       |       | or]{. |       |       | {.c7} |       |
|       | 7}    |       |       | c7}   |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Indi | [C1]{ | [LSR] | [Zero | [46]{ | [STY] | [Zero | [84]{ |
| {.c7} | rect, | .c7}  | {.c7} | Page] | .c7}  | {.c7} | Page] | .c7}  |
|       | X]{.c |       |       | {.c7} |       |       | {.c7} |       |
|       | 7}    |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CMP] | [Indi | [D1]{ | [LSR] | [Zero | [56]{ | [STY] | [Zero | [94]{ |
| {.c7} | rect, | .c7}  | {.c7} | Page, | .c7}  | {.c7} | Page, | .c7}  |
|       | Y]{.c |       |       | X]{.c |       |       | X]{.c |       |
|       | 7}    |       |       | 7}    |       |       | 7}    |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPX] | [Imme | [E0]{ | [LSR] | [Abso | [4E]{ | [STY] | [Abso | [8C]{ |
| {.c7} | diate | .c7}  | {.c7} | lute] | .c7}  | {.c7} | lute] | .c7}  |
|       | ]{.c7 |       |       | {.c7} |       |       | {.c7} |       |
|       | }     |       |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPX] | [Zero | [E4]{ | [LSR] | [Abso | [5E]{ | [TAX] | [Impl | [AA]{ |
| {.c7} | Page] | .c7}  | {.c7} | lute, | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | .c7}  |       |
|       |       |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPX] | [Abso | [EC]{ | [NOP] | [Impl | [EA]{ | [TAY] | [Impl | [A8]{ |
| {.c7} | lute] | .c7}  | {.c7} | ied]{ | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | .c7}  |       |       | .c7}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPY] | [Imme | [C0]{ | [ORA] | [Imme | [09]{ | [TSX] | [Impl | [BA]{ |
| {.c7} | diate | .c7}  | {.c7} | diate | .c7}  | {.c7} | ied]{ | .c7}  |
|       | ]{.c7 |       |       | ]{.c7 |       |       | .c7}  |       |
|       | }     |       |       | }     |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPY] | [Zero | [C4]{ | [ORA] | [Zero | [05]{ | [TXA] | [Impl | [8A]{ |
| {.c7} | Page] | .c7}  | {.c7} | Page] | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | {.c7} |       |       | .c7}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| [CPY] | [Abso | [CC]{ | [ORA] | [Zero | [15]{ | [TXS] | [Impl | [9A]{ |
| {.c7} | lute] | .c7}  | {.c7} | Page, | .c7}  | {.c7} | ied]{ | .c7}  |
|       | {.c7} |       |       | X]{.c |       |       | .c7}  |       |
|       |       |       |       | 7}    |       |       |       |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| []{.c | []{.c | []{.c | []{.c | []{.c | []{.c | [TYA] | [Impl | [98]{ |
| 7}    | 7}    | 7}    | 7}    | 7}    | 7}    | {.c7} | ied]{ | .c7}  |
|       |       |       |       |       |       |       | .c7}  |       |
+-------+-------+-------+-------+-------+-------+-------+-------+-------+

### [NES Assembly Formats]{.c57 .c23} {#h.fji30zo8qmh .c35}

[Our assembler will allow the following input format, each instruction/label will be on its own line. In addition unlimited whitespace is allowed:]{.c7}

[]{#t.785c03daa4e813953d8cbf70f3d9e2ff7a6c8246}[]{#t.35}

[Instruction Formats]{.c30}

[Instruction Type]{.c30}

[Format]{.c30}

[Description]{.c30}

[Constant]{.c7}

[Constant\_Name = &lt;Constant Value&gt;]{.c7}

[Must be declared before CPU\_Start]{.c7}

[Label]{.c7}

[Label\_Name:]{.c7}

[Cannot be the same as an opcode name. Allows reference from branch opcodes.]{.c7}

[Comment]{.c7}

[; Comment goes here]{.c7}

[Anything after the ; will be ignored]{.c7}

[CPU Start]{.c7}

[\_CPU:]{.c7}

[Signals the start of CPU memory]{.c7}

[Accumulator]{.c7}

[&lt;OPCODE&gt;]{.c7}

[Accumulator is value affected by Opcode]{.c7}

[Implied]{.c7}

[&lt;OPCODE&gt;]{.c7}

[Operands implied by opcode. ie. TXA has X as source and Accumulator as destination]{.c7}

[Immediate]{.c7}

[&lt;OPCODE&gt; \#&lt;Immediate&gt;]{.c7}

[The decimal number will be converted to binary and used as operand]{.c7}

[Absolute]{.c7}

[&lt;OPCODE&gt; \$&lt;ADDR/LABEL&gt;]{.c7}

[The byte at the specified address is used as operand]{.c7}

[Zero Page]{.c7}

[&lt;OPCODE&gt; \$&lt;BYTE OFFSET&gt;]{.c7}

[The byte at address \$00XX is used as operand.]{.c7}

[Relative]{.c7}

[&lt;OPCODE&gt; \$&lt;BYTE OFFSET/LABEL&gt;]{.c7}

[The byte at address PC +/- Offset is used as operand. Offset can range -128 to +127]{.c7}

[Absolute Index]{.c7}

[&lt;OPCODE&gt; \$&lt;ADDR/LABEL&gt;,&lt;X or Y&gt;]{.c7}

[Absolute but value in register added to address.]{.c7}

[Zero Page Index]{.c7}

[&lt;OPCODE&gt; \$&lt;BYTE OFFSET&gt;,&lt;X or Y&gt;]{.c7}

[Zero page but value in register added to offset.]{.c7}

[Zero Page X Indexed Indirect]{.c7}

[&lt;OPCODE&gt; (\$&lt;BYTE OFFSET&gt;,X)]{.c7}

[Value in X added to offset. Address in \$00XX (where XX is new offset) is used as the address for the operand.]{.c7}

[Zero Page Y Indexed Indirect]{.c7}

[&lt;OPCODE&gt; (\$&lt;BYTE OFFSET&gt;),Y]{.c7}

[The address in \$00XX, where XX is byte offset, is added to the value in Y and is used as the address for the operand.]{.c7}

[Data instruction]{.c7}

[&lt;.DB or .DW&gt; &lt;data values&gt;]{.c7}

[If .db then the data values must be bytes, if .dw then the data values must be 2 bytes. Multiple comma separated data values can be include for each instruction. Constants are valid.]{.c7}

[]{.c7}

[]{.c7}

[]{#t.1cff97851711fad7eb43d3937b11aea5c574f346}[]{#t.36}

[Number Formats]{.c30}

[Immediate Decimal (Signed)]{.c7}

[\#&lt;(-)DDD&gt;]{.c7}

[Max 127, Min -128]{.c7}

[Immediate Hexadecimal (Signed)]{.c7}

[\#\$&lt;HH&gt;]{.c7}

[]{.c7}

[Immediate Binary (Signed)]{.c7}

[\#%&lt;BBBB.BBBB&gt;]{.c7}

[Allows ‘.’ in between bits]{.c7}

[Address/Offset Hex]{.c7}

[\$&lt;Addr/Offset&gt;]{.c7}

[8 bits offset, 16 bits address]{.c7}

[Address/Offset Binary]{.c7}

[\$%&lt;Addr/Offset&gt;]{.c7}

[8 bits offset, 16 bits address]{.c7}

[Offset Decimal (Relative only)]{.c7}

[\#&lt;(-)DDD&gt;]{.c7}

[Relative instructions can’t be Immediate, so this is allowed.]{.c7}

[Max 127, Min -128]{.c7}

[Constant first byte]{.c7}

[&lt;Constant\_Name]{.c7}

[]{.c7}

[Constant second byte]{.c7}

[&gt;Constant\_Name]{.c7}

[]{.c7}

[Constant]{.c7}

[Constant\_Name]{.c7}

[]{.c7}

[Label]{.c7}

[Label\_Name]{.c7}

[Not valid for data instructions]{.c7}

### []{.c57 .c23} {#h.vf2hcrvkp1k3 .c139 .c39 .c123}

### [Invoking Assembler]{.c57 .c23} {#h.1ftppbjfbpv9 .c139 .c123}

[]{#t.6f668fdd16c4e436778a938b5c4f34d93bcf4744}[]{#t.37}

+-----------------------------------+-----------------------------------+
| [Usage]{.c30}                     | [Description]{.c30}               |
+-----------------------------------+-----------------------------------+
| [java NESAssemble &lt;input       | [Reads the input file and outputs |
| file&gt; &lt;cpuouput.mif&gt;     | the CPU ROM to cpuoutput.mif and  |
| &lt;ppuoutput.mif&gt;]{.c7}       | the PPU ROM to                    |
|                                   | ppuoutput.mif]{.c7}               |
+-----------------------------------+-----------------------------------+

[]{.c7}

[ iNES ROM Converter]{.c22} {#h.ekqczej5ygn6 .c35}
---------------------------

[Most NES games are currently available online in files of the iNES format, a header format used by most software NES emulators. Our NES will not support this file format. Instead, we will write a java program that takes an iNES file as input and outputs two .mif files that contain the CPU RAM and the PPU VRAM. These files will be used to instantiate the ROM’s of the CPU and PPU in our FPGA.]{.c7}

[]{#t.634ae5c55415151724744d13c7cc9c9a4d7dbd40}[]{#t.38}

+-----------------------------------+-----------------------------------+
| [Usage]{.c30}                     | [Description]{.c30}               |
+-----------------------------------+-----------------------------------+
| [java NEStoMIF &lt;input.nes&gt;  | [Reads the input file and outputs |
| &lt;cpuouput.mif&gt;              | the CPU RAM to cpuoutput.mif and  |
| &lt;ppuoutput.mif&gt;]{.c7}       | the PPU VRAM to                   |
|                                   | ppuoutput.mif]{.c7}               |
+-----------------------------------+-----------------------------------+

[]{.c7}

[ Tic Tac Toe]{.c22} {#h.syub5w8xzigk .c19}
--------------------

[We also implemented Tic Tac Toe in assembly for initial integration tests. We bundled it into a NES ROM, and thus can run it on existing emulators as well as our own hardware.]{.c7}

10. [Testing & Debug]{.c109 .c23} {#h.pefw11g7x04z style="display:inline"}
    =============================

[Our debugging process had multiple steps]{.c7}

[Simulation]{.c22} {#h.i9v97r1jowjk .c35}
------------------

[For basic sanity check, we simulated each module independently to make sure the signals behave as expected.]{.c7}

[Test]{.c22} {#h.s28dapnuwz93 .c35}
------------

[For detailed check, we wrote an automated testbench to confirm the functionality. The CPU test suite was from ]{}[[https://github.com/Klaus2m5/](https://www.google.com/url?q=https://github.com/Klaus2m5/&sa=D&ust=1494576244503000&usg=AFQjCNE1JiHYAJCYI_1k7L-Si52PIFKh4g){.c24}]{.c62}[ and we modified the test suite to run on the fceux NES emulator.]{}

[I]{}[ntegrated Simulation]{.c22} {#h.mv68y8tja9lo .c35}
---------------------------------

[After integration, we simulated the whole system with the ROM installed. We were able to get a detailed information at each cycle but the simulation took too long. It took about 30 minutes to simulate CPU operation for one second. Thus we designed a debug and trace module in hardware that could output CPU traces during actual gameplay..]{.c7}

[Tracer]{.c22} {#h.xldwn1zb9fzw .c35}
--------------

[We added additional code in Controller so that the Controller can store information at every cycle and dump them back to the serial console under some condition. At first, we used a button as the trigger, but after]{}[ we analyzed the exact problem, we used a conditional statement(for e.g. when PC reached a certain address) to trigger the dump. When the condition was met, the Controller would stall the CPU and start dumping what the CPU has been doing, in the opposite order of execution. The technique was extremely useful because we came to the conclusion that there must be a design defect when Mario crashed, such as using don’t cares or high impedance. After we corrected the defect, we were able to run Mario.]{}

------------------------------------------------------------------------

11. [Results]{} {#h.6zhnn81o27us style="display:inline"}
    ===========

[We were able to get NES working, thanks to our rigorous verification process, and onboard debug methodology. Some of the games we got working include Super Mario Bros, Galaga, Tennis, Golf, Donkey Kong, Ms Pacman, Defender II, Pinball, and Othello.  ]{.c7}

12. [Possible Improvements]{.c109 .c23} {#h.g7qfxmufg3ij style="display:inline"}
    ===================================

-   [Create a working audio processing unit]{.c7}
-   [More advanced memory mapper support]{.c7}
-   [Better image upscaling such as hqx]{.c7}
-   [Support for actual NES game carts]{.c7}
-   [HDMI]{.c7}
-   [VGA buffer instead of two RAM blocks to save space]{.c7}

13. [References and Links]{} {#h.9xwc48i9bi3r style="display:inline"}
    ========================

[Ferguson, Scott. "PPU Tutorial." N.p., n.d. Web. &lt;]{.c69}[[https://opcode-defined.quora.com](https://www.google.com/url?q=https://opcode-defined.quora.com&sa=D&ust=1494576244513000&usg=AFQjCNGLV8QOBaofHlIJOuV4MyLC4brQkA){.c24}]{.c62 .c69}[&gt;.]{.c7 .c69}

[ "6502 Specification." ]{.c69}[NesDev]{.c69}[. N.p., n.d. Web. 10 May 2017. &lt;]{.c69}[[http://nesdev.com/6502.txt](https://www.google.com/url?q=http://nesdev.com/6502.txt&sa=D&ust=1494576244515000&usg=AFQjCNG5m7S_waprlfT8QEhROiwN8d3KEg){.c24}]{.c62 .c69}[&gt;.]{.c7 .c69}

[Dormann, Klaus. "6502 Functional Test Suite." ]{.c69}[GitHub]{.c69 .c128}[. N.p., n.d. Web. 10 May 2017.        &lt;]{.c69}[[https://github.com/Klaus2m5/](https://www.google.com/url?q=https://github.com/Klaus2m5/&sa=D&ust=1494576244517000&usg=AFQjCNEEtPtcean98c-J5CKdpY_Jus6jpg){.c24}]{.c62 .c69}[&gt;.]{.c7 .c69}

["NES Reference Guide." ]{.c69}[Nesdev]{.c69}[. N.p., n.d. Web. 10 May 2017. &lt;]{.c69}[[http://wiki.nesdev.com/w/index.php/NES\_reference\_guide](https://www.google.com/url?q=http://wiki.nesdev.com/w/index.php/NES_reference_guide&sa=D&ust=1494576244519000&usg=AFQjCNGuyHPsCpyewUgjRkVM37mEHaV7cA){.c24}]{.c62 .c69}[&gt;.]{.c7 .c69}

[Java Simple Serial Connector library: &lt;]{.c69}[[https://github.com/scream3r/java-simple-serial-connector](https://www.google.com/url?q=https://github.com/scream3r/java-simple-serial-connector&sa=D&ust=1494576244520000&usg=AFQjCNGCf07L43dARQngxpg7jOja1xHf_g){.c24}]{.c62 .c69}[&gt;]{.c7 .c69}

[Final Github release: &lt;]{.c69}[[https://github.com/jtgebert/fpganes\_release](https://www.google.com/url?q=https://github.com/jtgebert/fpganes_release&sa=D&ust=1494576244521000&usg=AFQjCNH9NK9NdKBC9Ar1pU5FpDYAy5dhiA){.c24}]{.c62 .c69}[&gt;]{.c7 .c69}

[]{.c7 .c69}

[]{.c7 .c69}

[]{.c7 .c69}

[]{.c109 .c23} {#h.kehh6src6j2q .c132 .c123}
==============

[]{.c7}

[]{.c7}

14. [Co]{}[ntributions]{.c109 .c23} {#h.vkgt15aadvpx style="display:inline"}
    ===============================

[Eric Sullivan]{.c22} {#h.riv717lhxryl .c35}
---------------------

[Designed and debugged the NES picture processing unit, created a comprehensive set of PPU testbenches to verify functionality, Integrated the VGA to the PPU, implemented the DMA and dummy APU, started a CPU simulator in python, Helped debug the integrated system.]{}

[Patrick Yang]{.c22} {#h.fpooysc4oemr .c35}
--------------------

[Specified the CPU microarchitecture along with Pavan, designed the ALU, registers, and memory interface unit, wrote a self checking testbench, responsible for CPU debug, integrated all modules on top level file, and debugged of the integrated system. Helped Jon to modify controller driver to also be an onboard CPU trace module.]{}

[Pavan Holla]{.c22} {#h.7pjbrnhfuduw .c35}
-------------------

[Specified the CPU microarchitecture along with Patrick, designed the decoder and interrupt handler, and wrote the script that generates the processor control module. Modified a testsuite and provided the infrastructure for CPU verification. Wrote tic tac toe in assembly as a fail-safe game.  Also, worked on a parallel effort to integrate undocumented third party NES IP.]{.c7}

[Jonathan Ebert]{} {#h.jaedjh5lps0t .c35}
------------------

[Modified the VGA to interface with the PPU. W]{}[rote a new driver to control our existing SPART module to act as a NES controller and as an onboard CPU trace module. Wrote Java program to communicate with the SPART module using the JSSC library. Wrote memory wrappers, hardware decoder, and generated all game ROMs. Helped debug the integrated system. Wrote a very simple assembler. Wrote script to convert NES ROMs to MIF files. Also, worked on a parallel effort to integrate undocumented third party NES IP]{}[.]{}

<div>

[]{.c7}

</div>
