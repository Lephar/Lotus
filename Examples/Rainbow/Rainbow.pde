float r,g,b,t;

void setup()
{
  fullScreen(P2D);
  strokeWeight(1);
  frameRate(60);
  smooth(32);
  
  t=0;
}

void draw()
{
  for(float i=0; i<width; i++)
  {
    r = sin(t+2*PI*i/width)*127+128;
    g = sin(t+2*PI*i/width+2*PI/3)*127+128;
    b = sin(t+2*PI*i/width+4*PI/3)*127+128;
    stroke(r,g,b);
    line(i,0,i,height);
  }
  
  t+=0.01;
}