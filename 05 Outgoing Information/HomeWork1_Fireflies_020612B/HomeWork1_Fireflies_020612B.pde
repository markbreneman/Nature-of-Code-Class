Firefly [] firefly= new Firefly[35];
Mate m;

void setup() {
  size(600, 400);
  //  background(32, 32, 32);
  smooth();
  frameRate(25);
  //issue Firefly objects with random size radius
  for (int i=0; i< firefly.length; i++) {
    firefly[i] =new Firefly(int(random(0, 1)));
  }
    m = new Mate();
  
}

void draw() {
  
  
  noStroke();
  fill(32, 32, 32, 80);//Background
  rect(0, 0, width, height);
  m.display();


  for (int i=0; i< firefly.length; i++) { 
    for (int j = 0; j < firefly.length; j++) {
      if (i != j) {
        PVector repelforce = firefly[j].repel(firefly[i]);
        firefly[i].applyForce(repelforce);
      }}
    PVector attractforce = m.attract(firefly[i]);
    firefly[i].applyForce(attractforce);
    firefly[i].movement();//Movement of the fireflies
    firefly[i].render();//displaying the fireflies
    firefly[i].inwindow();//Keep fireflies in the window
  }
}

