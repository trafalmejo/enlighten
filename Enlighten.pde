
//COLOR
//SMELL 
//DETAIL
//SOUND
//MOTION

//REMOVE BLUE
//REMOVE MOTION
//REMOVE DETAIL


import peasy.*;
import processing.serial.*;



PeasyCam cam;
ParticleSystem ps;

//DATA FROM ARDUINO
int flameX = 0;
int flameY=0;
Serial myPort;  // Create object from Serial class
int end = 10;    // the number 10 is ASCII for linefeed (end of serial.println), later we will look for this to break up individual messages
String serial;   // declare a new string called 'serial' . A string is a sequence of characters (data type know as "char")
String [] lightSensor;
int x1, x2, y1, y2;
int xx = 0;
int yy = 0;
int offsetX;
int offsetY;

//WIND AND POSITION
float x, y, z;
float windX, windZ = 0;
float windForce = 0.05;
int bsize = 5;
boolean actives[] = {false, false, false, false, false, false, false, false};
//SCENE SIZE
int scene = 200;
boolean pause;
Bulb temp =  null;
Bulb bulbs[] = new Bulb[8];
int bright = 5;

//WAVE CANDLE
Wave wave;

byte out[] = new byte[8];

//SET PYRAMID UPSIDE DOWN
//Bulb bulb01 = new Bulb(7, -50, 7, bsize);
//Bulb bulb02 = new Bulb(7, -50, -7, bsize);
//Bulb bulb03 = new Bulb(-7, -50, -7, bsize);
//Bulb bulb04 = new Bulb(-7, -50, 7, bsize);
//Bulb bulb05 = new Bulb(-5, -40, 5, bsize);
//Bulb bulb06 = new Bulb(5, -40, -5, bsize);
//Bulb bulb07 = new Bulb(5, -40, 5, bsize);
//Bulb bulb08 = new Bulb(-5, -40, -5, bsize);
//SET PYRAMID NORMAL
//Bulb bulb01 = new Bulb(7, -40, 7, bsize);
//Bulb bulb02 = new Bulb(7, -40, -7, bsize);
//Bulb bulb03 = new Bulb(-7, -40, -7, bsize);
//Bulb bulb04 = new Bulb(-7, -40, 7, bsize);
//Bulb bulb05 = new Bulb(-5, -50, 5, bsize);
//Bulb bulb06 = new Bulb(5, -50, -5, bsize);
//Bulb bulb07 = new Bulb(5, -50, 5, bsize);
//Bulb bulb08 = new Bulb(-5, -50, -5, bsize);
//SET LINEAR
//Bulb bulb01 = new Bulb(-35, -60, 0, bsize);
//Bulb bulb02 = new Bulb(-25, -60, 0, bsize);
//Bulb bulb03 = new Bulb(-15, -60, 0, bsize);
//Bulb bulb04 = new Bulb(-5, -60, 0, bsize);
//Bulb bulb05 = new Bulb(5, -60, 0, bsize);
//Bulb bulb06 = new Bulb(15, -60, 0, bsize);
//Bulb bulb07 = new Bulb(25, -60, 0, bsize);
//Bulb bulb08 = new Bulb(35, -60, 0, bsize);
//SET LINEAR CLOSER
Bulb bulb01 = new Bulb(-28, -60, 0, bsize);
Bulb bulb02 = new Bulb(-20, -60, 0, bsize);
Bulb bulb03 = new Bulb(-12, -60, 0, bsize);
Bulb bulb04 = new Bulb(-4, -60, 0, bsize);
Bulb bulb05 = new Bulb(4, -60, 0, bsize);
Bulb bulb06 = new Bulb(12, -60, 0, bsize);
Bulb bulb07 = new Bulb(20, -60, 0, bsize);
Bulb bulb08 = new Bulb(28, -60, 0, bsize);

void settings()
{  
  size(1280, 720, P3D);
  //fullScreen(P3D);
}
void setup() {
  //for (int i = 0; i < Serial.list().length; i++) {
  //  println(Serial.list()[i]);
  //}
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);

  myPort.clear();  // function from serial library that throws out the first reading, in case we started reading in the middle of a string from Arduino
  serial = myPort.readStringUntil(end); // function that reads the string from serial port until a println and then assigns string to our string variable (called 'serial')
  serial = null; // initially, the string will be null (empty)
  offsetX = width/2;
  offsetY = height/2;


  x = width/2;
  y = height/2;
  z = 0;
  pause = false;
  wave = new Wave(0, 0, 0);
  //Dont trigger fisrt time
  wave.once= true;
  translate(x, y, z);
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
  //CAMERA SET UP
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(250);
  cam.setMaximumDistance(1500);
  //camera(300.0, -y, 400.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
}

