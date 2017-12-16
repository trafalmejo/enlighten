class Wave { 
  // Spring simulation constants
  float M = 0.8;   // Mass
  float K = 0.2;   // Spring constant
  float D = 0.92;  // Damping
  float R = 150;   // Rest position

  // Spring simulation variables
  float ps = R;    // Position
  float vs = 0.0;  // Velocity
  float as = 0;    // Acceleration
  float f = 0;     // Force
  //TO TEST EVERY BULB
  //int maxSize = 5;
    int maxSize = 90;


  float x, y, z;
  float tsize = 0;
  int res = 15;
  //JUST ONE WAVE PER TIME
  boolean once = false;
  float angle = 0;
  PVector positionW;

  Wave (float xp, float yp, float zp) {  
    x = xp; 
    y = yp; 
    z = zp;
    positionW = new PVector(x,y,z);
  }
  void reset() {
    tsize = 0;
    once = false;
  }
  void update() { 
    
    if (!once) {
      angle++;
      tsize += 1+map(cos(angle),-1,1,-3,3);
     // tsize += 4 ;

    }
    if (tsize > maxSize) {
      reset();
      once = true;
    }
  }
  //void update() { 
  //if (!once) {
  //   tsize += 4;
  //  }
  //}
  //if (tsize > 200) {
  //  reset();
  //  once = true;
  //}
  // }
  void display() {
    translate(x, y, z);
    //fill(255, 10, 10, 255);
    noFill();
    sphereDetail(res);
    sphere(tsize);
  }
}