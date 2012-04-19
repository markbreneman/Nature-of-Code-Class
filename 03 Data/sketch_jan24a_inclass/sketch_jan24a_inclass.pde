Walker w;


class Walker{
  //Later in the semester these variables will be replaced with vectors
  float x;
  float y;
  
  void walk(){
   inv xy(int(random(3))-1);
   inv xy(int(random(3))-1);
   x+= vx;
   y+= vy;
   x =  constrain(x,0,width-1);
   y =  constrain(y,0,height-1);
 
  }
  
  void display(){
    stroke(255);
    point(x,y);
  }
