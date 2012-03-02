import processing.opengl.*;
import javax.media.opengl.*;

Star s;
ArrayList<Photon> photons;
ArrayList<Hydrogen> fusion;
PGraphicsOpenGL pgl;
GL gl;

void setup(){
  size(1100, 700, OPENGL);
  PVector pLoc = new PVector(0, height/2);
  s = new Star(pLoc, 150);
  photons = new ArrayList<Photon>();
  fusion = new ArrayList<Hydrogen>();
  smooth();
  pgl = (PGraphicsOpenGL) g;
  gl = pgl.gl;
}

void draw(){
  pgl.beginGL();
  gl.glEnable(GL.GL_BLEND);
  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE);
  background(0);
  s.run();
  pgl.endGL();
}
