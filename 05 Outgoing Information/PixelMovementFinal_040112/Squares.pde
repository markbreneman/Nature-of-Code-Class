class Squares {

  float x;
  float y;
  float h;
  float w;
  float gravity =0;
  float sway =0;
  float wind;
  float bounce =0;
  float bounceTemp;
  float r, g, gg, b;
  float c = color(r, g, b);
  int fall = 0;
  //boolean fallen = false;
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  


  Squares(float tempX, float tempY, float tempW, float tempH) {

    x = tempX;
    y = tempY;
    h = tempH;
    w = tempW;
    
    acc = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    loc = new PVector(x,y);
    r = 2.0;
    
    
  }


  //Pixel Gravity 
  void gravity() {
    gravity = gravity+(.2*1.5);
    sway = wind + sin(g/2 +10);
  }


  //  void click(int mx, int my) {
  //    if (mx > x-10 && mx < x+10 + w && my > y-10 && my < y+10 + h) {
  //      
  //        fall = 1;
  //      wind = random(-2, 2);
  //    }
  //  
  //  }


  //  void fallen() {
  //    if (y >=height-20 && fall >=1) {
  //      gravity =0;
  //      sway =0;
  //    }
  //  }


  void display() {
    y = y +gravity;
    x = x +sway;
    //fill(c);
    rect(x, y, h, w);
        if (y > height-20) {
          y = height-10;
    //      gravity = 0;
    //      sway = 0;
    //      fall = 2;
        }
  }
}

