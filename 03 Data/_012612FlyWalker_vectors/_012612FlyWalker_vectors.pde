//Trying to create a class and object:refresh on processing

Gnat g;

void setup(){
  
  size(300,300);
  g = new Gnat();
//  background(137,137,137);
  frameRate(30);
}

void draw(){
  background(137,137,137);
  g.fly();
  g.display();
  
}


