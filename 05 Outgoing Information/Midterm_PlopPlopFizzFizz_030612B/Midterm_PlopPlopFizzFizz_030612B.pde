
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

