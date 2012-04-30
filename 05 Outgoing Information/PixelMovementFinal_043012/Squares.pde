class Squares {

  int x;
  int y;
  int h;
  int w;
  
  
  PVector location;
  PVector originalLocation;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float br;//brighntess

  Boolean returning;
  
  Squares(int tempX, int tempY, int tempW, int tempH) {

    x = tempX;
    y = tempY;
    h = tempH;
    w = tempW;
    
    returning=false;

    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-10, 10), random(-10, 10));
    location = new PVector(x, y);
    originalLocation = location.get();
    maxspeed = 4;
    maxforce = 0.1;
    
  }

  void display() { 
      loc = x+ y*width;
      br = brightness(img.pixels[loc]);
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      float a = alpha(img.pixels[loc]);
      fill(r,g,b,a);
      noStroke();
      rect(location.x, location.y, h, w);
  }
  
  void run(ArrayList<Squares> squares){
    flock(squares);
    update();
//    borders();
    display();
  }
  

  void update() {
     
      if (returning) {
      // arrive(originalLocation);  
      //A vector pointing from current location to the original
      PVector desired=PVector.sub(originalLocation, location);
      //Determine the length of the desired vector
      float d=desired.mag();
      // Normalize desired and scale with arbitrary damping within 100 pixels
      desired.normalize();
      if (d < 100) desired.mult(maxspeed*(d/100));
      else desired.mult(maxspeed);

      // Steering = Desired minus Velocity
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);  // Limit to maximum steering force
      applyForce(steer);
    }
    
      // Update velocity
      velocity.add(acceleration);
      // Limit speed
      velocity.limit(maxspeed);
      location.add(velocity);
      // Reset accelertion to 0 each cycle
      acceleration.mult(0);
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
  
   // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Squares> squares) {
    PVector sep = separate(squares);   // Separation
    PVector ali = align(squares);      // Alignment
    PVector coh = cohesion(squares);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.0);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }
  
  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Squares> squares) {
    float desiredseparation =30;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Squares other : squares) {
      float d = PVector.dist(location,other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location,other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Squares> squares) {
    float neighbordist = 50;
    float brthreshold=30;
    PVector sum = new PVector(0,0);
    int count = 0;

    for (Squares other : squares) {
      float d = PVector.dist(location,other.location);
      float brdiff=abs(br-other.br);
      if ((d > 0) && (d < neighbordist) && (brdiff<brthreshold)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0,0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Squares> squares) {
    float neighbordist = 50;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Squares other : squares) {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } else {
      return new PVector(0,0);
    }
  }
  
    // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }
  
  void startingposition(){
  returning =! returning;
  velocity = new PVector(random(-10, 10), random(-10, 10)); 
  }
}

