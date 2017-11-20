class Bulb { 
  float x, y, z, tam; 
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
  void updateWave() {
    wave.update();
  }
  void displayWave(){
    wave.display();
  }
  void enlighten() {
    in = true;
  }
  void unlighten() {
    in = false;
  }
  void resetTrigger() {
    wave.reset();
  }
}