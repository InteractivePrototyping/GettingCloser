/*
Test code for the Arduino Uno
Written by Tom Bonar for testing
Sensors being used for this code are the MB70X0 from MaxBotix
*/
const int pwPin1 = 3;

long sensor1, cm;

void setup () {
  Serial.begin(115200);
  pinMode(pwPin1, INPUT);
  pinMode(13,HIGH);
  digitalWrite(13,HIGH);
}

void read_sensor(){
  sensor1 = pulseIn(pwPin1, HIGH);
  cm = sensor1/58;
}


void loop () {
  read_sensor();
  printall();
  delay(100);
}

void printall(){
//  Serial.print("S1"); //comment me out if sending to Processing
//  Serial.print(" = "); //comment me out if sending to Processing
  Serial.println(cm);
//  Serial.print("cm"); //comment me out if sending to Processing
//  Serial.println();   //comment me out if sending to Processing
}
