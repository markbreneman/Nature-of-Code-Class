class Squares {

  float x;
  float y;
  float h;
  float w;

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

    Squares(float tempX, float tempY, float tempW, float tempH) {

    x = tempX;
    y = tempY;
    h = tempH;
    w = tempW;

    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-.25, .25), random(-.25, .25));
    location = new PVector(x, y);
    maxspeed = 3;
    maxforce = 0.05;
  }

  void display() {
    rect(location.x, location.y, h, w);
  }

  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }


  // Wraparound
//  void borders() {
//    if (location.x < -r) location.x = width+r;
//    if (location.y < -r) location.y = height+r;
//    if (location.x > width+r) location.x = -r;
//    if (location.y > height+r) location.y = -r;
//  }
}

