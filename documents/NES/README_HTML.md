<span class="c7"></span>

<span class="c148">FPGA Implementation of the Nintendo Entertainment System (NES)</span>

<span class="c42">Four People Generating A Nintendo Entertainment System (FPGANES)</span>

<span class="c128">Eric Sullivan, Jonathan Ebert, Patrick Yang, </span><span class="c114">Pavan Holla</span>

<span class="c114"></span>

<span class="c114"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c148">Final Report </span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c7"></span>

<span class="c176">University of Wisconsin-Madison</span>

<span class="c176">ECE 554</span>

<span class="c176">Spring 2017</span>

<span class="c7"></span>

<span class="c23"><a href="#h.g5jrstas8bb9" class="c24">Introduction</a></span><span class="c23">        </span><span class="c23"><a href="#h.g5jrstas8bb9" class="c24">6</a></span>

<span class="c23"><a href="#h.1ayvkhk4vvmg" class="c24">Top Level Block Diagram</a></span><span class="c23">        </span><span class="c23"><a href="#h.1ayvkhk4vvmg" class="c24">7</a></span>

<span><a href="#h.8r6j63kwrjxl" class="c24">Top level description</a></span><span>        </span><span><a href="#h.8r6j63kwrjxl" class="c24">7</a></span>

<span><a href="#h.a9ilbl8rkgkd" class="c24">Data Flow Diagram</a></span><span>        </span><span><a href="#h.a9ilbl8rkgkd" class="c24">8</a></span>

<span><a href="#h.m6jcsadip56s" class="c24">Control Flow Diagram</a></span><span>        </span><span><a href="#h.m6jcsadip56s" class="c24">8</a></span>

<span class="c23"><a href="#h.rdm0fxe7s5y9" class="c24">CPU</a></span><span class="c23">        </span><span class="c23"><a href="#h.rdm0fxe7s5y9" class="c24">9</a></span>

<span><a href="#h.eftj2rjo9s1h" class="c24">CPU Registers</a></span><span>        </span><span><a href="#h.eftj2rjo9s1h" class="c24">9</a></span>

<span><a href="#h.wvvuysbh6ili" class="c24">CPU ISA</a></span><span>        </span><span><a href="#h.wvvuysbh6ili" class="c24">9</a></span>

<span><a href="#h.9ie72e7qdon7" class="c24">CPU Addressing Modes</a></span><span>        </span><span><a href="#h.9ie72e7qdon7" class="c24">10</a></span>

<span><a href="#h.b7loafaij831" class="c24">CPU Interrupts</a></span><span>        </span><span><a href="#h.b7loafaij831" class="c24">10</a></span>

<span><a href="#h.q77927r8c49e" class="c24">CPU Opcode Matrix</a></span><span>        </span><span><a href="#h.q77927r8c49e" class="c24">10</a></span>

<span><a href="#h.ki2ushz1f0a3" class="c24">CPU Block Diagram</a></span><span>        </span><span><a href="#h.ki2ushz1f0a3" class="c24">13</a></span>

<span><a href="#h.er7yq56tef4v" class="c24">CPU Top Level Interface</a></span><span>        </span><span><a href="#h.er7yq56tef4v" class="c24">15</a></span>

<span><a href="#h.lomim8yvajg6" class="c24">CPU Instruction Decode Interface</a></span><span>        </span><span><a href="#h.lomim8yvajg6" class="c24">15</a></span>

<span><a href="#h.b3lc7rd7ackr" class="c24">CPU MEM Interface</a></span><span>        </span><span><a href="#h.b3lc7rd7ackr" class="c24">16</a></span>

<span><a href="#h.nexle64nrxxq" class="c24">CPU ALU Interface</a></span><span>        </span><span><a href="#h.nexle64nrxxq" class="c24">16</a></span>

<span><a href="#h.sprgfm6rx38x" class="c24">ALU Input Selector</a></span><span>        </span><span><a href="#h.sprgfm6rx38x" class="c24">17</a></span>

<span><a href="#h.5httww8vnv8g" class="c24">CPU Registers Interface</a></span><span>        </span><span><a href="#h.5httww8vnv8g" class="c24">17</a></span>

<span><a href="#h.eiifcf5tv1l9" class="c24">CPU Processor Control Interface</a></span><span>        </span><span><a href="#h.eiifcf5tv1l9" class="c24">18</a></span>

<span><a href="#h.3on9q42bqgrx" class="c24">CPU Enums</a></span><span>        </span><span><a href="#h.3on9q42bqgrx" class="c24">19</a></span>

<span class="c23"><a href="#h.fb8snxockohd" class="c24">Picture Processing Unit</a></span><span class="c23">        </span><span class="c23"><a href="#h.fb8snxockohd" class="c24">20</a></span>

<span><a href="#h.bvqrg858z31w" class="c24">PPU Top Level Schematic</a></span><span>        </span><span><a href="#h.bvqrg858z31w" class="c24">21</a></span>

<span><a href="#h.dkksbep8besq" class="c24">PPU Memory Map</a></span><span>        </span><span><a href="#h.dkksbep8besq" class="c24">22</a></span>

<span><a href="#h.pa3j41hpauwc" class="c24">PPU CHAROM</a></span><span>        </span><span><a href="#h.pa3j41hpauwc" class="c24">22</a></span>

<span><a href="#h.pg3as4rfwz9v" class="c24">PPU Rendering</a></span><span>        </span><span><a href="#h.pg3as4rfwz9v" class="c24">23</a></span>

<span><a href="#h.8bwwxukxxmnt" class="c24">PPU Memory Mapped Registers</a></span><span>        </span><span><a href="#h.8bwwxukxxmnt" class="c24">25</a></span>

<span><a href="#h.h50m30h4jbfm" class="c24">PPU Register Block Diagram</a></span><span>        </span><span><a href="#h.h50m30h4jbfm" class="c24">26</a></span>

<span><a href="#h.djradund7fk8" class="c24">PPU Register Descriptions</a></span><span>        </span><span><a href="#h.djradund7fk8" class="c24">26</a></span>

<span><a href="#h.qbi461d1fk95" class="c24">PPU Background Renderer</a></span><span>        </span><span><a href="#h.qbi461d1fk95" class="c24">28</a></span>

<span><a href="#h.kqe8ry35ghh" class="c24">PPU Background Renderer Diagram</a></span><span>        </span><span><a href="#h.kqe8ry35ghh" class="c24">29</a></span>

<span><a href="#h.z1adjveqdhdo" class="c24">PPU Sprite Renderer</a></span><span>        </span><span><a href="#h.z1adjveqdhdo" class="c24">30</a></span>

<span><a href="#h.ouavojij313q" class="c24">PPU Sprite Renderer Diagram</a></span><span>        </span><span><a href="#h.ouavojij313q" class="c24">32</a></span>

<span><a href="#h.ud4hcid0qc0t" class="c24">PPU Object Attribute Memory</a></span><span>        </span><span><a href="#h.ud4hcid0qc0t" class="c24">33</a></span>

<span><a href="#h.unbqcwik0ikz" class="c24">PPU Palette Memory</a></span><span>        </span><span><a href="#h.unbqcwik0ikz" class="c24">33</a></span>

<span><a href="#h.xlgt5p96mvki" class="c24">VRAM Interface</a></span><span>        </span><span><a href="#h.xlgt5p96mvki" class="c24">34</a></span>

<span><a href="#h.7oqgkdlshdds" class="c24">DMA</a></span><span>        </span><span><a href="#h.7oqgkdlshdds" class="c24">34</a></span>

<span><a href="#h.9f0tphgw8ifs" class="c24">PPU Testbench</a></span><span>        </span><span><a href="#h.9f0tphgw8ifs" class="c24">35</a></span>

<span><a href="#h.dgbwdleazq7q" class="c24">PPU Testbench PPM file format</a></span><span>        </span><span><a href="#h.dgbwdleazq7q" class="c24">36</a></span>

<span><a href="#h.8ijczpvs4ut5" class="c24">PPU Testbench Example Renderings</a></span><span>        </span><span><a href="#h.8ijczpvs4ut5" class="c24">37</a></span>

<span class="c23"><a href="#h.7c1koopsou4c" class="c24">Memory Maps</a></span><span class="c23">        </span><span class="c23"><a href="#h.7c1koopsou4c" class="c24">37</a></span>

<span><a href="#h.o4bj1b7uzlbc" class="c24">PPU ROM Memory Map</a></span><span>        </span><span><a href="#h.o4bj1b7uzlbc" class="c24">37</a></span>

<span><a href="#h.n5cypllda98c" class="c24">CPU ROM Memory Map</a></span><span>        </span><span><a href="#h.n5cypllda98c" class="c24">38</a></span>

<span><a href="#h.5cvhenp51lun" class="c24">Memory Mappers Interface</a></span><span>        </span><span><a href="#h.5cvhenp51lun" class="c24">39</a></span>

<span class="c23"><a href="#h.bryqhbcn7knu" class="c24">APU</a></span><span class="c23">        </span><span class="c23"><a href="#h.bryqhbcn7knu" class="c24">40</a></span>

<span><a href="#h.qk56hr19gphj" class="c24">APU Registers</a></span><span>        </span><span><a href="#h.qk56hr19gphj" class="c24">40</a></span>

<span class="c23"><a href="#h.5fhzf7bk1zke" class="c24">Controllers (SPART)</a></span><span class="c23">        </span><span class="c23"><a href="#h.5fhzf7bk1zke" class="c24">42</a></span>

<span><a href="#h.927n2dvl8df9" class="c24">Debug Modification</a></span><span>        </span><span><a href="#h.927n2dvl8df9" class="c24">42</a></span>

<span><a href="#h.917ivz4m4ziu" class="c24">Controller Registers</a></span><span>        </span><span><a href="#h.917ivz4m4ziu" class="c24">42</a></span>

<span><a href="#h.bnnsrcv0r4jw" class="c24">Controllers Wrapper</a></span><span>        </span><span><a href="#h.bnnsrcv0r4jw" class="c24">42</a></span>

<span><a href="#h.o12jcpl1v6h2" class="c24">Controller Wrapper Diagram</a></span><span>        </span><span><a href="#h.o12jcpl1v6h2" class="c24">43</a></span>

<span><a href="#h.b5ap3afv7f57" class="c24">Controller Wrapper Interface</a></span><span>        </span><span><a href="#h.b5ap3afv7f57" class="c24">43</a></span>

<span><a href="#h.ddzvq2rctlzt" class="c24">Controller</a></span><span>        </span><span><a href="#h.ddzvq2rctlzt" class="c24">44</a></span>

<span><a href="#h.ml0lp3awxz0e" class="c24">Controller Diagram</a></span><span>        </span><span><a href="#h.ml0lp3awxz0e" class="c24">44</a></span>

<span><a href="#h.8148udv35isa" class="c24">Controller Interface</a></span><span>        </span><span><a href="#h.8148udv35isa" class="c24">44</a></span>

<span><a href="#h.fna8vaz47pc1" class="c24">Special Purpose Asynchronous Receiver and Transmitter (SPART)</a></span><span>        </span><span><a href="#h.fna8vaz47pc1" class="c24">45</a></span>

<span><a href="#h.9khtivok6lhm" class="c24">SPART Diagram &amp; Interface</a></span><span>        </span><span><a href="#h.9khtivok6lhm" class="c24">45</a></span>

<span><a href="#h.fxadt5ql4b59" class="c24">Controller Driver</a></span><span>        </span><span><a href="#h.fxadt5ql4b59" class="c24">46</a></span>

<span><a href="#h.yma1hmwj1wcp" class="c24">Controller Driver State Machine</a></span><span>        </span><span><a href="#h.yma1hmwj1wcp" class="c24">46</a></span>

<span class="c23"><a href="#h.xrfacxsmruiq" class="c24">VGA</a></span><span class="c23">        </span><span class="c23"><a href="#h.xrfacxsmruiq" class="c24">47</a></span>

<span><a href="#h.7dmryvqi4l3b" class="c24">VGA Diagram</a></span><span>        </span><span><a href="#h.7dmryvqi4l3b" class="c24">47</a></span>

<span><a href="#h.7b41ivlnuec0" class="c24">VGA Interface</a></span><span>        </span><span><a href="#h.7b41ivlnuec0" class="c24">48</a></span>

<span><a href="#h.w1ger0jiy8bk" class="c24">VGA Clock Gen</a></span><span>        </span><span><a href="#h.w1ger0jiy8bk" class="c24">48</a></span>

<span><a href="#h.pw3svolg7ia" class="c24">VGA Timing Gen</a></span><span>        </span><span><a href="#h.pw3svolg7ia" class="c24">49</a></span>

<span><a href="#h.em4ktvbwfn8k" class="c24">VGA Display Plane</a></span><span>        </span><span><a href="#h.em4ktvbwfn8k" class="c24">49</a></span>

<span><a href="#h.68btkfb1o5ru" class="c24">VGA RAM Wrapper</a></span><span>        </span><span><a href="#h.68btkfb1o5ru" class="c24">50</a></span>

<span><a href="#h.1cvttmqqni8n" class="c24">VGA RAM Reader</a></span><span>        </span><span><a href="#h.1cvttmqqni8n" class="c24">50</a></span>

<span class="c23"><a href="#h.zbj1aj20rigt" class="c24">Software</a></span><span class="c23">        </span><span class="c23"><a href="#h.zbj1aj20rigt" class="c24">52</a></span>

<span><a href="#h.ik7f7bcto722" class="c24">Controller Simulator</a></span><span>        </span><span><a href="#h.ik7f7bcto722" class="c24">52</a></span>

<span><a href="#h.ev3eyvc4m806" class="c24">Controller Simulator State Machine</a></span><span>        </span><span><a href="#h.ev3eyvc4m806" class="c24">52</a></span>

<span><a href="#h.xqfqy7n0dj86" class="c24">Controller Simulator Output Packet Format</a></span><span>        </span><span><a href="#h.xqfqy7n0dj86" class="c24">52</a></span>

<span><a href="#h.wqujxd9v8i1y" class="c24">Controller Simulator GUI and Button Map</a></span><span>        </span><span><a href="#h.wqujxd9v8i1y" class="c24">53</a></span>

<span><a href="#h.t5xpa0jvlbyf" class="c24">Assembler</a></span><span>        </span><span><a href="#h.t5xpa0jvlbyf" class="c24">53</a></span>

<span><a href="#h.rp3i11uarg1" class="c24">Opcode Table</a></span><span>        </span><span><a href="#h.rp3i11uarg1" class="c24">54</a></span>

<span><a href="#h.fji30zo8qmh" class="c24">NES Assembly Formats</a></span><span>        </span><span><a href="#h.fji30zo8qmh" class="c24">56</a></span>

<span><a href="#h.1ftppbjfbpv9" class="c24">Invoking Assembler</a></span><span>        </span><span><a href="#h.1ftppbjfbpv9" class="c24">57</a></span>

<span><a href="#h.ekqczej5ygn6" class="c24">iNES ROM Converter</a></span><span>        </span><span><a href="#h.ekqczej5ygn6" class="c24">57</a></span>

<span><a href="#h.syub5w8xzigk" class="c24">Tic Tac Toe</a></span><span>        </span><span><a href="#h.syub5w8xzigk" class="c24">57</a></span>

<span class="c23"><a href="#h.pefw11g7x04z" class="c24">Testing &amp; Debug</a></span><span class="c23">        </span><span class="c23"><a href="#h.pefw11g7x04z" class="c24">58</a></span>

<span><a href="#h.i9v97r1jowjk" class="c24">Simulation</a></span><span>        </span><span><a href="#h.i9v97r1jowjk" class="c24">58</a></span>

<span><a href="#h.s28dapnuwz93" class="c24">Test</a></span><span>        </span><span><a href="#h.s28dapnuwz93" class="c24">58</a></span>

<span><a href="#h.mv68y8tja9lo" class="c24">Integrated Simulation</a></span><span>        </span><span><a href="#h.mv68y8tja9lo" class="c24">58</a></span>

