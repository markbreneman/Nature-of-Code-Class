// A simple Particle class

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer;
  float mass = 2;
  float ellipserad = random(3,10);  

  Particle(PVector l) {
    acc = new PVector(0,0.05,0);
    vel = new PVector(random(-3,3),random(-3,3));
    loc = l.get();
    timer = 255.0;
  }


  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= .5;
  }
  
 //Apply forces to the particle
    void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }

  // Method to display
  void render() {
    ellipseMode(CENTER);
    fill(C3,timer);
    ellipse(loc.x,loc.y,ellipserad,ellipserad);
  }
  
  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
