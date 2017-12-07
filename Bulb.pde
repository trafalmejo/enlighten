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
  int brightness;

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

    //IsIns();
    //isIn();
    translate(x, y, z);
    tsize = wave.tsize;
    numberParticles = particlesIn();
    noStroke();
    // if (!( numberParticles > 0 || in)) {
    if (numberParticles <= 0) {
      //fill(255, 255, 0);
      brightness = 0;
      fill(0);
    } else {
      //fill(255, 255, 0);
      //println(numberParticles);
      brightness = int(map(numberParticles, 0, bright, 0, 254));
      fill(brightness, brightness, 0);
    }
    if (isInWaveCandle()) {
      float a = position.dist(waveCandle.positionW)-waveCandle.tsize;
      a = map(a,position.dist(waveCandle.positionW),0,0,100);
      //println(a);
      brightness += a;
      fill(brightness, brightness, 0);
    }    
    //println(waveCandle.tsize);
    sphereDetail(res);
    sphere(size);
    stroke(1);
    //println(numberParticles);
  }

  boolean isInWaveCandle() {
    if (waveCandle.tsize > Math.sqrt(Math.pow((x - waveCandle.x), 2) + Math.pow((y - waveCandle.y), 2) + Math.pow((z - waveCandle.z), 2))) {
      return true;
    } else {
      return false;
    }
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