class Cannonball {
  float ellipseRad, theta, explodeForce, topSpeed, aVelocity, aAcceleration, angle;
  PVector location, velocity, acceleration;

  Cannonball() {
    ellipseRad=15;
    explodeForce=2;
    topSpeed=5;
    location=new PVector(random(width/2-12, width/2+12), random(height*2/3-70, height*2/3-15));
    velocity=new PVector(0, 0);
    acceleration=new PVector(0, 0);
  }

  void display() {
    fill(255, 0, 0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    ellipse(location.x, location.y, ellipseRad, ellipseRad);
    line(location.x, location.y, location.x+ellipseRad/2.25, location.y+ellipseRad/2.25);
    popMatrix();
  }

  void movement() {
    location.add(velocity);
    velocity.add(acceleration);
    velocity.limit(topSpeed);//So Cannonballs don't move faster than the framerate.Keeping them with normal movement
    aAcceleration = acceleration.x / 10.0;
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -0.1, 0.1); 
    angle += aVelocity;
    acceleration.mult(0);// Preventing accumulation of forces
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.sub(f);
  }

  void explode() {
    PVector force = new PVector(0, explodeForce);
    force.mult(0.1);
    applyForce(force);
  }
}

