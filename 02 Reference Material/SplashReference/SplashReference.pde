// Tinkle

PFont offthedrugs;
Emitter emitter;
String tinkle;
String waterStr;

ArrayList splashList;

Water water;

int prevTime = 0;
int curTime = 0;
float deltaTime = 0.0;

PVector mouseV;
float gravity = 9.8;

void setup()
{
  size(640, 480, P2D);

  offthedrugs = createFont("offthedrugs.ttf", 48);
  textFont(offthedrugs);
  textSize(48);

  tinkle = "elknit .";
  waterStr = "water";

  emitter = new Emitter();
  mouseV = new PVector(0, 0);

  water = new Water();

  splashList = new ArrayList();

  background(255);
  fill(40);
}

void draw()
{
  Update();
  Render();
}

void Update()
{
  prevTime = curTime;
  curTime = millis();
  deltaTime = (curTime - prevTime) / 1000.0f;

  mouseV = new PVector(mouseX - pmouseX, mouseY - pmouseY);

  water.Update();
  emitter.Update();

  SplashEmitter e = null;
  // Update splash emitters
  for (int i = 0; i < splashList.size(); i++)
  {
    e = (SplashEmitter)splashList.get(i);
    e.Update();
    if (e._baleted)
    {
      splashList.remove(i);
      e = null;
      i--;
    }
  }

  /*for(int j = 0; j < splashList.size(); j++)
   {
   e = (SplashEmitter)splashList.get(j);
   if(e._baleted)
   {
   splashList.remove(j);
   e = null;
   }
   }*/
}

void mouseClicked()
{
  emitter._active = !emitter._active;
}

void Render()
{
  background(40);

  water.Render();
  emitter.Render();

  SplashEmitter e = null;
  for (int i = 0; i < splashList.size(); i++)
  {
    e = (SplashEmitter)splashList.get(i);
    e.Render();
  }
}

void stop()
{
  super.stop();
}





