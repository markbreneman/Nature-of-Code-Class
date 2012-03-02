Cup cup;
Liquid liquid;
Pill pill;
ArrayList<ParticleSystem> systems;

//Colors
color C1 = color(28, 29, 33);
color C2 = color(49, 53, 61);
color C3 = color(66, 88, 120);
color C4 = color(146, 205, 207);
color C5 = color(238, 239, 247);

void setup() {
  size (300, 600);
  smooth();
  reset();
//  cup = new Cup();
//  liquid = new Liquid(cup.cupLeft, cup.liquidHeight, cup.cupRight, cup.liquidHeight, 0.3);

  liquid = new Liquid(0, height/2, width, height/2, 0.3);
  pill = new Pill(30, width/2, 10);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(C2);
  liquid.display();
//  cup.display();
  pill.display();
  pill.update();
  pill.checkEdges();

  if (liquid.contains(pill)) {
    PVector drag = liquid.drag(pill);
    pill.applyForce(drag);
  }

  if (pill.location.y==height/2) {
    systems.add(new ParticleSystem(1, new PVector(pill.location.x, pill.location.y)));
  }
//   if (pill.location.y-30>=height/2) {
////    systems.remove(1);
//    systems.particles.lifespan=0;
//  }

  for (ParticleSystem ps: systems) {
    ps.run();
    ps.addParticle();
  }
} 

void mousePressed() {
  reset();
}


void reset() {
  pill = new Pill(30, width/2, 10);
}

