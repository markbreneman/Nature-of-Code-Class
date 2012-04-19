
// A rectangular box

class Paddle {

  // We need to keep track of a Body and a width and height
  Body paddle;
  float w;
  float h;

  // Constructor
  Paddle(float x_, float y_) {
    float x = x_;
    float y = y_;
    w =300;
    h =300;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(paddle);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Shape s = paddle.getShapeList();
    boolean inside = s.testPoint(paddle.getMemberXForm(), worldPoint);
    return inside;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(paddle);
    // Get its angle of rotation
    float a = paddle.getAngle();
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    //    rotate(a);
    //    fill(175);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(10, 10, w, h);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(center));
    paddle = box2d.createBody(bd);

    // Define the shape -- a polygon (this is what we use for a rectangle)
    PolygonDef sd = new PolygonDef();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);
    // Parameters that affect physics
    sd.density = 1.0f;
    sd.friction = 0.3f;
    sd.restitution = 0.5f;

    // Attach that shape to our body!
    paddle.createShape(sd);
    paddle.setMassFromShapes();

    // Give it some initial random velocity
    //    paddle.setLinearVelocity(new Vec2(random(-5,5),random(2,5)));
    //    paddle.setAngularVelocity(random(-5,5));
  }
}


