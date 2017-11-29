//COLOR
//SMELL 
//DETAIL
//SOUND
//MOTION

//REMOVE BLUE
//REMOVE MOTION
//REMOVE DETAIL

float x, y, z;
int bsize = 10;
boolean actives[] = {false, false ,false, false, false, false, false, false};
int scene = 200;
Bulb temp = null;
Bulb bulbs[] = new Bulb[8];
Bulb bulb01 = new Bulb(50, -60, 50, bsize);
Bulb bulb02 = new Bulb(50, -60, -50, bsize);
Bulb bulb03 = new Bulb(-50, -60, -50, bsize);
Bulb bulb04 = new Bulb(-50, -60, 50, bsize);
Bulb bulb05 = new Bulb(-25, -80, 25, bsize);
Bulb bulb06 = new Bulb(25, -90, -25, bsize);
Bulb bulb07 = new Bulb(25, -80, 25, bsize);
Bulb bulb08 = new Bulb(-25, -100, -25, bsize);

void setup() {
  size(1280, 720, P3D);
  x = width/2;
  y = height/2;
  z = 0;
  translate(x, y, z);
  //for(int i = 0; i < bulbs.size(); i++){
  bulbs[0] = (bulb01);
  bulbs[1] = (bulb02);
  bulbs[2] = (bulb03);
  bulbs[3] = (bulb04);
  bulbs[4] = (bulb05);
  bulbs[5] = (bulb06);
  bulbs[6] = (bulb07);
  bulbs[7] = (bulb08);
  
  //camera(300.0, -y, 400.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
}

void draw() {
  
  background(150);
  camera(mouseX, -mouseY, 400.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

  for (int i = 0; i < bulbs.length; i++) {
    pushMatrix();
    bulbs[i].updateDisplay();
    popMatrix();

    pushMatrix();
    bulbs[i].displayWave();
    popMatrix();
  }

for(int i = 0; i < actives.length ; i++){
  if(actives[i]){
    bulbs[i].updateWave();
  }
}

  noFill();
  box(scene);
  //Candle
  fill(255);
  noStroke();
  sphere(5);
  stroke(1);

}
void keyPressed() {
    if (key == 49) {
      actives[0] = true;
      bulbs[0].wave.reset();
    }
      if (key == 50) {
      actives[1] = true;
      bulbs[1].wave.reset();
    }
      if (key == 51) {
      actives[2] = true;
      bulbs[2].wave.reset();
    }
      if (key == 52) {
      actives[3] = true;
      bulbs[3].wave.reset();
    }
      if (key == 53) {
      actives[4] = true;
      bulbs[4].wave.reset();
    }
      if (key == 54) {
      actives[5] = true;
      bulbs[5].wave.reset();
    }
      if (key == 55) {
      actives[6] = true;
      bulbs[6].wave.reset();
    }
      if (key == 56) {
      actives[7] = true;
      bulbs[7].wave.reset();
    }
}