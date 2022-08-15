import toxi.geom.*;

//DECLARE
ArrayList ballCollection;

void setup() {
  size(600, 600);
  smooth();

  //INITIALIZE
  ballCollection = new ArrayList();

  for (int i = 0; i < 500; i++) {
    Vec3D origin = new Vec3D(random(width), random(200), 0);
    Ball myBall = new Ball(origin);
    ballCollection.add(myBall);
  }
}

void draw() {
  background(0);

  //CALL FUNCTIONALITY

  for (int i = 0; i < ballCollection.size(); i++) {
    Ball mb = (Ball) ballCollection.get(i);
    mb.run();
  }
}
