float a=0;
float av=0;
float aa=0;

void setup(){
  size(400,400);
  
}

void draw(){
  background(255);
  smooth();
  translate(width/2,height/2); 
  fill(0);
  rotate(a);
  if(mousePressed){
  aa=map(mouseX,0,width,-.001,.001);}
  else{
    aa=0;}
  a+=av;
  av+=aa;
  rectMode(CENTER);
  rect(0,0,100,50);
}
