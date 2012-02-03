Mover m;
float t;
float dt= 0.001;
int noiseAmp=30;
float n,xWind;

void setup() {
  size(640,360);
  smooth();
  m = new Mover(); 
}

void draw() {
  background(255);
  t+=dt;
  n=noise(t)*noiseAmp;
//  println(n);

if(mouseX>m.location.x){
  xWind=-n;
}
else{
xWind=n;
} 

  if (mousePressed){
  PVector wind = new PVector(xWind,n);
  m.applyForce(wind);}
  
  m.update();
  m.display();
  m.checkEdges();

}



