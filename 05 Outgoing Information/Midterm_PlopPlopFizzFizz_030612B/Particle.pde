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
    acc = new PVector(0,0.05);
    vel = new PVector(random(-3,3),random(-3,3));
    loc = l.get();
    timer = 200.0;
  }


  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 3;
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
    strokeWeight(1);
    stroke(C4);
    ellipse(loc.x,loc.y,ellipserad,ellipserad);
  }
  
  // Is the particle still useful?
//  boolean dead() {
//  }
  boolean dead() {
    if (loc.y > height) {
      return true;
    }
    if (loc.y < height/2.75) {
      return true;
    }
    if (loc.x < mass) {
      return true;
    }
    if (loc.x > width-mass) {
      return true;
    }

    else{
      return false;
  }}
}
