void setup() {
  Serial.begin(9600);
  pinMode(11, INPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  if (digitalRead(11) == HIGH) {
    digitalWrite(13, HIGH);
    Serial.println("ON");
  } else if (digitalRead(11) == LOW) {
    digitalWrite(13, LOW);
    Serial.println("OFF");
  }

}
