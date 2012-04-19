class Asquare {

  float x;
  float y;
  float gravity =0;
  float sway =0;
  float h;
  float w;
  float wind;
  float bounce =0;
  float bounceTemp;
  float r, g, gg, b;
  float c = color(r, g, b);
  int fall = 0;
  //boolean fallen = false;





  Asquare(float tempX, float tempY, float tempW, float tempH) {

    x = tempX;
    y = tempY;
    h = tempH;
    w = tempW;
  }



  void gravity() {
    if (fall == 1) {
      gravity = gravity+(.2*0.5);
      sway = wind + sin(g/2 +10);
    }
  }

  void click(int mx, int my) {
    if (mx > x-10 && mx < x+10 + w && my > y-10 && my < y+10 + h) {
      
        fall = 1;
      wind = random(-2, 2);
    }
  
  }

  void fallen() {

    if (y >=height-20 && fall >=1) {
      gravity =0;
      sway =0;
    }
  }




  void display() {

    y = y +gravity;
    x = x +sway;
    //fill(c);
    rect(x, y, h, w);
    if (y > height-20 && fall >= 1) {
      y = height-10;
      gravity = 0;
      sway = 0;
      fall = 2;
    }
  }
}

