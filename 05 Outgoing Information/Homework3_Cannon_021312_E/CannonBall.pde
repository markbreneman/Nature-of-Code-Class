class Cannonball {
  float ellipseRad, theta, explodeForce, topSpeed, aVelocity, aAcceleration, angle, damping;
  PVector location, velocity, acceleration, gravity;

  Cannonball() {
    ellipseRad=15;
    explodeForce=10;
    topSpeed=5;
    //    damping=.9;
    location=new PVector();
    velocity=new PVector(0, 0);
    acceleration=new PVector(0, 0);
  }

  void display() {
    fill(255, 0, 0);
    pushMatrix();
    translate(width/2, 385);
    rotate(theta);
    ellipse(location.x, location.y, ellipseRad, ellipseRad);
    line(location.x, location.y,location.x+ellipseRad/2,location.y+ellipseRad/2);
    popMatrix();
  }

  void movement() {
    location.add(velocity);
    velocity.add(acceleration);
    //    velocity.mult(damping);
    //velocity.limit(topSpeed);//So Cannonballs don't move faster than the framerate.Keeping them with normal movement
    aAcceleration = acceleration.x / 10.0;
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -0.1, 0.1); 
    theta += aVelocity;
    acceleration.mult(0);// Preventing accumulation of forces
    
  }

  void applyForce(PVector force) {
    PVector f = force.get();//What does this do? exactly I'm still lost on the Get command
    acceleration.add(f);
  }

  void explode() {
    PVector force = new PVector(cos(radians(c.cannonAngle)-PI/2), sin(radians(c.cannonAngle)-PI/2));
    force.mult(explodeForce);
    applyForce(force);
  }

//  void updateLocation() {
//    pushMatrix();
//    translate(200,385);
////    ellipse(0,0,300,3);
//    PVector ballRadius= new PVector(0,0);
////    ballRadius.sub(location);
//    line(ballRadius.x,ballRadius.y,location.x,location.y);
////    ellipse(ballRadius.x,ballRadius.y,10,10);
//    
////    fill(255,0,0);
////    ellipse(0,0,30,30);
//    popMatrix();
////    location.x=cos(radians(c.cannonAngle)-PI/2);
////    location.y=sin(radians(c.cannonAngle)-PI/2);
//  }
}

