Mover mover1;

void setup() {
  size(300, 300);
  smooth();
  mover1=new Mover();
}

void draw() {
    noStroke();
    fill(132,132,132,10);
    rect(0,0,height,width);
//  background(132, 132, 132);
  mover1.update();
  mover1.display();
  println(mover1.location);
  mover1.checkEdges();
}


class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  int topspeed;
  
  Mover() { 
    location= new PVector(height/2, width/2);
    velocity= new PVector(0,0);
    acceleration= new PVector(-0.001,0.01);
    topspeed=10;
  }
  void update() { 
//    acceleration= new PVector(random(-1,1),random(-1,1));
//    acceleration.normalize();
//    acceleration.mult(.2);
//    acceleration.mult(random(2));
    PVector mouse = new PVector(mouseX,mouseY);
    PVector dir=PVector.sub(mouse,location);
    dir.normalize();
    dir.mult(.5);
    acceleration=dir;
    
    location.add(velocity);
    velocity.add(acceleration);
    velocity.limit(topspeed);
  }
  void display() { 
    stroke(0);
    fill(169);
    ellipse(location.x, location.y, 16, 16);
  }
  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } 
    else if (location.y < 0) {
      location.y = height;
    }
  }
}

