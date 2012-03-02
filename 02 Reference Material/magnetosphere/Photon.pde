
class Photon {
  PImage i;
  PVector location, velocity;
  float amplitude, period, angle, lifespan;
  boolean dead;
  ArrayList<PVector> history;

  Photon(PVector _location) {
    location = _location.get();
    velocity = new PVector(random(0, 23), random(-40, 40)); //change to make uniform velocity
    amplitude = 10;
    period = 5;
    lifespan = 255.0;
    history = new ArrayList<PVector>();
    i = loadImage("miniTexture.png");
  }

  void run() {
    update();
    display();
    history.add(location.get());
    if (history.size() > 20) {
      history.remove(0);
    }
  }

  void update() {
    float y = amplitude * sin((frameCount/period)*TWO_PI); 
    PVector osc = new PVector(0, y);
    velocity.add(osc);
    location.add(velocity);
    lifespan -= 2.0;
  }

  void display() {
    rectMode(CENTER);
    //image(i, location.x - 16, location.y - 16);
    fill(255,255,0, 70);
    ellipse(location.x, location.y, 1, 1);
    beginShape();
    stroke(200, 200, 0, 30);
    noFill();
    for (PVector v: history) {
      vertex(v.x, v.y);
    }
    endShape();
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}

