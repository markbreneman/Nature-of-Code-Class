class Pill {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float bottomofpill;
  
  //Dissolve Geometry Variables
  float radius;
  float circleRadius;  
  float totalPoints; 
  float breakPoint;
  ArrayList particles;    // An arraylist for all the Bubble particles

  ParticleSystem ps;


  Pill(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 2);
    acceleration = new PVector(0, 0);
    //VariableForDebugging
    totalPoints =3;
    circleRadius = 10;
    breakPoint=20;
  }
  //Apply forces to the pill
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  //Progress Movement of the Pill Object
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  //Draw the Pill Object
  void display() {
    noStroke();

    // DEBUGGING WHERE THE PARTICLES ARE
    for (int radius = 0; radius < mass; radius += circleRadius) {
      totalPoints = int((TWO_PI*radius)/circleRadius);
      for (int i = 0; i < totalPoints; i++) {
        // polar to cartesian coordinate transformation!
        float theta = map(i, 0, totalPoints, 0, TWO_PI);
        float xt = location.x + radius * sin(theta);
        float yt = location.y + radius * cos(theta);
        strokeWeight(1);
        fill(255, 255, 255);       
        ellipse(xt, yt, circleRadius, circleRadius);


        ////Develop Particles
        ////      if (location.y > 500) {
        //        PVector particlepill= new PVector(xt,yt);
        //        Particle p = new Particle(particlepill);
        //        particles.add(p); 
        //        ps.addParticle(p);
        ////      }
      }
    }
    //Coverup Pill Form
    //    fill(255,0,0);
    //    ellipse(location.x, location.y, mass*2, mass*2);
  }
//Keep the Pill in the window
  void checkEdges() {
    if (location.y > height-mass/2) {
      velocity.y *= -0.01;  // A little dampening when hitting the bottom
      location.y = height-mass/2;
    }
  }
}

