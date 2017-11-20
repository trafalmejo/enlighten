
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


  if(actives[0]){
    bulbs[0].updateWave();
  }
  if(actives[1]){
    bulbs[1].updateWave();
  }

  noFill();
  box(scene);
  //Candle
  fill(255);
  noStroke();
  sphere(5);
  stroke(1);
  waveReach();
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      actives[0] = true;
      bulbs[0].wave.reset();
    }
      if (keyCode == DOWN) {
      actives[1] = true;
      bulbs[1].wave.reset();
    }
  }
}
void waveReach() {
  for (int i = 0; i < bulbs.length; i++) {
    Bulb temp1 = bulbs[i];
    for (int j = 0; j < bulbs.length; j++) {
      Bulb temp2 =  bulbs[j];
      //Diameter of temp1 is greater than distance between center and temp2
      if (temp1.tsize > Math.sqrt(Math.pow((temp2.x - temp1.x), 2) + Math.pow((temp2.y - temp1.y), 2) + Math.pow((temp2.z - temp1.z), 2))) {
        temp2.enlighten();
      } else {
        //temp2. unlighten();
      }
    }
  }
}
void resetScene() {
  for (int i = 0; i < bulbs.length; i++) {
    bulbs[i].unlighten();
    bulbs[i].wave.reset();
  }
}
void triggerWave() {
  //temp.trigger();
  int time = millis();
  if (millis() < time + 2000)
  {
    temp.updateWave();
    time = millis();
  }
}
void mouseReleased() {
  temp = bulbs[7];
  int time = millis();
  if (millis() < time + 2000) {
    temp.updateWave();
    time = millis();
  }
}