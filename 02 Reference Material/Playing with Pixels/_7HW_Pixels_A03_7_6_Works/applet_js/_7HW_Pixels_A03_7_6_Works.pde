float c;
//boolean fallen = false;
PImage img;
PImage img2;
int x, y;

Asquare[] onesquare;


void setup() {
  size(800, 800);
  smooth();
  img = loadImage( "P1220588-F.jpg");
  img2 = loadImage( "P1220588-2F.jpg");

  onesquare = new Asquare[width*height];

  //loadPixels(); 
  for (int y = height; y> 0; y = y-10) {
    for (int x = width; x> 0; x = x-10) {
      //int tempYY = y;
      float newY = map(y, 0, height, height, 0);
      int loc2 = x + int(newY)*width;
      float r = red(img2.pixels[loc2]);
      float g = green(img2.pixels[loc2]);
      float b = blue(img2.pixels[loc2]);
      onesquare[loc2] = new Asquare(x-10, y-10, 10, 10);
    }
  }
  //updatePixels();
}

void draw() {
  background(img);
  counter();
  for (int y = height; y> 0; y = y-10) {
    for (int x = width; x> 0; x = x-10) {
      //int tempYY = y;
      float newY = map(y, 0, height, height, 0);
      int loc2 = x + int(newY)*width;
      float r = red(img2.pixels[loc2]);
      float g = green(img2.pixels[loc2]);
      float b = blue(img2.pixels[loc2]);
      
      if (onesquare[loc2].fall ==0) {
        fill (r, r, r);
      }else if (onesquare[loc2].fall >=2) {
        fill (color(rr, random(255), bb, 100));//<==Turn on or off blinking!!
      }
      

      noStroke();

      onesquare[loc2].display();
      onesquare[loc2].gravity();
      onesquare[loc2].fallen();
      onesquare[loc2].click(mouseX, mouseY);//<====Click no mare, "roll over" instead.
    }
  }
}

//void mousePressed() {
// for (int y = height; y> 0; y = y-20) {
//    for (int x = width; x> 0; x = x-20) {
//      //int tempYY = y;
//       float newY = map(y, 0, height, height, 0);
//      int loc2 = x + int(newY)*width;
//      onesquare[loc2].click(mouseX, mouseY);//<====It is CLICK if left here.
//      
//      
//    }
//  }
//}

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
      gravity = gravity+(.2*1.5);
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

  float rr=0;
  float gg=0;
  float bb=0;
  float counter1 = 0;
  float counter2 = 0;
  float counter3 = 0;
  float counter1Temp =0;
  float counter2Temp =0;
  float counter3Temp =0;
  
  
  void counter() {
    if(counter1Temp >= 1.2) {
      counter1 += 1;
      counter1Temp = 0;
      rr=random(255);
      
    }
     if(counter2Temp >= 1) {
      counter2 += 1;
      counter2Temp = 0;
      gg=random(255);
    }
     if(counter3Temp >= 1) {
      counter3 += 1;
      counter3Temp = 0;
      bb=random(255);
    }
    
    counter1Temp = counter1Temp + .03;
    counter2Temp = counter2Temp + .05;
    counter3Temp = counter3Temp + .002;
    // println ("C1="+counter1+" C2="+counter2+" C3="+counter3+ "  G="+g);//<==For testing
  }

