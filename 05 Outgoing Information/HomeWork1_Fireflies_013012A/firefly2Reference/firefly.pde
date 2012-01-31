Firefly a;
Firefly b;
Firefly d;


void setup() {
  size (400, 400);
  //frameRate(5);

  a= new Firefly();
  b= new Firefly();
  d= new Firefly();
}


void draw() {
  background(255);
  a.buzz();
  a.render();

  b.buzz();
  b.render();

  d.buzz();
  d.render();
  
  
  a.checkEdges();
  b.checkEdges ();
  d.checkEdges ();
  

}

//    if (location.x > width-20) {
//      location.x = location.x*-1 ;
//    } 
//    else if (location.x < 20) {
//      location.x = location.x*-1 ;
//    }
//}

