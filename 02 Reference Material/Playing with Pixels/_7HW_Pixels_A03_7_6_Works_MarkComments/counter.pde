  float rr=0;
  float gg=0;
  float bb=0;
  float counter1 = 0;
  float counter2 = 0;
  float counter3 = 0;
  float counter1Temp =0;
  float counter2Temp =0;
  float counter3Temp =0;
  
  
  void counter() {
    if(counter1Temp >= 1.2) {
      counter1 += 1;
      counter1Temp = 0;
      rr=random(255);
      
    }
     if(counter2Temp >= 1) {
      counter2 += 1;
      counter2Temp = 0;
      gg=random(255);
    }
     if(counter3Temp >= 1) {
      counter3 += 1;
      counter3Temp = 0;
      bb=random(255);
    }
    
    counter1Temp = counter1Temp + .03;
    counter2Temp = counter2Temp + .05;
    counter3Temp = counter3Temp + .002;
    // println ("C1="+counter1+" C2="+counter2+" C3="+counter3+ "  G="+g);//<==For testing
  }
