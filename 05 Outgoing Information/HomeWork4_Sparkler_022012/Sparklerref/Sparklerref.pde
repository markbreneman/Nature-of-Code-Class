ParticleSystem ps;
Repeller repeller;

void setup() {
  size(640,360);
  smooth();
  ps = new ParticleSystem(new PVector(width/2,50));
  
}

void draw() {
  background(255);
  ps.addParticle();
  repeller = new Repeller(mouseX,mouseY);
  // Apply gravity force to all Particles
  PVector gravity = new PVector(0,0.1);
  ps.applyForce(gravity);
  
  ps.applyRepeller(repeller);
  
  ps.run();
  repeller.display();
}
