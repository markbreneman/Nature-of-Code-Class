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
    g=-ellipseRad*500;
    
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
//    distance = constrain(distance,5.0,25.0);                            
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