<span><a href="#h.xldwn1zb9fzw" class="c24">Tracer</a></span><span>        </span><span><a href="#h.xldwn1zb9fzw" class="c24">58</a></span>

<span class="c23"><a href="#h.6zhnn81o27us" class="c24">Results</a></span><span class="c23">        </span><span class="c23"><a href="#h.6zhnn81o27us" class="c24">59</a></span>

<span class="c23"><a href="#h.g7qfxmufg3ij" class="c24">Possible Improvements</a></span><span class="c23">        </span><span class="c23"><a href="#h.g7qfxmufg3ij" class="c24">59</a></span>

<span class="c23"><a href="#h.9xwc48i9bi3r" class="c24">References and Links</a></span><span class="c23">        </span><span class="c23"><a href="#h.9xwc48i9bi3r" class="c24">59</a></span>

<span class="c23"><a href="#h.vkgt15aadvpx" class="c24">Contributions</a></span><span class="c23">        </span><span class="c23"><a href="#h.vkgt15aadvpx" class="c24">60</a></span>

<span><a href="#h.riv717lhxryl" class="c24">Eric Sullivan</a></span><span>        </span><span><a href="#h.riv717lhxryl" class="c24">60</a></span>

<span><a href="#h.fpooysc4oemr" class="c24">Patrick Yang</a></span><span>        </span><span><a href="#h.fpooysc4oemr" class="c24">60</a></span>

<span><a href="#h.7pjbrnhfuduw" class="c24">Pavan Holla</a></span><span>        </span><span><a href="#h.7pjbrnhfuduw" class="c24">60</a></span>

<span><a href="#h.jaedjh5lps0t" class="c24">Jonathan Ebert</a></span><span>        </span><span><a href="#h.jaedjh5lps0t" class="c24">60</a></span>

<span class="c186 c230"></span>

<span class="c109 c23"></span>
==============================

------------------------------------------------------------------------

<span class="c109 c23"></span>
==============================

1.  <span>Introduction</span>
    =========================

<span class="c68">Following the video game crash in the early 1980s, Nintendo released their first video game console, the Nintendo Entertainment System (NES). Following a slow release and early recalls, the console began to gain momentum in a market that many thought had died out, and the NES is still appreciated by enthusiasts today. A majority of its early success was due to the relationship that Nintendo created with third-party software developers. Nintendo required that restricted developers from publishing games without a license distributed by Nintendo. This decision led to higher quality games and helped to sway the public opinion on video games, which had been plagued by poor games for other gaming consoles. </span>

<span class="c68">Our motivation is to better understand how the NES worked from a hardware perspective, as the NES was an extremely advanced console when it was released in 1985 (USA). The NES has been recreated multiple times in software emulators, but has rarely been done in a hardware design language, which makes this a unique project.  Nintendo chose to use the 6502 processor, also used by Apple in the Apple II, and chose to include a picture processing unit to provide a memory efficient way to output video to the TV. Our goal was to recreate the CPU and PPU in hardware, so that we could run games that were run on the original console. In order to exactly recreate the original console, we needed to include memory mappers, an audio processing unit, a DMA unit, a VGA interface, and a way to use a controller for input. In addition, we wrote our own assembler and tic-tac-toe game to test our implementation.   The following sections will explain the microarchitecture of the NES. Much of the information was gleaned from nesdev.com, and from other online forums that reverse engineered the NES.</span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

<span class="c68"></span>

1.  <span class="c109 c23">Top Level Block Diagram</span>
    =====================================================

<!-- -->

1.  <span class="c22">Top level description</span>
    ----------------------------------------------

<span class="c7">Here is an overview of each module in our design. Our report has a section dedicated for each of these modules.</span>

1.  <span class="c7">PPU - The PPU(Picture Processing Unit) is responsible for rendering graphics on screen. It receives memory mapped accesses from the CPU, and renders graphics from memory, providing RGB values.</span>
2.  <span class="c7">CPU - Our CPU is a 6502 implementation. It is responsible for controlling all other modules in the NES. At boot, CPU starts reading programs at the address 0xFFFC.</span>
3.  <span class="c7">DMA - The DMA transfers chunks of data from CPU address space to PPU address space. It is faster than performing repeated Loads and Stores in the CPU.</span>
4.  <span class="c7">Display Memory and VGA - The PPU writes to the display memory, which is subsequently read out by the VGA module. The VGA module produces the hsync, vsync and RGB values that a monitor requires.</span>
5.  <span class="c7">Controller - A program runs on a host computer which transfers serial data to the FPGA. The protocol used by the controller is UART in our case</span>
6.  <span class="c7">APU - Generates audio in the NES. However, we did not implement this module.</span>
7.  <span class="c7">CHAR RAM/ RAM - Used by the CPU and PPU to store temporary data</span>
8.  <span class="c7">PROG ROM/ CHAR ROM - PROG ROM contains the software(instructions) that runs the game. CHAR ROM on the other hand contains mostly image data and graphics used in the game.</span>

<!-- -->

1.  <span class="c22">Data Flow Diagram</span>
    ------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 611.00px; height: 296.00px;">![](images/image3.png)</span>

<span class="c81">Figure 1: System level data flow diagram</span>

1.  <span class="c22"> Control Flow Diagram</span>
    ----------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 356.00px;">![](images/image2.png)</span>

<span class="c81">Figure 2: System level control flow diagram.</span>

1.  <span class="c109 c23">CPU</span>
    =================================

<span class="c22">CPU Registers</span>
--------------------------------------

<span class="c7">The CPU of the NES is the MOS 6502. It is an  accumulator plus index register machine. There are five primary registers on which operations are performed: </span>

1.  <span class="c7">PC : Program Counter</span>
2.  <span class="c7">Accumulator(A) : Keeps track of results from ALU</span>
3.  <span class="c7">X : X index register</span>
4.  <span class="c7">Y  : Y index register</span>
5.  <span class="c7">Stack pointer</span>
6.  <span class="c7">Status Register : Negative, Overflow, Unused, Break, Decimal, Interrupt, Zero, Carry</span>

-   <span class="c7">Break means that the current interrupt is from software interrupt, BRK</span>
-   <span class="c7">Interrupt is high when maskable interrupts (IRQ) is to be ignored. Non-maskable interrupts (NMI) cannot be ignored.</span>

<span class="c7">There are 6 secondary registers:</span>

1.  <span class="c7">AD : Address Register</span>

-   <span class="c7">Stores where to jump to or where to get indirect access from.</span>

1.  <span class="c7">ADV : AD Value Register</span>

-   <span class="c7">Stores the value from indirect access by AD.</span>

1.  <span class="c7">BA : Base Address Register</span>

-   <span class="c7">Stores the base address before index calculation. After the calculation, the value is transferred to AD if needed.</span>

1.  <span class="c7">BAV : BA Value Register</span>

-   <span class="c7">Stores the value from indirect access by BA.</span>

1.  <span class="c7">IMM : Immediate Register</span>

-   <span class="c7">Stores the immediate value from the memory.</span>

1.  <span class="c7">Offset</span>

-   <span class="c7">Stores the offset value of branch from memory</span>

<span class="c22">CPU ISA</span>
--------------------------------

<span class="c7">The ISA may be classified into a few broad operations: </span>

-   <span class="c7">Load into A,X,Y registers from memory</span>
-   <span class="c7">Perform arithmetic operation on A,X or Y</span>
-   <span class="c7">Move data from one register to another</span>
-   <span class="c7">Program control instructions like Jump and Branch</span>
-   <span class="c7">Stack operations</span>
-   <span class="c7">Complex instructions that read, modify and write back memory.</span>

<span class="c22">CPU Addressing Modes</span>
---------------------------------------------

<span class="c7">Additionally, there are thirteen addressing modes which these operations can use. They are</span>

-   <span class="c23">Accumulator</span><span class="c7"> – The data in the accumulator is used. </span>
-   <span class="c23">Immediate</span><span class="c7"> - The byte in memory immediately following the instruction is used. </span>
-   <span class="c23">Zero Page</span><span class="c7"> – The Nth byte in the first page of RAM is used where N is the byte in memory immediately following the instruction. </span>
-   <span class="c23">Zero Page, X Index</span><span class="c7"> – The (N+X)th byte in the first page of RAM is used where N is the byte in memory immediately following the instruction and X is the contents of the X index register.</span>
-   <span class="c23">Zero Page, Y Index</span><span class="c7"> – Same as above but with the Y index register </span>
-   <span class="c23">Absolute</span><span class="c7"> – The two bytes in memory following the instruction specify the absolute address of the byte of data to be used. </span>
-   <span class="c23">Absolute, X Index</span><span class="c7"> - The two bytes in memory following the instruction specify the base address. The contents of the X index register are then added to the base address to obtain the address of the byte of data to be used. </span>
-   <span class="c23">Absolute, Y Index</span><span class="c7"> – Same as above but with the Y index register </span>
-   <span class="c23">Implied</span><span class="c7"> – Data is either not needed or the location of the data is implied by the instruction. </span>
-   <span class="c23">Relative</span><span class="c7"> – The content of  sum of (the program counter and the byte in memory immediately following the instruction) is used. </span>
-   <span class="c23">Absolute Indirect</span><span class="c7"> - The two bytes in memory following the instruction specify the absolute address of the two bytes that contain the absolute address of the byte of data to be used.</span>
-   <span class="c23">(Indirect, X)</span><span class="c7"> – A combination of Indirect Addressing and Indexed Addressing </span>
-   <span class="c23">(Indirect), Y</span><span class="c7"> - A combination of Indirect Addressing and Indexed Addressing</span>

<span class="c22">CPU Interrupts</span>
---------------------------------------

<span class="c7">The 6502 supports three interrupts. The reset interrupt routine is called after a physical reset. The other two interrupts are the non\_maskable\_interrupt(NMI) and the general\_interrupt(IRQ). The general\_interrupt can be disabled by software whereas the others cannot. When interrupt occurs, the CPU finishes the current instruction then PC jumps to the specified interrupt vector then return when finished.  </span>

<span class="c22">CPU Opcode Matrix</span>
------------------------------------------

<span class="c7">The NES 6502 ISA is a CISC like ISA with 56 instructions. These 56 instructions can pair up with addressing modes to form various opcodes. The opcode is always 8 bits, however based on the addressing mode, upto 4 more memory location may need to be fetched.The memory is single cycle, i.e data\[7:0\] can be latched the cycle after address\[15:0\] is placed on the bus. The following tables summarize the instructions available and possible addressing modes:</span>

<span id="t.3cc61c11f8dce03b7ca8770afc1862c11a71fc7e"></span><span id="t.0"></span>

<span class="c76 c23">Storage</span>

<span class="c7">LDA</span>

<span class="c7">Load A with M</span>

<span class="c7">LDX</span>

<span class="c7">Load X with M</span>

<span class="c7">LDY</span>

<span class="c7">Load Y with M</span>

<span class="c7">STA</span>

<span class="c7">Store A in M</span>

<span class="c7">STX</span>

<span class="c7">Store X in M</span>

<span class="c7">STY</span>

<span class="c7">Store Y in M</span>

<span class="c7">TAX</span>

<span class="c7">Transfer A to X</span>

<span class="c7">TAY</span>

<span class="c7">Transfer A to Y</span>

<span class="c7">TSX</span>

<span class="c7">Transfer Stack Pointer to X</span>

<span class="c7">TXA</span>

<span class="c7">Transfer X to A</span>

<span class="c7">TXS</span>

<span class="c7">Transfer X to Stack Pointer</span>

<span class="c7">TYA</span>

<span class="c7">Transfer Y to A</span>

<span class="c76 c23">Arithmetic</span>

<span class="c7">ADC</span>

<span class="c7">Add M to A with Carry</span>

<span class="c7">DEC</span>

<span class="c7">Decrement M by One</span>

<span class="c7">DEX</span>

<span class="c7">Decrement X by One</span>

<span class="c7">DEY</span>

<span class="c7">Decrement Y by One</span>

<span class="c7">INC</span>

<span class="c7">Increment M by One</span>

<span class="c7">INX</span>

<span class="c7">Increment X by One</span>

<span class="c7">INY</span>

<span class="c7">Increment Y by One</span>

<span class="c7">SBC</span>

<span class="c7">Subtract M from A with Borrow</span>

<span class="c76 c23">Bitwise</span>

<span class="c7">AND</span>

<span class="c7">AND M with A</span>

<span class="c7">ASL</span>

<span class="c7">Shift Left One Bit (M or A)</span>

<span class="c7">BIT</span>

<span class="c7">Test Bits in M with A</span>

<span class="c7">EOR</span>

<span class="c7">Exclusive-Or M with A</span>

<span class="c7">LSR</span>

<span class="c7">Shift Right One Bit (M or A)</span>

<span class="c7">ORA</span>

<span class="c7">OR M with A</span>

<span class="c7">ROL</span>

<span class="c7">Rotate One Bit Left (M or A)</span>

<span class="c7">ROR</span>

<span class="c7">Rotate One Bit Right (M or A)</span>

<span class="c76 c23">Branch</span>

<span class="c7">BCC</span>

<span class="c7">Branch on Carry Clear</span>

<span class="c7">BCS</span>

<span class="c7">Branch on Carry Set</span>

<span class="c7">BEQ</span>

<span class="c7">Branch on Result Zero</span>

<span class="c7">BMI</span>

<span class="c7">Branch on Result Minus</span>

<span class="c7">BNE</span>

<span class="c7">Branch on Result not Zero</span>

<span class="c7">BPL</span>

<span class="c7">Branch on Result Plus</span>

<span class="c7">BVC</span>

<span class="c7">Branch on Overflow Clear</span>

<span class="c7">BVS</span>

<span class="c7">Branch on Overflow Set</span>

<span class="c76 c23">Jump</span>

<span class="c7">JMP</span>

<span class="c7">Jump to Location</span>

<span class="c7">JSR</span>

<span class="c7">Jump to Location Save Return Address</span>

<span class="c7">RTI</span>

<span class="c7">Return from Interrupt</span>

<span class="c7">RTS</span>

<span class="c7">Return from Subroutine</span>

<span class="c76 c23">Status Flags</span>

<span class="c7">CLC</span>

<span class="c7">Clear Carry Flag</span>

<span class="c7">CLD</span>

<span class="c7">Clear Decimal Mode</span>

<span class="c7">CLI</span>

<span class="c7">Clear interrupt Disable Bit</span>

<span class="c7">CLV</span>

<span class="c7">Clear Overflow Flag</span>

<span class="c7">CMP</span>

<span class="c7">Compare M and A</span>

<span class="c7">CPX</span>

<span class="c7">Compare M and X</span>

<span class="c7">CPY</span>

<span class="c7">Compare M and Y</span>

<span class="c7">SEC</span>

<span class="c7">Set Carry Flag</span>

<span class="c7">SED</span>

<span class="c7">Set Decimal Mode</span>

<span class="c7">SEI</span>

<span class="c7">Set Interrupt Disable Status</span>

<span class="c76 c23">Stack</span>

<span class="c7">PHA</span>

<span class="c7">Push A on Stack</span>

<span class="c7">PHP</span>

<span class="c7">Push Processor Status on Stack</span>

<span class="c7">PLA</span>

<span class="c7">Pull A from Stack</span>

<span class="c7">PLP</span>

<span class="c7">Pull Processor Status from Stack</span>

<span class="c76 c23">System</span>

<span class="c7">BRK</span>

<span class="c7">Force Break</span>

<span class="c7">NOP</span>

<span class="c7">No Operation</span>

<span class="c7"></span>

<span>The specific opcode hex values are specified in the Assembler section.</span>

<span class="c7">For more information on the opcodes, please refer</span>

<span class="c62"><a href="https://www.google.com/url?q=http://www.6502.org/tutorials/6502opcodes.html&amp;sa=D&amp;ust=1494576242985000&amp;usg=AFQjCNEBeKqowaqwPg9HG_5qMJJCemVN9Q" class="c24">http://www.6502.org/tutorials/6502opcodes.html</a></span>

<span class="c7">or </span>

