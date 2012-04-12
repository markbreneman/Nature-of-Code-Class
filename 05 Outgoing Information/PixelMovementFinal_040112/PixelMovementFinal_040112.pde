PImage img;
int x,y,pixelblocksize,timeramt;
float r,g,b;
Timer timer;

Squares[] singlesquares; //an array of singlesquare objects

void setup(){
  size(800,800);
  smooth();
  pixelblocksize=5;
  
  timeramt=5000;
  timer = new Timer(timeramt);// 
  
  //Loads the image into memory but doesn't display it.
  img=loadImage("original.jpg");
  
  // define the array to have as many locations as the window
  singlesquares = new Squares [width*height];
  
  //in 10 pixel rows and columns go through the array and get the pixels 
   for (y=0;  y<height; y = y+pixelblocksize) {
    for (x=0; x<width; x = x+pixelblocksize) {
      int loc = x + y*width; //find the one dimensional location in the array
      
      //create a new square object of the passed in arguement sizes at the position of the loc
      // first two arguments are x and y offsets of mouse position, 
      // and the last two arguments are the width and height
      singlesquares[loc] = new Squares(x, y, pixelblocksize, pixelblocksize);
    }
  }
  timer.start();
}

void draw(){
//image(img,0,0);//displays the image
//  background(0,0,0);
  for (y=0;  y<height; y = y+pixelblocksize) {
    for (x=0; x<width; x = x+pixelblocksize) {
      int loc = x + y*width;
       r = red(img.pixels[loc]);
       g = green(img.pixels[loc]);
       b = blue(img.pixels[loc]);
      fill (r,g,b);
      noStroke();
      singlesquares[loc].display();
      if(timer.isFinished()){ 
//        println("is finished!");
        singlesquares[loc].gravity();
      }
    }}

}
