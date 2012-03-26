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
  for (int i = 0; i < 15; i++) {
    Boid b = new Boid(width/2+random(0,75),height/2+random(0,75));
    flock.addBoid(b);
  }
  smooth();
  boolean paused = false; 
}

void draw() {
  background(255);
  loop();
  
  if(!paused) flock.run();
//  println(paused);
    // Instructions
  fill(0);
  text("Drag the mouse to generate new boids.",10,height-16);
}

// Add a new boid into the System
void mouseDragged() {
  flock.addBoid(new Boid(mouseX,mouseY));
}

//void keyPressed(){
//noLoop();
//}

 
void keyPressed() { 
     paused = !paused; 
}

