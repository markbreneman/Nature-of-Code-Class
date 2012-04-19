class Ground {

  float x1;
  float y1;
  float x2;
  float y2;
  float c;

  Ground(float topX, float topY, float bottomX, float bottomY) {
    x1=topX;
    y1=topY;
    x2=bottomX;
    y2=bottomY;
    c=.1;
  }


  boolean contains(Cannonball cannonball) {
    PVector g = cannonball.location;
    if (g.x > x1 && g.x < x2 && g.y > y1 && g.y < y2) {
      return true;
    }  
    else {
      return false;
    }
  }

//  PVector drag(Cannonball cannonball) {
//  float speed = cannonball.velocity.mag();
//  float dragMagnitude = -1*c*speed*speed;
//  
//  PVector drag = cannonball.velocity.get();
//  drag.normalize();
//  drag.mult(dragMagnitude);
//  return drag;
//  }


  void display() {
    rectMode(CORNERS);
    noStroke();
    fill(82, 52, 19);
    rect(0, height*2/3+15, width, height*2/3+120);
    //    fill(82, 52, 19);
    //    rect(0, height*2/3+15, width, height*2/3+70);
  }
}

