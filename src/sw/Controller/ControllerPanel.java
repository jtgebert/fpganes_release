import java.awt.*;
import javax.swing.*;
import java.awt.image.*;
import javax.imageio.ImageIO;
import java.io.*;

public class ControllerPanel extends JPanel {

  private BufferedImage image;

  public ControllerPanel() {

    setFocusTraversalKeysEnabled(false);

    try {
      image = ImageIO.read(new File("img/NESController.png"));
    }
    catch(FileNotFoundException fnfe) {
      System.err.println("Background image not found");
      System.exit(-1);
    }
    catch(IOException ioe) {
      System.err.println("Background image cannot be read");
      System.exit(-1);
    }

    setBounds(50, 30, 600, 247);
    setBackground(Color.DARK_GRAY);
    setFocusable(true);
    requestFocusInWindow();
    setLayout(null);
  }

  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    g.drawImage(image, 0, 0, this);
  }
}
