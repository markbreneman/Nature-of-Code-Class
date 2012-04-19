//Pin Object
Pin pin;
//Paper Object
Paper[] papers = new Paper [100];

void setup(){
  size (500,700);
  smooth();
  
  pin = new Pin(width/2, height-100,500);
  
  float y =0;
  
  for (int i = 0; i < papers.length; i++){
    papers[i] = new Paper(new PVector(random(width/2-40, width/2),y),floor(random(40,100)),random(100,200));
    y -= random(25, 100);  
  }
}

void draw(){
  
  background(125);
  
  pin.display();
  
  for (int i=0; i<papers.length; i++){
     if(pin.contains(papers[i])){
      PVector friction = pin.friction(papers[i]);
      papers[i].applyForce(friction);
    }
    papers[i].calculate();
    
    PVector air = new PVector(0, -0.8);
    PVector gravity = new PVector(0,1);
    papers[i].applyForce(gravity);
    papers[i].applyForce(air);
  
    papers[i].update();
    papers[i].display();
  }
  
  fill(255);
  textSize(10);
  text("*images being threaded at the location of the seeked pixel array", 10, height-10);
}
class Paper{
  
  int xspacing =1;  //how far apart should each point be
  int w;             //width of entire wave
  
  PVector origin;    //where does the wave's first point start?
  float theta = 0.0; //start angle at 0;
  float amplitude;  //height of wave
  float period;     //how many pixels before the wave repeats?
  float dx;           //value for incrementing X, to be calculated as a function of period and xspacing
  float[]yvalues;    // Using an array to store height values for the wave (not entirely necessary)

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  //Construction
  Paper(PVector o, int w_, float p) {
    origin = o.get();
    w = w_;
    period = p;
    amplitude = w/20;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
    velocity = new PVector();
    acceleration = new PVector();
  }
    void applyForce(PVector force) {
    PVector f = force.get();
    f.div(w);
    acceleration.add(f);
  }
  
  void calculate(){
    //increment theta (try different values for angular velocity here
    theta +=0.02;
    //for every x value, calculate a y value with sine function
    float x = theta;
    for (int i=0; i < yvalues.length;i++){
      yvalues[i] = sin(x)*amplitude;
      x+=dx;
    }
  }
  void update() {
    velocity.add(acceleration);
    origin.add(velocity);
    acceleration.mult(0);
  }
   void display() {
    // A simple way to draw the wave with an ellipse at each location
    for (int x = 0; x < yvalues.length; x++) {
      stroke(255,175);
      point(origin.x+x*xspacing,origin.y+yvalues[x]);
    }
    if (origin.y > height-200) {
      origin.y = height-200;
    }
  }
}
class Pin {

  //bottom anchor
  PVector anchor;

  float len;
  float c = 5;
  float x;
  float y;

  //Constructor
  Pin(float x_, float y_, float l) {
    anchor = new PVector(x_, y_);
    len = l;
    x = x_;
    y = y_;
  }
  
//friction once paper reaches pin
  boolean contains(Paper p) {
    PVector pl = p.origin;
    if ( pl.y > height-len) {
      return true;
    }
    else {
      return false;
    }
  }
  PVector friction(Paper p) {
    float speed = p.velocity.mag();
    float frictionMagnitude = -1 * c * speed * speed;

    PVector friction = p.velocity.get();
    friction.normalize();
    friction.mult(frictionMagnitude);

    return friction;
  }

  void display() {
    stroke(255);
    //pin
    line(anchor.x, anchor.y, anchor.x, height-len);

    //base
    noStroke();
    fill(200);
    rectMode(CENTER);
    rect(anchor.x, anchor.y, len/70, len/100);
  }
}


