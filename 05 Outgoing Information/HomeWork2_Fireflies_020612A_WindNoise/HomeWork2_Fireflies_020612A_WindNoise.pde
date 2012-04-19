Firefly [] firefly= new Firefly[35];

float t;
float dt= 0.001;
//int noiseAmp=30;
float n;

void setup() {
  size(600, 400);
  //  background(32, 32, 32);
  smooth();
  frameRate(25);
  //issue Firefly objects with random size radius
  for (int i=0; i< firefly.length; i++) {
    firefly[i] =new Firefly(int(random(0, 1)));
  }
}

void draw() {
  t+=dt;
  n=noise(t);
println(n);
  noStroke();
  fill(32, 32, 32, 80);//Background
  rect(0, 0, width, height);
  fill(234, 219, 50); //Firefly Color

  if (mousePressed) {
    PVector wind = new PVector(random(-n,n),random(-n,n));
    for (int i=0; i< firefly.length; i++) {
      firefly[i].applyForce(wind);
    }
  }

  for (int i=0; i< firefly.length; i++) { 
    firefly[i].movement();//Movement of the fireflies
    firefly[i].render();//displaying the fireflies
    firefly[i].inwindow();//Keep fireflies in the window
  }
}

