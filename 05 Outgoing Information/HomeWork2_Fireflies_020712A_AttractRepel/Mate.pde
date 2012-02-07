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
    g=ellipseRad*50;
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
    location = new PVector(mouseX,mouseY);
    fill(209, 40, 43); 
    
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
