class Flock {
  ArrayList<Squares> squaresarraylist; // An ArrayList for squares
  ArrayList<Squares> [][] grid; // An ArrayList for bin lattice
  int resolution=20;
  int cols = width/resolution;     // Calculate cols & rows
  int rows = height/resolution;
  
  Flock() {
    squaresarraylist = new ArrayList<Squares>(); // Initialize the ArrayList
       
    // Initialize grid as 2D array of empty ArrayLists
    grid = new ArrayList[cols][rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new ArrayList<Squares>();
      }
    }

  }

  void addSquare(Squares s) {
    squaresarraylist.add(s);
    int column = int(s.x) / resolution;
    int row = int(s.y) /resolution;
    grid[column][row].add(s);
    
  }

  void start() {
    for (Squares s : squaresarraylist) {
      s.display();
      int column = int(s.x) / resolution;
      int row = int(s.y) /resolution;
      grid[column][row].add(s);

    }
  }
  
  void run() { 
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
          grid[i][j].clear();
            }
              }
    for (Squares s : squaresarraylist) {
//      s.update();
        int column = int(s.x) / resolution;
        int row = int(s.y) /resolution;
        grid[column][row].add(s);
        s.run(grid[column][row]);
    }
//    println(squaresarraylist.size());
  }
  
  void reset(){
   for (Squares s : squaresarraylist) {
        s.startingposition();
    }
  }
}

