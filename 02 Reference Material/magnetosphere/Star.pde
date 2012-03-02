class Star {
  PVector location;
  float mass;

  Star(PVector _location, float _mass) {
    location = _location;
    mass = _mass;
  }

  void run() {
    fuse();
    display();
    fusion();
    flare();
  }

  void display() {
    fill(225, 225, 0, 70);
    noStroke();
    ellipse(location.x, location.y, mass, mass);
  }

  void fuse() {
   for(int i = 0; i < 8; i++){ 
    photons.add(new Photon(location));
   }
    
    Iterator<Photon> it = photons.iterator();
    while (it.hasNext ()) {
      Photon pho = it.next();
      //pho.velocity.normalize();
      //pho.velocity.mult(15);
      pho.run();
      if (pho.isDead()) {
        it.remove();
      }
    }
  }

  void fusion() {
   for(int i = 0; i < 20; i++ ){
    fusion.add(new Hydrogen(location));
   }
   
    Iterator<Hydrogen> it = fusion.iterator();
    while (it.hasNext ()) {
      Hydrogen hydro = it.next();
      hydro.velocity.normalize();
      hydro.velocity.mult(8);
      hydro.run();
      if (hydro.isDead()) {
        it.remove();
      }
    }
  }

  void flare(){
    if(mousePressed){
      PVector mouseLoc = new PVector(mouseX, mouseY);
      for(int i = 0; i < 5; i++){
        fusion.add(new Hydrogen(mouseLoc));
        photons.add(new Photon(mouseLoc));
      }
    }
  }
}

