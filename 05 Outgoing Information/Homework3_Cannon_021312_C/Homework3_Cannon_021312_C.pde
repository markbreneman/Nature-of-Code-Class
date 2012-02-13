Cannonball [] cannonball = new Cannonball[10];
Cannon c;


void setup() {
  size(400, 600);
  smooth();
  //Issue cannonball Objects
  for (int i=0; i<cannonball.length; i++) {
    cannonball[i]=new Cannonball();
  }
  //Issue cannon object
  c= new Cannon();
}

void draw() {
  background(169, 169, 169);
  //draw the cannon barrel and mount
  c.mount();
  c.barrel();
  PVector gravity = new PVector(0, .1);
  
  if (keyPressed) {
    if (key == CODED && keyCode == RIGHT) {
      c.cannonAngle+=1;  
    }
    else if (key == CODED && keyCode == LEFT) {
      c.cannonAngle-=1;
    }
  }

  //  draw the cannon balls
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

}

void keyPressed() {

  if (key == CODED && keyCode == UP && !c.launched) {
    for (int i=0; i<cannonball.length; i++) {
      cannonball[i].explode();
    }
    c.launched = true;
    //cannonball[i].applyForce(gravity);
  }
  //Reloading
  else if (key == CODED && keyCode == DOWN) {
    for (int i=0; i<cannonball.length; i++) {
      cannonball[i].location.y=random(height*2/3-70, height*2/3-15);
      cannonball[i].location.x=random(width/2-12, width/2+12);
      cannonball[i].velocity.y=0;
      cannonball[i].velocity.x=0;
      cannonball[i].acceleration.x=0;
      cannonball[i].acceleration.y=0;
      c.launched = false;
    }
  }
}

