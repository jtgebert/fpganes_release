import java.io.*;
import java.util.*;

public class Assembler {

  ////////// CONSTANTS //////////
  public static final int DECIMAL = 0;
  public static final int HEX = 1;
  public static final int BINARY = 2;

  ////////// MAIN METHOD //////////
  public static void main(String[] args) {

    File infile, outfile1;
    Scanner input = null;
    PrintWriter output = null;

    if (args.length != 2) {
      System.err.println("Incorrect arguements.\nPlease use: \"java Assembler "+
                          "<input.asm> <cpu output.mif> <ppu output.mif>");
      System.exit(-1);
    }

    try {
      infile = new File(args[0]);
      outfile1 = new File(args[1]);

      input = new Scanner(infile);
      output = new PrintWriter(outfile1);

      short addr = 0;
      int lineNum = 0;
      HashMap<String, Integer> labels = new HashMap<String, Integer>();
      HashMap<String, Constant> constants = new HashMap<String, Constant>();
      ArrayList<AssemblerInstruction> instructions = new ArrayList<AssemblerInstruction>();
      String line = "", label = "", constant = "";
      int memMode = 0;

      // loop over each line until
      while (input.hasNextLine()) {
        line = removeComment(input.nextLine()).trim();
        lineNum++;

        // look for start of CPU mem
        if (line.equals("_CPU:")) {
          addr = 0; // starting address of cpu mem
          break;
        }

        // if line is constant TODO 646 & 643
        // TODO need to change so constants only allowed before instructions
        if (line.contains("=")) {
          int indexAssignment = line.indexOf('=');
          constant = line.substring(0, indexAssignment).trim();
          // check that constant is valid
          if (!constant.matches("^[a-zA-Z_]+[a-zA-Z0-9_]*$")) {
            throw new AssemblerException(AssemblerException.INVALID_LABEL, lineNum, constant);
          }
          // check that constant isnt already declared
          if (labels.containsKey(constant) || constants.containsKey(constant)) {
            throw new AssemblerException(AssemblerException.NAME_MULTIPLY_DECLARD, lineNum, constant);
          }
          constants.put(constant, new Constant(line.substring(indexAssignment + 1).trim(), lineNum));
          line = "";
        }
      }

      // check that start of cpu mem was found
      if (!input.hasNextLine()) {
        throw new AssemblerException(AssemblerException.CPU_MEMORY_NOT_FOUND, lineNum);
      }

      // loop over each line of cpu memory
      while (input.hasNextLine()) {
        line = removeComment(input.nextLine()).trim();
        lineNum++;

        // if the line has a label, get the label and add to hashmap
        if (line.contains(":")) {
          int indexColon = line.indexOf(':');
          label = line.substring(0, indexColon).trim();
          // check that label is valid
          if (!label.matches("^[a-zA-Z_]+[a-zA-Z0-9_]*$")) {
            throw new AssemblerException(AssemblerException.INVALID_LABEL, lineNum, label);
          }
          // check that label isnt already declared
          if (labels.containsKey(label) || constants.containsKey(label)) {
            throw new AssemblerException(AssemblerException.NAME_MULTIPLY_DECLARD, lineNum, label);
          }
          labels.put(label, new Integer(addr));
          line = line.substring(indexColon + 1).trim();
        }

        // if the line contains an instruction
        if (line.length() != 0) {

          AssemblerInstruction instr;
          // data instruction
          if (line.matches("^\\.(d[bw]|D[BW]).*$")) {
            instr = new DataInstruction(line, lineNum, addr, constants);
          }
          // opcode instruction
          else {
            instr = new OpcodeInstruction(line, lineNum, addr, constants);
          }
          instructions.add(instr);

          // increment the address based on the instruction type
          // data instruction
          if (instr instanceof DataInstruction) {
            addr += ((DataInstruction) instr).numBytes();
          }
          // opcode instruction
          else {
            // increment the address based on the memory addressing mode
            memMode = ((OpcodeInstruction) instr).getMemMode();
            // instruction is three bytes
            if (hasTwoBytes(memMode)) {
              addr += 3;
            }
            // instruction is two bytes
            else if (hasOneByte(memMode)) {
              addr += 2;
            }
            // instruction is one byte
            else {
              addr++;
            }
          }
        }

      }

      for (AssemblerInstruction i : instructions) {

      // data instructions
      if (i instanceof DataInstruction) {
        DataInstruction instr = (DataInstruction) i;

          byte[] bytes = instr.getBytes();
          addr = instr.getAddr();
          // loop over all bytes
          for (int j = 0; j < bytes.length; j++) {
            // print byte
            output.println(String.format("%4s", Integer.toHexString((instr.getAddr() + j) & 0xFFFF)).replace(' ', '0').toUpperCase() + " : "
                            + String.format("%2s;", Integer.toHexString(bytes[j] & 0xFF)).replace(' ', '0').toUpperCase());
          }

        }
        // opcode instruction
        else {
          OpcodeInstruction instr = (OpcodeInstruction) i;
          // print opcode
          output.println(String.format("%4s", Integer.toHexString(instr.getAddr() & 0xFFFF)).replace(' ', '0').toUpperCase() + " : "
                          + String.format("%2s;", Integer.toHexString((instr).getOpcode() & 0xFF)).replace(' ', '0').toUpperCase());

          memMode = (instr).getMemMode();
          // update labels
          if (instr.getLabel() != null) {
            if (!labels.containsKey(instr.getLabel())) {
              throw new AssemblerException(AssemblerException.LABEL_NOT_DECLARED, instr.getLineNum(), instr.getLabel());
            }
            // absolute labels
            if (hasTwoBytes(memMode)) {
              (instr).updateAddr(labels.get(instr.getLabel()).shortValue());
            }
            // offsets
            else {
              (instr).updateOffset(labels.get(instr.getLabel()).shortValue());
            }
          }

          // print first following byte
          if (hasOneByte(memMode) || hasTwoBytes(memMode)) {
            output.println(String.format("%4s", Integer.toHexString((instr.getAddr() + 1) & 0xFFFF)).replace(' ', '0').toUpperCase() +
                            " : " + String.format("%2s;", Integer.toHexString((instr).getByte1() & 0xFF)).replace(' ', '0').toUpperCase());
          }

          // print second following byte
          if (hasTwoBytes(memMode)) {
            output.println(String.format("%4s", Integer.toHexString((instr.getAddr() + 2) & 0xFFFF)).replace(' ', '0').toUpperCase() +
                            " : " + String.format("%2s;", Integer.toHexString((instr).getByte2() & 0xFF)).replace(' ', '0').toUpperCase());
          }
        }
      }

    }
    catch (FileNotFoundException fnfe) {
      System.err.println("An input file was not found");
      System.err.println(fnfe);
      System.exit(-1);
    }
    catch (AssemblerException ae) {
      System.err.println(ae.toString());
      System.exit(-1);
    }
    finally {
      output.flush();
      output.close();
      input.close();
    }

  }

