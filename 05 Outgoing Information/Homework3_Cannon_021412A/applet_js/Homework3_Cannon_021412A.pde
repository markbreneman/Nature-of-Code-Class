Cannonball [] cannonball = new Cannonball[5];
Cannon c;
Ground g;
PFont font;

void setup() {
  size(700, 600);
  smooth();
  //ISSUE CANNONBALLS
  for (int i=0; i<cannonball.length; i++) {
    cannonball[i]=new Cannonball();
  }
  //ISSUE NEWCANNON AND GROUND OBJECTS
  c= new Cannon();
  g= new Ground(0, height*2/3+15, width, height*2/3+70);
  font = loadFont("Whitney-Book-18.vlw");
}

void draw() {
  background(169, 169, 169);
  //DRAW THE CANNON MOUNT AND BARREL
  c.mount();
  c.barrel();
  //DRAW THE GROUND AND CREATE GRAVITY
  g.display();
  PVector gravity = new PVector(0, .1);
  //ADD PROPERTIES TO THE GROUND
  for (int i = 0; i < cannonball.length; i++) {
    if (g.contains(cannonball[i])) {
      cannonball[i].velocity.y*=.01;
      cannonball[i].velocity.x*=0;
      cannonball[i].aVelocity=0;
      cannonball[i].aAcceleration=0;
    }
  }
  //CONTROL OF CANNON ANGLE
  if (keyPressed) {
    if (key == CODED && keyCode == RIGHT) {    
      c.cannonAngle+=1;
    }
    else if (key == CODED && keyCode == LEFT) {
      c.cannonAngle-=1;
    }
    for (int i=0; i<cannonball.length; i++) {
      cannonball[i].updateLocation();
    }
  }

  // DRAW THE CANNON BALLS
  for (int i=0; i<cannonball.length; i++) {
    cannonball[i].movement();
    cannonball[i].display();
    if (c.launched) {
      cannonball[i].applyForce(gravity);
    } 
    else {
      //cannonball[i].updateLocation();
    }
  }
  //INSTRUCTIONS
  textFont(font); 
  fill(0, 0, 0);
  text("Up to Launch", 15, height*7/8+10);
  text("Down to Reload", 15, height*7/8+30);
  text("Left/Right to angle Cannon", 15, height*7/8+50);
}
//LAUNCH THE CANNONBALLS
void keyPressed() {

  if (key == CODED && keyCode == UP && !c.launched) {
    for (int i=0; i<cannonball.length; i++) {
      cannonball[i].explode();
    }
    c.launched = true;
    //cannonball[i].applyForce(gravity);
  }
  //RELOADING
  else if (key == CODED && keyCode == DOWN) {
    for (int i=0; i<cannonball.length; i++) {
      cannonball[i].location.y=random(height*2/3-20, height*2/3-10);
      cannonball[i].location.x=random(width/2-12, width/2+12);
      cannonball[i].velocity.mult(0);
      cannonball[i].acceleration.mult(0);
      cannonball[i].aVelocity=0;
      cannonball[i].aAcceleration=0;
      c.launched = false;
    }
  }
  
  
}

class Cannon {
  float ellipseRad, cannonAngle;
  boolean launched = false;

  Cannon() {
    
  }
  void barrel() {
    pushMatrix();
    translate(width/2, 385);
    cannonAngle=constrain(cannonAngle,-90,90);
    rotate(radians(cannonAngle));
    smooth();
    //CREATE SECTION OF BARREL
    stroke(0);
    strokeWeight(1);
    fill(69, 69, 69);
    translate( -28, -50 );
    beginShape();
    vertex( 28, 71 );
    bezierVertex( 62, 69, 59, 39, 52, 0);
    vertex( 45, 0 );
    bezierVertex( 55, 58, 44, 64, 28, 64);
    vertex( 29, 64 );
    bezierVertex( 13, 64, 2, 58, 12, 0);
    vertex( 5, 0 );
    bezierVertex( -2, 39, -5, 69, 29, 71);
    endShape();

    //Create Barrel Transparency
    strokeWeight(1);
    fill(255, 0, 0, .8);
    beginShape();
    vertex( 28, 71 );
    bezierVertex( 62, 69, 59, 39, 52, 0);
    vertex( 5, 0 );
    bezierVertex( -2, 39, -5, 69, 29, 71);
    endShape();
    popMatrix();
  }

