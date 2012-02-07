Mover[] movers = new Mover[10];
float [] xinvisible;
//float xinvisible;
void setup() {
  size(640,360);
  smooth();
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1,5),0,0); 
  }
}

void draw() {
  background(255);  
  PVector wind = new PVector(0.001,0);
  PVector gravity = new PVector(0,0.1);
  for (int i = 0; i < movers.length; i++) {
  PVector invisiblerepel = movers[i].location.get();
  invisiblerepel.mult(-1);
  invisiblerepel.normalize();
  println(movers[i].location.get());
//  println(invisiblerepel);
  
    movers[i].applyForce(invisiblerepel);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }

}









