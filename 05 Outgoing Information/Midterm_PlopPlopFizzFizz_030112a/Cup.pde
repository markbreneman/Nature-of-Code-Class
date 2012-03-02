class Cup {

  float topCup;
  float bottomCup;
  float liquidHeight; 
  float cupLeft;
  float cupRight;

  Cup() {
    topCup=50;
    bottomCup=height-20;
    liquidHeight=height/2;
    cupLeft=width/30;
    cupRight=width*29/30;
    
  }
  void display() {
    stroke(0);
    strokeWeight(2);
    line(cupLeft, topCup, cupLeft+20, bottomCup);
    line(cupRight, topCup, cupRight-20, bottomCup);
    noFill();
    ellipseMode(CENTER);
    ellipse(width/2,topCup,284,20);
    ellipse(width/2,bottomCup,240,20);
  }
}
