Mover[] movers = new Mover[4];
float [] xinvisible;
//float xinvisible;
void setup() {
  size(640,360);
  smooth();
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(2,random(width),50); 
  }
}

void draw() {
  background(255);
//  translate(width/2,height/2);
  //for (int i = 0; i < movers.length; i++) {
  //xinvisible[i]=pow(movers[i].location.x,2);
  //}
//  println(xinvisible);
  PVector invisiblerepel = new PVector(-.005,0);
  PVector wind = new PVector(0.01,0);
  PVector gravity = new PVector(0,0.1);
  for (int i = 0; i < movers.length; i++) {

    movers[i].edgeForce();
    
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    //movers[i].applyForce(invisiblerepel);

    movers[i].update();
    movers[i].display();
    //movers[i].checkEdges();
  }

}
