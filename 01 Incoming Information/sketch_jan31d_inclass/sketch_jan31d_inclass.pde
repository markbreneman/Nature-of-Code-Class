float t;
void setup() {
  size(400, 200);
  smooth();

}

void draw() {
  background(255);
  //  float x = random(0,width);
  
  t+=.01;
  float n = noise(t);
  float x = n*width;
  fill(0);
  ellipse(x, 100, 16, 16);
//  noiseDetail(3,0.5);
}

