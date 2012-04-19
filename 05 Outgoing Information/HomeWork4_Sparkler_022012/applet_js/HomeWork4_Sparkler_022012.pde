//Comments
//My Intent here will be to use the idea of a particle system to demonstrate  
//the burnign of sparkler.  As the user clicks the mouse to ignite, the sparkler
//will burn and particles will fall off.

SparkSystem sparks; 
Repeller repeller;

void setup() {
  size(500, 600);
  smooth();
  frameRate(50);
  sparks = new SparkSystem(new PVector(width/2, 20));
  repeller = new Repeller(width/2, 18);
}

void draw() {
  background(32, 32, 32, .8);
  sparks.addSpark();
  PVector gravity = new PVector(0, 0.1);
  sparks.applyForce(gravity);
  sparks.applyRepeller(repeller);
  sparks.run();
  repeller.render();
}



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
//This class manages the sparks in an arraylist. The sparksystem then can be 
//managed in the main code

class SparkSystem {
  //SparkSystem Variables
  ArrayList<Spark> sparks; //Declar Arraylist of sparks
  PVector origin;//point at which sparks will be emitted

  //SparkSystem Constructor

  SparkSystem(PVector start) {//the PVector will determine location
    sparks = new ArrayList<Spark>(); //initialize the arraylists of sparks
    origin=start.get(); //Get the emitterpoint

  }
  
  void addSpark(){
    origin.y+=.125;
    sparks.add(new Spark(origin));
  }

  void applyForce(PVector f) {
    for (Spark s: sparks) {
      s.applyForce(f);
    }
  }
  
  void applyRepeller(Repeller r) {
    for (Spark s: sparks) {
      PVector repel = r.repel(s);        
      s.applyForce(repel);
    }
  }

  void run() {
    //Cycle through arraylist backwards..ASK Dan about this
    Iterator<Spark> it = sparks.iterator();
    while (it.hasNext ()) {
      Spark s= it.next();
      s.movement();
      if (s.isDead()) {
        it.remove();
      }
    }
  }

  // Is the Particle Still Active?
  boolean dead() {
    if (sparks.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}