void draw() {

  while (myPort.available() > 0) { //as long as there is data coming from serial port, read it and store it 
    serial = myPort.readStringUntil(end);
  }
  if (serial != null) {  //if the string is not empty, print the following

    /*  Note: the split function used below is not necessary if sending only a single variable. However, it is useful for parsing (separating) messages when
     reading from multiple inputs in Arduino. Below is example code for an Arduino sketch
     */

    lightSensor = split(serial, ',');  //a new array (called 'a') that stores values into separate cells (separated by commas specified in your Arduino program)
    x1 = Integer.parseInt(lightSensor[0].trim());
    y1 = Integer.parseInt(lightSensor[1].trim());
    x2 = Integer.parseInt(lightSensor[2].trim());
    y2 = Integer.parseInt(lightSensor[3].trim());
    //toArduino = Integer.parseInt(lightSensor[4].trim());
    //toArduino2 = Integer.parseInt(lightSensor[5].trim());
    //println(lightSensor[0] + "," + lightSensor[1] + "," + lightSensor[2] + "," +lightSensor[3]);
  }


  flameX = (x2 - x1);
  flameY = (y2 - y1);
  //println(flameX);
  //println(flameY);


  background(150);
  //bright = int(map(mouseX,0,1280 , 0, 60));
  // Calculate a "wind" force based on mouse horizontal position - Mouse Control
  //float dx = map(mouseX, 0, width, -0.2, 0.2);
  PVector wind = new PVector(windX, 0, windZ);
  // PVector wind = new PVector(dx, 0, 0);

  ps.applyForce(wind);

  ps.run();

  if (pause) {
    for (int i = 0; i < bright; i++) {
      ps.addParticle();
    }
  }
  // Draw an arrow representing the wind force
  //drawVector(wind, new PVector(0, -150, 0), 500);

  //camera(mouseX, -mouseY, 400.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  waveBehaviour();
  for (int i = 0; i < bulbs.length; i++) {
    pushMatrix();
    bulbs[i].updateDisplay();
    popMatrix();
  }
  noFill();
  box(scene);
  //Candle
  fill(255);
  noStroke();
  //sphere(5);
  stroke(1);
  windX=0;
  windZ=0;

  if (keyPressed) {
    if (keyCode == UP) {
      windZ -= windForce;
      //println(windZ);
    }
    if (keyCode == DOWN) {
      windZ += windForce;
    }  
    if (keyCode == LEFT) {
      windX -= windForce;
    }  
    if (keyCode == RIGHT) {
      windX += windForce;
    }
  } else {
    if (flameX < 0 && flameY < 0) {
      // windZ -= windForce;
      windX -= windForce;
    }
    if (flameX > 0 && flameY < 0) {
      // windZ -= windForce;
      windX += windForce;
    }  
    if (flameX < 0 && flameY > 0) {
      // windZ += windForce;
      windX -= windForce;
    }  
    if (flameX > 0 && flameY > 0) {
      // windZ += windForce;
      windX += windForce;
    }
  }

  //SENDING DATA TO ARDUINO
  myPort.write("a" + bulbs[0].brightness);
  myPort.write("b" + bulbs[1].brightness);
  myPort.write("c" + bulbs[2].brightness);
  myPort.write("d" + bulbs[3].brightness);
  myPort.write("e" + bulbs[4].brightness);
  myPort.write("f" + bulbs[5].brightness);
  myPort.write("g" + bulbs[6].brightness);
  myPort.write("h" + bulbs[7].brightness);



  //for (int i = 0; i < bulbs.length; i++) {
  //  if (bulbs[i]!= null) {
  //   // if (bulbs[i].brightness != 0) {
  //      out[i] = byte(bulbs[i].brightness);
  //   // } else {
  //    //  out[i] = 1;
  //   // }
  //  }
  //}
  //myPort.write(out);
  for (int i = 0; i < bulbs.length; i++) {
    print(bulbs[i].brightness + ", ");
  }
  println();
}


// Renders a vector object 'v' as an arrow and a position 'loc'
void drawVector(PVector v, PVector loc, float scayl) {
  pushMatrix();
  // Translate to position to render vector
  translate(loc.x, loc.y);
  stroke(255);
  // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v.heading());
  // Calculate length of vector & scale it to be bigger or smaller if necessary
  float len = v.mag()*scayl;
  PVector x = new PVector(v.x, 0, 0);
  PVector z = new PVector(0, 0, v.z);
  float xx = x.mag()*scayl;
  float zz = z.mag()*scayl;

  // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0, 0, 0, xx, 0, zz);
  translate(v.x, v.y, v.z);
  sphere(2);
  //line(len, 0, len-arrowsize, +arrowsize/2);
  //line(len, 0, len-arrowsize, -arrowsize/2);
  popMatrix();
}
void keyPressed() {
  //if (key == 49) {
  //  actives[0] = true;
  //  bulbs[0].wave.reset();
  //}
  //if (key == 50) {
  //  actives[1] = true;
  //  bulbs[1].wave.reset();
  //}
  //if (key == 51) {
  //  actives[2] = true;
  //  bulbs[2].wave.reset();
  //}
  //if (key == 52) {
  //  actives[3] = true;
  //  bulbs[3].wave.reset();
  //}
  //if (key == 53) {
  //  actives[4] = true;
  //  bulbs[4].wave.reset();
  //}
  //if (key == 54) {
  //  actives[5] = true;
  //  bulbs[5].wave.reset();
  //}
  //if (key == 55) {
  //  actives[6] = true;
  //  bulbs[6].wave.reset();
  //}
  //if (key == 56) {
  //  actives[7] = true;
  //  bulbs[7].wave.reset();
  //}
  if (key == 57) {
    pause = !pause;
  }
  if (key == 'p') {
    ps.addParticle();
  }
  if (key == 'o') {
    wave.reset();
  }


  //println(key);
  //println(keyCode);
}
void waveBehaviour() {
  wave.update();
  wave.display();
  //for (int i = 0; i < bulbs.length; i++) {

  //  pushMatrix();
  //  bulbs[i].displayWave();
  //  popMatrix();
  //}

  //for (int i = 0; i < actives.length; i++) {
  //  if (actives[i]) {
  //    bulbs[i].updateWave();
  //  }
  //}
}