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

