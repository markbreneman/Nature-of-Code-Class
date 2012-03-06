class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are birthed

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    //add particlesobjects to the array list
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));
    }
  }

  //This function goes over the arraylist of particles and and checks to see if they should be removed
  void run() {
    //Implementing THE ITERATOR!
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext ()) {
      Particle p = it.next();
      p.run();
      if (p.dead()) {
        it.remove();
      }
    }
  }

  //  void addParticle() {
  //    particles.add(new Particle(origin));
  //  }

  void addParticle(Particle p) {
    particles.add(p);
  }


  //A function to apply a force to all Particles
    void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}

