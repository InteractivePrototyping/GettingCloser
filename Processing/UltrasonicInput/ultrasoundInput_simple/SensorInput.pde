import processing.serial.*;
String myString = null;
Serial myPort;  // The serial port
String lastSensorString = "";
int sensorIntReading = 0;
int lf = 10;    // Linefeed in ASCII
boolean triggered = false;

int threshold = 25;
int portNum = 2;
boolean showSensorDebug = true;

void doSensorUpdate() {
  getSensorInput();
  //is sensor reading less than my threshold?
  if (sensorIntReading < threshold) {
    triggered = true;
  } else {
    triggered = false;
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
  text(nfs(int(sensorIntReading), 3) +" cm", 20, 20);
  if (triggered) {
    text("TRIGGERED!", 20, 40);
  } else {
    text("WAITING...", 20, 60);
  }
}


//void keyPressed() {
//  if (key == ' ') {
//    // ENSURE NOBODY IN SENSOR BEAM!!!
//    // SHOULD BE POINTING AT CENTRE OF CIRCLE
//    floor = sensorIntReading;
//    String[] data = new String[1];
//    data[0] = str(floor);
//    saveStrings("floor.txt", data);
//  } else if (key == 'd') {
//    showSensorDebug = !showSensorDebug;
//  }
//}