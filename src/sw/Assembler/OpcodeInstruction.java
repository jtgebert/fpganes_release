import java.util.*;

public class OpcodeInstruction extends AssemblerInstruction {

  ////////// MEMORY ADDRESSING MODES //////////
  public static final int IMPLIED = 0;
  public static final int ACCUMULATOR = 1;
  public static final int IMMEDIATE = 2;
  public static final int ABSOLUTE = 3;
  public static final int ZERO_PAGE = 4;
  public static final int RELATIVE = 5;
  public static final int ABSOLUTE_INDEXED_X = 6;
  public static final int ABSOLUTE_INDEXED_Y = 7;
  public static final int ZERO_PAGE_INDEXED_X = 8;
  public static final int ZERO_PAGE_INDEXED_Y = 9;
  public static final int ZERO_PAGE_INDIRECT_X = 10;
  public static final int ZERO_PAGE_INDIRECT_Y = 11;
  public static final int INDIRECT = 12;

  ////////// FIELDS //////////
  private byte opcode; // opcode byte
  private byte byte1; // immediate, offset, or second byte of address
  private byte byte2; // first byte of the address for absolute, null otherwise
  private String label; // the label name if a label is referenced by instruction
  private int memMode; // mem addressing mode
  private short addr; // the address of this instructions opcode
  private int lineNum; // the line number of this instruction

