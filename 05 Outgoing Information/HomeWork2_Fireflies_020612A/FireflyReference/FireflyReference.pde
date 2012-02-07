
int WIDTH = 800;
int HEIGHT = 600;

String REPEL = "repel";
String ATTRACT = "attract";
String mode = ATTRACT;

int MAX_FIREFLIES = 250;
Firefly[] fireflies = new Firefly[MAX_FIREFLIES];

void setup()
{
  size(WIDTH, HEIGHT);
  frameRate(30);
  for (int i = 0; i < MAX_FIREFLIES; i = i+1)
  {
    fireflies[i] = new Firefly();
  }
  strokeWeight(1.5);
  strokeCap(SQUARE);
}

void draw()
{
  fill(0, 0, 0, 85);
  rect(0, 0, WIDTH, HEIGHT);
  for (int i = 0; i < MAX_FIREFLIES; i = i+1)
  {
    fireflies[i].move();
    fireflies[i].draw();
  }
}

void mousePressed()
{
  mode = REPEL;
}

void mouseReleased()
{
  mode = ATTRACT;
}

class Firefly 
{
  float x = random(WIDTH);
  float y = random(HEIGHT);
  float ox = x;
  float oy = y;
  float a = random(1);
  boolean ainc = random(1) > 0.5;
  float p = 0;
  float vx = 0;
  float vy = 0;
  float wx;
  float wy;

  Firefly() {
//    newWaypoint();
  }

//  void newWaypoint() {
//    wx = random( (WIDTH + 100) - 50 );
//    wy = random( (HEIGHT + 100) - 50 );
//    setTimeout(newWaypoint, random(3000)+1000);
//  }

  void move() {
    ox = x;
    oy = y;
    float dx;
    float dy;

    if (mode == REPEL) {
      dx = x - mouseX;
      dy = y - mouseY;
    } 
    else {
      dx = mouseX - x;
      dy = mouseY - y;
    }

    // mouse velocity
    float dist = sqrt((dx*dx)+(dy*dy));
    dist = max(150-dist, 0);
    p = abs(dist);
    float rot = atan2(dy, dx);
    float repelx = cos(rot)*dist/100;
    float repely = sin(rot)*dist/100;
    vx = vx + repelx;
    vy = vy + repely;

    // waypoint
    dx = (wx - x) * 0.00020;
    dy = (wy - y) * 0.00020;
    vx += dx;
    vy += dy;
    vx *= 0.985;
    vy *= 0.985;
    x += vx;
    y += vy;

    // alpha
    if (ainc) {
      a = a + 0.03;
      if (a > 1) {
        a = 1;
        ainc = false;
      }
    } 
    else {
      a = a - 0.03;
      if (a < 0.2) {
        a = 0.2;
        ainc = true;
      }
    }
  }

  void draw() {
    int r = max(0, round(255 - p * 2));
    int g = round(p * 2);
    int b = 255;
    stroke(r, g, b, a * 255);
    line(ox, oy, x, y);
  }
}

