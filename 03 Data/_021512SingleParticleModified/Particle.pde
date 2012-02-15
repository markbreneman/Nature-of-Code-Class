// Simple Particle System
// Daniel Shiffman <http://www.shiffman.net>

// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float t;
  float dt= 0.001;
  int noiseAmp=1;
  float n, xWind;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-1, 0));
    location = l.get();
    lifespan = 400.0;
  }

  void run() {
    update();
    display();
    t+=dt;
    n=noise(t)*noiseAmp;

    if (mouseX>location.x) {
      xWind=-n;
    }
    else {
      xWind=n;
    }

    if (mousePressed) {
      PVector wind = new PVector(xWind, n);
      applyForce(wind);
    }
  }

  // Method to update location
  void update() {
    velocity.limit(10);
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    acceleration.mult(0);
  }

  // Method to display
  void display() {
    stroke(0, lifespan);
    fill(0, lifespan);
    ellipse(location.x, location.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f);
  }
}

