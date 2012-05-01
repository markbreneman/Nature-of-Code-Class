class Flock {
  ArrayList<Squares> squaresarraylist; // An ArrayList for squares
  ArrayList<Squares> [][] grid; // An ArrayList for bin lattice
  int resolution=10;
  int cols = width/resolution;     // Calculate cols & rows
  int rows = height/resolution;
  boolean go =false;

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
      for (int n = -1; n <= 1; n++) {
        for (int m = -1; m <= 1; m++) {
          if (x+n >= 0 && x+n < cols && y+m >= 0 && y+m< rows) grid[n+column][m+row].add(s);
        }
      }
    }

    for (Squares s : squaresarraylist) {
      int column = int(s.x) / resolution;
      int row = int(s.y) /resolution;
      s.run(grid[column][row]);
    }
  }

  void reset() {
    for (Squares s : squaresarraylist) {
      s.startingposition();
    }
  }
}

