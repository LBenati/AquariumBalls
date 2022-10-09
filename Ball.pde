class Ball {
  //GLOBAL VARIABLES
  Vec3D loc = new Vec3D(0, 0, 0);
  Vec3D speed = new Vec3D(random(-2, 2), random(-2, 2), 0);

  Vec3D acc = new Vec3D();

  Vec3D grav = new Vec3D(0, 0.2, 0);


  //CONSTRUCTOR
  Ball(Vec3D _loc) {
    loc = _loc;
  }

  //FUNCTIONS
  void run() {
    display();
    move();
    bounce();
    //gravity();
    lineBetween();
    flock();
  }

  void flock() {
    separate(5);
    cohesion(0.001);
    align(0.1);
  }

  void align(float magnitude) {
    Vec3D steer = new Vec3D();
    int count = 0;

    for (int i = 0; i < ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);

      if (distance > 0 && distance < 40) {
        steer.addSelf(other.speed);
        count++;
      }
    }

    if (count > 0) {
      steer.scaleSelf(1.0/count);
    }

    steer.scaleSelf(magnitude);
    acc.addSelf(steer);
  }

  void cohesion(float magnitude) {
    Vec3D sum = new Vec3D();
    int count = 0;

    for (int i = 0; i < ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);

      if (distance > 0 && distance < 60) {
        sum.addSelf(other.loc);
        count++;
      }
    }

    if (count > 0) {
      sum.scaleSelf(1.0/count);
    }

    Vec3D steer = sum.sub(loc);
    steer.scaleSelf(magnitude);

    acc.addSelf(steer);
  }

  void separate(float magnitude) {
    Vec3D steer = new Vec3D();
    int count = 0;

    for (int i = 0; i < ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);

      if (distance > 0 && distance < 30) {
        Vec3D diff = loc.sub(other.loc);
        diff.normalizeTo(1.0/distance);

        steer.addSelf(diff);
        count++;
      }
    }

    if (count > 0) {
      steer.scaleSelf(1.0/count);
    }

    steer.scaleSelf(magnitude);
    acc.addSelf(steer);
  }

  void lineBetween() {
    //ballCollection

    for (int i = 0; i < ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);

      if (distance > 0 && distance < 40) {
        stroke (0, 255, 180);
        strokeWeight(0.4);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
      }
    }
  }

  void gravity() {
    speed.addSelf(grav);
  }

  void bounce() {
    if (loc.x > width) {
      speed.x = speed.x * -1;
    }
    if (loc.x < 0) {
      speed.x = speed.x * -1;
    }
    if (loc.y > height) {
      speed.y = speed.y * -1;
    }
    if (loc.y < 0) {
      speed.y = speed.y * -1;
    }
  }

  void move() {
    speed.addSelf(acc);
    speed.limit(2);

    loc.addSelf(speed);

    acc.clear();
  }

  void display() {
    stroke(0);
    ellipse(loc.x, loc.y, 10, 10);
  }
}
