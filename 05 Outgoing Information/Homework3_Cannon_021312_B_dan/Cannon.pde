class Cannon {
  float ellipseRad;
  
  boolean launched = false;
  float cannonAngle;

  Cannon() {
  }
  void barrel() {
    pushMatrix();
    translate(width/2, 385);
  rotate(cannonAngle);
  
    smooth();
    stroke(0);
    //Create Section of Barrel
    strokeWeight(1);
    fill(69, 69, 69);
    translate( -28, -50 );
    beginShape();
    vertex( 28, 71 );
    bezierVertex( 62, 69, 59, 39, 52, 0);
    vertex( 45, 0 );
    bezierVertex( 55, 58, 44, 64, 28, 64);
    vertex( 29, 64 );
    bezierVertex( 13, 64, 2, 58, 12, 0);
    vertex( 5, 0 );
    bezierVertex( -2, 39, -5, 69, 29, 71);
    endShape();

    //Create Barrel Transparency
    strokeWeight(1);
    fill(255, 0, 0, .8);
    beginShape();
    vertex( 28, 71 );
    bezierVertex( 62, 69, 59, 39, 52, 0);
    vertex( 5, 0 );
    bezierVertex( -2, 39, -5, 69, 29, 71);
    endShape();
    popMatrix();
  }

  void mount() {
    fill(255, 255, 255);
    rectMode(CENTER);
    rect(width/2, height*2/3, 30, 30);
    noStroke();
    ellipse(width/2, height*2/3-15, 30, 30);
    stroke(0);
    ellipse(width/2, height*2/3-15, 10, 10);
    strokeWeight(3);
    line(width/2-100, height*2/3+15, width/2+100, height*2/3+15);
  }
}

