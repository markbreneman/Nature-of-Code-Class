class Firefly {
  float ellipseRad, topSpeed, growShrink;
  PVector location, velocity, acceleration, noff;
  int dir;

  Firefly(int tempGrowShrink) {
    ellipseRad=random(3, 10);
    growShrink=tempGrowShrink;
    topSpeed=1;
    location=new PVector(random(width), random(height));
    velocity=new PVector(0, 0);
    acceleration=new PVector(random(-0.01,0.01),random(-0.01,0.01));
    
  }

  void render() {
    ellipse(location.x, location.y, ellipseRad, ellipseRad);
    //FADE IN FADE OUT
    if (ellipseRad > 9) {
      growShrink = 0;
    } 
    else if (ellipseRad < 0) {
      growShrink = 1;
    }
    if (growShrink == 1) {
      ellipseRad += random(.2, .25);
    } 
    else if ( growShrink== 0) {
      ellipseRad -=random(.2, .25);
    }
    //    println(ellipseRad);
    //    println("growShrink value"+growShrink);
  }
  
   void applyForce(PVector f) {
    acceleration.add(f);
  }

  void movement() {

    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    velocity.limit(topSpeed);

  }

  void inwindow() {

    //    location.x = constrain(location.x, 0+ellipseRad, width-ellipseRad);
    //    location.y = constrain(location.y, 0+ellipseRad, height-ellipseRad);
    if (location.x > width) {
      velocity.x*=-1;
      location.x = width;
    } 
    else if (location.x < 0) {
      velocity.x*=-1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y*=-.55;
      location.y = height;
    } 
    else if (location.y < 0) {
      velocity.y*=-.55;
      location.y = 0;
    }
  }
}

