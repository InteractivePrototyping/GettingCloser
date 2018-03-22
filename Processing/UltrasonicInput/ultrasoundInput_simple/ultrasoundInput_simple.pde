

void setup(){
  size(400, 400);
  background(0);
  setupSerial();
}

void draw(){
  background(0);
  doSensorUpdate();
}