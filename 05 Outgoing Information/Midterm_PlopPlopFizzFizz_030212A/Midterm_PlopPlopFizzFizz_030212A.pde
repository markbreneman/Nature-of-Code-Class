//Playing with the idea of cup
//Cup cup;

Liquid liquid; //Call new Liquid object
Pill pill; //Call new Pill object
ArrayList psystems; //Setup an Arraylist of particle systems OR an Array list which can contain many particle systems.

//Define Colors
color C1 = color(28, 29, 33);
color C2 = color(49, 53, 61);
color C3 = color(66, 88, 120);
color C4 = color(146, 205, 207);
color C5 = color(238, 239, 247);

void setup() {
  size (300, 600);
  smooth();
  //  cup = new Cup();
  //Initialize Objects
  liquid = new Liquid(0, height/2, width, height/2, 0.3);
  pill = new Pill(30, width/2, 10);
  //Initialize an ArrayList to keep track of the Particle systems
  psystems = new ArrayList();
}

void draw() {
  background(C2);
//  frameRate(15); //for Debug
  //  cup.display();
  liquid.display();//Draw the liquid
  pill.display();//Draw the liquid
  pill.update();//Update the Pill
  pill.checkEdges();//Check to see where the Pill Is
  
//Applying fluid forces
  if (liquid.contains(pill)) {
    PVector drag = liquid.drag(pill);
    pill.applyForce(drag);
  }
//Check to see if the System of Particle Systems still has Particles
  for (int i = psystems.size()-1; i >= 0; i--) {
    
    ParticleSystem psys = (ParticleSystem) psystems.get(i);//whats happening here? I mean get it contextually but not really in principal
    psys.run();
    if (psys.dead()) {
      psystems.remove(i);
    }
  }

  if (pill.location.y==height/2) { 
    //add a new particle system to the system of systems arraylist
    
    psystems.add(new ParticleSystem(int(random(10, 15)), new PVector(pill.location.x, pill.location.y)));
  }
//  println(pill.location.y);
//  println("half the height is="+ height/2);
}

void mousePressed() {
  pill = new Pill(30, width/2, 10);
}


