class Wave extends Thread { 

  float x, y, z;
  float tsize = 0;
  int res = 15;
  boolean once = false;

  Wave (float xp, float yp, float zp) {  
    x = xp; 
    y = yp; 
    z = zp;
  }
  void reset() {
    tsize = 0;
    once = false;
  }
  void update() { 
    if(!once){
    tsize+=3;
    }
    if (tsize > 200) {
      reset();
      once = true;
    }
  }
  void display(){
    translate(x, y, z);
    //fill(255, 10, 10, 255);
    noFill();
    sphereDetail(res);
    sphere(tsize);
}

}