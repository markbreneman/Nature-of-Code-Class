class Firefly {
  float ellipseRad, topSpeed, growShrink,theta;
  PVector location, velocity, acceleration, noff;
  int dir;

  Firefly(int tempGrowShrink) {
    ellipseRad=random(3,10);
    growShrink=tempGrowShrink;
    topSpeed=1;
    location=new PVector(random(width), random(height));
    velocity=new PVector(0, 0);
    //    noff= new PVector(random(1), random(1));
  }

  void render() {
    theta+=0.05;
    ellipse(location.x, location.y, ellipseRad, ellipseRad);
    //FADE IN FADE OUT
    if (ellipseRad > 9) {
      growShrink = 0;
    } 
    else if (ellipseRad < 0) {
      growShrink = 1;
    }
    if (growShrink == 1) {
      ellipseRad += random(.2,.25);
//ellipseRad=((sin(theta)+1)*4.5);
    } 
    else if ( growShrink== 0) {
//      ellipseRad=((cos(-theta)+1)*4.5);
      ellipseRad -=random(.2,.25);
    }
    //    println(ellipseRad);
    //    println("growShrink value"+growShrink);
    
    
  }

  void movement() {
    acceleration=new PVector(random(-5, 5), random(-5, 5));
    //    acceleration.x = map(noise(noff.x), 0, 1, -1, 1);
    //    acceleration.y = map(noise(noff.y), 0, 1, -1, 1);
    //    acceleration.mult(0.1);
    //
    //    noff.add(0.01, 0.01, 0);

    velocity.limit(topSpeed);
    acceleration.normalize();
    acceleration.mult(.25);
    velocity.add(acceleration);
    location.add(velocity);

    //    if (dir== 1) {
    //      velocity.add(acceleration);
    //      location.add(velocity);
    //    }
    //    else if (dir==-1) {
    //      velocity.sub(acceleration);
    //      location.sub(velocity);
    //    }
  }

  void inwindow() {
    
    location.x = constrain(location.x, 0+ellipseRad, width-ellipseRad);
    location.y = constrain(location.y, 0+ellipseRad, height-ellipseRad);
    
    //Trying Various other Methods of Trying to Have them reach a wall and reverse rather than just hover
    //    if (location.x<0+ellipseRad) {
    //    dir=-1;
    //    }
    //    else if (location.x>width-ellipseRad) {
    //    dir=1;
    //    }
    //    if (location.y<0+ellipseRad) {
    //    dir=-1;
    //    }
    //    else if (location.y>height-ellipseRad) {
    //    dir=1;
    //    }
    //    println("location:x"+location.x);
    //    println("location:y"+location.y);
    //    println("dir"+dir);
    //    
    //  if (location.x > width) {
    //      acceleration.x *= -1;
    //    } 
    //    else if (location.x < 0) {
    //      acceleration.x *= -1;
    //    }
    //
    //    if (location.y > height) {
    //      acceleration.y *= -1;
    //    } 
    //    else if (location.y < 0) {
    //     acceleration.y *= -1;
    //    }
    
    
  }
}


