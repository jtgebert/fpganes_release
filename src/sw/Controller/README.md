<!-- PLEASE OPEN THIS DOCUMENT IN GITHUB, it has been marked up for github and might be confusing when viewing raw format-->
# Controller Simulator #

![controller_simulator.gih](../../../imgs/controller_simulator.gif?raw=true)

The controller simulator can be used to interact with our FPGA via serial communcation. Using the provided USB to GPIO cable, we connected our computer(s) to specific GPIO pins on the GPIO0 header. Then, the Controller.java file uses the JSSC (Java Simple Serial Connector) library to open the serial communcation ports on our computers, which allows the computer to send bytes to the FPGA.


GPIO cable header placement:
----------------------------

The GPIO-UART cables for both players will be connected to the GPIO0 header. For player 1, connect the GPIO end of the cable to the upper-right most 6 GPIO pins. The black GPIO female wire, or ground, should be connected to the bottom-most of these 6 pins. Player 2 will be mirrored horizontally from player 1. The GPIO cable will be connected to the bottom-right most 6 GPIO pins with the black GPIO female wire, or ground, connected to the upper-most of these 6 pins.


Downloading the JSSC Library:
-----------------------------

The JSSC library can be found here: [JSSC Download](http://search.maven.org/#search%7Cga%7C1%7Ca%3A%22jssc%22)
The Github repository for JSSC can be found here: [JSSC Github](https://github.com/scream3r/java-simple-serial-connector)

Our project used the 2.8.0 version of JSSC from the GroupID org.scream3r. Download the .jar and place it in this directory.


Compiling the Program:
----------------------

Ensure that all .java files are in the same source directory as the Controller.java file, and navigate to this directory. To compile the Java program, you will need to include the .jar in your classpath. Use the following terminal command: 

 `javac *.java -cp <path to .jar file>`

 ie. `javac *.java jssc-2.8.0-.jar`


Running the Java Program:
-------------------------

You must be in the same directory as the Controller.class file to issue the following commands. This program provides multiple modes of operation. Each mode is signaled by a option flag:

1) Normal operation: The controller will communicate with the FPGA and do nothing else. 

    Run the program with no option flags.

2) Recording operation: The controller will communicate with the FPGA and will record the button presses and the time intervals between them all into a file called button_press_records.txt. This file can later be used to "demo" a game. Please not the time accuracy of this is inconsistent due to the OS scheduler and FPGA inconsistencies. 

    Run program with the follwing option flag: ___-r___

3) Auto-Run operation: The controller will communicate with the FPGA and will also read in an input file containing button press records. It will automatically press the buttons at the same time as the buttons were pressed in the record file. 

    Run the program with the following option flag and file path: ___-a <path to button press records .txt file>___

4) Testing operation: In testing operation the controller will still communicate with the FPGA. In addition, it will also act as a serial event listener and will print out a line to both the console and a file cpu_states.txt every time it recieves 8 bytes.

    Run the program with the following option flag: ___-t___

The terminal command is slightly different depending on the operating system. Again, the JSSC library must be included in the classpath. This is the format for each operating system:

Windows: `java -cp <path to .jar file>; Controller <options>`       *** NOTICE THE SEMICOLON ***

ie. `java -cp jssc-2.8.0.jar; Controller -r`

Mac & Linux: `java -cp <path to .jar file>: Controller <options>`     *** NOTICE THE COLON ***
    
ie. `java -cp jssc-2.8.0.jar: Controller -a button_press_records.txt`


Controlling the Java Program:
-----------------------------

The program can be controller two ways:

1) Using key presses. The program GUI must be in focus (the front most window on your desktop) in order to recieve key presses. Keyboard keys are mapped to NES controller buttons as follows:

     KEY       |  BUTTON
   ------------|---------------
    Q          |  A
    W          |  B
    Up         |  Up
    Down Arrow |  Down
    Left Arrow |  Left
    Right Arrow|  Right
    Tab        |  Select
    Enter      |  Start

2) Clicking buttons on the GUI. Use your mouse to click the buttons. Please note that when you click a button there is a bug that will cause the program to stop recieving key button presses. To fix this, either spam the tab key until the buttons start responding to keys, or restart the program.

*Author:* [Jonathan Ebert](https://github.com/jtgebert)