  // assumes instr is trimmed of whitespace
  public OpcodeInstruction(String instr, int lineNum, short addr, HashMap<String, Constant> constants) throws AssemblerException {

    this.addr = addr;
    this.lineNum = lineNum;

    String opcodeName, operands;
    // get opcodes and operands from line
    if (!instr.contains(" ")) {
      opcodeName = instr.toUpperCase();
      operands = "";
    }
    else {
      int indexSpace = instr.indexOf(' ');
      opcodeName = instr.substring(0, indexSpace).toUpperCase();
      operands = instr.substring(indexSpace + 1).trim();
    }

    // check that opcode is three letters
    if (!opcodeName.matches("^[A-Z]{3}$")) {
      throw new AssemblerException(AssemblerException.INVALID_OPCODE, lineNum, opcodeName);
    }

    switch (opcodeName) {
      case "ADC":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0x69;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x65;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x75;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x6D;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x7D;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0x79;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0x61;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0x71;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "AND":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0x29;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x25;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x35;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x2D;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x3D;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0x39;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0x21;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0x31;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "ASL":
        if (isAccumulator(operands)) {
          this.opcode = (byte) 0x0A;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x06;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x16;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x0E;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x1E;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BCC":
        if (isRelative(operands)) {
          this.opcode = (byte) 0x90;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BCS":
        if (isRelative(operands)) {
          this.opcode = (byte) 0xB0;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BEQ":
        if (isRelative(operands)) {
          this.opcode = (byte) 0xF0;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BIT":
        if (isZeroPage(operands)) {
          this.opcode = (byte) 0x24;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x2C;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BMI":
        if (isRelative(operands)) {
          this.opcode = (byte) 0x30;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BNE":
        if (isRelative(operands)) {
          this.opcode = (byte) 0xD0;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BPL":
        if (isRelative(operands)) {
          this.opcode = (byte) 0x10;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BRK":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x00;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BVC":
        if (isRelative(operands)) {
          this.opcode = (byte) 0x50;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "BVS":
        if (isRelative(operands)) {
          this.opcode = (byte) 0x70;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CLC":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x18;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CLD":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xD8;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CLI":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x58;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CLV":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xB8;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CMP":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xC9;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xC5;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0xD5;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xCD;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0xDD;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0xD9;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0xC1;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0xD1;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CPX":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xE0;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xE4;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xEC;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "CPY":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xC0;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xC4;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xCC;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "DEC":
        if (isZeroPage(operands)) {
          this.opcode = (byte) 0xC6;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0xD6;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xCE;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0xDE;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "DEX":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xCA;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "DEY":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x88;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "EOR":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0x49;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x45;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x55;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x4D;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x5D;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0x59;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0x41;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0x51;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "INC":
        if (isZeroPage(operands)) {
          this.opcode = (byte) 0xE6;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0xF6;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xEE;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0xFE;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "INX":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xE8;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "INY":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xC8;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "JMP":
        if (isIndirect(operands)) {
          this.opcode = (byte) 0x6C;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x4C;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "JSR":
        if (isAbsolute(operands)) {
          this.opcode = (byte) 0x20;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "LDA":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xA9;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xA5;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0xB5;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xAD;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0xBD;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0xB9;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0xA1;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0xB1;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "LDX":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xA2;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xA6;
        }
        else if (isZeroPageIndexedY(operands)) {
          this.opcode = (byte) 0xB6;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xAE;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0xBE;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "LDY":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xA0;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xA4;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0xB4;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xAC;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0xBC;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "LSR":
        if (isAccumulator(operands)) {
          this.opcode = (byte) 0x4A;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x46;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x56;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x4E;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x5E;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "NOP":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xEA;
        }
      break;
      case "ORA":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0x09;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x05;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x15;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x0D;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x1D;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0x19;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0x01;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0x11;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "PHA":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x48;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "PHP":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x08;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "PLA":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x68;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "PLP":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x28;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "ROL":
        if (isAccumulator(operands)) {
          this.opcode = (byte) 0x2A;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x26;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x36;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x2E;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x3E;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "ROR":
        if (isAccumulator(operands)) {
          this.opcode = (byte) 0x6A;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0x66;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x76;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x6E;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x7E;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "RTI":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x40;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "RTS":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x60;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "SBC":
        if (isImmediate(operands)) {
          this.opcode = (byte) 0xE9;
        }
        else if (isZeroPage(operands)) {
          this.opcode = (byte) 0xE5;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0xF5;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0xED;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0xFD;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0xF9;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0xE1;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0xF1;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "SEC":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x38;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "SED":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xF8;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "SEI":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x78;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "STA":
        if (isZeroPage(operands)) {
          this.opcode = (byte) 0x85;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x95;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x8D;
        }
        else if (isAbsoluteIndexedX(operands)) {
          this.opcode = (byte) 0x9D;
        }
        else if (isAbsoluteIndexedY(operands)) {
          this.opcode = (byte) 0x99;
        }
        else if (isZeroPageIndirectIndexedX(operands)) {
          this.opcode = (byte) 0x81;
        }
        else if (isZeroPageIndirectIndexedY(operands)) {
          this.opcode = (byte) 0x91;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "STX":
        if (isZeroPage(operands)) {
          this.opcode = (byte) 0x86;
        }
        else if (isZeroPageIndexedY(operands)) {
          this.opcode = (byte) 0x96;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x8E;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "STY":
        if (isZeroPage(operands)) {
          this.opcode = (byte) 0x84;
        }
        else if (isZeroPageIndexedX(operands)) {
          this.opcode = (byte) 0x94;
        }
        else if (isAbsolute(operands)) {
          this.opcode = (byte) 0x8C;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "TAX":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xAA;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "TAY":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xA8;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "TSX":
        if (isImplied(operands)) {
          this.opcode = (byte) 0xBA;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "TXA":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x8A;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "TXS":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x9A;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
      case "TYA":
        if (isImplied(operands)) {
          this.opcode = (byte) 0x98;
        }
        else {
          throw new AssemblerException(AssemblerException.INVALID_OPERANDS, this.lineNum, instr);
        }
      break;
    }

  }

  private boolean isImplied(String operands) {
    if (operands.isEmpty()) {
      this.memMode = IMPLIED;
      return true;
    }
    else {
      return false;
    }
  }

  private boolean isAccumulator(String operands) {
    if (operands.isEmpty()) {
      this.memMode = ACCUMULATOR;
      return true;
    }
    else {
      return false;
    }
  }

  private boolean isImmediate(String operands) throws AssemblerException {
    if (operands.matches("^#(-?[0-9]{1,3}|\\$[0-9A-Fa-f]{1,2}|%[01]{1,8})$")) {
      this.memMode = IMMEDIATE;
      // remove #
      operands = operands.substring(1);
      // hex
      if (operands.charAt(0) == '$') {
        this.byte1 = Assembler.getByteFromString(operands.substring(1), Assembler.HEX, this.lineNum);
      }
      // binary
      else if (operands.charAt(0) == '%') {
        this.byte1 = Assembler.getByteFromString(operands.substring(1), Assembler.BINARY, this.lineNum);
      }
      // decimal
      else {
        this.byte1 = Assembler.getByteFromString(operands, Assembler.DECIMAL, this.lineNum);
      }
      return true;
    }
    else {
      return false;
    }
  }

  private boolean isAbsolute(String operands) {
    if (operands.matches("^(\\$(%[01]{16}|[0-9A-Fa-f]{4})|[a-zA-Z_]+[a-zA-Z0-9_]*)$")) {
      this.memMode = ABSOLUTE;
      // not label
      if (operands.charAt(0) == '$') {
        // binary
        if (operands.charAt(1) == '%') {
          short s = Assembler.getShortFromString(operands.substring(2), Assembler.BINARY);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
        // hex
        else {
          short s = Assembler.getShortFromString(operands.substring(1), Assembler.HEX);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
      }
      // label
      else {
        this.label = operands;
      }
      return true;
    }

    return false;
  }

  private boolean isZeroPage(String operands) throws AssemblerException {
    if (operands.matches("^\\$(%[01]{8}|[0-9A-Fa-f]{2})$")) {
      this.memMode = ZERO_PAGE;
      // binary
      if (operands.charAt(1) == '%') {
        this.byte1 = Assembler.getByteFromString(operands.substring(2), Assembler.BINARY, this.lineNum);
      }
      // hex
      else {
        this.byte1 = Assembler.getByteFromString(operands.substring(1), Assembler.HEX, this.lineNum);
      }
      return true;
    }

    return false;
  }

  private boolean isRelative(String operands) throws AssemblerException {
    if (operands.matches("^(\\$(%[01]{1,8}|[0-9A-Fa-f]{1,2})|[a-zA-Z_]+[a-zA-Z0-9_]*|#-?[0-9]{1,3})$")) {
      this.memMode = RELATIVE;
      // not label
      if (operands.charAt(0) == '$') {
        // binary
        if (operands.charAt(1) == '%') {
          this.byte1 = Assembler.getByteFromString(operands.substring(2), Assembler.BINARY, this.lineNum);
        }
        // hex
        else {
          this.byte1 = Assembler.getByteFromString(operands.substring(1), Assembler.HEX, this.lineNum);
        }
      }
      // label
      else {
        this.label = operands;
      }
      return true;
    }

    return false;
  }

  private boolean isAbsoluteIndexedX(String operands) {
    if (operands.matches("^(\\$(%[01]{16}|[0-9A-Fa-f]{4})|[a-zA-Z_]+[a-zA-Z0-9_]*) *, *[Xx]$")) {
      this.memMode = ABSOLUTE_INDEXED_X;
      // remove comma and reg name
      operands = operands.substring(0, operands.indexOf(',')).trim();
      // not label
      if (operands.charAt(0) == '$') {
        // binary
        if (operands.charAt(1) == '%') {
          short s = Assembler.getShortFromString(operands.substring(2), Assembler.BINARY);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
        // hex
        else {
          short s = Assembler.getShortFromString(operands.substring(1), Assembler.HEX);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
      }
      // label
      else {
        this.label = operands;
      }
      return true;
    }

    return false;
  }

  private boolean isAbsoluteIndexedY(String operands) {
    if (operands.matches("^(\\$(%[01]{16}|[0-9A-Fa-f]{4})|[a-zA-Z_]+[a-zA-Z0-9_]*) *, *[Yy]$")) {
      this.memMode = ABSOLUTE_INDEXED_Y;
      // remove comma and reg name
      operands = operands.substring(0, operands.indexOf(',')).trim();
      // not label
      if (operands.charAt(0) == '$') {
        // binary
        if (operands.charAt(1) == '%') {
          short s = Assembler.getShortFromString(operands.substring(2), Assembler.BINARY);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
        // hex
        else {
          short s = Assembler.getShortFromString(operands.substring(1), Assembler.HEX);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
      }
      // label
      else {
        this.label = operands;
      }
      return true;
    }

    return false;
  }

  private boolean isZeroPageIndexedX(String operands) throws AssemblerException {
    if (operands.matches("^\\$(%[01]{8}|[0-9A-Fa-f]{2}) *, *[Xx]$")) {
      this.memMode = ZERO_PAGE_INDEXED_X;
      // remove comma and reg name
      operands = operands.substring(0, operands.indexOf(',')).trim();
      // binary
      if (operands.charAt(1) == '%') {
        this.byte1 = Assembler.getByteFromString(operands.substring(2), Assembler.BINARY, this.lineNum);
      }
      // hex
      else {
        this.byte1 = Assembler.getByteFromString(operands.substring(1), Assembler.HEX, this.lineNum);
      }
      return true;
    }

    return false;
  }

  private boolean isZeroPageIndexedY(String operands) throws AssemblerException {
    if (operands.matches("^\\$(%[01]{8}|[0-9A-Fa-f]{2}) *, *[Yy]$")) {
      this.memMode = ZERO_PAGE_INDEXED_Y;
      // remove comma and reg name
      operands = operands.substring(0, operands.indexOf(',')).trim();
      // binary
      if (operands.charAt(1) == '%') {
        this.byte1 = Assembler.getByteFromString(operands.substring(2), Assembler.BINARY, this.lineNum);
      }
      // hex
      else {
        this.byte1 = Assembler.getByteFromString(operands.substring(1), Assembler.HEX, this.lineNum);
      }
      return true;
    }

    return false;
  }

  private boolean isZeroPageIndirectIndexedX(String operands) throws AssemblerException {
    if (operands.matches("^\\( *\\$(%[01]{8}|[0-9A-Fa-f]{2}) *, *[Xx] *\\)$")) {
      this.memMode = ZERO_PAGE_INDIRECT_X;
      // remove parens and reg name
      operands = operands.substring(1, operands.indexOf(',')).trim();
      // binary
      if (operands.charAt(1) == '%') {
        this.byte1 = Assembler.getByteFromString(operands.substring(2).trim(), Assembler.BINARY, this.lineNum);
      }
      // hex
      else {
        this.byte1 = Assembler.getByteFromString(operands.substring(1).trim(), Assembler.HEX, this.lineNum);
      }
      return true;
    }

    return false;
  }

  private boolean isZeroPageIndirectIndexedY(String operands) throws AssemblerException {
    if (operands.matches("^\\( *\\$(%[01]{8}|[0-9A-Fa-f]{2}) *\\) *, *[Yy]$")) {
      this.memMode = ZERO_PAGE_INDIRECT_Y;
      // remove parens and reg name
      operands = operands.substring(1, operands.indexOf(')')).trim();
      // binary
      if (operands.charAt(1) == '%') {
        this.byte1 = Assembler.getByteFromString(operands.substring(2).trim(), Assembler.BINARY, this.lineNum);
      }
      // hex
      else {
        this.byte1 = Assembler.getByteFromString(operands.substring(1).trim(), Assembler.HEX, this.lineNum);
      }
      return true;
    }

    return false;
  }

  private boolean isIndirect(String operands) throws AssemblerException {
    if (operands.matches("^\\( *(\\$(%[01]{16}|[0-9A-Fa-f]{4})|[a-zA-Z_]+[a-zA-Z0-9_]*) *\\)$")) {
      this.memMode = INDIRECT;
      // remove comma and reg name
      operands = operands.substring(1, operands.indexOf(')')).trim();
      // not label
      if (operands.charAt(0) == '$') {
        // binary
        if (operands.charAt(1) == '%') {
          short s = Assembler.getShortFromString(operands.substring(2), Assembler.BINARY);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
        // hex
        else {
          short s = Assembler.getShortFromString(operands.substring(1), Assembler.HEX);
          this.byte1 = (byte) s;
          this.byte2 = (byte) (s >> 8);
        }
      }
      // label
      else {
        this.label = operands;
      }
      return true;
    }

    return false;
  }

  public byte getOpcode() {
    return this.opcode;
  }

  public byte getByte1() {
    return this.byte1;
  }

  public byte getByte2() {
    return this.byte2;
  }

  public String getLabel() {
    return this.label;
  }

  public int getMemMode() {
    return this.memMode;
  }

  public short getAddr() {
    return this.addr;
  }

  public int getLineNum() {
    return this.lineNum;
  }

  public void updateOffset(short labelAddr) throws AssemblerException {
    short s = (short) ((int) labelAddr - ((int) this.addr + 2) ); // +2 because offset is from next instruction
    if (s <= 127 && s >= -128) {
      this.byte1 = (byte) s;
    }
    else {
      throw new AssemblerException(AssemblerException.OFFSET_OUT_OF_RANGE, this.lineNum, "" + s);
    }
  }

  public void updateAddr(short labelAddr) {
    this.byte1 = (byte) labelAddr;
    this.byte2 = (byte) (labelAddr >> 8);
  }

  public int getInstructionType() {
    return AssemblerInstruction.OPCODE_INSTRUCTION;
  }

}
