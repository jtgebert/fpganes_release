import java.util.*;

public class DataInstruction extends AssemblerInstruction {

  public static final String CONSTANT = "[<>]?[a-zA-Z_][a-zA-Z0-9_]* *([+-] *([0-9]+|\\$[A-Za-z0-9]+|%[01]+))?";
  public static final String COMMA_SEPARATOR = " *, *";
  public static final String HEX_BYTE = "\\$[a-zA-Z0-9]{1,2}";
  public static final String HEX_WORD = "\\$[a-zA-Z0-9]{1,4}";
  public static final String BINARY_BYTE = "%[01]{1,8}";
  public static final String BINARY_WORD = "%[01]{1,16}";
  public static final String DATA_BYTE = "\\.(DB|db) +";
  public static final String DATA_WORD = "\\.(DW|dw) +";
  public static final String LABEL = "[a-zA-Z_][A-Za-z0-9_]*";
  public static final String ARITHMETIC_ADDITION = " *\\+ *[0-9]*";
  public static final String ARITHMETIC_SUBTRACTION = " *- *[0-9]*";


  public static final int BYTES = 1;
  public static final int WORDS = 2;

  private short addr;
  private int lineNum;
  private int numBytes;
  private byte[] bytes;

  public DataInstruction(String instr, int lineNum, short addr, HashMap<String, Constant> constants) throws AssemblerException {
    this.lineNum = lineNum;
    this.addr = addr;

    // byte instruction
    if (instr.matches("^" + DATA_BYTE + "(" + CONSTANT + "|" + HEX_BYTE + "|" + BINARY_BYTE + ")(" +
                      COMMA_SEPARATOR + "(" + CONSTANT + "|" + HEX_BYTE + "|" + BINARY_BYTE + "))*$")) {
      // get the number of bytes set by the instruction
      instr = instr.substring(instr.indexOf(' ')).trim();
      setNumBytes(instr, BYTES);

      // loop over each byte declaration and add it to the array
      String line;
      for (int i = 0; i < numBytes; i++) {
        // get byte decl
        if (instr.contains(",")) {
          line = instr.substring(0, instr.indexOf(',')).trim();
          instr = instr.substring(instr.indexOf(',') + 1).trim();
        }
        else {
          line = instr;
        }

        // set the byte based of the type of instr
        // constant
        if (line.matches("^" + CONSTANT + "$")) {
          this.bytes[i] = getByteFromConstant(line, lineNum, constants);
        }
        // hex
        else if (line.matches("^" + HEX_BYTE + "$")) {
          this.bytes[i] = Assembler.getByteFromString(line.substring(1), Assembler.HEX, lineNum);
        }
        // binary
        else if (line.matches("^" + BINARY_BYTE + "$")) {
          this.bytes[i] = Assembler.getByteFromString(line.substring(1), Assembler.BINARY, lineNum);
        }
        else {
          throw new AssemblerException(AssemblerException.UNRECOGNIZED_DATA_INSTRUCTION, this.lineNum, line);
        }
      }
    }
    // word instruction
    else if (instr.matches("^" + DATA_WORD + "(" + CONSTANT + "|" + HEX_WORD + "|" + BINARY_WORD + ")(" +
                      COMMA_SEPARATOR + "(" + CONSTANT + "|" + HEX_WORD + "|" + BINARY_WORD + "))*$")) {
      // get the number of bytes set by the instruction
      instr = instr.substring(instr.indexOf(' ')).trim();
      setNumBytes(instr, WORDS);

      // loop over each byte declaration and add it to the array
      String line;
      for (int i = 0; i < numBytes; i += 2) {
        // get byte decl
        if (instr.contains(",")) {
          line = instr.substring(0, instr.indexOf(',')).trim();
          instr = instr.substring(instr.indexOf(',') + 1).trim();
        }
        else {
          line = instr;
        }

        // set the byte based of the type of instr
        // TODO if this is to assemble the smbdis.asm we need to add constants to 
        // a list first and then go back and update them, because labels can be used
        // as constants
        // constant
        if (line.matches("^" + CONSTANT + "$")) {
          short s = getShortFromConstant(line, lineNum, constants);
          this.bytes[i] = (byte) s;
          this.bytes[i + 1] = (byte) (s >> 8);
        }
        // hex
        else if (line.matches("^" + HEX_WORD + "$")) {
          short s = Assembler.getShortFromString(line.substring(1), Assembler.HEX);
          this.bytes[i] = (byte) s;
          this.bytes[i + 1] = (byte) (s >> 8);
        }
        // binary
        else if (line.matches("^" + BINARY_WORD + "$")) {
          short s = Assembler.getShortFromString(line.substring(1), Assembler.BINARY);
          this.bytes[i] = (byte) s;
          this.bytes[i + 1] = (byte) (s >> 8);
        }
        else {
          throw new AssemblerException(AssemblerException.UNRECOGNIZED_DATA_INSTRUCTION, this.lineNum, line);
        }
      }


    }
    else {
      throw new AssemblerException(AssemblerException.UNRECOGNIZED_DATA_INSTRUCTION, this.lineNum, instr);
    }

  }

