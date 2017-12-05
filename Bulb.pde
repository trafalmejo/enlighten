class Bulb { 
  float x, y, z; 
  boolean ins[] = {false, false, false, false, false, false, false, false};
  boolean in = false;
  int res = 5;
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

    //wave.start();
  } 
  void updateDisplay() {

    IsIns();
    isIn();
    translate(x, y, z);
    tsize = wave.tsize;
    numberParticles = particlesIn();
    noStroke();
    if (!( numberParticles > 0 || in)) {
      // if (!(onFire)) {
      //numberParticles = 0;
      //fill(255, 255, 0);
      fill(0);
    } else {
      //fill(255, 255, 0);
      //println(numberParticles);
      int f = int(map(numberParticles, 0, 56, 0, 255));
      fill(f, f, 0);
    }
    sphereDetail(res);
    sphere(size);
    stroke(1);
    println(numberParticles);
  }
  void onFire() {
    onFire = true;
    numberParticles++;
  }
  void outFire() {
    onFire = false;
    numberParticles--;
  }
  //CHECK IF THE BULB IN THE WAVE
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
  //SUMS UP ALL THE BOOLEANS
  void isIn() {
    boolean fin = ins[0];
    for (int i = 0; i < ins.length; i++) {
      fin |= ins[i];
    }
    in = fin;
  }
  // CHECK HOW MANY PARTICLES IN IN HERE.
  int particlesIn() {
    int num = 0;
    for (int i = ps.particles.size()-1; i >= 0; i--) {
      Particle p = ps.particles.get(i);
      if (p.loc.dist(position) < size) {
        num++;
      }
    }
    return num;
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