  void mount() {
    fill(255, 255, 255);
    rectMode(CENTER);
    stroke(0);
    rect(width/2, height*2/3, 30, 30);
    noStroke();
    ellipse(width/2, height*2/3-15, 30, 30);
    stroke(0);
    ellipse(width/2, height*2/3-15, 10, 10);
    strokeWeight(3);
//    line(0, height*2/3+15, width, height*2/3+15);
    
  }
}

class Cannonball {
  float ellipseRad, theta, explodeForce, topSpeed, aVelocity, aAcceleration, angle, damping;
  PVector location, velocity, acceleration, gravity;

  Cannonball() {
    ellipseRad=15;
    explodeForce=10;
    //    topSpeed=5;
    //    damping=.9;
    location=new PVector(random(width/2-12, width/2+12), random(height*2/3-20, height*2/3-10));
    velocity=new PVector(0, 0);
    acceleration=new PVector(0, 0);
  }

  void display() {

    fill(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    ellipse(0, 0, ellipseRad, ellipseRad);
    //    line(0, 0, ellipseRad/2.25, ellipseRad/2.25);
    fill(255);
    noStroke();
    ellipse(3, -3, 5, 5);
    popMatrix();
  }

  void movement() {
    location.add(velocity);
    velocity.add(acceleration);
    //velocity.mult(damping);
    //velocity.limit(topSpeed);//So Cannonballs don't move faster than the framerate.Keeping them with normal movement
    aAcceleration = acceleration.y/4*random(-1, 1);
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -0.1, 0.1); 
    theta += aVelocity;
    acceleration.mult(0);// PREVENTING ACCUMULATION OF FORCES
  }

  void applyForce(PVector force) {
    PVector f = force.get();//What does this do? exactly I'm still lost on the Get command
    acceleration.add(f);
  }

  void explode() {
    PVector force = new PVector(cos(radians(c.cannonAngle)-PI/2), sin(radians(c.cannonAngle)-PI/2));

    force.x*=random(1, 2);
    force.y*=random(1, 2);
    force.mult(explodeForce);
    applyForce(force);
  }

  void updateLocation() {
    //    PVector force = new PVector(cos(radians(c.cannonAngle)-PI/2), sin(radians(c.cannonAngle)-PI/2));
    //    translate(200, 385);
    //    line(0, 0, force.x, force.y);
  }
}

class Ground {

  float x1;
  float y1;
  float x2;
  float y2;
  float c;

  Ground(float topX, float topY, float bottomX, float bottomY) {
    x1=topX;
    y1=topY;
    x2=bottomX;
    y2=bottomY;
    c=.1;
  }


  boolean contains(Cannonball cannonball) {
    PVector g = cannonball.location;
    if (g.x > x1 && g.x < x2 && g.y > y1 && g.y < y2) {
      return true;
    }  
    else {
      return false;
    }
  }

//  PVector drag(Cannonball cannonball) {
//  float speed = cannonball.velocity.mag();
//  float dragMagnitude = -1*c*speed*speed;
//  
//  PVector drag = cannonball.velocity.get();
//  drag.normalize();
//  drag.mult(dragMagnitude);
//  return drag;
//  }


  void display() {
    rectMode(CORNERS);
    noStroke();
    fill(82, 52, 19);
    rect(0, height*2/3+15, width, height*2/3+120);
    //    fill(82, 52, 19);
    //    rect(0, height*2/3+15, width, height*2/3+70);
  }
}


