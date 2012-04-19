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

    Pill(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 2);
    acceleration = new PVector(0, 0);
    //VariableForDebugging
    totalPoints =3;
    circleRadius = 10;
    breakPoint=20;
    particles = new ArrayList(); // Initialize the arraylist to hold "bubbles"
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
//        ellipse(xt, yt, circleRadius, circleRadius);
        
        // DEVELOP PARTICLES
        if (location.y == height-mass) {
          PVector particlepill= new PVector(xt, yt); // create a PVector point to xt,and yt location
          Particle p = new Particle(particlepill); // create a new particle object at the PVector location(based of xt, and yt)
          particles.add(p); //add that particle to the arraylist of particles
          for (int j=0;j<particles.size();j++) {
            println(particles.size());  
            p.render();
            //          ps.addParticle(p);
            //          ps.run();
          }
        }
      }
    }
    //Coverup Pill Form
        //    fill(255,0,0);
        //    ellipse(location.x, location.y, mass*2, mass*2);
  }



  //Keep the Pill in the window
  void checkEdges() {
    if (location.y > height-mass) {
      velocity.y *= -0.8;  // A little dampening when hitting the bottom
      location.y = height-mass;
      velocity.y = 0;
    }
  }
}

