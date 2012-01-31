// Daniel Shiffman
// The Nature of Code
// http://www.shiffman.net/

float t = 0.0;
float dt = 0.001; 

void setup() {
  size(200,200);
  background(0);
  smooth();
  noStroke();
}

void draw() {
  // Create an alpha blended background
  fill(0, 10);
  rect(0,0,width,height);
  
  //float n = random(0,width);  // Try this line instead of noise
  
  // Get a noise value based on xoff and scale it according to the window's width
  float n = noise(t)*width;
  
  // With each cycle, increment xoff
  t += dt;
  
  // Draw the ellipse at the value produced by perlin noise
  fill(200);
  ellipse(n,height/2,16,16);
}
