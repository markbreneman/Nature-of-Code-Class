//This class manages the sparks object:the display and behavior 

class Spark {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float ellipseDia;
  float lifespan = 160;
  float mass = 100;
  ArrayList<PVector> trail = new ArrayList();
  boolean ignited=false;
  

  Spark(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1.5, 1.5), random(-3, .5));
    //    acceleration = new PVector(0,0);
    //    velocity = new PVector(0,0);
    location = l.get();
    ellipseDia=5;
  }

  void movement() {
    update();
    render();
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan-=2.0;
    trail.add(location.get());
    if (trail.size() > 10) {
      trail.remove(0);}
  }

  void render() {
   
    beginShape();
    strokeWeight(2);
    stroke(243,204,104,lifespan);
//    noFill();
    for (PVector v: trail) {
      vertex(v.x, v.y);
    }
    endShape();
    noStroke();
    fill(239,228,176, lifespan);
    ellipse(location.x, location.y, ellipseDia, ellipseDia);

  }


boolean isDead() {
  if (lifespan < 0.0) {
    return true;
  } 
  else {
    return false;
  }
}
}
