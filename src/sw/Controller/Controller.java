import java.awt.*;
import java.awt.event.*;
import java.util.*;
import jssc.*;
import javax.swing.*;
import javax.swing.AbstractButton.*;
import javax.swing.event.*;
import java.util.regex.*;
import java.io.*;

public class Controller extends JFrame implements KeyListener,
                                                  ChangeListener,
                                                  SerialPortEventListener,
                                                  WindowListener {

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////// FIELDS ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  private ArrayList<NESButton> buttons = new ArrayList<NESButton>();
  private ControllerPanel panel;
  private boolean buttonStates[] = new boolean[8];
  private SerialPort port = null;
  private PrintWriter pw = null;
  private long startTime = 0;
  private PrintWriter buttonPressRecorder = null;
  private boolean record = false; // true if we are recording the button presses
  private boolean testing = false; // true if we are recording cpu states
  public static int byteNum = 0;

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// CONSTRUCTORS /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  public Controller(boolean record, boolean testing) {

    // Set JFRAME Parameters
    super("NES Controller");
    setLayout(null);
    setSize(700, 330);
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setLocationRelativeTo(null);
    getContentPane().setBackground(Color.DARK_GRAY);
    setLocationRelativeTo(null);
    addWindowListener(this);

    // initialize all buttons to not pressed
    for (int i = 0; i < buttonStates.length; i++) {
      buttonStates[i] = false;
    }

    // add the controller panel
    panel = new ControllerPanel();
    panel.addKeyListener(this);
    add(panel);

    // add all buttons
    buttons.add(new CircleButton(NESButton.CIRCLE_BUTTON_TYPE_A, this));
    buttons.add(new CircleButton(NESButton.CIRCLE_BUTTON_TYPE_B, this));
    buttons.add(new HorizontalButton(HorizontalButton.HORIZONTAL_BUTTON_TYPE_SELECT, this));
    buttons.add(new HorizontalButton(HorizontalButton.HORIZONTAL_BUTTON_TYPE_START, this));
    buttons.add(new UpArrowButton(this));
    buttons.add(new DownArrowButton(this));
    buttons.add(new LeftArrowButton(this));
    buttons.add(new RightArrowButton(this));
    buttons.add(null); // when user presses button that is not mapped to key

    // add buttons to panel
    for (int i = 0; i < buttons.size() - 1; i++) {
      panel.add(buttons.get(i));
    }

    // get a list of all serial ports
    String[] portList = SerialPortList.getPortNames();
    System.out.println("Number of serial ports found: " + portList.length +
                       "\n\nPort Names:");

    // find the FPGA serial port
    for (int i = 0; i < portList.length; i++) {
	  System.out.println(portList[i]);

      // get OS name
      String osName = System.getProperty("os.name");
      // MAC
      if (osName.contains("Mac")) {
        if (portList[i].contains("usbserial")) {
          this.port = new SerialPort(portList[i]);
		  // open the port and set parameters
		  try {
		    this.port.openPort();
		    System.out.println("\nOpened Port: " + this.port.getPortName());
		    this.port.setParams(SerialPort.BAUDRATE_1200, SerialPort.DATABITS_8,
		  					  SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
		    this.port.addEventListener(this);
			break;
		  }
		  catch (SerialPortException spe) {
		    System.err.println(portList[i] + ": " + spe.getExceptionType());
			this.port = null;
		  }
		  // BELOW CATCH BLOCK ONLY WHEN NOT TESTING/USING COM PORTS
		  //*
		  catch (NullPointerException npe) {
		  }// */
        }
      }
      // Windows
      if (osName.contains("Windows")) {
        int portNum = Character.getNumericValue(portList[i].charAt(3));
        if (portNum > 3) {
          this.port = new SerialPort(portList[i]);
		  // open the port and set parameters
		  try {
		    this.port.openPort();
		    System.out.println("\nOpened Port: " + this.port.getPortName());
		    this.port.setParams(SerialPort.BAUDRATE_1200, SerialPort.DATABITS_8,
		  					  SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
		    this.port.addEventListener(this);
			break;
		  }
		  catch (SerialPortException spe) {
		    System.err.println(portList[i] + ": " + spe.getExceptionType());
			this.port = null;
		  }
		  // BELOW CATCH BLOCK ONLY WHEN NOT TESTING/USING COM PORTS
		  //*
		  catch (NullPointerException npe) {
		  }// */
        }
      }
    }

    // if the FPGA port not found then exit
    if (this.port == null) {
      System.err.println("Did not find FPGA on port list");
      //System.exit(-1); // COMMENT OUT WHEN NOT USING/TESTING COM PORTS
    }

    this.testing = testing;
    if (testing) {
    	try {
    	  this.pw = new PrintWriter(new File("cpu_states.txt"));
    	}
    	catch (FileNotFoundException fnfe) {
    	  System.err.println("Could not open CPU States output file.");
    	  System.exit(-1);
    	}
    }

    // get initialization time to record button states
    this.record = record;
    if (record) {
      try {
        this.buttonPressRecorder = new PrintWriter(new File("button_press_records.txt"));
      }
      catch (FileNotFoundException fnfe) {
        System.err.println("Could not write to file \"button_press_records.txt\"");
        System.exit(-1);
      }
      startTime = System.nanoTime();
    }
  }

////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// METHODS ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  /**************************************
   * main class, instantiate controller *
   **************************************/
  public static void main(String[] args) {

    // parse arguements looking for -r and -t
    boolean r = false, t = false, a = false;
    String autoRunFile = "";
    for (int i = 0; i < args.length; i++) {
      if (args[i].contains("-")) {
        String options = args[i].substring(1);
        for (int j = 0; j < options.length(); j++) {
          if (options.charAt(j) == 'r') {
            r = true;
          }
          else if (options.charAt(j) == 't') {
            t = true;
          }
          else if (options.charAt(j) == 'a') {
            a = true;
          }
          else {
            System.out.println("Invalid option in arguemnt: " + args[i]);
          }
        }
      }
      else if (a && args[i].contains(".txt")) {
        autoRunFile = args[i];
      }
      else {
        System.out.println("Illegal Arguement: " + args[i]);
      }
    }

    Controller controller = new Controller(r, t);
    controller.setVisible(true);

    // for auto runs
    if (a) {
      System.out.println("Starting Auto Sequence...\n");
      try {
        controller.autoRun(new File(autoRunFile));
      }
      catch (FileNotFoundException fnfe) {
        System.err.println("Auto Run File not found: " + autoRunFile);
        System.exit(-1);
      }
    }
  }

  /*****************************************************
   * returns the button index based on the key pressed *
   *****************************************************/
  public int decodeKey(int key) {
    switch (key) {
	    case KeyEvent.VK_Q: return 0;
      case KeyEvent.VK_W: return 1;
      case KeyEvent.VK_TAB: return 2;
      case KeyEvent.VK_ENTER: return 3;
      case KeyEvent.VK_UP: return 4;
      case KeyEvent.VK_DOWN: return 5;
      case KeyEvent.VK_LEFT: return 6;
      case KeyEvent.VK_RIGHT: return 7;
      default: return 8;
    }
  }

  /************************************************************
   * returns the key character value based on the key pressed *
   ************************************************************/
   public char getKeyChar(int key) {
     switch (key) {
       case KeyEvent.VK_Q: return 'q';
       case KeyEvent.VK_W: return 'w';
       case KeyEvent.VK_TAB: return (char) 9;
       case KeyEvent.VK_ENTER: return (char) 10;
       case KeyEvent.VK_UP: return (char) 65535;
       case KeyEvent.VK_DOWN: return (char) 65535;
       case KeyEvent.VK_LEFT: return (char) 65535;
       case KeyEvent.VK_RIGHT: return (char) 65535;
       default: return 8;
     }
   }

  /************************************************************
   * when a key is pressed set the corresponding button state *
   ************************************************************/
  public void keyPressed(KeyEvent e) {
    long pressTime = System.nanoTime();
    NESButton pressedButton = buttons.get(decodeKey(e.getKeyCode()));
    if (pressedButton != null) {
      pressedButton.press();
    }

    // record button press and time
    if (record) {
      this.buttonPressRecorder.print(pressTime - this.startTime);
      this.buttonPressRecorder.println(":Press:" + e.getKeyCode());
    }
  }

  /******* key typed not used ********/
  public void keyTyped(KeyEvent e) {}

  /*************************************************************
   * when a key is released set the corresponding button state *
   *************************************************************/
  public void keyReleased(KeyEvent e) {
    long releaseTime = System.nanoTime();
    NESButton releasedButton = buttons.get(decodeKey(e.getKeyCode()));
    if (releasedButton != null) {
      releasedButton.release();

      // record button release and time
      if (record) {
        this.buttonPressRecorder.print(releaseTime - this.startTime);
        this.buttonPressRecorder.println(":Release:" + e.getKeyCode());
      }
    }
  }

  /********************************************************************
   * send a button state update to the FPGA when button states change *
   ********************************************************************/
  public void sendUpdate() {

    // print byte num
    System.out.print("Sending " + this.byteNum + ": ");
    this.byteNum++;

    // create the byte to send
    byte dataOut = 0;
    for (int i = 0; i < buttonStates.length; i++) {
      if (buttonStates[i]) {
        System.out.print("1");
        dataOut += Math.pow(2.0, (double) i);
      }
      else {
        System.out.print("0");
      }
    }
    System.out.println("");

    // write byte
    try {
      this.port.writeByte(dataOut);
    }
    catch (SerialPortException spe) {
      System.err.println("Error writing data: " + spe.getExceptionType());
    }
    // BELOW CATCH BLOCK WHEN NOT USING/TESTING COM PORTS
    //*
    catch (NullPointerException npe) {
    } // */
  }

  /*************************************************************
   * detects when a button state is changed and send an update *
   *************************************************************/
  public void stateChanged(ChangeEvent e) {
    // get the button that caused event
    NESButton button = (NESButton) e.getSource();
    DefaultButtonModel model = (DefaultButtonModel) button.getModel();

    // button pressed
    if (model.isPressed()) {
      buttonStates[button.getIndex()] = true;
      sendUpdate();
    }
    // button released
    else if (!model.isArmed() && !model.isPressed()) {
      buttonStates[button.getIndex()] = false;
      sendUpdate();
    }
  }
  /*******************************
   * handle recieved serial data *
   *******************************/
  public void serialEvent(SerialPortEvent spe) {

    // if we are testing with cpu states
    if (this.testing) {
      try {
        // if a character was received
        if (spe.isRXCHAR()) {
          // if we have received at least 8 bytes
      		if (spe.getEventValue() >= 8) {
            // format the bytes to show cpu state
      			System.out.print("CPU STATE: ");
      			String state = this.port.readHexString(8);
      			String[] values = state.split( " " );
      			String formattedState = String.format( "PC : %s, A : %s, X : %s, Y : %s, mem_cs_n, mem_wr, cpu_ram_addr : %s, data : %s",
      			values[ 7 ] + values[ 6 ], values[ 5 ], values[ 4 ], values[ 3 ], values[ 2 ], values[ 1 ], values[ 0 ] );

            // print bytes to the file
      			this.pw.println( formattedState );
      		}
        }
      }
      catch(SerialPortException e) {
        System.err.println("Error reading hex string." + e.getExceptionType());
      }
    }
  }

  /*******************************************
   * when controller closed, close resources *
   *******************************************/
  public void windowClosing(WindowEvent we) {
    System.out.println("Closing Controller");
    if (this.record) {
      this.buttonPressRecorder.close();
    }
    if (this.testing) {
      this.pw.close();
    }
  }

  /*************************************
   * Window Listener Interface Methods *
   *************************************/
  public void windowActivated(WindowEvent we) {}
  public void windowClosed(WindowEvent we) {}
  public void windowDeactivated(WindowEvent we) {}
  public void windowDeiconified(WindowEvent we) {}
  public void windowIconified(WindowEvent we) {}
  public void windowOpened(WindowEvent we) {}

  /***************************************************************************
   * this method will run a demo of an nes game                              *
   * game control must be provided as an input file in the following format: *
   * <time(ns)>:<Pressed/Released>:<Key Value>                               *
   ***************************************************************************/
  public void autoRun(File infile) throws FileNotFoundException {
    Scanner scnr = new Scanner(infile);

    // loop over each line of the input file
    long pressTime, currTime, startTime = System.nanoTime();
    while (scnr.hasNextLine()) {
      // parse line for parameters
      String line = scnr.nextLine();
      Long time = new Long(line.substring(0, line.indexOf(':'))); // get time of event
      boolean press = line.substring(line.indexOf(':') + 1, line.lastIndexOf(':')).equals("Press"); // get press or release
      Integer keyNum = new Integer(line.substring(line.lastIndexOf(':') + 1)); // key that was pressed
      int keyInt = keyNum.intValue(); // int value of key
      char keyChar = getKeyChar(keyNum.intValue()); // character value of the key

      // wait the correct ammount of time
      do {
        pressTime = System.currentTimeMillis();
        currTime = System.nanoTime();
      } while (currTime - startTime < time);

      // press button if pressed
      if (press) {
        this.panel.dispatchEvent(new KeyEvent(this.panel, KeyEvent.KEY_PRESSED, pressTime, 0, keyInt, keyChar));
      }
      // release if realese
      else {
        this.panel.dispatchEvent(new KeyEvent(this.panel, KeyEvent.KEY_RELEASED, pressTime, 0, keyInt, keyChar));
      }
    }
  }
}
