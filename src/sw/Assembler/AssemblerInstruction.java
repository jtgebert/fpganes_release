public abstract class AssemblerInstruction {

  public static final int DATA_INSTRUCTION = 0;
  public static final int OPCODE_INSTRUCTION = 1;

  public abstract int getInstructionType();
  public abstract short getAddr();
  public abstract int getLineNum();
}
