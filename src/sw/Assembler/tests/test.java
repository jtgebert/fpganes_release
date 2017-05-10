public class test {
  public static void main(String[] args) {
    String operands = "$7";
    byte byte1 = 0;
    if (operands.length() == 2) {
      byte1 = (byte) Character.digit(operands.charAt(1), 16);
      // sign extend
      if (byte1 > 7) {
        byte1 += (byte) (Character.digit('F', 16) << 4);
      }
    }
    System.out.println(byte1);

    char c = 'A';
    System.out.println(((int) c - 48));

    String str = "8000";
    short b = 0;
    int length = str.length();
    //sign extend
    if ((int) str.charAt(0) - 48 > 7 && length < 4) {
      for (int i = 0; i < 4 - length; i++) {
        str = "F" + str;
      }
      System.out.println(str);
    }
    length = str.length();
    // set byte
    for (int i = 0; i < length; i++) {
      b += ((short) Character.digit(str.charAt(i), 16)) << ((length - 1 - i) * 4);
    }

    System.out.println(b);

    byte1 = (byte) b;
    byte byte2 = (byte) (b >> 8);
    System.out.println(Integer.toBinaryString(byte1));
    System.out.println(Integer.toBinaryString(byte2));

    String teststr = " ";
    System.out.println(teststr.trim());
  }
}
