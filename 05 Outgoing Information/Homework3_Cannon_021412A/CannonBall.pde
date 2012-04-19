class Cannonball {
  float ellipseRad, theta, explodeForce, topSpeed, aVelocity, aAcceleration, angle, damping;
  PVector location, velocity, acceleration, gravity;

  Cannonball() {
    ellipseRad=15;
    explodeForce=10;
    //    topSpeed=5;
    //    damping=.9;
    location=new PVector(random(width/2-12, width/2+12), random(height*2/3-20, height*2/3-10));
    velocity=new PVector(0, 0);
    acceleration=new PVector(0, 0);
  }

  void display() {

    fill(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    ellipse(0, 0, ellipseRad, ellipseRad);
    //    line(0, 0, ellipseRad/2.25, ellipseRad/2.25);
    fill(255);
    noStroke();
    ellipse(3, -3, 5, 5);
    popMatrix();
  }

  void movement() {
    location.add(velocity);
    velocity.add(acceleration);
    //velocity.mult(damping);
    //velocity.limit(topSpeed);//So Cannonballs don't move faster than the framerate.Keeping them with normal movement
    aAcceleration = acceleration.y/4*random(-1, 1);
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -0.1, 0.1); 
    theta += aVelocity;
    acceleration.mult(0);// PREVENTING ACCUMULATION OF FORCES
  }

  void applyForce(PVector force) {
    PVector f = force.get();//What does this do? exactly I'm still lost on the Get command
    acceleration.add(f);
  }

  void explode() {
    PVector force = new PVector(cos(radians(c.cannonAngle)-PI/2), sin(radians(c.cannonAngle)-PI/2));

    force.x*=random(1, 2);
    force.y*=random(1, 2);
    force.mult(explodeForce);
    applyForce(force);
  }

  void updateLocation() {
    //    PVector force = new PVector(cos(radians(c.cannonAngle)-PI/2), sin(radians(c.cannonAngle)-PI/2));
    //    translate(200, 385);
    //    line(0, 0, force.x, force.y);
  }
}

