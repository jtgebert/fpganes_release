public class Constant {

  private int bytes; // number of bytes in this constant 1 or 2
  private byte byte1; // first byte
  private byte byte2; // second byte
  private short shrt; // both bytes

  public Constant(String value, int lineNum) throws AssemblerException {
    if (!value.matches("^(\\$[0-9A-Za-z]{1,4}|%[01]{1,16}|-?[0-9]{1,3})$")) {
      throw new AssemblerException(AssemblerException.INVALID_CONSTANT_FORMAT, lineNum, value);
    }

    // num of digits
    int length = value.length() - 1;

    switch (value.charAt(0)) {
      // HEX
      case '$':
        // ABSOLUTE
        if (length > 2) {
          this.shrt = Assembler.getShortFromString(value.substring(1), Assembler.HEX);
          this.byte1 = (byte) this.shrt;
          this.byte2 = (byte) (this.shrt >> 8);
          this.bytes = 2;
        }
        // OFFSET/IMMEDIATE
        else {
          this.byte1 = Assembler.getByteFromString(value.substring(1), Assembler.HEX, lineNum);
          this.bytes = 1;
        }
      break;
      // BINARY
      case '%':
        // ABSOLUTE
        if (length > 8) {
          this.shrt = Assembler.getShortFromString(value.substring(1), Assembler.BINARY);
          this.byte1 = (byte) this.shrt;
          this.byte2 = (byte) (this.shrt >> 8);
          this.bytes = 2;
        }
        // OFFSET/IMMEDIATE
        else {
          this.byte1 = Assembler.getByteFromString(value.substring(1), Assembler.BINARY, lineNum);
          this.bytes = 1;
        }
      break;
      // DECIMAL IMMEDIATE
      default:
        this.byte1 = Assembler.getByteFromString(value.substring(0), Assembler.DECIMAL, lineNum);
        this.bytes = 1;
      break;
    }
  }

  public byte getByte1() {
    return this.byte1;
  }

  public byte getByte2() {
    return this.byte2;
  }

  public int numBytes() {
    return this.bytes;
  }

  public short getShort() {
    return this.shrt;
  }

}
