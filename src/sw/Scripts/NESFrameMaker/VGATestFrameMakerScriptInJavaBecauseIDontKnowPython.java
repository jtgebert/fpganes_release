import java.io.*;

public class VGATestFrameMakerScriptInJavaBecauseIDontKnowPython {

  public static void main(String[] args) {

    try {

      PrintWriter pw = new PrintWriter(new File("vga_test_frame.mif"));

      pw.print("DEPTH = 61440;\nWIDTH = 6;\nADDRESS_RADIX = DEC;\nDATA_RADIX = BIN;\nCONTENT\nBEGIN\n\n");

      for (int i = 0; i < 61440; i++) {
        pw.print(i + " : " + getRowPixel(i) + ";\n");
      }

      pw.print("\nEND;");

      pw.close();

    }
    catch (FileNotFoundException fnfe) {
      System.err.println("file not found");
      System.exit(-1);
    }

  }

  public static String getRowPixel(int address) {
  
	if (address % 12288 < 6144) {
		if (address % 64 < 32) {
		  return "000001";
		}
		else {
		  return "010101";
		}
	}
	else {
		if (address % 64 < 32) {
		  return "010101";
		}
		else {
		  return "000001";
		}
	}
  
	/*
    if (address < 6144) {
      return "000001";
    }
    else if (address < 12288) {
      return "010101";
    }
    else if (address < 18432) {
      return "011000";
    }
    else if (address < 24576) {
      return "100111";
    }
    else if (address < 30720) {
      return "111100";
    }
    else if (address < 36864) {
      return "110000";
    }
    else if (address < 43008) {
      return "111111";
    }
    else if (address < 49152) {
      return "010100";
    }
    else if (address < 55296) {
      return "101001";
    }
    else {
      return "010011";
    }
	*/
  }

}
