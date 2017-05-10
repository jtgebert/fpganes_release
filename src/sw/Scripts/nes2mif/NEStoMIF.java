// binary dump of a file: xxd -b -c 1 $INFILE| cut -d" " -f 2 > $OUTFILE

import java.io.*;

public class NEStoMIF {

  public static void main(String[] args) {

    if (args.length != 3) {
      System.err.println("Incorrect arguements\nPlease use: \"java NEStoMIF"
                         + " <infile> <prog rom outfile> <char rom outfile>\"");
      System.exit(-1);
    }

    String inPath, progOutPath, charOutPath;
    inPath = args[0];
    progOutPath = args[1];
    charOutPath = args[2];

    try {
      File infile = new File(inPath);
      File progOutfile = new File(progOutPath);
      File charOutfile = new File(charOutPath);

      byte[] bytes = new byte[(int) infile.length()];
      InputStream bytesIn = new BufferedInputStream(new FileInputStream(infile));

      PrintWriter progRomPrinter = new PrintWriter(progOutfile);
      PrintWriter charRomPrinter = new PrintWriter(charOutfile);

      try {
        bytesIn.read(bytes, 0, (int) infile.length());
        bytesIn.close();
      }
      catch (IOException ioe) {
        System.out.println("IOException when reading bytes");
        System.exit(-1);
      }

      int progRomSize, charRomSize; // sizes of respective roms

      // determine prog and char rom size
      // progRomEnd = 32784; // currently only support mario
      progRomSize = 16384 * bytes[4];
      charRomSize = 8192 * bytes[5];
      // zero for byte 5 infers 8k char rom
      if (charRomSize == 0) {
        charRomSize = 8192;
      }

      // print mif headers to the output files
      progRomPrinter.println("DEPTH = " + progRomSize + ";\nWIDTH = 8;\nADDRESS_RADIX = HEX;"
                              + "\nDATA_RADIX = BIN;\nCONTENT\nBEGIN\n");
      charRomPrinter.println("DEPTH = " + charRomSize + ";\nWIDTH = 8;\nADDRESS_RADIX = HEX;"
                              + "\nDATA_RADIX = BIN;\nCONTENT\nBEGIN\n");


      // loop over all prog rom bytes and print to prog rom file
      for (int address = 0; address < progRomSize; address++) {
        progRomPrinter.print(String.format("%6X", address).replace(" ", "0"));
        progRomPrinter.print(" : ");
        progRomPrinter.println(String.format("%8s;", Integer.toBinaryString(((int) bytes[address + 16]) & 0xFF)).replace(' ', '0'));
      }

      // loop over all char rom bytes and print to char rom file
      for (int address = 0; address < charRomSize; address++) {
        charRomPrinter.print(String.format("%6X", address).replace(" ", "0"));
        charRomPrinter.print(" : ");
        charRomPrinter.println(String.format("%8s;", Integer.toBinaryString(((int) bytes[address + progRomSize + 16]) & 0xFF)).replace(' ', '0'));
      }

      progRomPrinter.print("END;");
      charRomPrinter.print("END;");

      progRomPrinter.close();
      charRomPrinter.close();

    }
    catch (FileNotFoundException fnfe) {
      System.err.println("File paths incorrect");
      System.exit(-1);
    }
  }
}
