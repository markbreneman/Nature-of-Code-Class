class Pill {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float bottomofpill;

  //Dissolve Geometry Variables
  float radius; //radius of the circle defining the particle layout
  float circleRadius;  
  float totalPoints; 
  float xt;//x as a function of theta
  float yt;//y as a function of theta
  ArrayList<Particle> particles;    // An arraylist for all the Bubble particles
  boolean made;
  float pillsize;

  Pill(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 3);
    acceleration = new PVector(0, 0);
    //BubbleParticleVariables
    totalPoints =3;
    circleRadius = 10; // radius of the circle
    particles = new ArrayList(); // Initialize the arraylist to hold "bubbles"
    boolean made=false;
    pillsize =50;
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
    fill(255, 255, 255);
    ellipse(location.x, location.y, pillsize, pillsize);
  }

  //Draw the Pill Object
  void display() {
    noStroke();

    if (location.y>= height*.4 && made==false) {
      for (int radius = 0; radius < mass; radius += circleRadius) {
        totalPoints = int((TWO_PI*radius)/circleRadius);
        for (int i = 0; i < totalPoints; i++) {
          // polar to cartesian coordinate transformation!
          float theta = map(i, 0, totalPoints, 0, TWO_PI);
          xt = location.x + radius * sin(theta);
          yt = location.y + radius * cos(theta);
          strokeWeight(1);
          fill(255, 255, 255);       
          ellipse(xt, yt, circleRadius, circleRadius);//This doesn't really mean anything its just a shape over the "body" of the object 
          // DEVELOP PARTICLES
          PVector particlepill= new PVector(xt, yt); // create a PVector point to xt,and yt location
          Particle pp = new Particle(particlepill); // create a new particle object at the PVector location(based of xt, and yt)
          particles.add(pp); //add that particle to the arraylist of particles
          //made=true;
        }
      }
    }
    println(particles.size());
    if (!particles.isEmpty()) {
      Particle first = particles.get(0);
      //println(first.timer);
    }
    for (Particle p: particles) {
      p.run();
      PVector dissolve = new PVector ( random(-.05,.05),-.09);
      p.applyForce(dissolve);
    }
    if (location.y >= height*.85 && pillsize>0) {
        pillsize-=.25;
        
      }

    for (int i = particles.size()-1; i >=0; i--) {
      Particle p = particles.get(i);
      if (p.dead()) {
        particles.remove(i);
      }
    if(pillsize<=0){
      made=true;}
    }
  }

  //Keep the Pill in the window
  void checkEdges() {
    if (location.y > height-mass) {
      velocity.y *= -0.8;  // A little dampening when hitting the bottom
      location.y = height-mass;
      velocity.x = 0;
      velocity.y = 0;
    }
    if (location.x < mass) {
      location.x =mass;
      velocity.x *=-0.01;
    }
    if (location.x > width-mass) {
      location.x = width-mass;
      velocity.x *=-0.8;
    }
  }
}