<span class="c62"><a href="https://www.google.com/url?q=http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502_Opcodes&amp;sa=D&amp;ust=1494576242986000&amp;usg=AFQjCNHWwLgjADTnuMa3o9CZ5cr83kwE8A" class="c24">http://www.thealmightyguru.com/Games/Hacking/Wiki/index.php/6502_Opcodes</a></span>

<span>CPU Block Diagram</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 389.33px;">![](images/image1.png)</span>
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<span class="c7"></span>

<span id="t.3b03df5ff635ab55210457ca4172a1dbb6594ce9"></span><span id="t.1"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c76 c23">Block</span></p></td>
<td><p><span class="c76 c23">Primary Function</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Decode</span></p></td>
<td><p><span class="c7">Decode the current instruction. Classifies the opcode into an instruction_type(arithmetic,ld etc) and addressing mode(immediate, indirect etc)</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">State machine that keeps track of current instruction stage, and generates signals to load registers.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Performs ALU ops and handles Status Flags</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Contains all registers. Register values change according to signals from processor control.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Mem</span></p></td>
<td><p><span class="c7">Acts as the interface between CPU and memory. Mem block thinks it’s communicating with the memory but the DMA can reroute the communication to any other blocks like PPU, controller</span></p></td>
</tr>
</tbody>
</table>

<span class="c76 c23"></span>

<span class="c76 c23">Instruction flow</span>

<span class="c7">The following table presents a high level overview of how each instruction is handled.</span>

<span id="t.c34310f1171abde1363919ba55d0bbfe4c032809"></span><span id="t.2"></span>

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c23 c76">Cycle Number</span></p></td>
<td><p><span class="c76 c23">Blocks </span></p></td>
<td><p><span class="c76 c23">Action</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0</span></p></td>
<td><p><span class="c7">Processor Control → Registers</span></p></td>
<td><p><span class="c7">Instruction Fetch </span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">1</span></p></td>
<td><p><span class="c7">Register →  Decode</span></p></td>
<td><p><span class="c7">Classify instruction and addressing mode</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">1</span></p></td>
<td><p><span class="c7">Decode → Processor Control</span></p></td>
<td><p><span class="c7">Init state machine for instruction type and addressing mode</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">2-6</span></p></td>
<td><p><span class="c7">Processor Control → Registers</span></p></td>
<td><p><span class="c7">Populate scratch registers based on addressing mode.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Last Cycle</span></p></td>
<td><p><span class="c7">Processor Control → ALU</span></p></td>
<td><p><span class="c7">Execute</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">Last Cycle</span></p></td>
<td><p><span class="c7">Processor Control → Registers</span></p></td>
<td><p><span class="c7">Instruction Fetch</span></p></td>
</tr>
</tbody>
</table>

<span class="c76 c23"></span>

<span class="c76 c23">State Machines</span>

<span class="c7">Each {instruction\_type, addressing\_mode} triggers its own state machine. In brief, this state machine is responsible for signalling the Registers module to load/store addresses from memory or from the ALU. </span>

<span>State machine spec for each instruction type and addressing mode can be found at </span><span class="c62 c69 c188"><a href="https://www.google.com/url?q=https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-_sEox-QsTjJSlt06lE/edit?usp%3Dsharing&amp;sa=D&amp;ust=1494576243018000&amp;usg=AFQjCNGRWTa2F9IkuDjlOnKv-jo9f3MhSQ" class="c24">https://docs.google.com/spreadsheets/d/16uGTSJEzrANUzr7dMmRNFAwA-_sEox-QsTjJSlt06lE/edit?usp=sharing</a></span>

<span class="c7">Considering one of the simplest instructions ADC immediate,which takes two cycles, the state machine is as follows:</span>

<span>Instruction\_type=ARITHMETIC, addressing mode= IMMEDIATE</span>

<span id="t.986d78169f9d35d012fa7f117a4e53d6949bf356"></span><span id="t.3"></span>

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c7">state=0</span></p></td>
<td><p><span class="c7">state=1</span></p></td>
<td><p><span class="c7">state=2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ld_sel=LD_INSTR; //instr= memory_data</span></p>
<p><span class="c7">pc_sel=INC_PC; //pc++</span></p>
<p><span class="c7">next_state=state+1’b1</span></p>
<p><span class="c7"></span></p>
<p><span class="c7"></span></p></td>
<td><p><span class="c7">ld_sel=LD_IMM;</span></p>
<p><span class="c7">//imm=memory_data</span></p>
<p><span class="c7">pc_sel=INC_PC</span></p>
<p><span class="c7">next_state=state+1’b1</span></p></td>
<td><p><span class="c7">alu_ctrl=DO_OP_ADC // execute</span></p>
<p><span class="c7">src1_sel=SRC1_A</span></p>
<p><span class="c7">src2_sel=SRC2_IMM</span></p>
<p><span class="c7">dest_sel=DEST_A</span></p>
<p><span class="c7">ld_sel=LD_INSTR//fetch next instruction</span></p>
<p><span class="c7">pc_sel=INC_PC</span></p>
<p><span class="c7">next_state=1’b1</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c7">All instructions are classified into one of 55 state machines in the cpu specification sheet. The 6502 can take variable time for a single instructions based on certain conditions(page\_cross, branch\_taken etc). These corner case state transitions are also taken care of by processor control.</span>

<span>CPU </span><span class="c22">Top Level Interface</span>
-------------------------------------------------------------

<span id="t.ec6e0cf4837ca798f6158bba27f8906dd57ddbdb"></span><span id="t.4"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active high reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">nmi</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">Non maskable interrupt from PPU. Executes BRK instruction in CPU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">addr[15:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">Address for R/W issued by CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">dout[7:0]</span></p></td>
<td><p><span class="c7">input/</span></p>
<p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">Data from the RAM in case of reads and and to the RAM in case of writes</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">memory_read</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">read enable signal for RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">memory_write</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">write enable signal for RAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">CPU Instruction Decode Interface</span>
---------------------------------------------------------

<span class="c7">The decode module is responsible for classifying the instruction into one of the addressing modes and an instruction type. It also generates the signal that the ALU would eventually use if the instruction passed through the ALU.        </span>

<span id="t.f13182f9d70c3545bc3d4e1c8077ef6922fd108a"></span><span id="t.5"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">instruction_register</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Opcode of the current instruction</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">nmi</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">cpu_top</span></p></td>
<td><p><span class="c7">Non maskable interrupt from PPU. Executes BRK instruction in CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">instruction_type</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Type of instruction. Belongs to enum ITYPE.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">addressing_mode</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Addressing mode of the opcode in instruction_register. Belongs to enum AMODE.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">alu_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">ALU operation expected to be performed by the opcode, eventually. Processor control chooses to use it at a cycle appropriate for the instruction. Belongs to enum DO_OP.</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">CPU MEM Interface</span>
------------------------------------------

<span class="c7">The MEM module is the interface between memory and CPU. It provides appropriate address and read/write signal for the memory. Controlled by the select signals</span>

<span id="t.60770ee16f74d493ac822410188b75f9a14e434b"></span><span id="t.6"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">addr_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Selects which input to use as address to memory. Enum of ADDR</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">int_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Selects which interrupt address to jump to. Enum of INT_TYPE</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ld_sel,st_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Decides whether to read or write based on these signals</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ad, ba, sp, irql, irqh, pc</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Registers that are candidates of the address</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">addr</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Memory</span></p></td>
<td><p><span class="c7">Address of the memory to read/write</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">read,write</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Memory</span></p></td>
<td><p><span class="c7">Selects whether Memory should read or write</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">CPU ALU Interface</span>
------------------------------------------

<span class="c7">Performs arithmetic, logical operations and operations that involve status registers.</span>

<span id="t.74d7ae3809789a7579d3dd984c8cb1e6937f5c5b"></span><span id="t.7"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">in1, in2</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">ALU Input Selector</span></p></td>
<td><p><span class="c7">Inputs to the ALU operations selected by ALU Input module.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">alu_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">ALU operation expected to be performed by the opcode, eventually. Processor control chooses to use it at a cycle appropriate for the instruction. Belongs to enum DO_OP.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk, rst</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock and active high reset</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">out</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">to all registers</span></p></td>
<td><p><span class="c7">Output of ALU operation. sent to all registers and registers decide whether to receive it or ignore it as its next value.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">n, z, v, c, b, d, i</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Status Register</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

### <span class="c57 c23">ALU Input Selector</span>

<span class="c7">Selects the input1 and input2 for the ALU</span>

<span id="t.962a520a35f5a47f155664eb3cba694a0b1b6dba"></span><span id="t.8"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">src1_sel, src2_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Control signal that determines which sources to take in as inputs to ALU according to the instruction and addressing mode</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">a, bal, bah, adl, pcl, pch, imm, adv, x, bav, y, offset</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Registers that are candidates to the input to ALU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">temp_status</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Sometimes status information is required but we don’t want it to affect the status register. So we directly receive temp_status value from ALU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">in1, in2</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Selected input for the ALU</span></p></td>
</tr>
</tbody>
</table>

<span class="c22">CPU Registers Interface</span>
------------------------------------------------

<span class="c7">Holds all of the registers</span>

<span id="t.35d129561daa24a66b47c8945cde454ce8f2506d"></span><span id="t.9"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk, rst</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clk and rst</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">dest_sel, pc_sel, sp_sel, ld_sel, st_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Selects which input to accept as new input. enum of DEST, PC, SP, LD, ST</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clr_adh, clr_bah</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Processor Control</span></p></td>
<td><p><span class="c7">Clears the high byte of ad, ba</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">alu_out, next_status</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Output from ALU and next status value. alu_out can be written to most of the registers</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">data</span></p></td>
<td><p><span class="c7">inout</span></p></td>
<td><p><span class="c7">Memory</span></p></td>
<td><p><span class="c7">Datapath to Memory. Either receives or sends data according to ld_sel and st_sel.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">a, x, y, ir, imm, adv, bav, offset, sp, pc, ad, ba, n, z, v, c, b, d, i, status</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Register outputs that can be used by different modules</span></p></td>
</tr>
</tbody>
</table>

<span class="c22">CPU Processor Control Interface</span>
--------------------------------------------------------

<span class="c7">The processor control module maintains the current state that the instruction is in and decides the control signals for the next state. Once the instruction type and addressing modes are decoded, the processor control block becomes aware of the number of cycles the instruction will take. Thereafter, at each clock cycle it generates the required control signals.</span>

<span id="t.b393916cb565d703d6fe7f4dbd36fb92b6b7db96"></span><span id="t.10"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">instruction_type</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Decode</span></p></td>
<td><p><span class="c7">Type of instruction. Belongs to enum ITYPE.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">addressing_mode</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Decode</span></p></td>
<td><p><span class="c7">Addressing mode of the opcode in instruction_register. Belongs to enum AMODE.</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">alu_ctrl</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Decode</span></p></td>
<td><p><span class="c7">ALU operation expected to be performed by the opcode, eventually. Processor control chooses to use it at a cycle appropriate for the instruction. Belongs to enum DO_OP.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">reset_adh</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Resets ADH register</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">reset_bah</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Resets BAH register</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">set_b</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Sets the B flag</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">addr_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Selects the value that needs to be set on the address bus. Belongs to enum ADDR</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">alu_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Selects the operation to be performed by the ALU in the current cycle. Belongs to enum DO_OP</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">dest_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Selects the register that receives the value from ALU output.Belongs to enum DEST</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ld_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Selects the register that will receive the value from Memory Bus. Belongs to enum LD</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">pc_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Selects the value that the PC will take next cycle. Belongs to enum PC</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">sp_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Selects the value that the SP  will take next cycle. Belongs to enum SP</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">src1_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Selects src1 for ALU. Belongs to enum SRC1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">src2_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">ALU</span></p></td>
<td><p><span class="c7">Selects src2 for ALU. Belongs to enum SRC2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">st_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
<td><p><span class="c7">Selects the register whose value will be placed on dout. Belongs to enum ST</span></p></td>
</tr>
</tbody>
</table>

<span class="c22">CPU Enums</span>
----------------------------------

<span id="t.d41042ffa22f98544df79c723d4fbbb413491765"></span><span id="t.11"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Enum name</span></p></td>
<td><p><span class="c30">Legal Values</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ITYPE</span></p></td>
<td><p><span class="c7">ARITHMETIC,BRANCH,BREAK,CMPLDX,CMPLDY,INTERRUPT,JSR,JUMP,OTHER,PULL,PUSH,RMW,RTI,RTS,STA,STX,STY</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">AMODE</span></p></td>
<td><p><span class="c7">ABSOLUTE,ABSOLUTE_INDEX,ABSOLUTE_INDEX_Y,ACCUMULATOR,IMMEDIATE,IMPLIED,INDIRECT,INDIRECT_X,INDIRECT_Y,RELATIVE,SPECIAL,ZEROPAGE,ZEROPAGE_INDEX,ZEROPAGE_INDEX_Y</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">DO_OP</span></p></td>
<td><p><span class="c7">DO_OP_ADD,DO_OP_SUB,DO_OP_AND,DO_OP_OR,DO_OP_XOR,DO_OP_ASL,DO_OP_LSR,DO_OP_ROL,DO_OP_ROR,DO_OP_SRC2DO_OP_CLR_C,DO_OP_CLR_I,DO_OP_CLR_V,DO_OP_SET_C,DO_OP_SET_I,DO_OP_SET_V</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ADDR</span></p></td>
<td><p><span class="c7">ADDR_AD,ADDR_PC,ADDR_BA,ADDR_SP,ADDR_IRQL,ADDR_IRQH</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">LD</span></p></td>
<td><p><span class="c7">LD_INSTR,LD_ADL,LD_ADH,LD_BAL,LD_BAH,LD_IMM,LD_OFFSET,LD_ADV,LD_BAV,LD_PCL,LD_PCH</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">SRC1</span></p></td>
<td><p><span class="c7">SRC1_A,SRC1_BAL,SRC1_BAH,SRC1_ADL,SRC1_PCL,SRC1_PCH,SRC1_BAV,SRC1_1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">SRC2</span></p></td>
<td><p><span class="c7">SRC2_DC,SRC2_IMM,SRC2_ADV,SRC2_X,SRC2_BAV,SRC2_C,SRC2_1,SRC2_Y,SRC2_OFFSET</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">DEST</span></p></td>
<td><p><span class="c7">DEST_BAL,DEST_BAH,DEST_ADL,DEST_A,DEST_X,DEST_Y,DEST_PCL,DEST_PCH,DEST_NONE</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">PC</span></p></td>
<td><p><span class="c50">AD_P_TO_PC,INC_PC,KEEP_PC</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">SP</span></p></td>
<td><p><span class="c50">INC_SP,DEC_SP</span></p></td>
</tr>
</tbody>
</table>

<span class="c173"></span>

1.  <span class="c109 c23">Picture Processing Unit</span>
    =====================================================

<span class="c7"></span>

<span class="c2">The NES picture processing unit or PPU is the unit responsible for handling all of the console's graphical workloads. Obviously this is useful to the CPU because it offloads the highly intensive task of rendering a frame. This means the CPU can spend more time performing the game logic. </span>

<span class="c2"></span>

<span class="c2">The PPU renders a frame by reading in scene data from various memories the PPU has access to such as VRAM, the game cart, and object attribute memory and then outputting an NTSC compliant 256x240 video signal at 60 Hz. The PPU was a special custom designed IC for Nintendo, so no other devices use this specific chip. It operates at a clock speed of 5.32 MHz making it three times faster than the NES CPU. This is one of the areas of difficulty in creating the PPU because it is easy to get the CPU and PPU clock domains out of sync.</span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c2"></span>

<span class="c22">PPU Top Level Schematic</span>
------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 625.50px; height: 355.85px;">![schemeit-project.png](images/image9.png)</span>

<span class="c23">6502: </span><span class="c7">The CPU used in the NES. Communicates with the PPU through simple load/store instructions. This works because the PPU registers are memory mapped into the CPU's address space.</span>