  public int getInstructionType() {
    return AssemblerInstruction.DATA_INSTRUCTION;
  }
  public short getAddr() {
    return this.addr;
  }
  public int getLineNum() {
    return this.lineNum;
  }

  public int numBytes() {
    return this.numBytes;
  }

  public byte[] getBytes() {
    return this.bytes;
  }

  private void setNumBytes(String line, int bytes) {
    this.numBytes = bytes;

    // count number of bytes in this instruction
    while (line.contains(",")) {
      this.numBytes += bytes;
      line = line.substring(line.indexOf(',') + 1).trim();
    }
    // initialize arrays to desired size
    this.bytes = new byte[this.numBytes];
  }

  private byte getByteFromConstant(String line, int lineNum, HashMap<String, Constant> constants) throws AssemblerException {
    // determine if byte mask used
    char lowHigh = line.charAt(0);
    if (lowHigh == '<' || lowHigh == '>') {
      line = line.substring(1);
    }
    // determine how much to add/sub from the const
    byte num = 0;
    // adding
    if (line.matches("^" + LABEL + ARITHMETIC_ADDITION + "$")) {
      num = (new Integer(line.substring(line.indexOf('+') + 1).trim())).byteValue();
      line = line.substring(0, line.indexOf('+')).trim();
    }
    // subtraction
    else if (line.matches("^" + LABEL + ARITHMETIC_SUBTRACTION + "$")) {
      num = (new Integer("-" + line.substring(line.indexOf('-') + 1).trim())).byteValue();
      line = line.substring(0, line.indexOf('-')).trim();
    }

    // get constant from name
    Constant cons = constants.get(line);
    // check that const exists
    if (cons == null) {
      throw new AssemblerException(AssemblerException.CONSTANT_NOT_FOUND, lineNum, line);
    }
    // check constant is correct size
    if (cons.numBytes() == 2 && (lowHigh != '>' && lowHigh != '<')) {
      throw new AssemblerException(AssemblerException.INCORRECT_CONSTANT_SIZE, lineNum, line);
    }
    // check for incorrect use of < and >
    if (cons.numBytes() == 1 && (lowHigh == '>' || lowHigh == '<')) {
      throw new AssemblerException(AssemblerException.INVALID_BYTE_MASK, lineNum, line);
    }
    byte b;
    // apply byte mask
    if (lowHigh == '>') {
      b = cons.getByte2();
    }
    else {
      b = cons.getByte1();
    }

    // add/sub from the byte TODO mabye check for overflow
    return (byte) (b + num);

  }

  private short getShortFromConstant(String line, int lineNum, HashMap<String, Constant> constants) throws AssemblerException {
    // determine if byte mask used
    char lowHigh = line.charAt(0);
    if (lowHigh == '<' || lowHigh == '>') {
      throw new AssemblerException(AssemblerException.INVALID_BYTE_MASK, lineNum, line + "\nByte Mask can't be used on constant words.");
    }
    // determine how much to add/sub from the const
    short num = 0;
    // adding
    if (line.matches("^" + LABEL + ARITHMETIC_ADDITION + "$")) {
      num = (new Integer(line.substring(line.indexOf('+') + 1).trim())).shortValue();
      line = line.substring(0, line.indexOf('+')).trim();
    }
    // subtraction
    else if (line.matches("^" + LABEL + ARITHMETIC_SUBTRACTION + "$")) {
      num = (new Integer("-" + line.substring(line.indexOf('-') + 1).trim())).shortValue();
      line = line.substring(0, line.indexOf('-')).trim();
    }

    // get constant from name
    Constant cons = constants.get(line);
    // check that const exists
    if (cons == null) {
      throw new AssemblerException(AssemblerException.CONSTANT_NOT_FOUND, lineNum, line);
    }
    // check constant is correct size
    if (cons.numBytes() == 1) {
      throw new AssemblerException(AssemblerException.INCORRECT_CONSTANT_SIZE, lineNum, line);
    }

    // TODO check for overflow?
    return (short) (cons.getShort() + num);

  }

} // class
