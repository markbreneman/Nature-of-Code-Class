// A simple Particle class

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer;  

  Particle(PVector l) {
    acc = new PVector(0,0.05,0);
    vel = new PVector(random(-3,3),random(-3,0),0);
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
    timer -= 1.0;
  }

  // Method to display
  void render() {
    ellipseMode(CENTER);
//    stroke(255,timer);
    fill(C3,timer);
    float ellipserad = random(3,10);
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
