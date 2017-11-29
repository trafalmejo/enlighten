class Bulb { 
  float x, y, z, tam; 
  boolean ins[] = {false,false,false,false,false,false,false,false};
  boolean in = false;
  float tsize = 0;
  Wave wave;
  Bulb (float xp, float yp, float zp, float tamp) {  
    x = xp; 
    y = yp; 
    z = zp;
    tam = tamp;
    wave = new Wave(x, y, z);

    // wave.start();
  } 
  void updateDisplay() {
    IsIns();
    isIn();
    translate(x, y, z);
    tsize = wave.tsize;

    noStroke();
    if (!in) {
      fill(255, 255, 0);
    } else {
      fill(0, 255, 0);
    }
    sphere(tam);
    stroke(1);
  }
  void IsIns() {
    for (int i = 0; i < bulbs.length; i++) {
      Bulb temp1 = bulbs[i];
      if (temp1.tsize > Math.sqrt(Math.pow((x - temp1.x), 2) + Math.pow((y - temp1.y), 2) + Math.pow((z - temp1.z), 2))) {
         ins[i] =true;
      }
      else {
         ins[i] =false;
      }
    }
  }
  void isIn(){
    boolean fin = ins[0];
      for (int i = 0; i < ins.length; i++) {
        fin |= ins[i];
      }
      in = fin;
  }
  void updateWave() {
    wave.update();
  }
  void displayWave() {
    wave.display();
  }
  void resetTrigger() {
    wave.reset();
  }
}