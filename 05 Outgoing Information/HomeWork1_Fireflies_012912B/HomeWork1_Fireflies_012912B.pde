Firefly [] firefly= new Firefly[40];

void setup() {
  size(600, 400);
  background(32, 32, 32);
  smooth();
  frameRate(25);
  for (int i=0; i< firefly.length; i++) {
    firefly[i] =new Firefly(int(random(0,1)));
  }
}

void draw() {
   noStroke();
  fill(32, 32, 32,60);
  rect(0, 0, width, height);
  fill(234,219,50);
//  background(32, 32, 32, 10);
  for (int i=0; i< firefly.length; i++) { 
    firefly[i].movement();
    firefly[i].draw();
    firefly[i].inwindow();
  }
}


