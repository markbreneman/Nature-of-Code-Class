Firefly firefly;

void setup() {
  size(600, 400);
  background(32, 32, 32);
  smooth();
  frameRate(30);
  firefly= new Firefly();
}

void draw() {
  background(32, 32, 32, 10);
  firefly.movement();
  firefly.render();
  firefly.inwindow();
}

class Firefly {
  float ellipseRad, topSpeed,growShrink;
  PVector location, velocity, acceleration;
  int dir;
  

  Firefly() {
    ellipseRad=10;
    growShrink=-1;
    topSpeed=5;
    location=new PVector(random(width), random(height));
    velocity=new PVector(0, 0);
 
  }
  void movement() {
    dir=1;
    velocity.limit(topSpeed);
    acceleration=new PVector(random(-.5*dir, .5*dir),random(-.5*dir, .5*dir));
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
  
  void render() {
    ellipse(location.x, location.y, ellipseRad, ellipseRad);
//FADE IN FADE OUT 
//    if (ellipseRad > 9) {
//        growShrink = 0;
//    } else if (ellipseRad < 1) {
//        growShrink = 1;
//        }
//    if (growShrink == 1) {
//        ellipseRad += .125;
//    } else if ( growShrink== 0) {
//        ellipseRad -= .125;  
//    }
////    println(ellipseRad);
////    println("growShrink value"+growShrink);
}
  void inwindow() {
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
//    location.x = constrain(location.x, 0+ellipseRad, width-ellipseRad);
//    location.y = constrain(location.y, 0+ellipseRad, height-ellipseRad);

  if (location.x > width) {
      acceleration.x *= -1;
    } 
    else if (location.x < 0) {
      acceleration.x *= -1;
    }

    if (location.y > height) {
      acceleration.y *= -1;
    } 
    else if (location.y < 0) {
     acceleration.y *= -1;
    }
  }
}

