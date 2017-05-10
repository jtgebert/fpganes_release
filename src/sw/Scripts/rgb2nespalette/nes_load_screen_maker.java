import java.util.*;
import java.io.*;

public class nes_load_screen_maker {

  public static void main(String[] args) throws FileNotFoundException {

    Scanner scnr = new Scanner(new File("nes_palette.txt"));
    ArrayList<int[]> palette = new ArrayList<int[]>();
    String r, g, b;

    while (scnr.hasNext()) {
      int[] rgb = new int[3];
      r = scnr.nextLine();
      b = r.substring(r.lastIndexOf(',') + 1);
      r = r.substring(0, r.lastIndexOf(','));
      g = r.substring(r.indexOf(',') + 1);
      r = r.substring(0, r.indexOf(','));

      rgb[0] = Integer.parseInt(r);
      rgb[1] = Integer.parseInt(g);
      rgb[2] = Integer.parseInt(b);
      palette.add(rgb);
    }

    scnr = new Scanner(new File("nes_load_screen.txt"));
    PrintWriter pw = new PrintWriter(new File("nes_load_screen.mif"));

    pw.print("DEPTH = 61440;\nWIDTH = 6;\nADDRESS_RADIX = DEC;\nDATA_RADIX = BIN;\nCONTENT\nBEGIN\n\n");

    int addr = 0, index = 0;
    double sum = 0, minSum = Double.MAX_VALUE;
    int[] rgb = new int[3];
    int[] rgb2 = new int[3];
    while (scnr.hasNext()) {
      minSum = Double.MAX_VALUE;
      index = 0;

      pw.print(addr + " : ");
      addr++;

      r = scnr.nextLine();
      b = r.substring(16);
      g = r.substring(8, 16);
      r = r.substring(0, 8);

      rgb[0] = Integer.parseInt(r, 2);
      rgb[1] = Integer.parseInt(g, 2);
      rgb[2] = Integer.parseInt(b, 2);

      for (int i = 0; i < palette.size(); i++) {
        rgb2 = palette.get(i);
        sum = Math.sqrt(Math.pow((double) rgb[0] - rgb2[0], 2) + Math.pow((double) rgb[1] - rgb2[1], 2) + Math.pow((double) rgb[2] - rgb2[2], 2));
        if (sum < minSum) {
          minSum = sum;
          index = i;
        }
      }

      rgb2 = palette.get(index);
      System.out.println(rgb2[0] + " " + rgb2[1] + " " + rgb2[2]);

      r = Integer.toBinaryString(index);
      for (int i = 0; i < 6 - r.length(); i++) {
        pw.print("0");
      }
      pw.println(r + ";");

    }

    pw.print("\nEND;");
    pw.close();
    scnr.close();

  }

}
