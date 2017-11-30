//COLOR
//SMELL 
//DETAIL
//SOUND
//MOTION

//REMOVE BLUE
//REMOVE MOTION
//REMOVE DETAIL
ParticleSystem ps;

float x, y, z;
int bsize = 10;
boolean actives[] = {false, false, false, false, false, false, false, false};
int scene = 200;
boolean pause;
Bulb temp =  null;
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
  pause = true;
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

  //ORIGIN VECTOR
  ps = new ParticleSystem(0, new PVector(0, 0, 0), createShape());

  //camera(300.0, -y, 400.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
}

void draw() {

  background(150);

  // Calculate a "wind" force based on mouse horizontal position
  float dx = map(mouseX, 0, width, -0.2, 0.2);
  PVector wind = new PVector(0, 0, 0);
  ps.applyForce(wind);

  ps.run();
  
  if (pause) {
    for (int i = 0; i < 2; i++) {
      ps.addParticle();
    }
  }
  // Draw an arrow representing the wind force
  drawVector(wind, new PVector(0, -150, 0), 500);
}

// Renders a vector object 'v' as an arrow and a position 'loc'
void drawVector(PVector v, PVector loc, float scayl) {
  pushMatrix();
  float arrowsize = 4;
  // Translate to position to render vector
  translate(loc.x, loc.y);
  stroke(255);
  // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v.heading());
  // Calculate length of vector & scale it to be bigger or smaller if necessary
  float len = v.mag()*scayl;
  // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0, 0, len, 0);
  line(len, 0, len-arrowsize, +arrowsize/2);
  line(len, 0, len-arrowsize, -arrowsize/2);
  popMatrix();


  camera(mouseX, -mouseY, 400.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

  for (int i = 0; i < bulbs.length; i++) {
    pushMatrix();
    bulbs[i].updateDisplay();
    popMatrix();

    pushMatrix();
    bulbs[i].displayWave();
    popMatrix();
  }

  for (int i = 0; i < actives.length; i++) {
    if (actives[i]) {
      bulbs[i].updateWave();
    }
  }

  noFill();
  box(scene);
  //Candle
  fill(255);
  noStroke();
  //sphere(5);
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
  if (key == 57) {
    pause = !pause;
  }
}