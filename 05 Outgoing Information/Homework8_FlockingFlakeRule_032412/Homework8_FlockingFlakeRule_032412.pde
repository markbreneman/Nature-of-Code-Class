// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2009

// Demonstration of Craig Reynolds' "Flocking" behavior
// See: http://www.red3d.com/cwr/
// Rules: Cohesion, Separation, Alignment

// Click mouse to add boids into the system

Flock flock;

void setup() {
  size(640,360);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 2; i++) {
    Boid b = new Boid(width/2+random(0,75),height/2+random(0,75));
    flock.addBoid(b);
  }
  
  smooth();
  
}

void draw() {
  background(255);
  flock.run();
  frameRate(10);
    // Instructions
  fill(0);
  text("Drag the mouse to generate new boids.",10,height-16);
  
//  if(mousePressed== true){
//    flock.addBoid(new Boid(mouseX,mouseY));}
}


// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
  
}

void keyPressed(){
  
  noLoop();
}



