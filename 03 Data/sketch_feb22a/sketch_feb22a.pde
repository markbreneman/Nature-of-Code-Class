import processing.opengl.*;
import javax.media.opengl.*;

Star s;
ArrayList<Photon> photons;
ArrayList<Hydrogen> fusion;
PGraphicsOpenGL pgl;
GL gl;

void setup(){
  size(1100, 700, OPENGL);
  PVector pLoc = new PVector(0,height/2);
  s = new Star(pLoc, 150);
  photons = new ArrayList<Photon>();
  fusion = new ArrayList<Hydrogen>();
  smooth();
  pgl = (PGraphicsOpenGL) g;
  gl = pgl.gl;
}

void draw(){
  pgl.beginGL();
  //gl.glDisable(GL.GL_DEPTH_TEST);
  gl.glEnable(GL.GL_BLEND);
  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE);
  background(0);
  s.run();
  pgl.endGL();
}

class Hydrogen {
  PImage i;
  PVector location, velocity;
  float lifespan;
  boolean dead;

  Hydrogen (PVector _location) {
    location = _location.get();
    velocity = new PVector(random(0, 60), random(-60, 60)); //change to make uniform velocity
    lifespan = 255.0;
    i = loadImage("texture.png");
  }

  void run() {
    update();
    display();
  }

  void update() {
    location.add(velocity);
    velocity.div(5);
    lifespan -= random(10.0, 20.0);
  }

  void display() {
    tint(lifespan);
    image(i, location.x -20, location.y-20);
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


class Photon {
  PImage i;
  PVector location, velocity;
  float amplitude, period, angle, lifespan;
  boolean dead;
  ArrayList<PVector> history;

  Photon(PVector _location) {
    location = _location.get();
    velocity = new PVector(random(0, 23), random(-40, 40)); //change to make uniform velocity
    amplitude = 10;
    period = 5;
    lifespan = 255.0;
    history = new ArrayList<PVector>();
    i = loadImage("miniTexture.png");
  }

  void run() {
    update();
    display();
    history.add(location.get());
    if (history.size() > 20) {
      history.remove(0);
    }
  }

  void update() {
    float y = amplitude * sin((frameCount/period)*TWO_PI); 
    PVector osc = new PVector(0, y);
    velocity.add(osc);
    location.add(velocity);
    lifespan -= 2.0;
  }

  void display() {
    rectMode(CENTER);
    //image(i, location.x - 16, location.y - 16);
    fill(255,255,0, 70);
    ellipse(location.x, location.y, 2, 2);
    beginShape();
    stroke(200, 200, 0, 30);
    noFill();
    for (PVector v: history) {
      vertex(v.x, v.y);
    }
    endShape();
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

class Star {
  PVector location;
  float mass;

  Star(PVector _location, float _mass) {
    location = _location;
    mass = _mass;
  }

  void run() {
    emit();
    display();
    fusion();
  }

  void display() {
    fill(225, 225, 0, 70);
    noStroke();
    ellipse(location.x, location.y, mass, mass);
  }

  void emit() {
   for(int i = 0; i < 8; i++){ 
    photons.add(new Photon(location));
   }
    
    Iterator<Photon> it = photons.iterator();
    while (it.hasNext ()) {
      Photon pho = it.next();
      pho.run();
      if (pho.isDead()) {
        it.remove();
      }
    }
  }

  void fusion() {
   for(int i = 0; i < 10; i++ ){
    fusion.add(new Hydrogen(location));
   }
   
    Iterator<Hydrogen> it = fusion.iterator();
    while (it.hasNext ()) {
      Hydrogen hydro = it.next();
      hydro.run();
      if (hydro.isDead()) {
        it.remove();
      }
    }
  }
}


