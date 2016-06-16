import processing.video.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
color black = color(0);
color white = color(255);
int numPixels;
int threshold = 100;
Capture video;
void setup() {
  size(640, 480); 
  strokeWeight(5);
  video = new Capture(this, width, height);
  video.start(); 
  numPixels = video.width * video.height;
  noCursor();
  smooth();
}
void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    float pixelBrightness; 
    loadPixels();
    for (int i = 0; i < numPixels; i++) {
      pixelBrightness = brightness(video.pixels[i]);
      if (pixelBrightness > threshold) {
        pixels[i] = white; 
      } 
      else { // Otherwise,
        pixels[i] = black;
      }
    }
    updatePixels();
    if (keyPressed) {
      if (key == 's'){
        threshold +=5;
      } 
      if(key == 'a'){
        threshold -=5;
      }
      if(key == 'q'){
        String filename = "line-"+millis();
        saveFrame(filename+".png");
        runScript(filename);
      }
    }
  }
}
void runScript(String filename){ 
   String commandToRun = "./convert.sh " + filename;
  File workingDir = new File(sketchPath(""));
  String returnedValues;
  try {
    Process p = Runtime.getRuntime().exec(commandToRun, null, workingDir);
    int i = p.waitFor();
    if (i == 0) {
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
      while ( (returnedValues = stdInput.readLine ()) != null) {
        println(returnedValues);
      }
    }
    else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
      while ( (returnedValues = stdErr.readLine ()) != null) {
        println(returnedValues);
      }
    }
  }
  catch (Exception e) {
    println("Error running command!");
    println(e);
    // e.printStackTrace(); // a more verbose debug, if needed
  }
}

