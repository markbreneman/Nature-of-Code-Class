
PFont font;
Liquid liquid; //Call new Liquid object
ArrayList<Pill> pills; //Call new Pill object
ArrayList psystems; //Setup an Arraylist of particle systems OR an Array list which can contain many particle systems.
ArrayList fizz;


//Define Colors
color C1 = color(28, 29, 33);
color C2 = color(49, 53, 61);
color C3 = color(66, 88, 120);
color C4 = color(146, 205, 207);
color C5 = color(238, 239, 247);
float noisex=0;
float noisey=0;
float ampx=0; //amplification of noise valuex
float ampy=0; //amplification of noise valuey
float xfluidforce;
float yfluidforce;
boolean textflag;



void setup() {
  size (300, 600);
  smooth();
  //  cup = new Cup();
  //Initialize Objects
  liquid = new Liquid(0, height/3, width, height);
  pills = new ArrayList<Pill>();
  //  pill = new Pill(30, width/2, 10);
  //Initialize an ArrayList to keep track of the Particle systems
  psystems = new ArrayList();
  font = loadFont("FontdinerdotcomSparkly-48.vlw");
  textFont(font);
  textflag=false;
}

void draw() {
  background(C2);
  //  frameRate(15); //for Debug
  //  cup.display();
  liquid.display();//Draw the liquid
  for (Pill p: pills) {
    p.display();//Draw the liquid
    p.update();//Update the Pill
    p.checkEdges();//Check to see where the Pill Is

      //Applying fluid forces
    if (liquid.contains(p)) {
      PVector drag = liquid.drag(p);
      p.applyForce(drag);
      noisex+=0.01;
      noisey+=0.01;
      ampx=random(-5, 5);
      //    println("ampX=" + ampx);
      ampy=random(0, .05);
      xfluidforce = noise(noisex)*ampx;
      //    println("xfluidforce=" + xfluidforce);
      yfluidforce = noise(noisey)*ampy;
      PVector fluid= new PVector(xfluidforce, yfluidforce);
      //If the Pill is in the water and it is not at the bottom apply the oscillation force; if at the bottom apply an oscillation force of zero
      if (p.location.y >height/3 && p.location.y< height-p.mass*4) {
        //      fluid.x=fluid.x*pill.location.y/1000;  
        // I want the oscillation to be dependent partially on the location Y, should slow down as it falls
        p.applyForce(fluid);
      }    
      else if (p.location.y > height-p.mass*4) {
        fluid.mult(0);
        p.applyForce(fluid);
      }
    }
    println(p.location.y);
    if (int(p.location.y)+1==height/3) { 
    //add a new particle system to the system of systems arraylist
    psystems.add(new ParticleSystem(int(random(20, 35)), new PVector(p.location.x, p.location.y)));
    textflag=true;
  }
  }
  
   if(textflag==true){
     text("Plop", 10, 40);
     text("Plop", 80, 80);
   }
     
  
  //Check to see if the System of Particle Systems still has Particles
  for (int i = psystems.size()-1; i >= 0; i--) {

    ParticleSystem psys = (ParticleSystem) psystems.get(i);
    psys.run();
    if (psys.dead()) {
      psystems.remove(i);
      
    }
  }
  //println("height is" + height/3);
  //println("pill locationY" + int(pill.location.y));
}

void mousePressed() {
  pills.add(new Pill(30, mouseX, 10));
}

class Liquid {

  float x;
  float y;
  float w;
  float h;
  float c;

  Liquid(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = 0.12;
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

// A simple Particle class

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer;
  float mass = 2;
  float ellipserad = random(3,10);  

  Particle(PVector l) {
    acc = new PVector(0,0.05);
    vel = new PVector(random(-3,3),random(-3,3));
    loc = l.get();
    timer = 200.0;
  }


  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 3;
  }
  
 //Apply forces to the particle
    void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }

  // Method to display
  void render() {
    ellipseMode(CENTER);
    fill(C3,timer);
    strokeWeight(1);
    stroke(C4);
    ellipse(loc.x,loc.y,ellipserad,ellipserad);
  }
  
  // Is the particle still useful?
//  boolean dead() {
//  }
  boolean dead() {
    if (loc.y > height) {
      return true;
    }
    if (loc.y < height/2.75) {
      return true;
    }
    if (loc.x < mass) {
      return true;
    }
    if (loc.x > width-mass) {
      return true;
    }

    else{
      return false;
  }}
}
class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are birthed

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    //add particlesobjects to the array list
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));
    }
  }

  //This function goes over the arraylist of particles and and checks to see if they should be removed
  void run() {
    //Implementing THE ITERATOR!
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext ()) {
      Particle p = it.next();
      p.run();
//      if (p.dead()) {
//        it.remove();
//      }
    }
  }

  //  void addParticle() {
  //    particles.add(new Particle(origin));
  //  }

  void addParticle(Particle p) {
    particles.add(p);
  }


  //A function to apply a force to all Particles
    void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}

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
      if (location.y>= height*.7) {
     text("Fizz", 150,130);
     text("Fizz", 200, 170);}
  }

  //Draw the Pill Object
  void display() {
    noStroke();

    if (location.y>= height*.7 && made==false) {
      for (int radius = 0; radius < mass; radius += circleRadius) {
        totalPoints = int((TWO_PI*radius)/circleRadius);
        for (int i = 0; i < totalPoints; i++) {
          // polar to cartesian coordinate transformation!
          float theta = map(i, 0, totalPoints, 0, TWO_PI);
          xt = location.x + radius * sin(theta);
          yt = location.y + radius * cos(theta);
          strokeWeight(1);
          fill(255, 255, 255);       
//          ellipse(xt, yt, circleRadius, circleRadius);//This doesn't really mean anything its just a shape over the "body" of the object 
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
    if (location.y >= height*.65 && pillsize>0) {
        pillsize-=.15;
        
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
    if (location.y > height-pillsize) {
      velocity.y *= -0.8;  // A little dampening when hitting the bottom
      location.y = height-pillsize;
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


