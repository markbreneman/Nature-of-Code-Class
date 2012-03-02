class Particle {
  PVector _p;
  PVector _v;
  PVector _a;
  float _width;
  float _angle;
  float _angleV;
  char _letter;
  Boolean _baleted;
  
  Particle(PVector pos, PVector vel, PVector acc, float a, float av, float lWidth, char letter)
  {
    _p = pos;
    _v = vel;
    _a = acc;
    _width = lWidth;
    _angle = a;
    _angleV = av;
    _letter = letter;
    
    _baleted = false;
  }
  
  void Update()
  {
    _v.x += _a.x;
    _v.y += _a.y;
    _p.x += _v.x * deltaTime;
    _p.y += _v.y * deltaTime;
    
    _angle += _angleV;
    
    if(_p.x < -_width || _p.x > width + _width)
    {
      _baleted = true;
    }
    else if(_p.y < -100 + textDescent())
    {
      _baleted = true;
    }
    
    // Entering water
    if(_p.y > water._height)
    {
      _baleted = true;
    }
  }
}
