class Flock {
  ArrayList<Squares> squaresarraylist; // An ArrayList for squares

  Flock() {
    squaresarraylist = new ArrayList<Squares>(); // Initialize the ArrayList
  }

  void addSquare(Squares s) {
    squaresarraylist.add(s);
  }

  void start() {
    for (Squares s : squaresarraylist) {
      s.display();
    }
  }
  
  void run() {
    for (Squares s : squaresarraylist) {
//      s.update();
        s.run(squaresarraylist);
    }}
}

