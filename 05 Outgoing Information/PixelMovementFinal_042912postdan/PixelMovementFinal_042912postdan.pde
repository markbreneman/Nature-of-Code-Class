PImage img;
int x, y, loc, pixelblocksize, timeramt;
//float r, g, b, br;
Timer timer;

Flock flock;

void setup() {
  size(800, 800);
  smooth();
  pixelblocksize=7;
  
  timeramt=2000;
  timer = new Timer(timeramt);// 

  //Loads the image into memory but doesn't display it.
  img=loadImage("original.png");

  //Create a new flock object(an arraylist of squares)
  flock= new Flock();

  for (y=0;  y<height; y = y+pixelblocksize) {
    for (x=0; x<width; x = x+pixelblocksize) {
      int loc = x + y*width; //find the one dimensional location in the array
      float br = brightness(img.pixels[loc]);
      //create a new square object of the passed in arguement sizes at the position of the loc
      // first two arguments are the x and y location 
      // and the last two arguments are the width and height, final argument is brightness
      Squares s = new Squares(x, y, pixelblocksize, pixelblocksize, br);
      flock.addSquare(s);
    }
  }
  timer.start();
}

void draw() {  
  //image(img,0,0);//displays the image
  //  background(255, 255, 255, .08);  
  background(0, 0, 0, .08);  
    
  flock.start();
  if (timer.isFinished()) {
    flock.run();
  }
  println(frameRate);
  
  saveFrame("render/render####.png");
}

//Temporarily on mousePressed calc. seeking force and apply as a steering behavior
void mousePressed() {
//    for (y=0;  y<height; y = y+pixelblocksize) {
//        for (x=0; x<width; x = x+pixelblocksize) {
//          int loc = x + y*width; //find the one dimensional location in the array
//          
//        }
//      }
flock.reset();
}


void keyPressed() {
  //  save(millis()+".png");
}

