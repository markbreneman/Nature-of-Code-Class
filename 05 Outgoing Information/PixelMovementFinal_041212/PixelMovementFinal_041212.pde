PImage img;
int x, y, loc, pixelblocksize, timeramt;
float r, g, b;
Timer timer;

Squares[] singlesquares; //an array of Sqaure objects called singlesquares
PVector[] originallocations;//an array of PVectors which point to the original positions
PVector[] desiredforces;//an array of PVectors which point to the original positions

void setup() {
  size(800, 800);
  smooth();
  pixelblocksize=5;

  timeramt=5000;
  timer = new Timer(timeramt);// 

  //Loads the image into memory but doesn't display it.
  img=loadImage("original.jpg");

  // define the array of square to have as many locations as the window
  singlesquares = new Squares [width*height];

  // define the array of Pvectors to have as many locations as the window
  originallocations=new PVector[width*height];
  desiredforces=new PVector[width*height];


  //in  rows and columns(defined by pixelblocksize) go through the array and get the pixels 
  for (y=0;  y<height; y = y+pixelblocksize) {
    for (x=0; x<width; x = x+pixelblocksize) {
      int loc = x + y*width; //find the one dimensional location in the array

      //create a new square object of the passed in arguement sizes at the position of the loc
      // first two arguments are the x and y location 
      // and the last two arguments are the width and height
      singlesquares[loc] = new Squares(x, y, pixelblocksize, pixelblocksize);
      originallocations[loc]=new PVector(x, y);
    }
  }
  timer.start();
}



void draw() {
  //image(img,0,0);//displays the image
  background(0, 0, 0);

  //   for (int i=0; i<originallocations.length; i++){
  //    println( originallocations[i]);
  //  }

  //Should this be within the Square Object or the array of Squares as an object
  for (y=0;  y<height; y = y+pixelblocksize) {
    for (x=0; x<width; x = x+pixelblocksize) {
      int loc = x + y*width;
      r = red(img.pixels[loc]);
      g = green(img.pixels[loc]);
      b = blue(img.pixels[loc]);
      fill (r, g, b);
      noStroke();
      singlesquares[loc].display();

      if (timer.isFinished()) { 
        //        println("is finished!");
        singlesquares[loc].update();
      }
    }
  }
}

//Temporarily on mousePressed calc. seeking force and apply as a steering behavior
void mousePressed() {
  for (int i=0;i<originallocations.length;i++) {
    // desiredforces[loc] =new PVector.sub(originallocation[loc]-singlesquares[loc].location)

    //
  }
}

