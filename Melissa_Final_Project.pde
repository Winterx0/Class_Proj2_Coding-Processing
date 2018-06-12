/**
 * Processing Sound Library, Example 1
 * 
 * Five sine waves are layered to construct a cluster of frequencies. 
 * This method is called additive synthesis. Use the mouse position 
 * inside the display window to detune the cluster.
 */

import processing.sound.*;

SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies
int numSines = 5; // Number of oscillators to use
int x = 100;
int y = 100;
int dx = 1;
PImage mouth;
PImage loli;

import processing.video.*;

Movie video;

void setup() {  
  size(800, 800);
  background(255);
   
  frameRate(30);
  video = new Movie(this, "lollio.mp4");
  video.loop();
  video.speed(1);
  video.volume(5);
  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineFreq = new float[numSines]; // Initialize array for Frequencies

  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);


    mouth = loadImage("mouth.jpg");
    loli = loadImage("loli.jpg");
  }
} 

void draw() {
  background(155, 255, 2411);
  stroke(255);
  translate(width/2, height/2);
  line(pmouseX, pmouseY, pmouseX, pmouseY);
  
   if (video.available()) {
      video.read();
    }
  pushMatrix();
  rotate(radians(90));
  image(video, 0,0, width,height);
  popMatrix();

  //Map mouseY from 0 to 1
  float yoffset = map(mouseY, 0, height, 0, 1);
  //Map mouseY logarithmically to 150 - 1150 to create a base frequency range
  float frequency = pow(1000, yoffset) + 150;
  //Use mouseX mapped from -0.5 to 0.5 as a detune argument
  float detune = map(mouseX, 0, width, -0.5, 0.5);

  for (int i = 0; i < numSines; i++) { 
    sineFreq[i] = frequency * (i + 1 * detune);
    // Set the frequencies for all oscillators
    sineWaves[i].freq(sineFreq[i]);
  }
  { 
    tint(255, 127, mouseY, mouseX);
    imageMode(CENTER);
    image(mouth, 0, 190, mouseX, mouseY);
    loadPixels();
    for (int x = 0; x < width; x++); 
    {
      float d = dist(x, y, width/2, height/2);
      int loc = x+y*width;
      pixels[loc] = color(d);
    }
  }
  updatePixels();

  if (mousePressed) {
    //background(3466);
    tint(255, 127, mouseY, mouseX); 
    image(loli, mouseX-width/2, mouseY-height/2, 200, 200);
    
    
  }
}

 // Called every time a new frame is available to read
void movieEvent(Movie video) {
  video.read();
}


void display() {
  stroke(0);
  fill(127);
  // ellipse(x, 200, mouseX, mouseY);
  imageMode(CENTER);
  image(mouth, x, y, mouseX, mouseY);
}
//void mousePressed() {
// background(3466);
// tint(255, 127, mouseY, mouseX); 
//image(loli, mouseX, mouseY, 200, 200);



//}
void keyPressed() {
  background(255, 127, 0);
  tint(255, 127, mouseY, mouseX);
  image(loli, mouseX, mouseY, 200, 200);
  line(pmouseX, pmouseY, pmouseX, pmouseY);

  //Map mouseY from 0 to 1
  float yoffset = map(mouseY, 0, height, 0, 1);
  //Map mouseY logarithmically to 150 - 1150 to create a base frequency range
  float frequency = pow(1000, yoffset) + 150;
  //Use mouseX mapped from -0.5 to 0.5 as a detune argument
  float detune = map(mouseX, 0, width, -0.5, 0.5);

  for (int i = 0; i < numSines; i++) { 
    sineFreq[i] = frequency * (i + 1 * detune);
    // Set the frequencies for all oscillators
    sineWaves[i].freq(sineFreq[i]);
  }
}