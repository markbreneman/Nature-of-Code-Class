Cup cup;
Liquid liquid;
Pill pill;
ArrayList psystems;

//Colors
color C1 = color(28, 29, 33);
color C2 = color(49, 53, 61);
color C3 = color(66, 88, 120);
color C4 = color(146, 205, 207);
color C5 = color(238, 239, 247);

void setup() {
  size (300, 600);
  smooth();
  //  cup = new Cup();
  //  liquid = new Liquid(cup.cupLeft, cup.liquidHeight, cup.cupRight, cup.liquidHeight, 0.3);

  liquid = new Liquid(0, height/2, width, height/2, 0.3);
  pill = new Pill(30, width/2, 10);
  psystems = new ArrayList();
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

  for (int i = psystems.size()-1; i >= 0; i--) {
    ParticleSystem psys = (ParticleSystem) psystems.get(i);
    psys.run();
    if (psys.dead()) {
      psystems.remove(i);
    }
  }

  if (pill.location.y==height/2) {
    psystems.add(new ParticleSystem(int(random(5, 10)), new PVector(pill.location.x, pill.location.y)));
  }
//  println(pill.location.y);
//  println("half the height is="+ height/2);
}

void mousePressed() {
  pill = new Pill(30, width/2, 10);
}