  // removes a comment from a line of code
  public static String removeComment(String str) {
    if (str.contains(";")) {
      return str.substring(0, str.indexOf(';'));
    }
    else {
      return str;
    }
  }

  // returns true if this mem addressing mode has two bytes after opcode
  public static boolean hasTwoBytes(int memMode) {
    if (memMode == OpcodeInstruction.ABSOLUTE ||
        memMode == OpcodeInstruction.ABSOLUTE_INDEXED_X ||
        memMode == OpcodeInstruction.ABSOLUTE_INDEXED_Y ||
        memMode == OpcodeInstruction.INDIRECT) {
      return true;
    }

    return false;
  }

  // returns true if this mem addressing mode has one byte after opcode
  public static boolean hasOneByte(int memMode) {
    if (memMode == OpcodeInstruction.ZERO_PAGE ||
        memMode == OpcodeInstruction.ZERO_PAGE_INDEXED_X ||
        memMode == OpcodeInstruction.ZERO_PAGE_INDEXED_Y ||
        memMode == OpcodeInstruction.ZERO_PAGE_INDIRECT_X ||
        memMode == OpcodeInstruction.ZERO_PAGE_INDIRECT_Y ||
        memMode == OpcodeInstruction.RELATIVE ||
        memMode == OpcodeInstruction.IMMEDIATE) {
      return true;
    }

    return false;
  }

  // assumes that $ and # and % already removed
  // 0 for dec, 1 for hex, 2 for binary
  public static byte getByteFromString(String str, int type, int lineNum) throws AssemblerException {
    if (type == DECIMAL) {
      Integer i = new Integer(str);
      // check that decimal number is within bounds
      if (i > 127 || i < -128) {
        throw new AssemblerException(AssemblerException.INVALID_IMMEDIATE, lineNum);
      }
      else {
        return i.byteValue();
      }
    }
    else if (type == HEX) {
      // two hex digits
      if (str.length() == 2) {
        return (byte) (((byte) (Character.digit(str.charAt(0), 16) << 4)) +
                ((byte) Character.digit(str.charAt(1), 16)));
      }
      // one hex digit
      else {
        byte b = (byte) Character.digit(str.charAt(0), 16);
        // sign extend
        if (b > 7) {
          b += (byte) (Character.digit('F', 16) << 4);
        }
        return b;
      }
    }
    else if (type == BINARY) {
      byte b = 0;
      int length = str.length();
      // sign extend
      if (str.charAt(0) == '1' && length > 1) {
        for (int i = 0; i < 8 - length; i++) {
          str = "1" + str;
        }
      }
      length = str.length();
      // set byte
      for (int i = 0; i < length; i++) {
        b += ((byte) Character.digit(str.charAt(i), 2)) << (length - 1 - i);
      }
      return b;
    }

    return 0; // TODO should never return this
  }

  // 1 for hex, 2 for binary
  public static short getShortFromString(String str, int type) {
    if (type == HEX) {
      short b = 0;
      int length = str.length();
      //sign extend
      if ((int) str.charAt(0) - 48 > 7 && length < 4) {
        for (int i = 0; i < 4 - length; i++) {
          str = "F" + str;
        }
      }
      length = str.length();
      // set byte
      for (int i = 0; i < length; i++) {
        b += ((short) Character.digit(str.charAt(i), 16)) << ((length - 1 - i) * 4);
      }
      return b;
    }
    else if (type == BINARY) {
      short b = 0;
      int length = str.length();
      // sign extend
      if (str.charAt(0) == '1' && length > 1) {
        for (int i = 0; i < 16 - length; i++) {
          str = "1" + str;
        }
      }
      length = str.length();
      // set byte
      for (int i = 0; i < length; i++) {
        b += ((short) Character.digit(str.charAt(i), 2)) << (length - 1 - i);
      }
      return b;
    }

    return 0; // TODO should never return this
  }

}
