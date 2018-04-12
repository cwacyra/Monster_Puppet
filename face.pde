
import oscP5.*;
OscP5 oscP5;

PImage face;
PImage maw;
// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

float x,x2,x3,x4;
float y,y2,y3,y4;
float easing = 0.5;

void setup() {
  size(640, 480);
  frameRate(30);
  
  face = loadImage("face.png");
  maw = loadImage("jaw.png");

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
}

void draw() {  
  background(255); 
  noStroke();
  if(found > 0) {
    
  //
  float targetX = posePosition.x;
  float dx = targetX - x;
  x += dx * .05;
  
  float targetY = posePosition.y;
  float dy = targetY - y;
  y += dy * .05;
  //
  float target2x = posePosition.x;
  float dx1 = target2x - x2;
  x2 += dx1 * .1;
  
  float target2y= posePosition.y;
  float dy1 = target2y - y2;
  y2 += dy1 * 0.1;
  

  fill(153, 31, 160);
  //blobs
  ellipse(x2-100, y2, 366,366);
  ellipse(x+100, y-100, 266,266);
  ellipse(x+150, y+170, 140,140);
  ellipse(x2-140, y2+180, 160,160);
  ellipse(x-110, y+180, 130,130);
  
  
  
  //
    
    translate(posePosition.x, posePosition.y);
    scale(5);
    image(face,-45,-40, width/7,height/7);
    fill(255);
    ellipse(-20, eyeLeft * -9, 20, 20);
    ellipse(20, eyeRight * -9, 20,20);
    fill(0);
    ellipse(-20, eyeLeft * -9, 5,5);
    ellipse(20, eyeRight * -9, 5,5);
    
    image(maw, -40  , 0 + mouthHeight*1.5 , width/8, height/15);
    //ellipse(0, 20, mouthWidth* 3, mouthHeight * 3);
    rectMode(CENTER);
   
    
  }
}

// OSC CALLBACK FUNCTIONS

public void found(int i) {
  println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}