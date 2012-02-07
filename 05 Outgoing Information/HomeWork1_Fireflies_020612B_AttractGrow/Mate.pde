class Mate{
//  float Mass 
  float ellipseRad;
  PVector location;
  float g;
  int growShrink;
  
  
  Mate(){
//    location = new PVector(width/2,height/2);
    
    g=0.4;
    ellipseRad=random(3, 10);
  }

PVector attract(Firefly firefly){
    PVector force = PVector.sub(location,firefly.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance,5.0,25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (g * ellipseRad * ellipseRad) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }


  void display() {
    location = new PVector(mouseX,mouseY);
    fill(255, 0, 0); 
    
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
