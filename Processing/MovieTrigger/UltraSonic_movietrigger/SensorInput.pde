import processing.serial.*;
String myString = null;
Serial myPort;  // The serial port
String lastSensorString = "";
int sensorIntReading = 0;
int lf = 10;    // Linefeed in ASCII
boolean triggered = false;
int floor = 100;
int threshold = 25;
int portNum = 0;
boolean showSensorDebug = true;


void setupSensor() {
  String[] data = loadStrings("floor.txt");
  floor = int(data[0]);
  data = loadStrings("port.txt");
  portNum = int(data[0]);
  data = loadStrings("threshold.txt");
  threshold = int(data[0]);
  setupSerial();
}

void doSensorUpdate() {
  getSensorInput();
  //if (abs(sensorIntReading - floor) > threshold) {
    
    //is my sensor reading less than (floor minus threshold) 
    //eg floor is 100, threshold is 50. Is my sensor reading less than 50? 
  if (sensorIntReading < (floor - threshold)) {
    triggered = true;
  } else {
    triggered =  false;
  }
  if (showSensorDebug) {
    drawStuff();
  }
}

void setupSerial() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[portNum], 115200);
  myPort.clear();
  myString = myPort.readStringUntil(lf);
  myString = null;
}

void getSensorInput() {
  if (myPort.available () > 0) {
    myString = myPort.readStringUntil(lf);
    if (myString != null) {
      String s = trim(myString); // READING!!!
      if (lastSensorString.equals(s) == false) { // NEW READING!!!
        lastSensorString = s; // remember this reading
        int newSensorIntReading = int(s); // convert it to integer to be useful
        if (newSensorIntReading != -1) { // Helps avoid random false positive input
          sensorIntReading = newSensorIntReading;
        }
      }
    }
  }
}

void drawStuff() {

  textAlign(LEFT, TOP);
  textSize(18);  
  fill(255);
  text("READING: "+nfs(int(sensorIntReading), 3) +" cm", 20, 20);
  text("FLOOR: "+floor, 20, 40);
  text("THRESHOLD: "+threshold, 20, 60);

  if (triggered) {

    text("TRIGGERED!", 20, 80);

  } else {

    text("WAITING...", 20, 80);

  }
}