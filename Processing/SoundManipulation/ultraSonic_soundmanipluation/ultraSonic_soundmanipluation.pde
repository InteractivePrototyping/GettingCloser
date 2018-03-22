import processing.sound.*;

SoundFile soundfile;

void setup() {
  size(400, 400);
  background(0);
  //Load a soundfile
  soundfile = new SoundFile(this, "vibraphon.aiff");

  // These methods return useful infos about the file
  println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");

  // Play the file in a loop
  soundfile.loop();
  //sensor setup
  setupSensor();
}

void draw() {
  background(0);

  //sensor reading
  doSensorUpdate();

  // Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback 
  // speed 2 is an octave up 0.5 is an octave down.
  //  soundfile.rate(map(mouseX, 0, width, 0.25, 4.0)); 
  soundfile.rate(map(sensorIntReading, 0, 100, 0.25, 4.0)); 
  
  // Map mouseY from 0.2 to 1.0 for amplitude  
  // soundfile.amp(map(mouseY, 0, width, 0.2, 1.0));
  soundfile.amp(map(sensorIntReading, 0, 100, 0.2, 1.0));
}