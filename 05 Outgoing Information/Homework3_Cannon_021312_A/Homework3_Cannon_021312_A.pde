Cannonball [] cannonball = new Cannonball[10];
Cannon c;
float cannonAngle;

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
  pushMatrix();
  translate(width/2, 385);
  rotate(cannonAngle);
  c.barrel();
  popMatrix();  
  PVector gravity = new PVector(0,.1);


  if (keyPressed) {
    if (key == CODED && keyCode == RIGHT) {
      cannonAngle+=.1;
    }
    else if (key == CODED && keyCode == LEFT) {
      cannonAngle-=.1;
    }
  }


  //  draw the cannon balls
  for (int i=0; i<cannonball.length; i++) {
    cannonball[i].movement();
    cannonball[i].display();
//    cannonball[i].applyForce(gravity);
    
    //adding the explosion
    if (keyPressed) {
      if (key == CODED && keyCode == UP) {
        cannonball[i].explode(cannonAngle);
//        cannonball[i].applyForce(gravity);
      }
      //Reloading
      else if (key == CODED && keyCode == DOWN) {
        cannonball[i].location.y=random(height*2/3-70, height*2/3-15);
        cannonball[i].velocity.y=0;
      }
    }
  }
}

