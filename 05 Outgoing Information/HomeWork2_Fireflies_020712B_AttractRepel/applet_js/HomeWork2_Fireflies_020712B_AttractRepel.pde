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
  //issue new mate object
    m = new Mate();
  
}

void draw() { 
  noStroke();
  //Background
  fill(32, 32, 32, 80);
  rect(0, 0, width, height);
  
  //Draw the Mate Object
  m.display();
  //Draw Fireflies and Actvity
  for (int i=0; i< firefly.length; i++) {
   //Fireflies are repeled by one another
    for (int j = 0; j < firefly.length; j++) {
      if (i != j) {
        PVector repelforce = firefly[j].repel(firefly[i]);
        firefly[i].applyForce(repelforce);
      }}
    //Fireflies are attracted to the Mate  
    PVector attractforce = m.attract(firefly[i]);
    firefly[i].applyForce(attractforce);
    firefly[i].movement();//Movement of the fireflies
    firefly[i].render();//displaying the fireflies
    firefly[i].inwindow();//Keep fireflies in the window
  }
}

class Mate{
//  float Mass 
  float ellipseRad;
  PVector location;
  float g;
  int growShrink;
  
  
  Mate(){
//    location = new PVector(width/2,height/2);
    
//    g=20;
    ellipseRad=random(3, 15);
    g=50;
  }
//Function to Accept Firefly Object and determine PVector Force which is
//returned as the attraction force in this case
  PVector attract(Firefly firefly){
    PVector force = PVector.sub(location,firefly.location); //Create a new force vector based off the distance from the Mate to the Firefly    
    float distance = force.mag();// Get the actual length of that vector                                 
    distance = constrain(distance,5.0,25.0);                                
    force.normalize();                                            
    float strength = (g * ellipseRad * ellipseRad) / (distance * distance);
    force.mult(strength);                                         
    return force;
  }


  void display() {
    location = new PVector(mouseX-20,mouseY-20);
//    fill(209, 40, 43); 
    noFill();
    stroke(234, 219, 50);
    strokeWeight(ellipseRad/5+.25);    
    if (ellipseRad > 9) {
      growShrink = 0;
    } 
    else if (ellipseRad < 0) {
      growShrink = 1;
    }
    if (growShrink == 1) {
      ellipseRad += random(.2, .25);
    } 
    else if ( growShrink== 0) {
      ellipseRad -=random(.2, .25);
    }
    ellipse(location.x,location.y,ellipseRad*2,ellipseRad*2);
  } 
  
}
class Firefly {
  float ellipseRad, topSpeed, growShrink;
  PVector location, velocity, acceleration, noff;
  int dir;
  float g;  

  Firefly(int tempGrowShrink) {
    ellipseRad=random(3, 10);
    growShrink=tempGrowShrink;
    topSpeed=1;
    location=new PVector(random(width), random(height));
    velocity=new PVector(0, 0);
    acceleration=new PVector(random(-5,5),random(-5,5));
    g=-ellipseRad*.5;
    
  }
  //How to display the firefly
  void render() {
    noStroke();
    fill(234, 219, 50); //Firefly Color
    ellipse(location.x, location.y, ellipseRad, ellipseRad);
    //FADE IN FADE OUT
    if (ellipseRad > 9) {
      growShrink = 0;
    } 
    else if (ellipseRad < 0) {
      growShrink = 1;
    }
    if (growShrink == 1) {
      ellipseRad += random(.2, .25);
    } 
    else if ( growShrink== 0) {
      ellipseRad -=random(.2, .25);
    }
    //    println(ellipseRad);
    //    println("growShrink value"+growShrink);
  }
  //Applying Force Function - how to handle forces; forces only affect acceleration
   void applyForce(PVector f) {
    acceleration.add(f);
  }
  
  PVector repel(Firefly firefly){
    PVector force = PVector.sub(location,firefly.location);            
    float distance = force.mag();                                
//    distance = constrain(distance,5.0,25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            
    float strength = (g * ellipseRad * ellipseRad) / (distance * distance); 
    force.mult(strength);                                        
    return force;
  }
  //Movement Function - how to create the movement  
  void movement() {
    location.add(velocity);
    velocity.add(acceleration);
    acceleration.mult(0);// Preventing accumulation of accleration WRT forces
    velocity.limit(topSpeed);//So Fireflies don't move faster than the framerate.Keeping them with normal movement

  }
  //Function to Keep Fireflies in the Window
  void inwindow() {

    //    location.x = constrain(location.x, 0+ellipseRad, width-ellipseRad);
    //    location.y = constrain(location.y, 0+ellipseRad, height-ellipseRad);
    if (location.x > width) {
      velocity.x*=-1;
      location.x = width;
    } 
    else if (location.x < 0) {
      velocity.x*=-1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y*=-.55;
      location.y = height;
    } 
    else if (location.y < 0) {
      velocity.y*=-.55;
      location.y = 0;
    }
  }
}


