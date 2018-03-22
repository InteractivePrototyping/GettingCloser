

import processing.serial.*;
import processing.video.*;

Movie movie;
PGraphics offscreen;
int distance = 0;
float f = 0;
float s = 0.05;
boolean sensorless = false;
//change this to be whatever movie.duration() is. 
float lengthOfMovie=26.35;

void setup() {
  size(500, 500, P2D);

  noCursor();
  movie = new Movie(this, "growth01.mov");  
  movie.read();
  movie.play();
  movie.pause();
  noCursor();
  if (!sensorless) {
    setupSensor();
  }

  //find the length of mymovie. This will print it in the black box at the beginning of running the sketch 
   println(movie.duration());
}



void draw() {
  background(0);
  //useful infor printed to screen
  // drawStuff();

  if (movie.available() == true) {
    movie.read();
    movie.play();
  }

  //no sensor debug
  if (sensorless) {
    if (mousePressed) {
      triggered = true;
      if (sensorless) {
        triggered = false;
        if (mousePressed) {
          triggered = true;
        }
      }
    } else {
      triggered = false;
    }
  }


  if (triggered) {
    f = min(movie.duration(), f+s);
  } else {
    f = max(0, 0);
  }
  movie.jump(f);
  image(movie, 0, 0, width, height);
  
  //if sensor is plugged in
  if (!sensorless) {
    doSensorUpdate();
  }

  //looper
  if(f>lengthOfMovie){
  f=0;
  }
}

void keyPressed() {
  switch(key) {
  case ' ':
    floor = sensorIntReading;
    String[] data = new String[1];
    data[0] = str(floor);
    saveStrings("floor.txt", data);
    break;
  case 'd':
    showSensorDebug = !showSensorDebug;
    break;
  }
}