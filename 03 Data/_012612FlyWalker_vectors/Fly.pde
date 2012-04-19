class Gnat {
  int x, y, ellipseRad;
  PVector location,velocity;


  Gnat() {
    ellipseRad=20;
    location = new PVector(width/2, height/2);
  }

  void display() {
    smooth();
    stroke(0);
//    fill(255,10);
//    rect(0,0,width,height);
    
    //Body
    ellipseMode(CENTER);
    fill(37, 37, 37);    
    ellipse(location.x, location.y, ellipseRad, ellipseRad/2.25);
    //WingBottom
    pushMatrix();
    translate(location.x+ellipseRad/3, location.y+ellipseRad/2.85);
    rotate(radians(30));
    noFill();
    ellipse(0, 0, ellipseRad/1.25, ellipseRad/3);
    popMatrix();
    //WingTop
    pushMatrix();
    translate(location.x-ellipseRad/3, location.y-ellipseRad/2.85);
    rotate(radians(30));
    noFill();
    ellipse(0, 0, ellipseRad/1.25, ellipseRad/3);
    popMatrix();
  }

  void fly() {
    velocity = new PVector(random(-10, 10), random(-10, 10));
      println("this is the original location value" + location);
      println("this is the"+ velocity);
    location.add(velocity);
    println("this is the added value"+location);
    location.x=constrain(location.x, 0, width-5);
    location.y=constrain(location.y, 0, height-5);
    println(location);
  }
}

