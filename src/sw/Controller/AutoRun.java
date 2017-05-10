import java.awt.*;
import java.util.*;
import java.io.*;

public class AutoRun {

  public static void main(String[] args) {
    if (args.length != 1) {
      System.err.println("Invalid arguements. Please use java AutoRun <button_recording_file.txt>");
      System.exit(-1);
    }
    else {
      try {
        Robot robot = new Robot();
        Scanner scnr = new Scanner(new File(args[0]));

        // loop over each line of the input file
        long startTime = System.nanoTime();
        while (scnr.hasNextLine()) {
          String line = scnr.nextLine();
          Long time = new Long(line.substring(0, line.indexOf(':'))); // get time of event
          boolean press = line.substring(line.indexOf(':') + 1, line.lastIndexOf(':')).equals("Press"); // get press or release
          Integer keyNum = new Integer(line.substring(line.lastIndexOf(':') + 1)); // key that was pressed

          System.out.println("Setting " + keyNum.intValue() + " " + press + " at time " + time.longValue() + "ns");

          // wait the correct ammount of time
          while (System.nanoTime() - startTime < time);

          //lastTime = time;

          if (press) { // press button if press
            robot.keyPress(keyNum.intValue());
          }
          else { // release if realese
            robot.keyRelease(keyNum.intValue());
          }
        }
      }
      catch (FileNotFoundException fnfe) {
        System.err.println("Input file not found");
        System.exit(-1);
      }
      catch (AWTException awte) {
        System.err.println("Error instantiating robot");
        System.exit(-1);
      }
    }
  }

}
