// A simple Particle class, renders the particle as an image

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  PShape img;
  int size = 10;
  int res = 1;
  boolean in, out;

  Particle(PVector l, PShape img_) {
    acc = new PVector(0, 0, 0);
    float vx = randomGaussian()*0.7;
    float vy = randomGaussian()*0.8 - 1.0;
    float vz = randomGaussian()*0.7;

    vel = new PVector(vx, vy, vz);
    loc = l.copy();
    lifespan = 120.0;
    img = img_;
    //Started out
    in = false;
    out = false;
  }

  void run() {
    update();
    render();
  }

  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    acc.add(f);
  }  

  // Method to update position
  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 2.5;
    acc.mult(0); // clear Acceleration
    //check if it touching some bulb
    for (int i = 0; i < bulbs.length; i++) {
      //PARTICLE IS INSIDE THE BULB AND IT IS THE FIRST TIME ENTERING
      if (loc.dist(bulbs[i].position) < bulbs[i].size && !in) {
        bulbs[i].onFire();
        in = true;
        //println("contact: " + i);
      } else if (loc.dist(bulbs[i].position) < bulbs[i].size && !out) {
        bulbs[i].outFire();
        out = true;
      }
      //bulbs[i].outFire();
    }
  }

  // Method to display
  void render() {
    imageMode(CENTER);
    tint(255, lifespan);
    //image(img, loc.x, loc.y);
    // Drawing a circle instead
    //fill(255,lifespan);
    //noStroke();
    //ellipse(loc.x,loc.y,img.width,img.height);

    //SPHERE
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    //fill(255,255,255,255);
    //noStroke();
    sphereDetail(res);
    noFill();
    stroke(255,0,0
    
    );
    //sphere(size);
    ellipse(loc.x, loc.y, 2,2);
    stroke(0);
    popMatrix();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {

      for (int i = 0; i < bulbs.length; i++) {
        //println("contact: "+ i + ", "+  bulbs[i].numberParticles);

        //IF IT IS INSIDE
        if (loc.dist(bulbs[i].position) < bulbs[i].size && in && !out) {
          //println("die Inside");
          bulbs[i].outFire();
        }
      }
      return true;
    } else {

      return false;
    }
  }
}