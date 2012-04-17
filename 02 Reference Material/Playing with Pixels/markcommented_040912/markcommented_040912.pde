float c;
//boolean fallen = false;
PImage img;
PImage img2;
int x, y;

Asquare[] onesquare;//an array of aSquare objects


void setup() {
  size(800, 800);
  smooth();
//  img = loadImage( "original.jpg");
  img2 = loadImage( "invert.jpg");
  
  onesquare = new Asquare[width*height];//create a new ASqaure Object that is the area

  //loadPixels(); 
  for (int y = height; y> 0; y = y-4) {
    for (int x = width; x> 0; x = x-4) {
      //int tempYY = y;
      float newY = map(y, 0, height, height, 0);
      int loc2 = x + int(newY)*width;
//      float r = red(img2.pixels[loc2]);
//      float g = green(img2.pixels[loc2]);
//      float b = blue(img2.pixels[loc2]);
      // first two arguments are x and y offsets of mouse position, 
      //and the last two arguments are the width and height
       onesquare[loc2] = new Asquare(x-4, y-4, 4, 4);  
    }
  }  
  //updatePixels();
}

void draw() {
  background(0,0,0);
  //background(img);
//  image(img,0,0);
//  counter();
  for (int y = height; y> 0; y = y-4) {
    for (int x = width; x> 0; x = x-4) {
      //int tempYY = y;
      float newY = map(y, 0, height, height, 0);
      int loc2 = x + int(newY)*width;
      float r = red(img2.pixels[loc2]);
      float g = green(img2.pixels[loc2]);
      float b = blue(img2.pixels[loc2]);
      
      if (onesquare[loc2].fall ==0) {
        fill (r, r, r);
      }else if (onesquare[loc2].fall >=2) {
//        fill (color(rr, random(255), bb, 100));//<==Turn on or off blinking!!
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
