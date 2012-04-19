class Emitter {
  PVector _p;
  PVector _dir;
  float _speed;
  float _freq; // 1 particle emitted per this time
  float _variance;
  ArrayList _particleList;
  int _maxParticles;
  float _timer;
  int _currentChar;
  Boolean _active;

  Emitter()
  {
    _particleList = new ArrayList();
    _p = new PVector(100, 100);
    _dir = new PVector(0.5, -0.5);
    _speed = 400;
    _freq = 0.08;
    _variance = 0.1;
    _maxParticles = 100;
    _timer = 0.0;
    _currentChar = 0;
    _active = false;
  }

  Emitter(PVector pos, PVector dir, float speed, float freq, int maxParticles)
  {
    _particleList = new ArrayList();
    _p = pos;
    _dir = dir;
    _speed = speed;
    _freq = freq;
    _variance = 0.1;
    _maxParticles = maxParticles;
    _timer = 0.0;
    _active = false;
  }

  void Update()
  {
    _p = new PVector(mouseX, mouseY);
    _timer += deltaTime;
    while (_timer >= _freq)
    {
      if (_active)
      {
        EmitParticle();
      }

      _timer -= _freq;
    }

    // Update all particles
    for (int i = 0; i < _particleList.size(); i++)
    {
      Letter l = (Letter)_particleList.get(i);
      l.Update();

      if (l._baleted)
      {
        _particleList.remove(i);
        l = null;
        i--;
      }
    }

    /*for(int j = 0; j < _particleList.size(); j++)
     {
     Letter d = (Letter)_particleList.get(j);
     if(d._baleted)
     {
     _particleList.remove(j);
     d = null;
     }
     }*/
  }

  void Render()
  {
    fill(205, 195, 20);
    for (int i = 0; i < _particleList.size(); i++)
    {
      Letter l = GetLetter(i);
      pushMatrix();
      translate(l._p.x, l._p.y);
      rotate(l._angle);
      text(l._letter, 0, 0);
      popMatrix();
    }
  }

  void EmitParticle()
  {
    if (tinkle.charAt(_currentChar) != ' ')
    {
      Letter l = new Letter();
      l._p = new PVector(_p.x, _p.y);
      l._v = new PVector((_dir.x + random(-_variance, _variance)) * _speed, (_dir.y)/* + random(-_variance, _variance))*/ * _speed + mouseV.y);
      l._a = new PVector(0, gravity);
      l._angleV = random(-0.05, 0.05);
      l._width = textWidth(tinkle.charAt(_currentChar));

      l._letter = tinkle.charAt(_currentChar);

      AddLetter(l);
    }

    _currentChar++;
    if (_currentChar >= tinkle.length())
    {
      _currentChar = 0;
    }
  }

  void AddLetter(Letter l)
  {
    _particleList.add(l);
  }

  Letter GetLetter(int i)
  {
    return (Letter)_particleList.get(i);
  }
}
