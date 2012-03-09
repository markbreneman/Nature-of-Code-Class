import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
import hypermedia.video.*;
import java.awt.Rectangle;

// A reference to our box2d world
PBox2D box2d;
int zoom=3; //Scaling up the display


// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Ball> balls;

// SPRING VARIABLE
Spring spring1;

//PADDLE VARAIABLES 
Paddle paddle1;


//OPEN CV VARIABLES 
OpenCV opencv;
int contrast_value    = 0;
int brightness_value  = 0;

//TIMER VARIABLES
Timer timer;


void setup() {
  size(640, 480);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  balls = new ArrayList<Ball>();
  boundaries = new ArrayList<Boundary>();

  // Set Boundaries of the Wall
  //  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10));
  //  boundaries.add(new Boundary(3*width/4, height-5, width/2-50, 10));
  boundaries.add(new Boundary(width/2, height-5, width, 10));
  boundaries.add(new Boundary(width-5, height/2, 10, height));
  boundaries.add(new Boundary(5, height/2, 10, height));

  // Add Paddles for 
  //  paddle1=new Paddle(faces[0].x+faces[0].width/2, faces[0].y+faces[0].height/2);
  paddle1=new Paddle(width/2, height/2);
  // Make springs- They will only actually be made when faces are detected
  spring1 = new Spring();
  spring1.bind(width/2+10, height/2+10, paddle1);


  //OPENCVSETUP
  opencv = new OpenCV( this );
  opencv.capture( width/zoom, height/zoom);                   // START VIDEO
  opencv.cascade( OpenCV.CASCADE_FRONTALFACE_ALT );  // load detection description, here-> front face detection : "haarcascade_frontalface_alt.xml"


  //TIMER
  timer=new Timer(100);
  timer.start();
  
//  // Add a listener to listen for collisions!
//box2d.world.setContactListener(new CustomListener());
}


void draw() {
  background(255);
  opencv.read();//GRAB A NEW FRAME
  opencv.flip( OpenCV.FLIP_HORIZONTAL ); // FLIP IMAGE HORIZONTALLY
  //  opencv.convert( GRAY );
  opencv.contrast( contrast_value );
  opencv.brightness( brightness_value );

  // proceed detection
  Rectangle[] faces = opencv.detect( 1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );

  // display the image
  image( opencv.image(), 0, 0,width,height );

  // We must always step through time!
  box2d.step();
  
    for ( int i=0; i<faces.length; i++ ) {
    //SCALE THE SIZE BACK UP
    faces[i].x*=zoom;
    faces[i].y*=zoom;
    faces[i].width*=zoom;
    faces[i].height*=zoom;}

  ////FACE DETECTION PADDLE MOVEMENT
  for ( int i=0; i<constrain(faces.length,0,3); i++ ) {    
    //    println("faces X" + faces[0].x);
    //    println("faces Y" + faces[0].y);
    if (faces.length>0) {
      spring1.update(faces[i].x+faces[i].width/2, faces[0].y+faces[i].height/2);
      noFill();
      stroke(255, 0, 0);
      strokeWeight(2);
      rectMode(CORNER);
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height );
    }
    else {
      spring1.destroy();
    }
  }

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Ball b: balls) {
    b.display();
  }

  // Display Paddle
  paddle1.display();
//  spring1.display();

  // Ball that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list

  for (int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    if (b.done()) {
      balls.remove(i);
    }
  }
    if (timer.isFinished()) {
      // Add a new ball
      Ball p = new Ball(random(0,width), 35, random(5, 10));
      balls.add(p); 
      // Start timer again
      timer.start();
   }
  if (mousePressed) {
    Ball p = new Ball(mouseX, mouseY, random(5, 10));
    balls.add(p);
  }
}

