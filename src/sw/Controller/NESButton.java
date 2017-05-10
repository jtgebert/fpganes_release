import javax.swing.*;
import javax.swing.plaf.*;

abstract public class NESButton extends JButton {

  public static final int CIRCLE_BUTTON_TYPE_A = 0;
  public static final int CIRCLE_BUTTON_TYPE_B = 1;
  public static final int HORIZONTAL_BUTTON_TYPE_SELECT = 2;
  public static final int HORIZONTAL_BUTTON_TYPE_START = 3;

  protected ImageIcon img;
  protected ImageIcon pressedImg;
  protected int index;

  public NESButton(String img, String pressedImg, int index, Controller c) {
    super();
    this.img = new ImageIcon(img);
    this.pressedImg = new ImageIcon(pressedImg);
    this.index = index;
    setFocusPainted(false);
    setContentAreaFilled(false);
    setBorderPainted(false);
    setIcon(this.img);
    setSelectedIcon(this.pressedImg);
    setPressedIcon(this.pressedImg);
    addChangeListener(c);
  }

  public void press() {
    DefaultButtonModel model = (DefaultButtonModel) this.getModel();
    model.setArmed(true);
    model.setPressed(true);
  }

  public void release() {
    DefaultButtonModel model = (DefaultButtonModel) this.getModel();
    model.setPressed(false);
    model.setArmed(false);
  }

  public int getIndex() {
    return this.index;
  }

}

class CircleButton extends NESButton {

  public CircleButton(int index, Controller c) {
    super("img/NESCircleButton.png", "img/NESCircleButtonPressed.png", index, c);
    if (index == CIRCLE_BUTTON_TYPE_A) {
      setBounds(461, 137, 75, 76);
    }
    else {
      setBounds(385, 137, 75, 76);
    }
  }

}

class HorizontalButton extends NESButton {

  public HorizontalButton(int index, Controller c) {
    super("img/NESHorizontalButton.png", "img/NESHorizontalButtonPressed.png", index, c);
    if (index == HORIZONTAL_BUTTON_TYPE_START) {
      setBounds(294, 166, 48, 20);
    }
    else {
      setBounds(212, 166, 48, 20);
    }
  }

}

class UpArrowButton extends NESButton {

  public UpArrowButton(Controller c) {
    super("img/NESUpButton.png", "img/NESUpButtonPressed.png", 4, c);
    setBounds(85, 95, 28, 37);
  }

}

class DownArrowButton extends NESButton {

  public DownArrowButton(Controller c) {
    super("img/NESDownButton.png", "img/NESDownButtonPressed.png", 5, c);
    setBounds(85, 160, 28, 37);
  }

}

class LeftArrowButton extends NESButton {

  public LeftArrowButton(Controller c) {
    super("img/NESLeftButton.png", "img/NESLeftButtonPressed.png", 6, c);
    setBounds(48, 132, 37, 28);
  }

}

class RightArrowButton extends NESButton {

  public RightArrowButton(Controller c) {
    super("img/NESRightButton.png", "img/NESRightButtonPressed.png", 7, c);
    setBounds(113, 132, 37, 28);
  }

}
