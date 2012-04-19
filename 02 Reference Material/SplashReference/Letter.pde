class Letter {
  PVector _p;
  PVector _v;
  PVector _a;
  PVector _prevP;
  float _width;
  float _angle;
  float _angleV;
  char _letter;
  float _friction;
  float _impactFriction;
  float _splashFactor;
  Boolean _baleted;
  
  final int STATE_OUT = 0;
  final int STATE_IN = 1;
  final int STATE_FLOAT = 2;
  int _state;
  
  Letter()
  {
    _p = new PVector(width / 2, height / 2);
    _prevP = _p;
    _v = new PVector(0, 0);
    _a = new PVector(0, 0);
    _width = 0;
    _angle = 0;
    _angleV = 0;
    _letter = 'a';
    _friction = 0.98;
    _impactFriction = 0.35;
    
    _baleted = false;
    _state = STATE_OUT;
  }
  
  Letter(PVector pos, PVector vel, PVector acc, float a, float av, float lWidth, char letter)
  {
    _p = pos;
    _prevP = _p;
    _v = vel;
    _a = acc;
    _width = lWidth;
    _angle = a;
    _angleV = av;
    _letter = letter;
    _friction = 0.98;
    _impactFriction = 0.35;
    
    _baleted = false;
    _state = STATE_OUT;
  }
  
  void Update()
  {
    _prevP = new PVector(_p.x, _p.y);
    
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
    
    // Below water level and out of water
    if(_state == STATE_FLOAT)
    {
      _v.x = _v.x * _friction;
      _p.y = water._height;
      _angleV *= 0.98;
    }
    // Entering water
    else if(_p.y > water._height && _state == STATE_OUT)
    {
      _state = STATE_IN;
      _v.x *= _friction;
      _v.y *= _impactFriction;
      _a.y = -_a.y * 0.7;
      _angleV *= 0.98;
      water._height -= 0.2;
      
      if(_prevP.y < water._height)
      {
        SplashEmitter e = new SplashEmitter(new PVector(_p.x, water._height - 20),
          new PVector(0, -1), _v.y * 0.65, 30);
        splashList.add(e);
      }
    }
    // Below water level and in water
    else if(_p.y > water._height && _state == STATE_IN)
    {
      _v.x = _v.x * _friction;
      _angleV *= 0.98;
    }
    // If leaving water, make the text float at the top
    else if(_p.y <= water._height && _state == STATE_IN)
    {
      _p.y = water._height;
      _v.y = 0;
      _a.y = 0;
      _angleV *= 0.98;
      _state = STATE_FLOAT;
    }
  }
}
