
class Hydrogen {
  PImage i;
  PVector location, velocity;
  float lifespan;
  boolean dead;

  Hydrogen (PVector _location) {
    location = _location.get();
    velocity = new PVector(random(0, 60), random(-60, 60)); //change to make uniform velocity
    lifespan = 255.0;
    i = loadImage("texture.png");
  }

  void run() {
    update();
    display();
  }

  void update() {
    location.add(velocity);
    velocity.div(5);
    lifespan -= 18;
  }

  void display() {
    tint(lifespan * 2);
    image(i, location.x -20, location.y-20);
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

