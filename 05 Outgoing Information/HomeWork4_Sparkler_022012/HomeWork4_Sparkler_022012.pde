//Comments
//My Intent here will be to use the idea of a particle system to demonstrate  
//the burnign of sparkler.  As the user clicks the mouse to ignite, the sparkler
//will burn and particles will fall off.

SparkSystem sparks; 
Repeller repeller;

void setup() {
  size(500, 600);
  smooth();
  frameRate(50);
  sparks = new SparkSystem(new PVector(width/2, 20));
  repeller = new Repeller(width/2, 18);
}

void draw() {
  background(32, 32, 32, .8);
  sparks.addSpark();
  PVector gravity = new PVector(0, 0.1);
  sparks.applyForce(gravity);
  sparks.applyRepeller(repeller);
  sparks.run();
  repeller.render();
}



