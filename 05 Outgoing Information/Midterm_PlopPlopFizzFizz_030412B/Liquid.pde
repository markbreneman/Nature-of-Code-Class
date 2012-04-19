class Liquid {

  float x;
  float y;
  float w;
  float h;
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  boolean contains(Pill p) {
    PVector l = p.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }

  PVector drag(Pill p) {
    float speed = p.velocity.mag();
    float dragMagnitude = -1 * c * speed * speed;

    PVector drag = p.velocity.get();
    drag.normalize();
    drag.mult(dragMagnitude);

    return drag;
  }

  void display() {
    noStroke();
    //noFill();
    fill(C3);
    rect(x, y, w, h);
  }
}

