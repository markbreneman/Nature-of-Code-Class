PImage img;
int x, y, loc, pixelblocksize, timeramt;
float r, g, b;
Timer timer;

Flock flock;

void setup() {
  size(800, 800);
  smooth();
  pixelblocksize=10;

  timeramt=2000;
  timer = new Timer(timeramt);// 

  //Loads the image into memory but doesn't display it.
  img=loadImage("original.png");

  //Create a new flock object(an arraylist of squares)
  flock= new Flock();

  for (y=0;  y<height; y = y+pixelblocksize) {
    for (x=0; x<width; x = x+pixelblocksize) {

      //create a new square object of the passed in arguement sizes at the position of the loc
      // first two arguments are the x and y location 
      // and the last two arguments are the width and height

      Squares s = new Squares(x, y, pixelblocksize, pixelblocksize);
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
}

//Temporarily on mousePressed calc. seeking force and apply as a steering behavior
void mousePressed() {
}

void keyPressed() {
  //  save(millis()+".png");
}

