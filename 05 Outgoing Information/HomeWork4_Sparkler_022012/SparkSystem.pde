//This class manages the sparks in an arraylist. The sparksystem then can be 
//managed in the main code

class SparkSystem {
  //SparkSystem Variables
  ArrayList<Spark> sparks; //Declar Arraylist of sparks
  PVector origin;//point at which sparks will be emitted

  //SparkSystem Constructor

  SparkSystem(PVector start) {//the PVector will determine location
    sparks = new ArrayList<Spark>(); //initialize the arraylists of sparks
    origin=start.get(); //Get the emitterpoint

  }
  
  void addSpark(){
    origin.y+=.125;
    sparks.add(new Spark(origin));
  }

  void applyForce(PVector f) {
    for (Spark s: sparks) {
      s.applyForce(f);
    }
  }
  
  void applyRepeller(Repeller r) {
    for (Spark s: sparks) {
      PVector repel = r.repel(s);        
      s.applyForce(repel);
    }
  }

  void run() {
    //Cycle through arraylist backwards..ASK Dan about this
    Iterator<Spark> it = sparks.iterator();
    while (it.hasNext ()) {
      Spark s= it.next();
      s.movement();
      if (s.isDead()) {
        it.remove();
      }
    }
  }

  // Is the Particle Still Active?
  boolean dead() {
    if (sparks.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}