<span class="c23">Address Decoder:</span><span class="c7"> The address decoder is responsible for selecting the chip select of the device the CPU wants to talk to. In the case of the PPU the address decoder will activate if from addresses \[0x2000, 0x2007\].</span>

<span class="c23">VRAM:</span><span class="c7"> The PPU video memory contains the data needed to render the scene, specifically it holds the name tables. VRAM is 2 Kb in size and depending on how the PPU VRAM address lines are configured, different mirroring schemes are possible. </span>

<span class="c23">Game Cart:</span><span class="c7"> The game cart has a special ROM on it called the character ROM, or char ROM for short. the char ROM contains the sprite and background tile pattern data. These are sometimes referred to as the pattern tables. </span>

<span class="c23">PPU Registers:</span><span class="c7"> These registers allow the CPU to modify the state of the PPU. It maintains all of the control signals that are sent to both the background and sprite renderers.</span>

<span class="c23">Background Renderer:</span><span class="c7"> Responsible for drawing the background data for a scene. </span>

<span class="c23">Sprite Renderer:</span><span> Responsible for drawing the sprite data for a scene, and maintaining object attribute memory.</span>

<span class="c23">Object Attribute Memory:</span><span class="c7"> Holds all of the data needed to know how to render a sprite. OAM is 256 bytes in size and each sprite utilizes 4 bytes of data. This means the PPU can support 64 sprites.</span>

<span class="c23">Pixel Priority:</span><span class="c7"> During the visible pixel section of rendering, both the background and sprite renderers produce a single pixel each clock cycle. The pixel priority module looks at the priority values and color for each pixel and decides which one to draw to the screen. </span>

<span class="c23">VGA Interface:</span><span> This is where all of the frame data is kept in a frame buffer. This data is then upscaled to 640x480 when it goes out to the monitor.</span>

<span class="c22">PPU Memory Map</span>
---------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 421.64px; height: 466.50px;">![](images/image22.png)</span>

<span class="c134">The PPU memory map is broken up into three distinct regions, the pattern tables, name tables, and palettes. Each of these regions holds data the PPU need to obtain to render a given scanline. The functionality of each part is described in the PPU Rendering section.</span>

<span class="c22">PPU CHAROM</span>
-----------------------------------

-   <span class="c18">ROM from the cartridge is broken in two sections</span>

<!-- -->

-   <span class="c18">Program ROM</span>

<!-- -->

-   <span class="c18">Contains program code for the 6502</span>
-   <span class="c18">Is mapped into the CPU address space by the mapper</span>

<!-- -->

-   <span class="c18">Character ROM </span>

<!-- -->

-   <span class="c18">Contains sprite and background data for the PPU</span>
-   <span class="c18">Is mapped into the PPU address space by the mapper</span>

<span class="c22">PPU Rendering</span>
--------------------------------------

-   <span class="c18">Pattern Tables</span>

<!-- -->

-   <span class="c18">$0000-$2000 in VRAM</span>

<!-- -->

-   <span class="c18">Pattern Table 0 ($0000-$0FFF)</span>
-   <span class="c18">Pattern Table 1 ($1000-$2000)</span>
-   <span class="c18">The program selects which one of these contains sprites and backgrounds</span>
-   <span class="c18">Each pattern table is 16 bytes long and represents 1 8x8 pixel tile</span>

<!-- -->

-   <span class="c18">Each 8x1 row is 2 bytes long</span>
-   <span class="c18">Each bit in the byte represents a pixel and the corresponding bit for each byte is combined to create a 2 bit color.</span>

<!-- -->

-   <span class="c18">Color\_pixel = {byte2\[0\], byte1\[0\]}</span>

<!-- -->

-   <span class="c18">So there can only be 4 colors in any given tile</span>
-   <span class="c18">Rightmost bit is leftmost pixel</span>

<!-- -->

-   <span class="c18">Any pattern that has a value of 0 is transparent i.e. the background color</span>

<span class="c18"></span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 414.58px; height: 172.50px;">![](images/image15.png)</span>

<span class="c18"></span>

-   <span class="c18">Name Tables</span>

<!-- -->

-   <span class="c18">$2000-$2FFF in VRAM with $3000-$3EFF as a mirror</span>
-   <span class="c18">Laid out in memory in 32x30 fashion</span>

<!-- -->

-   <span class="c18">Think of as a 2d array where each element specifies a tile in the pattern table.</span>
-   <span class="c18">This results in a resolution of 256x240</span>

<!-- -->

-   <span class="c18">Although the PPU supports 4 name tables the NES only supplied enough VRAM for 2 this results in 2 of the 4 name tables being mirror</span>

<!-- -->

-   <span class="c18">Vertically = horizontal movement</span>
-   <span class="c18">Horizontally = vertical movement</span>

<!-- -->

-   <span class="c18">Each entry in the name table refers to one pattern table and is one byte. Since there are 32x30=960 entries each name table requires 960 bytes of space the left over 64 bytes are used for attribute tables</span>
-   <span class="c18">Attribute tables</span>

<!-- -->

-   <span class="c18">1 byte entries that contains the palette assignment for a 2x2 grid of tiles</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 216.00px; height: 254.72px;">![](images/image10.png)</span>

<span class="c18"></span>

-   <span class="c18">Sprites</span>

<!-- -->

-   <span class="c18">Just like backgrounds sprite tile data is contained in one of the pattern tables</span>
-   <span class="c18">But unlike backgrounds sprite information is not contained in name tables but in a special reserved 256 byte RAM called the object attribute memory (OAM)</span>

<!-- -->

-   <span class="c18">Object Attribute Memory</span>

<!-- -->

-   <span class="c18">256 bytes of dedicated RAM</span>
-   <span class="c18">Each object is allocated 4 bytes of OAM so we can store data about 64 sprites at once</span>
-   <span class="c18">Each object has the following information stored in OAM</span>

<!-- -->

-   <span class="c18">X Coordinate</span>
-   <span class="c18">Y Coordinate</span>
-   <span class="c18">Pattern Table Index</span>
-   <span class="c18">Palette Assignment</span>
-   <span class="c18">Horizontal/Vertical Flip</span>

<!-- -->

-   <span class="c18">Palette Table</span>

<!-- -->

-   <span class="c18">Located at $3F00-$3F20</span>

<!-- -->

-   <span class="c18">$3F00-$3F0F is background palettes</span>
-   <span class="c18">$3F10-$3F1F is sprite palettes</span>

<!-- -->

-   <span class="c18">Mirrored all the way to $4000</span>
-   <span class="c18">Each color takes one byte</span>
-   <span class="c18">Every background tile and sprite needs a color palette.</span>
-   <span class="c18">When the background or sprite is being rendered the the color for a specific table is looked up in the correct palette and sent to the draw select mux.</span>

<!-- -->

-   <span class="c18">Rendering is broken into two parts which are done for each horizontal scanline</span>

<!-- -->

-   <span class="c18">Background Rendering</span>

<!-- -->

-   <span class="c18">The background enable register ($2001) controls if the default background color is rendered ($2001) or if background data from the background renderer.</span>
-   <span class="c18">The background data is obtained for every pixel.</span>

<!-- -->

-   <span class="c18">Sprite Rendering</span>

<!-- -->

-   <span class="c18">The sprite renderer has room for 8 unique sprites on each scanline.</span>
-   <span class="c18">For each scanline the renderer looks through the OAM for sprites that need to be drawn on the scanline. If this is the case the sprite is loaded into the scanline local sprites</span>

<!-- -->

-   <span class="c18">If this number exceeds 8 a flag is set and the behavior is undefined.</span>

<!-- -->

-   <span class="c144 c69 c186">If a sprite should be drawn for a pixel instead of the background the sprite renderer sets the sprite priority line to a mux that decides what to send to the screen and the mux selects the sprite color d</span><span class="c144 c69 c186">ata.</span>

<span class="c22">PPU Memory Mapped Registers</span>
----------------------------------------------------

<span class="c7">The PPU register interface exists so the CPU can modify and fetch the state elements of the PPU. These state elements include registers that set control signals, VRAM, object attribute memory, and palettes. These state elements then determine how the background and sprite renderers will draw the scene. The PPU register module also contains the pixel mux and palette memory which are used to determine what pixel data to send to the VGA module.</span>

