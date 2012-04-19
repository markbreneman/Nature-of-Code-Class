class Squares {

  float x;
  float y;
  float h;
  float w;

  PVector location;
  PVector originalLocation;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

    Boolean returning;

  Squares(float tempX, float tempY, float tempW, float tempH) {

    x = tempX;
    y = tempY;
    h = tempH;
    w = tempW;

    acceleration = new PVector(0, 0);
    //    velocity = new PVector(random(-.25, .25), random(-.25, .25));
    velocity = new PVector(random(-10, 10), random(-10, 10));
    location = new PVector(x, y);
    originalLocation = location.get();
    maxspeed = 3;
    maxforce = 0.05;
  }

  void display() {
    rect(location.x, location.y, h, w);
  }

  void update() {
    // if (returning) {
    // arrive(originalLocation);  

    //A vector pointing from current location to the original
    PVector desired=PVector.sub(originalLocation, location);
    //Determine the length of the desired vector
    float d=desired.mag();
    // Normalize desired and scale with arbitrary damping within 100 pixels
    desired.normalize();
    if (d < 75) desired.mult(maxspeed*(d/100));
    else desired.mult(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);


    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void goHome() {
    // returning = true; 
    location.x = originalLocation.x; 
    location.y = originalLocation.y;
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}

