public class AssemblerException extends Exception {

  public static final int CPU_MEMORY_NOT_FOUND = 0;
  public static final int INVALID_OPCODE = 1;
  public static final int INVALID_LABEL = 2;
  public static final int NAME_MULTIPLY_DECLARD = 3;
  public static final int INVALID_OPERANDS = 4;
  public static final int INVALID_IMMEDIATE = 5;
  public static final int OFFSET_OUT_OF_RANGE = 6;
  public static final int LABEL_NOT_DECLARED = 7;
  public static final int INVALID_NUMBER_FORMAT = 8;
  public static final int INVALID_CONSTANT_FORMAT = 9;
  public static final int UNRECOGNIZED_DATA_INSTRUCTION = 10;
  public static final int CONSTANT_NOT_FOUND = 11;
  public static final int INCORRECT_CONSTANT_SIZE = 12;
  public static final int INVALID_BYTE_MASK = 13;

  private int type;
  private int lineNum;
  private String str = "";

  public AssemblerException(int err, int lineNum) {
    this.type = err;
    this.lineNum = lineNum;
  }

  public AssemblerException(int err, int lineNum, String str) {
    this.type = err;
    this.lineNum = lineNum;
    this.str = str;
  }

  public String toString() {
    if (type == 0) {
      return "Start of CPU memory not found.\nUse \"_CPU:\" to signal start of CPU memory.";
    }
    else if (type == 1) {
      return "Opcode on line " + lineNum + ", \"" + str + "\", is not a valid opcode.";
    }
    else if (type == 2) {
      return "Label on line " + lineNum + ", \"" + str + "\", is not a valid label name.";
    }
    else if (type == 3) {
      return "The label or constant, \"" + str + "\", was multiply declard on line " + lineNum + ".";
    }
    else if (type == 4) {
      return "Operands on line " + lineNum + ", \"" + str + "\", are not recognized.";
    }
    else if (type == 5) {
      return "Immediate on line " + lineNum + " must be between -128 and 127.";
    }
    else if (type == 6) {
      return "Offset on line " + lineNum + " is out of range. It's value is " + str + ", but must be between -128 and 127.";
    }
    else if (type == 7) {
      return "The label, " + str + ", specified on line " + lineNum + " was not declared.";
    }
    else if (type == 8) {
      return "The number format on line " + lineNum + " was not recognized: " + str;
    }
    else if (type == 9) {
      return "The constant on line " + lineNum + " has an invalid format: " + str;
    }
    else if (type == 10) {
      return "The data instruction on line " + lineNum + " was not recognized: " + str;
    }
    else if (type == 11) {
      return "The constant on line " + lineNum + " was not declared before it was used: " + str;
    }
    else if (type == 12) {
      return "The constant on line " + lineNum + " was the wrong size: " + str;
    }
    else if (type == 13) {
      return "The byte mask on line " + lineNum + " cannot be applied to the given constant: " + str;
    }
    return "";
  }

}
