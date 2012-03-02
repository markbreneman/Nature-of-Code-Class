import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PBox2D box2d;

// A list for all of our rectangles
ArrayList<Box> boxes;

void setup() {
  size(400,300);
  smooth();
  box2d = new PBox2D(this);
  box2d.createWorld();

  // Create ArrayLists
  boxes = new ArrayList<Box>();
}

void draw() {
  background(255);
  box2d.step();//Stepping throught time for box2D to calculate per frame.
  // When the mouse is clicked, add a new Box object
  if (mousePressed) {
    Box p = new Box(mouseX,mouseY);
    boxes.add(p);
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }
}
