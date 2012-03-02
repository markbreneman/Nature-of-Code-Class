class SplashEmitter {
  PVector _p;
  PVector _dir;
  float _speed;
  float _variance;
  float _posVariance;
  ArrayList _particleList;
  int _numParticles;
  Boolean _baleted;
  
  SplashEmitter()
  {
    _particleList = new ArrayList();
    _p = new PVector(100, 100);
    _dir = new PVector(0, -1);
    _speed = 400;
    _variance = 1;
    _posVariance = 10;
    _numParticles = 50;
    _baleted = false;
    
    for(int i = 0; i < _numParticles; i++)
    {
      EmitParticle();
    }
  }
  
  SplashEmitter(PVector pos, PVector dir, float speed, int numParticles)
  {
    _particleList = new ArrayList();
    _p = pos;
    _dir = dir;
    _speed = speed;
    _variance = 1;
    _posVariance = 10;
    _numParticles = numParticles;
    _baleted = false;
    
    for(int i = 0; i < _numParticles; i++)
    {
      EmitParticle();
    }
  }
  
  void Update()
  {
    // Update all particles
    for(int i = 0; i < _particleList.size(); i++)
    {
      Particle l = (Particle)_particleList.get(i);
      l.Update();
      
      if(l._baleted)
      {
        _particleList.remove(i);
        l = null;
        i--;
      }
    }
    
    /*for(int j = 0; j < _particleList.size(); j++)
    {
      Particle p = (Particle)_particleList.get(j);
      if(p._baleted)
      {
        _particleList.remove(j);
        p = null;
      }
    }*/
    
    if(_particleList.size() == 0)
    {
      _baleted = true;
    }
  }
  
  void Render()
  {
    fill(water._r, water._g, water._b);
    for(int i = 0; i < _particleList.size(); i++)
    {
      Particle l = GetParticle(i);
      pushMatrix();
      translate(l._p.x, l._p.y);
      rotate(l._angle);
      text(l._letter, 0, 0);
      popMatrix();
    }
  }
  
  void EmitParticle()
  {
    Particle p = new Particle(new PVector(_p.x + random(-_posVariance, _posVariance), _p.y),
      new PVector((_dir.x + random(-_variance, _variance)) * _speed, (_dir.y +  random(-_variance, _variance)) * _speed + mouseV.y),
      new PVector(0, gravity),
      0.0, 0.0,
      textWidth("."),
      '.');
    //l._angleV = random(-0.05, 0.05);
    
    AddParticle(p);
  }
  
  void AddParticle(Particle p)
  {
    _particleList.add(p);
  }
  
  Particle GetParticle(int i)
  {
    return (Particle)_particleList.get(i);
  }
}