<span id="t.2410c3dd563250403a6a2b073e837692eff20a19"></span><span id="t.12"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">data[7:0]</span></p></td>
<td><p><span class="c7">inout</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Bi directional data bus between the CPU/PPU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">address[2:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Register select</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">CPU read/write select</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">cs_in</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">PPU chip select</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">irq</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Signal PPU asserts to trigger CPU NMI</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">pixel_data[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">RGB pixel data to be sent to the display</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vram_addr_out[13:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">VRAM address to read/write from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vram_rw_sel</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">Determines if the current vram operation is a read or write</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vram_data_out[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">Data to write to VRAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">frame_end</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Signals the VGA interface that this is the end of a frame</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">frame_start</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Signals the VGA interface that a frame is starting to keep the PPU and VGA in sync</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rendering</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Signals the VGA interface that pixel data output is valid</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c7"></span>

<span class="c22">PPU Register Block Diagram</span>
---------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 370.50px; height: 351.34px;">![Untitled Diagram.png](images/image20.png)</span>

<span class="c22">PPU Register Descriptions</span>
--------------------------------------------------

-   <span class="c134">Control registers are mapped into the CPUs address space (</span><span class="c18">$2000 - $2007)</span>
-   <span class="c2 c69">The registers are repeated every eight bytes until address $3FF</span>
-   <span class="c69 c23 c144">PPUCTRL\[7:0\] (</span><span class="c18">$2000) WRITE</span>

<!-- -->

-   <span class="c18">\[1:0\]: Base nametable address which is loaded at the start of a frame</span>

<!-- -->

-   <span class="c18">0: $2000</span>
-   <span class="c18">1: $2400</span>
-   <span class="c18">2: $2800</span>
-   <span class="c18">3: $2C00</span>

<!-- -->

-   <span class="c18">\[2\]: VRAM address increment per CPU read/write of PPUDATA</span>

<!-- -->

-   <span class="c18">0: Add 1 going across</span>
-   <span class="c18">1: Add 32 going down</span>

<!-- -->

-   <span class="c18">\[3\]: Sprite pattern table for 8x8 sprites</span>

<!-- -->

-   <span class="c18">0: $0000</span>
-   <span class="c18">1: $1000</span>
-   <span class="c18">Ignored in 8x16 sprite mode</span>

<!-- -->

-   <span class="c18">\[4\]: Background pattern table address</span>

<!-- -->

-   <span class="c18">0: $0000</span>
-   <span class="c18">1: $1000</span>

<!-- -->

-   <span class="c18">\[5\]: Sprite size</span>

<!-- -->

-   <span class="c18">0: 8x8</span>
-   <span class="c18">1: 8x16</span>

<!-- -->

-   <span class="c18">\[6\]: PPU master/slave select</span>

<!-- -->

-   <span class="c18">0: Read backdrop from EXT pins</span>
-   <span class="c18">1: Output color on EXT pins</span>

<!-- -->

-   <span class="c18">\[7\]: Generate NMI interrupt at the start of vertical blanking interval</span>

<!-- -->

-   <span class="c18">0: off</span>
-   <span class="c18">1: on</span>

<!-- -->

-   <span class="c144 c69 c23">PPUMASK\[7:0\] </span><span class="c18">($2001) WRITE</span>

<!-- -->

-   <span class="c18">\[0\]: Use grayscale image</span>

<!-- -->

-   <span class="c18">0: Normal color</span>
-   <span class="c18">1: Grayscale</span>

<!-- -->

-   <span class="c18">\[1\]: Show left 8 pixels of background</span>

<!-- -->

-   <span class="c18">0: Hide</span>
-   <span class="c18">1: Show background in leftmost 8 pixels of screen</span>

<!-- -->

-   <span class="c18">\[2\]: Show left 8 piexels of sprites</span>

<!-- -->

-   <span class="c18">0: Hide</span>
-   <span class="c18">1: Show sprites in leftmost 8 pixels of screen</span>

<!-- -->

-   <span class="c18">\[3\]: Render the background</span>

<!-- -->

-   <span class="c18">0: Don’t show background</span>
-   <span class="c18">1: Show background</span>

<!-- -->

-   <span class="c18">\[4\]: Render the sprites</span>

<!-- -->

-   <span class="c18">0: Don’t show sprites</span>
-   <span class="c18">1: Show sprites</span>

<!-- -->

-   <span class="c18">\[5\]: Emphasize red</span>
-   <span class="c18">\[6\]: Emphasize green</span>
-   <span class="c18">\[7\]: Emphasize blue</span>

<!-- -->

-   <span class="c144 c69 c23">PPUSTATUS\[7:0\] </span><span class="c18">($2002) READ</span>

<!-- -->

-   <span class="c18">\[4:0\]: Nothing?</span>
-   <span class="c18">\[5\]: Set for sprite overflow which is when more than 8 sprites exist in one scanline (Is actually more complicated than this to do a hardware bug)</span>
-   <span class="c18">\[6\]: Sprite 0 hit. This bit gets set when a non zero part of sprite zero overlaps a non zero background pixel</span>
-   <span class="c18">\[7\]: Vertical blank status register</span>

<!-- -->

-   <span class="c18">0: Not in vertical blank</span>
-   <span class="c18">1: Currently in vertical blank</span>

<!-- -->

-   <span class="c144 c69 c23">OAMADDR\[7:0\] </span><span class="c18">($2003) WRITE</span>

<!-- -->

-   <span class="c18">Address of the object attribute memory the program wants to access</span>

<!-- -->

-   <span class="c144 c69 c23">OAMDATA\[7:0\] </span><span class="c18">($2004) READ/WRITE</span>

<!-- -->

-   <span class="c18">The CPU can read/write this register to read or write to the PPUs object attribute memory. The address should be specified by writing the OAMADDR register beforehand. Each write will increment the address by one, but a read will not modify the address</span>

<!-- -->

-   <span class="c144 c69 c23">PPUSCROLL\[7:0\] </span><span class="c18">($2005) WRITE</span>

<!-- -->

-   <span class="c18">Tells the PPU what pixel of the nametable selected in PPUCTRL should be in the top left hand corner of the screen</span>

<!-- -->

-   <span class="c144 c69 c23">PPUADDR\[7:0\] </span><span class="c18">($2006) WRITE</span>

<!-- -->

-   <span class="c18">Address the CPU wants to write to VRAM before writing a read of PPUSTATUS is required and then two bytes are written in first the high byte then the low byte</span>

<!-- -->

-   <span class="c144 c69 c23">PPUDATA\[7:0\] </span><span class="c18">($2007) READ/WRITE</span>

<!-- -->

-   <span class="c18">Writes/Reads data from VRAM for the CPU. The value in PPUADDR is then incremented by the value specified in PPUCTRL</span>

<!-- -->

-   <span class="c144 c69 c23">OAMDMA\[7:0\]</span><span class="c18"> ($4014) WRITE</span>

<!-- -->

-   <span class="c144 c69 c186">A write of $XX to this register will result in the CPU memory page at $XX00-$XXFF being written into the PPU object attribute memory</span>

<span class="c22">PPU Background Renderer</span>
------------------------------------------------

<span class="c7">The background renderer is responsible for rendering the background for each frame that is output to the VGA interface. It does this by prefetching the data for two tiles at the end of the previous scanline. And then begins to continuously fetch tile data for every pixel of the visible frame. This allows the background renderer to produce a steady flow of output pixels despite the fact it takes 8 cycles to fetch 8 pixels of a scanline.</span>

<span id="t.cfcc5323a0745a2d21a0d8ca697f3e16babd2727"></span><span id="t.13"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">bg_render_en</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Background render enable</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">x_pos[9:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current pixel for the active scanline</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">y_pos[9:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current scanline being rendered</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vram_data_in[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current data that has been read in from VRAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">bg_pt_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects the location of the background renderer pattern table</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">show_bg_left_col</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Determines if the background for the leftmost 8 pixels of each scanline will be drawn</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">fine_x_scroll[2:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects the pixel drawn on the left hand side of the screen</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">coarse_x_scroll[4:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects the tile to start rendering from in the x direction</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">fine_y_scroll[2:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects the pixel drawn on the top of the screen</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">coarse_y_scroll[4:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects the tile to start rendering from in the y direction</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">nametable_sel[1:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects the nametable to start rendering from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">update_loopy_v</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Signal to update the temporary vram address</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cpu_loopy_v_inc</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Signal to increment the temporary vram address by the increment amount</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">cpu_loopy_v_inc_amt</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">If this signal is set increment the temp vram address by 32 on cpu_loopy_v_inc, and increment by 1 if it is not set on cpu_loopy_v_inc</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vblank_out</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Determines it the PPU is in vertical blank</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">bg_rendering_out</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Determines if the bg renderer is requesting vram reads</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">bg_pal_sel[3:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Pixel Mux</span></p></td>
<td><p><span class="c7">Selects the palette for the background pixel</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">loopy_v_out[14:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The temporary vram address register for vram reads/writes</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vram_addr_out[13:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">The VRAM address the sprite renderer wants to read from</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">PPU Background Renderer Diagram</span>
--------------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 326.64px; height: 420.71px;">![Untitled Diagram.png](images/image18.png)</span>

<span class="c23">VRAM:</span><span class="c7"> The background renderer reads from two of the three major areas of address space available to the PPU, the pattern tables, and the name tables. First the background renderer needs the name table byte for a given tile to know which tile to draw in the background. Once it has this information is need the pattern to know how to draw the background tile.</span>

<span class="c23">PPU Register Interface:</span><span class="c7"> All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.</span>

<span class="c23">Scrolling Register:</span><span class="c7"> The scrolling register is responsible for keeping track of what tile is currently being drawn to the screen. </span>

<span class="c23">Scrolling Update Logic: </span><span class="c7">Every time the data for a background tile is successfully fetched the scrolling register needs to be updated. Most of the time it is a simple increment, but more care has to be taken when the next tile falls in another name table. This logic allows the scrolling register to correctly update to be able to smoothly jump between name tables while rendering. </span>

<span class="c23">Background Renderer State Machine: </span><span class="c7">The background renderer state machine is responsible for sending the correct control signals to all of the other modules as the background is rendering. </span>

<span class="c23">Background Shift Registers:</span><span class="c7"> These registers shift out the pixel data to be rendered on every clock cycle. They also implement the logic that makes fine one pixel scrolling possible by changing what index of the shift registers is the one being shifted out each cycle.</span>

<span class="c23">Pixel Priority Mux: </span><span class="c7">Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.</span>

<span class="c22">PPU Sprite Renderer</span>
--------------------------------------------

<span class="c7">The PPU sprite renderer is used to render all of the sprite data for each scanline. The way the hardware was designed it only allows for 64 sprites to kept in object attribute memory at once. There are only 8 spots available to store the sprite data for each scanline so only 8 sprites can be rendered for each scanline. Sprite data in OAM is evaluated for the next scanline while the background renderer is mastering the VRAM bus. When rendering reaches horizontal blank the sprite renderer fetches the pattern data for all of the sprites to be rendered on the next scanline and places the data in the sprite shift registers. The sprite x position is also loaded into a down counter which determines when to make the sprite active and shift out the pattern data on the next scanline.</span>

<span id="t.cdbc9e2f9b853601435427311431e91e21b12696"></span><span id="t.14"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_render_en</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Sprite renderer enable signal</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">x_pos[9:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current pixel for the active scanline</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">y_pos[9:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current scanline being rendered</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">spr_addr_in[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current OAM address being read/written</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_data_in[7:0]</span></p></td>
<td><p><span class="c7">inout</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">The current data being read/written from OAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vram_data_in[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">The data the sprite renderer requested from VRAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cpu_oam_rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Selects if OAM is being read from or written to from the CPU</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">cpu_oam_req</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Signals the CPU wants to read/write OAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_pt_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Determines the PPU pattern table address in VRAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">spr_size_sel</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Determines the size of the sprites to be drawn</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">show_spr_left_col</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Determines if sprites on the leftmost 8 pixels of each scanline will be drawn</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">spr_overflow</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">If more than 8 sprites fall on a single scanline this is set</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_pri_out</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Pixel Mux</span></p></td>
<td><p><span class="c7">Determines the priority of the sprite pixel data</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">spr_data_out[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">returns oam data the CPU requested</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_pal_sel[3:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Pixel Mux</span></p></td>
<td><p><span class="c7">Sprite pixel color data to be drawn</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vram_addr_out[13:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">Sprite vram read address</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_vram_req</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VRAM</span></p></td>
<td><p><span class="c7">Signals the sprite renderer is requesting a VRAM read</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">spr_0_rendering</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">Pixel Mux</span></p></td>
<td><p><span class="c7">Determines if the current sprite that is rendering is sprite 0</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">inc_oam_addr</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Signals the OAM address in the registers to increment</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">PPU Sprite Renderer Diagram</span>
----------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 556.77px; height: 408.55px;">![Untitled Diagram.png](images/image12.png)</span>

<span class="c76 c23"></span>

<span class="c76 c23"></span>

<span class="c76 c23"></span>

<span class="c23">VRAM:</span><span> The sprite renderer need to be able to fetch the sprite pattern data from the character rom. This is why it can request VRAM reads from this region through the PPU Register Interface</span>

<span class="c23">PPU Register Interface:</span><span> All background rendering VRAM reads are performed through the PPU register interface. This allows for vram address bus arbitration between the background renderer, sprite renderer, and the cpu.</span><span class="c76 c23"> </span>

<span class="c23">Object Attribute Memory:</span><span class="c7"> OAM contains all of the data needed to render a sprite to the screen except the pattern data itself. For each sprite OAM holds its x position, y position, horizontal flip, vertical flip, and palette information. In total OAM supports 64 sprites.</span>

<span class="c23">Sprite Renderer State Machine:</span><span class="c7"> The sprite renderer state machine is responsible for sending all of the control signals to each of the other units in the renderer. This includes procesing the data in OAM, move the correct sprites to secondary OAM, VRAM reads, and shifting out the sprite data when the sprite needs to be rendered to the screen.</span>

<span class="c23">Sprite Shift Registers:</span><span class="c7"> The sprite shift registers hold the sprite pixel data for sprites on the current scanline. When a sprite becomes active its data is shifted out to the pixel priority mux.</span>

<span class="c23">Pixel Priority Mux: </span><span>Since both the sprite renderer and background renderer output one pixel every clock cycle during the visible part of the frame, there needs to be some logic to pick between the two pixels that are output. The pixel priority mux does this based on the priority of the sprite pixel, and the color of both the sprite pixel and background pixel.</span>

<span class="c23">Temporary Sprite Data:</span><span class="c7"> The temporary sprite data is where the state machine moves the current sprite being evaluated in OAM to. If the temporary sprite falls on the next scanline its data is moved into a slot in secondary OAM. If it does not the data is discarded.</span>

<span class="c23">Secondary Object Attribute Memory:</span><span class="c7"> Secondary OAM holds the sprite data for sprites that fall on the next scanline. During hblank this data is used to load the sprite shift registers with the correct sprite pattern data.</span>

<span class="c23">Sprite Counter and Priority Registers:</span><span> These registers hold the priority information for each sprite in the sprite shift registers. It also holds a down counter for each sprite which is loaded with the sprite's x position. When the counter hits 0 the corresponding sprite becomes active and the sprite data needs to be shifted out to the screen.</span>

<span class="c22">PPU Object Attribute Memory</span>
----------------------------------------------------

<span class="c7"></span>

<span id="t.c1d0725151e3ae45852fd0f9196d5e83cf527c44"></span><span id="t.15"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">oam_en</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">OAM</span></p></td>
<td><p><span class="c7">Determines if the input data is for a valid read/write</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">oam_rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">OAM</span></p></td>
<td><p><span class="c7">Determines if the current operation is a read or write</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">spr_select[5:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">OAM</span></p></td>
<td><p><span class="c7">Determines which sprite is being read/written</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">byte_select[1:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">OAM</span></p></td>
<td><p><span class="c7">Determines which sprite byte is being read/written</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">data_in[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">OAM</span></p></td>
<td><p><span class="c7">Data to write to the specified OAM address</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">data_out[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU Register</span></p></td>
<td><p><span class="c7">Data that has been read from OAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">PPU Palette Memory</span>
-------------------------------------------

<span class="c7"></span>

<span id="t.f1d3489e5c353600b2df513bca63b64f963856ac"></span><span id="t.16"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">pal_addr[4:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">palette mem</span></p></td>
<td><p><span class="c7">Selects the palette to read/write in the memory</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">pal_data_in[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">palette mem</span></p></td>
<td><p><span class="c7">Data to write to the palette memory</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">palette_mem_rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">palette mem</span></p></td>
<td><p><span class="c7">Determines if the current operation is a read or write</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">palette_mem_en</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">palette mem</span></p></td>
<td><p><span class="c7">Determines if the palette mem inputs are valid</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">color_out[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Returns the selected palette for a given address on a read</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">VRAM Interface</span>
---------------------------------------

<span class="c7">The VRAM interface instantiates an Altera RAM IP core. Each read take 2 cycles one for the input and one for the output</span>

<span id="t.40d96b8d3f361e8568937a45000f4fd566ca150c"></span><span id="t.17"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vram_addr[10:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">Address from VRAM to read to or write from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vram_data_in[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">The data to write to VRAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vram_en</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">The VRAM enable signal</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vram_rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">Selects if the current op is a read or write</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">vram_data_out[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">The data that was read from VRAM on a read</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22"></span>
-------------------------

<span class="c22">DMA</span>
----------------------------

<span class="c7">The DMA is used to copy 256 bytes of data from the CPU address space into the OAM (PPU address space). The DMA is 4x faster than it would be to use str and ldr instructions to copy the data. While copying data, the CPU is stalled.</span>

<span id="t.529fd0b7b6c6112b07e37b86cf3de0f87c25e96e"></span><span id="t.18"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">oamdma</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">When written to, the DMA will begin copying data to the OAM. If the value written here is XX then the data that will be copied begins at the address XX00 in the CPU RAM and goes until the address XXFF. Data will be copied to the OAM starting at the OAM address specified in the OAMADDR register of the OAM.</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">cpu_ram_q</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">Data read in from CPU RAM will come here</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">dma_done</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Informs the CPU to pause while the DMA copies OAM data from the CPU RAM to the OAM section of the PPU RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">cpu_ram_addr</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">The address of the CPU RAM where we are reading data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cpu_ram_wr</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">Read/write enable signal for CPU RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">oam_data</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">OAM</span></p></td>
<td><p><span class="c7">The data that will be written to the OAM at the address specified in OAMADDR</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">dma_req</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">APU</span></p></td>
<td><p><span class="c7">High when the DMC wants to use the DMA</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">dma_ack</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">APU</span></p></td>
<td><p><span class="c7">High when data on DMA</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">dma_addr</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">APU</span></p></td>
<td><p><span class="c7">Address for DMA to read from ** CURRENTLY NOT USED **</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">dma_data</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">APU</span></p></td>
<td><p><span class="c7">Data from DMA to apu memory ** CURRENTLY NOT USED **</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c7"></span>

<span class="c22">PPU Testbench</span>
--------------------------------------

<span class="c7">In a single frame the PPU outputs 61,440 pixels. Obviously this amount of information would be incredibly difficult for a human to verify as correct by looking at a simulation waveform. This is what drove me to create a testbench capable of rendering full PPU frames to an image. This allowed the process of debugging the PPU to proceed at a much faster rate than if I used waveforms alone. Essentially how the test bench works is the testbench sets the initial PPU state, it lets the PPU render a frame, and then the testbench receives the data for each pixel and generates a PPM file. The testbench can render multiple frames in a row, so the tester can see how the frame output changes as the PPU state changes.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 409.38px; height: 165.80px;">![Untitled Diagram.png](images/image14.png)</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 388.22px; height: 240.99px;">![Untitled Diagram.png](images/image17.png)</span>

<span class="c22">PPU Testbench PPM file format</span>
------------------------------------------------------

<span class="c7">The PPM image format is one of the easiest to understand image formats available. This is mostly because of how it is a completely human readable format. A PPM file simply consists of a header, and then pixel data. The header consists of the text “P3” on the first line, followed by the image width and height on the next line, then a max value for each of the rgb components of a pixel on the final line of the header. After the header it is just width \* height rgb colors in row major order.</span>

<span class="c22"></span>
-------------------------

<span class="c22"></span>
-------------------------

<span class="c22">PPU Testbench Example Renderings</span>
---------------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 197.53px; height: 186.50px;">![test (1).png](images/image5.png)</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 200.68px; height: 187.50px;">![test (2).png](images/image7.png)</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 199.53px; height: 189.50px;">![test (3).png](images/image6.png)</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 202.30px; height: 187.50px;">![test (4).png](images/image19.png)</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 201.50px; height: 187.67px;">![test (5).png](images/image26.png)</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 198.60px; height: 186.50px;">![test (10).png](images/image8.png)</span>

1.  <span>Memor</span><span>y Maps</span>
    =====================================

<span class="c7">Cartridges are a Read-Only Memory that contains necessary data to run games. However, it is possible that in some cases that a cartridge holds more data than the CPU can address to. In this case, memory mapper comes into play and changes the mapping as needed so that one address can point to multiple locations in a cartridge. For our case, the end goal was to get the game Super Mario Bros. running on our FPGA. This game does not use a memory mapper, so we did not work on any memory mappers. In the future, we might add support for the other memory mapping systems so that we can play other games.</span>

<span class="c7">These were two ip catalog ROM blocks that are created using MIF files for Super Mario Bros. They contained the information for the CPU and PPU RAM and VRAM respectively.</span>

<span class="c22"></span>
-------------------------

<span class="c22">PPU ROM Memory Map</span>
-------------------------------------------

<span class="c7">This table shows how the PPU’s memory is laid out. The Registers are explained in greater detail in the Architecture Document.</span>

<span id="t.d3aeb09ef995373f509588bfbe093c2a247a33be"></span><span id="t.19"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Address Range</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x0000 - 0x0FFF</span></p></td>
<td><p><span class="c7">Pattern Table 0</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x1000 - 0x1FFF</span></p></td>
<td><p><span class="c7">Pattern Table 1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x2000 - 0x23BF</span></p></td>
<td><p><span class="c7">Name Table 0</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x23C0 - 0x23FF</span></p></td>
<td><p><span class="c7">Attribute Table 0</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x2400 - 0x27BF</span></p></td>
<td><p><span class="c7">Name Table 1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x27C0 - 0x27FF</span></p></td>
<td><p><span class="c7">Attribute Table 1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x2800 - 0x2BBF</span></p></td>
<td><p><span class="c7">Name Table 2</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x2BC0 - 0x2BFF</span></p></td>
<td><p><span class="c7">Attribute Table 2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x2C00 - 0x2FBF</span></p></td>
<td><p><span class="c7">Name Table 3</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x2FC0 - 0x2FFF</span></p></td>
<td><p><span class="c7">Attribute Table 3</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x3000 - 0x3EFF</span></p></td>
<td><p><span class="c7">Mirrors 0x2000 - 0x2EFF</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x3F00 - 0x3F0F</span></p></td>
<td><p><span class="c7">Background Palettes</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x3F10 - 0x3F1F</span></p></td>
<td><p><span class="c7">Sprite Palettes</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x3F20 - 0x3FFF</span></p></td>
<td><p><span class="c7">Mirrors 0x3F00 - 0x3F1F</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x4000 - 0xFFFF</span></p></td>
<td><p><span class="c7">Mirrors 0x0000 - 0x3FFF</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">CPU ROM Memory Map</span>
-------------------------------------------

<span class="c7">This table explains how the CPU’s memory is laid out. The Registers are explained in greater detail in the Architecture document.</span>

<span id="t.3ea006ae6c40b543eff9ac9fa3559a879d0621f6"></span><span id="t.20"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Address Range</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x0000 - 0x00FF</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x0100 - 0x1FF</span></p></td>
<td><p><span class="c7">Stack</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x0200 - 0x07FF</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x0800 - 0x1FFF</span></p></td>
<td><p><span class="c7">Mirrors 0x0000 - 0x07FF</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x2000 - 0x2007</span></p></td>
<td><p><span class="c7">Registers</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x2008 - 0x3FFF</span></p></td>
<td><p><span class="c7">Mirrors 0x2000 - 0x2007</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x4000 - 0x401F</span></p></td>
<td><p><span class="c7">I/O Registers</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x4020 - 0x5FFF</span></p></td>
<td><p><span class="c7">Expansion ROM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0x6000 - 0x7FFF</span></p></td>
<td><p><span class="c7">SRAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">0x8000 - 0xBFFF</span></p></td>
<td><p><span class="c7">Program ROM Lower Bank</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">0xC000 - 0xFFFF</span></p></td>
<td><p><span class="c7">Program ROM Upper Bank</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">Memory Mappers Interface</span>
-------------------------------------------------

<span id="t.a7c474da3306d0e8e99e8d3a20902e581a1043cc"></span><span id="t.21"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rd</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU/PPU</span></p></td>
<td><p><span class="c7">Read request</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">addr</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU/PPU</span></p></td>
<td><p><span class="c7">Address to read from</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">data</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU/PPU</span></p></td>
<td><p><span class="c7">Data from the address</span></p></td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

<span class="c109 c23"></span>
==============================

1.  <span class="c109 c23">APU</span>
    =================================

<span class="c7">Due to limitations of our FPGA design board (no D2A converter) and time constraints, our group did not implement the APU. Instead, we created the register interface for the APU, so that the CPU could still read and write from the registers. The following section is provided for reference only.</span>

<span>The NES included an Audio Processing Unit (APU) to control all sound output. The APU contains five audio channels: two pulse wave modulation channels, a triangle wave channel, a noise channel (fo</span><span>r</span><span class="c7"> random audio), and a delta modulation channel. Each channel is mapped to registers in the CPU’s address space and each channel runs independently of the others. The outputs of all five channels are then combined using a non-linear mixing scheme. The APU also has a dedicated APU Status register. A write to this register can enable/disable any of the five channels. A read to this register can tell you if each channel still has a positive count on their respective timers. In addition, a read to this register will reveal any DMC or frame interrupts.</span>

<span class="c22"> APU Registers</span>
---------------------------------------

<span id="t.ef2c0e3f9254f624e8fccd0f50ed51a04d039588"></span><span id="t.22"></span>

<span class="c30">Registers</span>

<span class="c7">$4000</span>

<span class="c7">First pulse wave</span>

<span class="c7">DDLC VVVV</span>

<span class="c7">Duty, Envelope Loop, Constant Volume, Volume</span>

<span class="c7">$4001</span>

<span class="c7">First pulse wave</span>

<span class="c7">EPPP NSSS</span>

<span class="c7">Enabled, Period, Negate, Shift</span>

<span class="c7">$4002</span>

<span class="c7">First pulse wave</span>

<span class="c7">TTTT TTTT</span>

<span class="c7">Timer low</span>

<span class="c7">$4003</span>

<span class="c7">First pulse wave</span>

<span class="c7">LLLL LTTT</span>

<span class="c7">Length counter load, Timer high</span>

<span class="c7">$4004</span>

<span class="c7">Second pulse wave</span>

<span class="c7">DDLC VVVV</span>

<span class="c7">Duty, Envelope Loop, Constant Volume, Volume</span>

<span class="c7">$4005</span>

<span class="c7">Second pulse wave</span>

<span class="c7">EPPP NSSS</span>

<span class="c7">Enabled, Period, Negate, Shift</span>

<span class="c7">$4006</span>

<span class="c7">Second pulse wave</span>

<span class="c7">TTTT TTTT</span>

<span class="c7">Timer low</span>

<span class="c7">$4007</span>

<span class="c7">Second pulse wave</span>

<span class="c7">LLLL LTTT</span>

<span class="c7">Length counter load, Timer high</span>

<span class="c7">$4008</span>

<span class="c7">Triangle wave</span>

<span class="c7">CRRR RRRR</span>

<span class="c7">Length counter control, linear count load</span>

<span class="c7">$4009</span>

<span class="c7">Triangle wave</span>

<span class="c7"></span>

<span class="c7">Unused</span>

<span class="c7">$400A</span>

<span class="c7">Triangle wave</span>

<span class="c7">TTTT TTTT</span>

<span class="c7">Timer low</span>

<span class="c7">$400B</span>

<span class="c7">Triangle wave</span>

<span class="c7">LLLL LTTT</span>

<span class="c7">Length counter load, Timer high</span>

<span class="c7">$400C</span>

<span class="c7">Noise Channel</span>

<span class="c7">--LC  VVVV</span>

<span class="c7">Envelope Loop, Constant Volume, Volume</span>

<span class="c7">$400D</span>

<span class="c7">Noise Channel</span>

<span class="c7"></span>

<span class="c7">Unused</span>

<span class="c7">$400E</span>

<span class="c7">Noise Channel</span>

<span class="c7">L---  PPPP</span>

<span class="c7">Loop Noise, Noise Period</span>

<span class="c7">$400F</span>

<span class="c7">Noise Channel</span>

<span class="c7">LLLL  L---</span>

<span class="c7">Length counter load</span>

<span class="c7">$4010</span>

<span class="c7">Delta modulation channel</span>

<span class="c7">IL-- FFFF</span>

<span class="c7">IRQ enable, Loop, Frequency</span>

<span class="c7">$4011</span>

<span class="c7">Delta modulation channel</span>

<span class="c7">-LLL  LLLL</span>

<span class="c7">Load counter</span>

<span class="c7">$4012</span>

<span class="c7">Delta modulation channel</span>

<span class="c7">AAAA AAAA</span>

<span class="c7">Sample Address</span>

<span class="c7">$4013</span>

<span class="c7">Delta modulation channel</span>

<span class="c7">LLLL LLLL</span>

<span class="c7">Sample Length</span>

<span class="c7">$4015 (write)</span>

<span class="c7">APU Status Register Writes</span>

<span class="c7">---D NT21</span>

<span class="c7">Enable DMC, Enable Noise, Enable Triangle, Enable Pulse 2/1</span>

<span class="c7">$4015 (read)</span>

<span class="c7">APU Status Register Read</span>

<span class="c7">IF-D NT21</span>

<span class="c7">DMC Interrupt, Frame Interrupt, DMC Active, Length Counter &gt; 0 for Noise, Triangle, and Pulse Channels</span>

<span class="c7">$4017 (write)</span>

<span class="c7">APU Frame Counter</span>

<span class="c7">MI-- ----</span>

<span class="c7">Mode (0 = 4 step, 1 = 5 step), IRQ inhibit flag</span>

------------------------------------------------------------------------

<span class="c109 c23"></span>
==============================

1.  <span class="c109 c23">Controllers (SPART)</span>
    =================================================

<span class="c7">The controller module allows users to provide input to the FPGA. We opted to create a controller simulator program instead of using an actual NES joypad. This decision was made because the NES controllers used a proprietary port and because the available USB controllers lacked specification sheets. The simulator program communicates with the FPGA using the SPART interface, which is similar to UART. Our SPART module used 8 data bits, no parity, and 1 stop bit for serial communication. All data was received automatically into an 8 bit buffer by the SPART module at 2400 baud. In addition to the SPART module, we also needed a controller driver to allow the CPU to interface with the controllers. The controllers are memory mapped to $4016 and $4017 for CPU to read.</span>

<span class="c7">When writing high to address $4016 bit 0, the controllers are continuously loaded with the states of each button. Once address $4016 bit 0 is cleared, the data from the controllers can be read by reading from address $4016 for player 1 or $4017 for player 2. The data will be read in serially on bit 0. The first read will return the state of button A, then B, Select, Start, Up, Down, Left, Right. It will read 1 if the button is pressed and 0 otherwise. Any read after clearing $4016 bit 0 and after reading the first 8 button values, will be a 1. If the CPU reads when before clearing $4016, the state of button A with be repeatedly returned.</span>

<span class="c22">Debug Modification</span>
-------------------------------------------

<span class="c7">In order to provide an easy way to debug our top level design, we modified the controller to send an entire ram block out over SPART when it receives the send\_states signal. This later allowed us to record the PC, IR, A, X, Y, flags, and SP of the CPU into a RAM block every CPU clock cycle and print this out onto a terminal console when we reached a specific PC.</span>

<span class="c22">Controller Registers</span>
---------------------------------------------

<span id="t.f48da44243cd4a3f2f9d86b2a46e440bbc5c870d"></span><span id="t.23"></span>

<span class="c30">Registers</span>

<span class="c7">$4016 (write)</span>

<span class="c7">Controller Update</span>

<span class="c7">---- ---C</span>

<span class="c7">Button states of both controllers are loaded</span>

<span class="c7">$4016 (read)</span>

<span class="c7">Controller 1 Read</span>

<span class="c7">---- ---C</span>

<span class="c7">Reads button states of controller 1 in the order A, B, Start, Select, Up, Down, Left, Right</span>

<span class="c7">$4017 (read)</span>

<span class="c7">Controller 2 Read</span>

<span class="c7">---- ---C</span>

<span class="c7">Reads button states of controller 2 in the order A, B, Start, Select, Up, Down, Left, Right</span>

<span class="c22">Controllers Wrapper</span>
--------------------------------------------

<span class="c7">The controllers wrapper acts as the top level interface for the controllers. It instantiates two Controller modules and connects each one to separate TxD RxD lines. In addition, the Controllers wrapper handles passing the cs, addr, and rw lines into the controllers correctly. Both controllers receive an address of 0 for controller writes, while controller 1 will receive address 0 for reads and controller 2 will receive address 1. </span>

### <span class="c57 c23">Controller Wrapper Diagram</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 431.00px; height: 271.48px;">![](images/image16.png)</span>

### <span class="c57 c23">Controller Wrapper Interface</span>

<span id="t.547db5e3cba569b697a57d71bdba389e98fcd63f"></span><span id="t.24"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c135">Signal name</span></p></td>
<td><p><span class="c135">Signal Type</span></p></td>
<td><p><span class="c135">Source/Dest</span></p></td>
<td><p><span class="c135">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">TxD1</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">UART</span></p></td>
<td><p><span class="c7">Transmit data line for controller 1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">TxD2</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">UART</span></p></td>
<td><p><span class="c7">Transmit data line for controller 2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">RxD1</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">UART</span></p></td>
<td><p><span class="c7">Receive data line for controller 1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">RxD2</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">UART</span></p></td>
<td><p><span class="c7">Receive data line for controller 2</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">addr</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Controller address, 0 for $4016, 1 for $4017</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">cpubus[7:0]</span></p></td>
<td><p><span class="c7">inout</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Data from/to the CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cs</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Chip select</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Read/Write signal (high for reads)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rx_data_peek</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">LEDR[7:0]</span></p></td>
<td><p><span class="c7">Output states to the FPGA LEDs to show that input was being received</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">send_states</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">When this signal goes high, the controller begins outputting RAM data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cpuram_q</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">Stored CPU states from the RAM block</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rd_addr</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">The address the controller is writing out to SPART</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rd</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">High when controller is reading from CPU RAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">Controller</span>
-----------------------------------

<span class="c7">The controller module instantiates the Driver and SPART module’s.</span>

### <span class="c57 c23">Controller Diagram</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 444.76px; height: 242.50px;">![](images/image21.png)</span>

### <span class="c57 c23">Controller Interface</span>

<span id="t.bb0222080501ccd3509902d3def0cd1f0ab3985c"></span><span id="t.25"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">TxD</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">UART</span></p></td>
<td><p><span class="c7">Transmit data line</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">RxD</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">UART</span></p></td>
<td><p><span class="c7">Receive data line</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">addr</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Controller address 0 for $4016, 1 for $4017</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">dout[7:0]</span></p></td>
<td><p><span class="c7">inout</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Data from/to the CPU</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cs</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Chip select</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rw</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU</span></p></td>
<td><p><span class="c7">Read write signal (low for writes)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rx_data_peek</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">LEDR</span></p></td>
<td><p><span class="c7">Outputs button states to FPGA LEDs</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">send_states</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">When this signal goes high, the controller begins outputting RAM data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">cpuram_q</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">Stored CPU states from the RAM block</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rd_addr</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">The address the controller is writing out to SPART</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rd</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">CPU RAM</span></p></td>
<td><p><span class="c7">High when controller is reading from CPU RAM</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">Special Purpose Asynchronous Receiver and Transmitter (SPART)</span>
--------------------------------------------------------------------------------------

<span class="c188">The SPART Module is used to receive serial data. The SPART and driver share many interconnections in order to control the reception and transmission of data. On the left, the SPART interfaces to an 8- bit, 3-state bidirectional bus, DATABUS\[7:0\]. This bus is used to transfer data and control information between the driver and the SPART. In addition, there is a 2-bit address bus, IOADDR\[1:0\] which is used to select the particular register that interacts with the DATABUS during an I/O operation. The IOR/W signal determines the direction of data transfer between the driver and SPART. For a Read (IOR/W=1), data is transferred from the SPART to the driver and for a Write (IOR/W=0), data is transferred from the driver to the SPART. IOCS and IOR/W are crucial signals in properly controlling the three-state buffer on DATABUS within the SPART. Receive Data Available (RDA), is a status signal which indicates that a byte of data has been received and is ready to be read from the SPART to the Processor. When the read operation is performed, RDA is reset. Transmit Buffer Ready (TBR) is a status signal which indicates that the transmit buffer in the SPART is ready to accept a byte for transmission. When a write operation is performed and the SPART is not ready for more transmission data, TBR is reset. The SPART is fully synchronous with the clock signal CLK; this implies that transfers between the driver and SPART can be controlled by applying IOCS, IOR/W, IOADDR, and DATABUS (in the case of a write operation) for a single clock cycle and capturing the transferred data on the next positive clock edge. The received data on RxD, however, is asynchronous with respect</span><span> </span><span class="c188">to CLK. Also, the serial I/O port on the workstation which receives the transmitted data from TxD has no access to CLK. This interface thus constitutes the “A” for “Asynchronous” in SPART and requires an understanding of RS-232 signal timing and (re)synchronization.</span>

<span>SPART Diagram & Interface</span>

------------------------------------------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 491.16px; height: 308.00px;">![](images/image11.png)</span>

<span class="c22">Controller Driver</span>
------------------------------------------

<span class="c7">The controller driver is tasked with reloading the controller button states from the SPART receiver buffer when address $4016 (or $0 from controller’s point of view) is set. In addition, the driver must grab the CPU databus on a read and place a button value on bit 0. On the first read, the button state of value A is placed on the databus, followed by B, Select, Start, Up, Down, Left, Right. The value will be 1 for pressed and 0 for not pressed. After reading the first 8 buttons, the driver will output a 0 on the databus. Lastly, the controller driver can also be used to control the SPART module to output to the UART port of the computer.</span>

### <span class="c57 c23">Controller Driver State Machine</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 549.33px;">![](images/image13.png)</span>

------------------------------------------------------------------------

<span class="c109 c23"></span>
==============================

1.  <span class="c109 c23">VGA</span>
    =================================

<span class="c7">The VGA interface consists of sending the pixel data to the screen one row at a time from left to right. In between each row it requires a special signal called horizontal sync (hsync) to be asserted at a specific time when only black pixels are being sent, called the blanking interval. This happens until the bottom of the screen is reached when another blanking interval begins where the interface is only sending black pixels, but instead of hsync being asserted the vertical sync signal is asserted. </span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 350.00px; height: 266.00px;">![](images/image23.png)</span>

<span class="c7">The main difficulty with the VGA interface will be designing a system to take the PPU output (a 256x240 image) and converting it into a native resolution of 640x480 or 1280x960. This was done by adding two RAM blocks to buffer the data.</span>

<span class="c22">VGA Diagram</span>
------------------------------------

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 527.40px; height: 285.54px;">![](images/image24.png)</span>

<span class="c22">VGA Interface</span>
--------------------------------------

<span id="t.0b4df1c79bd101595fde9cf3c1fde60b0b71da17"></span><span id="t.26"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">V_BLANK_N</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Syncing each pixel</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_R[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Red pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_G[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Green pixel value</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_B[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Blue pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_CLK</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">VGA clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_HS</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Horizontal line sync</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_SYNC_N</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">0</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_VS</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Vertical line sync</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">pixel_data[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">Pixel data to be sent to the display</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ppu_clock</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">pixel data is updated every ppu clock cycle</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rendering</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">high when PPU is rendering</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">frame_end</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">high at the end of a PPU frame</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">frame_start</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">high at start of PPU frame</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">VGA Clock Gen</span>
--------------------------------------

<span class="c7">This module takes in a 50MHz system clock and creates a 25.175MHz clock, which is the standard VGA clock speed.</span>

<span id="t.db67cd3b6f294595ac31a0aea59a47ead9f1be93"></span><span id="t.27"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span>VGA_CLK</span></p></td>
<td><p><span>output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Clock synced to VGA timing</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">locked</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">Locks VGA until clock is ready</span></p></td>
</tr>
</tbody>
</table>

<span class="c22">VGA Timing Gen</span>
---------------------------------------

<span class="c7">This block is responsible for generating the timing signals for VGA with a screen resolution of 480x640. This includes the horizontal and vertical sync signals as well as the blank signal for each pixel.</span>

<span id="t.479f40eaa1ae54a4dbe23dc6f8fb1ac9c0dbacf1"></span><span id="t.28"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_CLK</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Clock Gen</span></p></td>
<td><p><span class="c7">vga_clk</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">V_BLANK_N</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA, Ram Reader</span></p></td>
<td><p><span class="c7">Syncing each pixel</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_HS</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Horizontal line sync</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_VS</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">Vertical line sync</span></p></td>
</tr>
</tbody>
</table>

<span class="c22"></span>
-------------------------

<span class="c22">VGA Display Plane</span>
------------------------------------------

<span class="c7">The PPU will output sprite and background pixels to the VGA module, as well as enables for each. The display plane will update the RAM block at the appropriate address with the pixel data on every PPU clock cycle when the PPU is rendering.</span>

<span id="t.5a3c07c6be733afbbfea8913bd13a94fa777ca2d"></span><span id="t.29"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System clock</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ppu_clock</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">Clock speed that the pixels from the PPU come in</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">wr_address</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">Address to write to</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">wr_req</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">Write data to the RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">data_out[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">The pixel data to store in RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">pixel_data[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">Pixel data to be sent to the display</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rendering</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">high when PPU is rendering</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">frame_start</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">high at start of PPU frame</span></p></td>
</tr>
</tbody>
</table>

<span class="c22"></span>
-------------------------

<span class="c22">VGA RAM Wrapper</span>
----------------------------------------

<span class="c7">This module instantiates two 2-port RAM blocks and using control signals, it will have the PPU write to a specific RAM block, while the VGA reads from another RAM block. The goal of this module was to make sure that the PPU writes never overlap the VGA reads, because the PPU runs at a faster clock rate. </span>

<span id="t.73d8ab931bb1de11920ee6fbbb98ace8684a3d59"></span><span id="t.30"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">wr_address</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Display Plane</span></p></td>
<td><p><span class="c7">Address to write to</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">wr_req</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Display Plane</span></p></td>
<td><p><span class="c7">Request to write data</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">data_in[5:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Display Plane</span></p></td>
<td><p><span class="c7">The data into the RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rd_req</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">RAM Reader</span></p></td>
<td><p><span class="c7">Read data out from RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rd_address</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">RAM Reader</span></p></td>
<td><p><span class="c7">Address to read from</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">data_out[5:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM Reader</span></p></td>
<td><p><span class="c7">data out from RAM</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ppu_frame_end</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">PPU</span></p></td>
<td><p><span class="c7">high at the end of a PPU frame</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">vga_frame_end</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">VGA</span></p></td>
<td><p><span class="c7">high at end of VGA frame</span></p></td>
</tr>
</tbody>
</table>

<span class="c22"></span>
-------------------------

<span class="c22">VGA RAM Reader</span>
---------------------------------------

<span class="c7">The RAM Reader is responsible for reading data from the correct address in the RAM block and outputting it as an RGB signal to the VGA. It will update the RGB signals every time the blank signal goes high. The NES supported a 256x240 image, which we will be converting to a 640x480 image. This means that the 256x240 image will be multiplied by 2, resulting in a 512x480 image. The remaining 128 pixels on the horizontal line will be filled with black pixels by this block. Lastly, this block will take use the pixel data from the PPU and the NES Palette RGB colors, to output the correct colors to the VGA.</span>

<span class="c7"></span>

<span class="c7"></span>

<span id="t.42c807ab21e38b5395f49bf60866dd95219157f1"></span><span id="t.31"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Signal name</span></p></td>
<td><p><span class="c30">Signal Type</span></p></td>
<td><p><span class="c30">Source/Dest</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">clk</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rst_n</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">System active low reset</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">rd_req</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">Read data out from RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">rd_address</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">Address to read from</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">data_out[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">RAM</span></p></td>
<td><p><span class="c7">data out from RAM</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_R[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">VGA Red pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_G[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">VGA Green pixel value</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">VGA_B[7:0]</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">VGA Blue pixel value</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">VGA_Blnk[7:0]</span></p></td>
<td><p><span class="c7">input</span></p></td>
<td><p><span class="c7">Time Gen</span></p></td>
<td><p><span class="c7">VGA Blank signal (high when we write each new pixel)</span></p></td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

<span class="c109 c23"></span>
==============================

1.  <span class="c109 c23">Software</span>
    ======================================

<span class="c22">Controller Simulator</span>
---------------------------------------------

<span class="c7">In order to play games on the NES and provide input to our FPGA, we will have a java program that uses the JSSC (Java Simple Serial Connector) library to read and write data serially using the SPART interface. The program will provides a GUI that was created using the JFrame library. This GUI will respond to mouse clicks as well as key presses when the window is in focus. When a button state on the simulator is changed, it will trigger the program to send serial data. When data is detected on the rx line, the simulator will read in the data (every time there is 8 bytes in the buffer) and will output this data as a CPU trace to an output file. Instructions to invoke this program can be found in the README file of our github directory.</span>

### <span class="c57 c23">Controller Simulator State Machine </span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 346.76px; height: 336.00px;">![](images/image25.png)</span>

### <span class="c57 c23">Controller Simulator Output Packet Format</span>

<span id="t.ad9e3dcf59b3c7f193497b3a552afdad72d4c697"></span><span id="t.32"></span>

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Packet name</span></p></td>
<td><p><span class="c30">Packet type</span></p></td>
<td><p><span class="c30">Packet Format</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Controller Data</span></p></td>
<td><p><span class="c7">output</span></p></td>
<td><p><span class="c7">ABST-UDLR</span></p></td>
<td><p><span class="c7">This packet indicates which buttons are being pressed. A 1 indicates pressed, a 0 indicates not pressed. </span></p>
<p><span class="c7">(A) A button, (B) B button, (S) Select button, (T) Start button, (U) Up, (D) Down, (L) Left, (R) Right</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

### <span class="c57 c23">Controller Simulator GUI and Button Map</span>

<span class="c7">The NES controller had a total of 8 buttons, as shown below.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 257.33px;">![](images/image4.png)</span>

<span class="c7">The NES buttons will be mapped to specific keys on the keyboard. The keyboard information will be obtained using KeyListeners in the java.awt.\* library. The following table indicates how the buttons are mapped and their function in Super Mario Bros.</span>

<span id="t.ad380988598047a9ceb5cfe38e7d802123c4d7be"></span><span id="t.33"></span>

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Keyboard button</span></p></td>
<td><p><span class="c30">NES Equivalent</span></p></td>
<td><p><span class="c30">Super Mario Bros. Function</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">X Key</span></p></td>
<td><p><span class="c7">A Button</span></p></td>
<td><p><span class="c7">Jump (Hold to jump higher)</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">Z Key</span></p></td>
<td><p><span class="c7">B Button</span></p></td>
<td><p><span class="c7">Sprint (Hold and use arrow keys)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Tab Key</span></p></td>
<td><p><span class="c7">Select Button</span></p></td>
<td><p><span class="c7">Pause Game</span></p></td>
</tr>
<tr class="odd">
<td><p><span>Enter Key</span></p></td>
<td><p><span>Start Button</span></p></td>
<td><p><span>Start Game</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Up Arrow</span></p></td>
<td><p><span class="c7">Up on D-Pad</span></p></td>
<td><p><span class="c7">No function</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">Down Arrow</span></p></td>
<td><p><span class="c7">Down on D-Pad</span></p></td>
<td><p><span class="c7">Enter pipe (only works on some pipes)</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">Left Arrow</span></p></td>
<td><p><span class="c7">Left on D-Pad</span></p></td>
<td><p><span class="c7">Move left</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">Right Arrow</span></p></td>
<td><p><span class="c7">Right on D-Pad</span></p></td>
<td><p><span class="c7">Move right</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22">Assembler</span>
----------------------------------

<span class="c7">We will include an assembler that allows custom software to be developed for our console. This assembler will convert assembly code to machine code for the NES on .mif files that we can load into our FPGA. It will include support for labels and commenting.The ISA is specified in the table below:</span>

<span class="c7"></span>

### <span class="c57 c23">Opcode Table</span>

<span id="t.a78dffae99888f28a7d901ca905aed1ef15fecc7"></span><span id="t.34"></span>

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
<td><p><span class="c122 c23">Opcode</span></p></td>
<td><p><span class="c122 c23">Mode</span></p></td>
<td><p><span class="c23 c122">Hex</span></p></td>
<td><p><span class="c122 c23">Opcode</span></p></td>
<td><p><span class="c122 c23">Mode</span></p></td>
<td><p><span class="c122 c23">Hex</span></p></td>
<td><p><span class="c122 c23">Opcode</span></p></td>
<td><p><span class="c122 c23">Mode</span></p></td>
<td><p><span class="c122 c23">Hex</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">69</span></p></td>
<td><p><span class="c7">DEC</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">C6</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">0D</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">65</span></p></td>
<td><p><span class="c7">DEC</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">D6</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">1D</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">75</span></p></td>
<td><p><span class="c7">DEC</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">CE</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">19</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">6D</span></p></td>
<td><p><span class="c7">DEC</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">DE</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">01</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">7D</span></p></td>
<td><p><span class="c7">DEX</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">CA</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">11</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">79</span></p></td>
<td><p><span class="c7">DEY</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">88</span></p></td>
<td><p><span class="c7">PHA</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">48</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">61</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">49</span></p></td>
<td><p><span class="c7">PHP</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">08</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ADC</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">71</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">45</span></p></td>
<td><p><span class="c7">PLA</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">68</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">29</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">55</span></p></td>
<td><p><span class="c7">PLP</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">28</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">25</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">4D</span></p></td>
<td><p><span class="c7">ROL</span></p></td>
<td><p><span class="c7">Accumulator</span></p></td>
<td><p><span class="c7">2A</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">35</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">5D</span></p></td>
<td><p><span class="c7">ROL</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">26</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">2D</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">59</span></p></td>
<td><p><span class="c7">ROL</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">36</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">3D</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">41</span></p></td>
<td><p><span class="c7">ROL</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">2E</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">39</span></p></td>
<td><p><span class="c7">EOR</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">51</span></p></td>
<td><p><span class="c7">ROL</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">3E</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">21</span></p></td>
<td><p><span class="c7">INC</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">E6</span></p></td>
<td><p><span class="c7">ROR</span></p></td>
<td><p><span class="c7">Accumulator</span></p></td>
<td><p><span class="c7">6A</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">AND</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">31</span></p></td>
<td><p><span class="c7">INC</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">F6</span></p></td>
<td><p><span class="c7">ROR</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">66</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ASL</span></p></td>
<td><p><span class="c7">Accumulator</span></p></td>
<td><p><span class="c7">0A</span></p></td>
<td><p><span class="c7">INC</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">EE</span></p></td>
<td><p><span class="c7">ROR</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">76</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ASL</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">06</span></p></td>
<td><p><span class="c7">INC</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">FE</span></p></td>
<td><p><span class="c7">ROR</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">6E</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ASL</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">16</span></p></td>
<td><p><span class="c7">INX</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">E8</span></p></td>
<td><p><span class="c7">ROR</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">7E</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">ASL</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">0E</span></p></td>
<td><p><span class="c7">INY</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">C8</span></p></td>
<td><p><span class="c7">RTI</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">40</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">ASL</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">1E</span></p></td>
<td><p><span class="c7">JMP</span></p></td>
<td><p><span class="c7">Indirect</span></p></td>
<td><p><span class="c7">6C</span></p></td>
<td><p><span class="c7">RTS</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">60</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">BCC</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">90</span></p></td>
<td><p><span class="c7">JMP</span></p></td>
<td><p><span class="c7">Absolute </span></p></td>
<td><p><span class="c7">4C</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">E9</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">BCS</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">B0</span></p></td>
<td><p><span class="c7">JSR</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">20</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">E5</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">BEQ</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">F0</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">A9</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">F5</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">BIT</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">24</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">A5</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">ED</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">BIT</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">2C</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">B5</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">FD</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">BMI</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">30</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">AD</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">F9</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">BNE</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">D0</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">BD</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">E1</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">BPL</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">10</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">B9</span></p></td>
<td><p><span class="c7">SBC</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">F1</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">BRK</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">00</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">A1</span></p></td>
<td><p><span class="c7">SEC</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">38</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">BVC</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">50</span></p></td>
<td><p><span class="c7">LDA</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">B1</span></p></td>
<td><p><span class="c7">SED</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">F8</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">BVS</span></p></td>
<td><p><span class="c7">Relative</span></p></td>
<td><p><span class="c7">70</span></p></td>
<td><p><span class="c7">LDX</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">A2</span></p></td>
<td><p><span class="c7">SEI</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">78</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CLC</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">18</span></p></td>
<td><p><span class="c7">LDX</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">A6</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">85</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CLD</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">D8</span></p></td>
<td><p><span class="c7">LDX</span></p></td>
<td><p><span class="c7">Zero Page, Y</span></p></td>
<td><p><span class="c7">B6</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">95</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CLI</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">58</span></p></td>
<td><p><span class="c7">LDX</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">AE</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">8D</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CLV</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">B8</span></p></td>
<td><p><span class="c7">LDX</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">BE</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">9D</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">C9</span></p></td>
<td><p><span class="c7">LDY</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">A0</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">99</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">C5</span></p></td>
<td><p><span class="c7">LDY</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">A4</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">81</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">D5</span></p></td>
<td><p><span class="c7">LDY</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">B4</span></p></td>
<td><p><span class="c7">STA</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">91</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">CD</span></p></td>
<td><p><span class="c7">LDY</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">AC</span></p></td>
<td><p><span class="c7">STX</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">86</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">DD</span></p></td>
<td><p><span class="c7">LDY</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">BC</span></p></td>
<td><p><span class="c7">STX</span></p></td>
<td><p><span class="c7">Zero Page, Y</span></p></td>
<td><p><span class="c7">96</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Absolute, Y</span></p></td>
<td><p><span class="c7">D9</span></p></td>
<td><p><span class="c7">LSR</span></p></td>
<td><p><span class="c7">Accumulator</span></p></td>
<td><p><span class="c7">4A</span></p></td>
<td><p><span class="c7">STX</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">8E</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Indirect, X</span></p></td>
<td><p><span class="c7">C1</span></p></td>
<td><p><span class="c7">LSR</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">46</span></p></td>
<td><p><span class="c7">STY</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">84</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CMP</span></p></td>
<td><p><span class="c7">Indirect, Y</span></p></td>
<td><p><span class="c7">D1</span></p></td>
<td><p><span class="c7">LSR</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">56</span></p></td>
<td><p><span class="c7">STY</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">94</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CPX</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">E0</span></p></td>
<td><p><span class="c7">LSR</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">4E</span></p></td>
<td><p><span class="c7">STY</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">8C</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CPX</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">E4</span></p></td>
<td><p><span class="c7">LSR</span></p></td>
<td><p><span class="c7">Absolute, X</span></p></td>
<td><p><span class="c7">5E</span></p></td>
<td><p><span class="c7">TAX</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">AA</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CPX</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">EC</span></p></td>
<td><p><span class="c7">NOP</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">EA</span></p></td>
<td><p><span class="c7">TAY</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">A8</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CPY</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">C0</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Immediate</span></p></td>
<td><p><span class="c7">09</span></p></td>
<td><p><span class="c7">TSX</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">BA</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">CPY</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">C4</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Zero Page</span></p></td>
<td><p><span class="c7">05</span></p></td>
<td><p><span class="c7">TXA</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">8A</span></p></td>
</tr>
<tr class="odd">
<td><p><span class="c7">CPY</span></p></td>
<td><p><span class="c7">Absolute</span></p></td>
<td><p><span class="c7">CC</span></p></td>
<td><p><span class="c7">ORA</span></p></td>
<td><p><span class="c7">Zero Page, X</span></p></td>
<td><p><span class="c7">15</span></p></td>
<td><p><span class="c7">TXS</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">9A</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7"></span></p></td>
<td><p><span class="c7">TYA</span></p></td>
<td><p><span class="c7">Implied</span></p></td>
<td><p><span class="c7">98</span></p></td>
</tr>
</tbody>
</table>

### <span class="c57 c23">NES Assembly Formats</span>

<span class="c7">Our assembler will allow the following input format, each instruction/label will be on its own line. In addition unlimited whitespace is allowed:</span>

<span id="t.785c03daa4e813953d8cbf70f3d9e2ff7a6c8246"></span><span id="t.35"></span>

<span class="c30">Instruction Formats</span>

<span class="c30">Instruction Type</span>

<span class="c30">Format</span>

<span class="c30">Description</span>

<span class="c7">Constant</span>

<span class="c7">Constant\_Name = &lt;Constant Value&gt;</span>

<span class="c7">Must be declared before CPU\_Start</span>

<span class="c7">Label</span>

<span class="c7">Label\_Name:</span>

<span class="c7">Cannot be the same as an opcode name. Allows reference from branch opcodes.</span>

<span class="c7">Comment</span>

<span class="c7">; Comment goes here</span>

<span class="c7">Anything after the ; will be ignored</span>

<span class="c7">CPU Start</span>

<span class="c7">\_CPU:</span>

<span class="c7">Signals the start of CPU memory</span>

<span class="c7">Accumulator</span>

<span class="c7">&lt;OPCODE&gt;</span>

<span class="c7">Accumulator is value affected by Opcode</span>

<span class="c7">Implied</span>

<span class="c7">&lt;OPCODE&gt;</span>

<span class="c7">Operands implied by opcode. ie. TXA has X as source and Accumulator as destination</span>

<span class="c7">Immediate</span>

<span class="c7">&lt;OPCODE&gt; \#&lt;Immediate&gt;</span>

<span class="c7">The decimal number will be converted to binary and used as operand</span>

<span class="c7">Absolute</span>

<span class="c7">&lt;OPCODE&gt; $&lt;ADDR/LABEL&gt;</span>

<span class="c7">The byte at the specified address is used as operand</span>

<span class="c7">Zero Page</span>

<span class="c7">&lt;OPCODE&gt; $&lt;BYTE OFFSET&gt;</span>

<span class="c7">The byte at address $00XX is used as operand.</span>

<span class="c7">Relative</span>

<span class="c7">&lt;OPCODE&gt; $&lt;BYTE OFFSET/LABEL&gt;</span>

<span class="c7">The byte at address PC +/- Offset is used as operand. Offset can range -128 to +127</span>

<span class="c7">Absolute Index</span>

<span class="c7">&lt;OPCODE&gt; $&lt;ADDR/LABEL&gt;,&lt;X or Y&gt;</span>

<span class="c7">Absolute but value in register added to address.</span>

<span class="c7">Zero Page Index</span>

<span class="c7">&lt;OPCODE&gt; $&lt;BYTE OFFSET&gt;,&lt;X or Y&gt;</span>

<span class="c7">Zero page but value in register added to offset.</span>

<span class="c7">Zero Page X Indexed Indirect</span>

<span class="c7">&lt;OPCODE&gt; ($&lt;BYTE OFFSET&gt;,X)</span>

<span class="c7">Value in X added to offset. Address in $00XX (where XX is new offset) is used as the address for the operand.</span>

<span class="c7">Zero Page Y Indexed Indirect</span>

<span class="c7">&lt;OPCODE&gt; ($&lt;BYTE OFFSET&gt;),Y</span>

<span class="c7">The address in $00XX, where XX is byte offset, is added to the value in Y and is used as the address for the operand.</span>

<span class="c7">Data instruction</span>

<span class="c7">&lt;.DB or .DW&gt; &lt;data values&gt;</span>

<span class="c7">If .db then the data values must be bytes, if .dw then the data values must be 2 bytes. Multiple comma separated data values can be include for each instruction. Constants are valid.</span>

<span class="c7"></span>

<span class="c7"></span>

<span id="t.1cff97851711fad7eb43d3937b11aea5c574f346"></span><span id="t.36"></span>

<span class="c30">Number Formats</span>

<span class="c7">Immediate Decimal (Signed)</span>

<span class="c7">\#&lt;(-)DDD&gt;</span>

<span class="c7">Max 127, Min -128</span>

<span class="c7">Immediate Hexadecimal (Signed)</span>

<span class="c7">\#$&lt;HH&gt;</span>

<span class="c7"></span>

<span class="c7">Immediate Binary (Signed)</span>

<span class="c7">\#%&lt;BBBB.BBBB&gt;</span>

<span class="c7">Allows ‘.’ in between bits</span>

<span class="c7">Address/Offset Hex</span>

<span class="c7">$&lt;Addr/Offset&gt;</span>

<span class="c7">8 bits offset, 16 bits address</span>

<span class="c7">Address/Offset Binary</span>

<span class="c7">$%&lt;Addr/Offset&gt;</span>

<span class="c7">8 bits offset, 16 bits address</span>

<span class="c7">Offset Decimal (Relative only)</span>

<span class="c7">\#&lt;(-)DDD&gt;</span>

<span class="c7">Relative instructions can’t be Immediate, so this is allowed.</span>

<span class="c7">Max 127, Min -128</span>

<span class="c7">Constant first byte</span>

<span class="c7">&lt;Constant\_Name</span>

<span class="c7"></span>

<span class="c7">Constant second byte</span>

<span class="c7">&gt;Constant\_Name</span>

<span class="c7"></span>

<span class="c7">Constant</span>

<span class="c7">Constant\_Name</span>

<span class="c7"></span>

<span class="c7">Label</span>

<span class="c7">Label\_Name</span>

<span class="c7">Not valid for data instructions</span>

### <span class="c57 c23"></span>

### <span class="c57 c23">Invoking Assembler</span>

<span id="t.6f668fdd16c4e436778a938b5c4f34d93bcf4744"></span><span id="t.37"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Usage</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">java NESAssemble &lt;input file&gt; &lt;cpuouput.mif&gt; &lt;ppuoutput.mif&gt;</span></p></td>
<td><p><span class="c7">Reads the input file and outputs the CPU ROM to cpuoutput.mif and the PPU ROM to ppuoutput.mif</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22"> iNES ROM Converter</span>
--------------------------------------------

<span class="c7">Most NES games are currently available online in files of the iNES format, a header format used by most software NES emulators. Our NES will not support this file format. Instead, we will write a java program that takes an iNES file as input and outputs two .mif files that contain the CPU RAM and the PPU VRAM. These files will be used to instantiate the ROM’s of the CPU and PPU in our FPGA.</span>

<span id="t.634ae5c55415151724744d13c7cc9c9a4d7dbd40"></span><span id="t.38"></span>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><span class="c30">Usage</span></p></td>
<td><p><span class="c30">Description</span></p></td>
</tr>
<tr class="even">
<td><p><span class="c7">java NEStoMIF &lt;input.nes&gt; &lt;cpuouput.mif&gt; &lt;ppuoutput.mif&gt;</span></p></td>
<td><p><span class="c7">Reads the input file and outputs the CPU RAM to cpuoutput.mif and the PPU VRAM to ppuoutput.mif</span></p></td>
</tr>
</tbody>
</table>

<span class="c7"></span>

<span class="c22"> Tic Tac Toe</span>
-------------------------------------

<span class="c7">We also implemented Tic Tac Toe in assembly for initial integration tests. We bundled it into a NES ROM, and thus can run it on existing emulators as well as our own hardware.</span>

1.  <span class="c109 c23">Testing & Debug</span>
    =============================================

<span class="c7">Our debugging process had multiple steps</span>

<span class="c22">Simulation</span>
-----------------------------------

<span class="c7">For basic sanity check, we simulated each module independently to make sure the signals behave as expected.</span>

<span class="c22">Test</span>
-----------------------------

<span>For detailed check, we wrote an automated testbench to confirm the functionality. The CPU test suite was from </span><span class="c62"><a href="https://www.google.com/url?q=https://github.com/Klaus2m5/&amp;sa=D&amp;ust=1494576244503000&amp;usg=AFQjCNE1JiHYAJCYI_1k7L-Si52PIFKh4g" class="c24">https://github.com/Klaus2m5/</a></span><span> and we modified the test suite to run on the fceux NES emulator.</span>

<span>I</span><span class="c22">ntegrated Simulation</span>
-----------------------------------------------------------

<span class="c7">After integration, we simulated the whole system with the ROM installed. We were able to get a detailed information at each cycle but the simulation took too long. It took about 30 minutes to simulate CPU operation for one second. Thus we designed a debug and trace module in hardware that could output CPU traces during actual gameplay..</span>

<span class="c22">Tracer</span>
-------------------------------

<span>We added additional code in Controller so that the Controller can store information at every cycle and dump them back to the serial console under some condition. At first, we used a button as the trigger, but after</span><span> we analyzed the exact problem, we used a conditional statement(for e.g. when PC reached a certain address) to trigger the dump. When the condition was met, the Controller would stall the CPU and start dumping what the CPU has been doing, in the opposite order of execution. The technique was extremely useful because we came to the conclusion that there must be a design defect when Mario crashed, such as using don’t cares or high impedance. After we corrected the defect, we were able to run Mario.</span>

------------------------------------------------------------------------

1.  <span>Results</span>
    ====================

<span class="c7">We were able to get NES working, thanks to our rigorous verification process, and onboard debug methodology. Some of the games we got working include Super Mario Bros, Galaga, Tennis, Golf, Donkey Kong, Ms Pacman, Defender II, Pinball, and Othello.  </span>

1.  <span class="c109 c23">Possible Improvements</span>
    ===================================================

-   <span class="c7">Create a working audio processing unit</span>
-   <span class="c7">More advanced memory mapper support</span>
-   <span class="c7">Better image upscaling such as hqx</span>
-   <span class="c7">Support for actual NES game carts</span>
-   <span class="c7">HDMI</span>
-   <span class="c7">VGA buffer instead of two RAM blocks to save space</span>

1.  <span>References and Links</span>
    =================================

<span class="c69">Ferguson, Scott. "PPU Tutorial." N.p., n.d. Web. &lt;</span><span class="c62 c69"><a href="https://www.google.com/url?q=https://opcode-defined.quora.com&amp;sa=D&amp;ust=1494576244513000&amp;usg=AFQjCNGLV8QOBaofHlIJOuV4MyLC4brQkA" class="c24">https://opcode-defined.quora.com</a></span><span class="c7 c69">&gt;.</span>

<span class="c69"> "6502 Specification." </span><span class="c69">NesDev</span><span class="c69">. N.p., n.d. Web. 10 May 2017. &lt;</span><span class="c62 c69"><a href="https://www.google.com/url?q=http://nesdev.com/6502.txt&amp;sa=D&amp;ust=1494576244515000&amp;usg=AFQjCNG5m7S_waprlfT8QEhROiwN8d3KEg" class="c24">http://nesdev.com/6502.txt</a></span><span class="c7 c69">&gt;.</span>

<span class="c69">Dormann, Klaus. "6502 Functional Test Suite." </span><span class="c69 c128">GitHub</span><span class="c69">. N.p., n.d. Web. 10 May 2017.        &lt;</span><span class="c62 c69"><a href="https://www.google.com/url?q=https://github.com/Klaus2m5/&amp;sa=D&amp;ust=1494576244517000&amp;usg=AFQjCNEEtPtcean98c-J5CKdpY_Jus6jpg" class="c24">https://github.com/Klaus2m5/</a></span><span class="c7 c69">&gt;.</span>

<span class="c69">"NES Reference Guide." </span><span class="c69">Nesdev</span><span class="c69">. N.p., n.d. Web. 10 May 2017. &lt;</span><span class="c62 c69"><a href="https://www.google.com/url?q=http://wiki.nesdev.com/w/index.php/NES_reference_guide&amp;sa=D&amp;ust=1494576244519000&amp;usg=AFQjCNGuyHPsCpyewUgjRkVM37mEHaV7cA" class="c24">http://wiki.nesdev.com/w/index.php/NES_reference_guide</a></span><span class="c7 c69">&gt;.</span>

<span class="c69">Java Simple Serial Connector library: &lt;</span><span class="c62 c69"><a href="https://www.google.com/url?q=https://github.com/scream3r/java-simple-serial-connector&amp;sa=D&amp;ust=1494576244520000&amp;usg=AFQjCNGCf07L43dARQngxpg7jOja1xHf_g" class="c24">https://github.com/scream3r/java-simple-serial-connector</a></span><span class="c7 c69">&gt;</span>

<span class="c69">Final Github release: &lt;</span><span class="c62 c69"><a href="https://www.google.com/url?q=https://github.com/jtgebert/fpganes_release&amp;sa=D&amp;ust=1494576244521000&amp;usg=AFQjCNH9NK9NdKBC9Ar1pU5FpDYAy5dhiA" class="c24">https://github.com/jtgebert/fpganes_release</a></span><span class="c7 c69">&gt;</span>

<span class="c7 c69"></span>

<span class="c7 c69"></span>

<span class="c7 c69"></span>

<span class="c109 c23"></span>
==============================

<span class="c7"></span>

<span class="c7"></span>

1.  <span>Co</span><span class="c109 c23">ntributions</span>
    ========================================================

<span class="c22">Eric Sullivan</span>
--------------------------------------

<span>Designed and debugged the NES picture processing unit, created a comprehensive set of PPU testbenches to verify functionality, Integrated the VGA to the PPU, implemented the DMA and dummy APU, started a CPU simulator in python, Helped debug the integrated system.</span>

<span class="c22">Patrick Yang</span>
-------------------------------------

<span>Specified the CPU microarchitecture along with Pavan, designed the ALU, registers, and memory interface unit, wrote a self checking testbench, responsible for CPU debug, integrated all modules on top level file, and debugged of the integrated system. Helped Jon to modify controller driver to also be an onboard CPU trace module.</span>

<span class="c22">Pavan Holla</span>
------------------------------------

<span class="c7">Specified the CPU microarchitecture along with Patrick, designed the decoder and interrupt handler, and wrote the script that generates the processor control module. Modified a testsuite and provided the infrastructure for CPU verification. Wrote tic tac toe in assembly as a fail-safe game.  Also, worked on a parallel effort to integrate undocumented third party NES IP.</span>

<span>Jonathan Ebert</span>
---------------------------

<span>Modified the VGA to interface with the PPU. W</span><span>rote a new driver to control our existing SPART module to act as a NES controller and as an onboard CPU trace module. Wrote Java program to communicate with the SPART module using the JSSC library. Wrote memory wrappers, hardware decoder, and generated all game ROMs. Helped debug the integrated system. Wrote a very simple assembler. Wrote script to convert NES ROMs to MIF files. Also, worked on a parallel effort to integrate undocumented third party NES IP</span><span>.</span>

<span class="c7"></span>
