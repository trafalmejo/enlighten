class Bulb { 
  float x, y, z; 
  boolean ins[] = {false, false, false, false, false, false, false, false};
  boolean in = false;
  boolean onFire = false;
  float tsize, size = 0;
  PVector position;
  int numberParticles;

  Wave wave;

  Bulb (float xp, float yp, float zp, float tamp) {  
    x = xp; 
    y = yp; 
    z = zp;
    position = new PVector(xp, yp, zp);
    size = tamp;
    wave = new Wave(x, y, z);

    // wave.start();
  } 
  void updateDisplay() {
    IsIns();
    isIn();
    translate(x, y, z);
    tsize = wave.tsize;

    noStroke();
    if (!(onFire || in)) {
     // if (!(onFire)) {

        //fill(255, 255, 0);
        fill(0);
      } else {
        fill(0, 255, 0);
        //int f = int(map(numberParticles,0,1,0, 255));
        //fill(f,f,0);
      }
      sphere(size);
      stroke(1);
    }
    void onFire() {
      onFire = true;
      numberParticles++;
    }
    void outFire() {
      onFire = false;
      numberParticles--;
    }
    void IsIns() {
      for (int i = 0; i < bulbs.length; i++) {
        Bulb temp1 = bulbs[i];
        //IF THE BULB IS IN THE WAVE
        if (temp1.tsize > Math.sqrt(Math.pow((x - temp1.x), 2) + Math.pow((y - temp1.y), 2) + Math.pow((z - temp1.z), 2))) {
          ins[i] =true;
        } else {
          ins[i] =false;
        }
      }
    }
    void isIn() {
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
    void setNumberParticles(int a) {
      numberParticles = a;
    }
  }