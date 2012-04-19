class Pill {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  //Dissolve Geometry Variables
  float radius;
  float circleRadius;  
  float totalPoints; 
  float breakPoint;
  

  Pill(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 2);
    acceleration = new PVector(0, 0);

    totalPoints =3;
    circleRadius = 10;
    breakPoint=20;
    

    
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    
    
   //Building the Dissolve Geometry
    radius+=circleRadius;
    for (int j = 0; j < 4; j++) {
      totalPoints+=totalPoints;
      for (int i = 0; i < totalPoints; i++) {
        // polar to cartesian coordinate transformation!
        float theta = map(i, 0, totalPoints, 0, TWO_PI);
        float xt = location.x + radius * sin(theta);
        float yt = location.y + radius * cos(theta);
        if (totalPoints>=breakPoint) {
          break;
        }
        ellipse(xt, yt, circleRadius, circleRadius);
      }
      break;
    }fill(C5);
    
    
    ellipse(location.x, location.y, mass, mass);

   
  }

  void checkEdges() {
    if (location.y > height) {
      velocity.y *= -0.01;  // A little dampening when hitting the bottom
      location.y = height;
    }
  }
  
//  boolean inWater(){
//    PVector inwater= location;
//    
}


