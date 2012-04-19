import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;


import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;



PBox2D box2d;

int currentBox = 0;

Box box;
Box box2;

ArrayList<Particle> particles;
ArrayList<Boundary> boundaries;

Spring spring;
Spring spring2;

float xoff = 0;
float yoff = 0;

Minim minim;
AudioSnippet bubble; 

void setup() {
  size(800, 600);
  smooth();

  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  box = new Box(width/2, height/2);
  box2 = new Box(width/2, height/2); 

  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width, height/2, 20, 600));   //right
  boundaries.add(new Boundary(width-800, height/2, 20, 600));    //left

  spring = new Spring();
  spring.bind(width/2, height/2, box);
  spring2 = new Spring();
  spring2.bind(width/2, height/2 + 100, box2);
  // Create the empty list
  particles = new ArrayList<Particle>();
  
   minim = new Minim(this);
     bubble = minim.loadSnippet("bubble.mp3");
}

void draw() {
  fill(255, 80);
  rect(0, 0, width*2, height*2);

  if (random(1) < 0.2) {  
    float sz = random(4, 8);
    //float sz = 4;
    particles.add(new Particle(width/2, -20, sz));
  }

  box2d.step();

  Vec2 mouseWorld = box2d.coordPixelsToWorld(mouseX, mouseY); 
  println("x = " + mouseWorld.x + " y = " + mouseWorld.y);
  println("x = " + mouseX + " y = " + mouseY);
  boolean overBox = box.mouseOver(mouseX, mouseY);
  if (overBox) {
    println("i'm over");
  } 
  else {
    println("not over");
  }

  float x = noise(xoff)*width;
  float y = noise(yoff)*height;
  xoff += 0.01;
  yoff += 0.01;

  if (mousePressed) {

    if (currentBox == 0) {
      spring.update(mouseX, mouseY);
      spring.display();
    } 
    else {
      spring2.update(mouseX - 100, mouseY);
      spring2.display();
    }
  } 

  box.body.setAngularVelocity(0);
  box2.body.setAngularVelocity(0);

  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();

    if (p.done()) {
      particles.remove(i);
    }
  }

 
  box.display();
  box2.display();
  
  for (Boundary wall: boundaries) {
    wall.display();
  }
}

void beginContact(Contact cp) {

  println("beginContact");
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();


  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) {
    Particle p1 = (Particle) o1;
    p1.change();
    Particle p2 = (Particle) o2;
    p2.change();
  }
}

   void stop()
{
  // always close Minim audio classes when you are done with them
  kick.close();
  minim.stop();
  
  super.stop();
}
void endContact(Contact cp) {
  println("endContact");
}


void keyPressed() {
  currentBox++;
  if (currentBox > 1) {
    currentBox = 0;
  }

  println("currentBox: " + currentBox);
}

/*

void keyPressed(){
  
if ( key == 'k' ) bubble.isPlaying(); 
  
} 
*/












