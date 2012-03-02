class Water {
  float _height;
  int _r;
  int _g;
  int _b;
  
  Water()
  {
    _height = height - 50;
    _r = 0;
    _g = 174;
    _b = 240;
  }
  
  void Update()
  {
    if(_height < 0)
    {
      _height = 0;
    }
  }
  
  void Render()
  {
    fill(_r, _g, _b);
    
    int modx = 0;
    int mody = 0;
    
    pushMatrix();
    translate(-20, _height);
    
    for(int y = 0; y < 20; y++)
    {
      for(int x = 0; x < 8; x++)
      {
        text(waterStr, modx, mody);
        modx += textWidth(waterStr);
      }
      modx = 0;
      mody += textAscent() + textDescent();
    }
    
    popMatrix();
  }
}

