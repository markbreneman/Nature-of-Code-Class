//This class manages the repeller object:the display and behavior 

class Repeller {

  float G=5;
  PVector location;
  float r=10;

  Repeller(float x, float y) {
    location = new PVector(x, y);
  }

  void render() {
    stroke(0);
//    fill(127);
    location.y+=.13;
//    ellipse(location.x, location.y, r*2, r*2);
  }

  PVector repel(Spark s) {
    PVector dir = PVector.sub(location, s.location);
    float d=dir.mag();
    d=constrain(d, 20, 30);
    float force = -1 *G/pow(d, 2);
    dir.mult(force);
    return dir;
  }
}

