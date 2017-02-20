import processing.video.*;

long haar[];
Capture camera;

void settings()
{
  size(1280,720);
  noSmooth();
}

void setup()
{
  frameRate(30);
  noStroke();
  //noFill();
  
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  
  (camera=new Capture(this,width,height,30)).start();
}

void draw()
{
  if(camera.available()) camera.read();
  image(camera,width/2,height/2);
  haar=haar(camera);
  fill();
  rect();
  surface.setTitle(""+frameRate);
}