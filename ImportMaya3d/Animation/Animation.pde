int f;
PImage img[];
PShape body;
int zoom;

void setup()
{
  size(800,600,P3D);
  frameRate(60);
  
  imageMode(CENTER);
  body=loadShape("YellowCab.obj");
  zoom=10;
}

void draw()
{
  background(255);
  translate(width/2,height/2,-zoom*100);
  rotateX(-mouseY*2*PI/height);
  rotateY(-mouseX*2*PI/width);
  shape(body,0,0);
}

void mouseWheel(MouseEvent event)
{
  int e = (int)event.getCount();
  zoom += e;
}