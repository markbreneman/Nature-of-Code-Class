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
  
  //draw the cannon balls
  for (int i=0; i<cannonball.length; i++) {
    cannonball[i].movement();
    cannonball[i].display();
  //adding the explosion
    if (keyPressed) {
      if (key == CODED && keyCode == UP) {
        cannonball[i].explode();
      }
   //Reloading
      else if (key == CODED && keyCode == DOWN) {
        cannonball[i].location.y=random(height*2/3-70, height*2/3-15);
        cannonball[i].velocity.y=0;
      }
    }
  }
  
  if (keyPressed) {
      if (key == CODED && keyCode == LEFT) {
        cannonball[i].explode();
      }
    
}

