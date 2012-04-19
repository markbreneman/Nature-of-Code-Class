class Gnat {
  int x,y,ellipseRad;
  
  Gnat(){
    x=width/2;
    y=height/2;
    ellipseRad=20;
  }
  
  void display(){
    smooth();
    stroke(0);
//    fill(255,10);
//    rect(0,0,width,height);
    
    //Body
    ellipseMode(CENTER);
    fill(37,37,37);    
    ellipse(x,y,ellipseRad,ellipseRad/2.25);
    //WingBottom
    pushMatrix();
    translate(x+ellipseRad/3,y+ellipseRad/2.85);
    rotate(radians(30));
    noFill();
    ellipse(0,0,ellipseRad/1.25,ellipseRad/3);
    popMatrix();
    //WingTop
    pushMatrix();
    translate(x-ellipseRad/3,y-ellipseRad/2.85);
    rotate(radians(30));
    noFill();
    ellipse(0,0,ellipseRad/1.25,ellipseRad/3);
    popMatrix();
    
  }
  
  void fly(){
    int vx =int(random(-20,20));
    int vy =int(random(-20,20));
    x += vx;
    y += vy;
    x=constrain(x,0,width-5);
    y=constrain(y,0,height-5);
    }
}
    
