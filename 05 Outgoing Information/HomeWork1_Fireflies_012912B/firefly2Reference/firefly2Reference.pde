//Firefly class
//Emily Webster
//Nature of code :: Spring 11'

class Firefly {
  PVector location;
  int dir=1;

  Firefly() {
    location = new PVector(width/2, height/2);
  }
  //color c =color( 0,255);
  float c = 0; 

  void render() {
    stroke(0);    
    fill(random(c-10,c));
    ellipseMode(CENTER);
    ellipse(location.x, location.y, 10,10);

    c++;
  }

  void buzz() {

    PVector fly = new PVector(random(-5*dir,15*dir),random(-7,7));

    fly.normalize();
    fly.mult(0.5);

    /////like saying new PVector called fly that has a varying x location and y locaiton

    if (dir == 1) {
      location.add(fly);
    }
    else if(dir==-1) {
      location.sub(fly);
    }
  }



  void checkEdges() {

    if (location.x > width-15) {
      dir= -1;
    } 
    else if (location.x < 15) {
      dir =1;
    }
  }


  float xoff = 0.0;
  void draw() 
  {

    xoff = xoff +5;
    float n = noise(xoff) * width;
    line(n, 0, n, height);
  }
}

