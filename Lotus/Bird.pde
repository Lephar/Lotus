class Bird
{
  int frame;
  float x, y, w, h;
  PImage bird[];
  
  Bird(int x, int y)
  {
    w = unit*42;
    h = unit*42;
    this.x = x*unit;
    this.y = (y+112)*unit-h;
    
    frame=0;
    bird = new PImage[BIRD];
    for(int i=0; i<BIRD; i++) (bird[i] = loadImage("images/b"+i+".png")).resize(int(w),int(h));
  }
  
  void draw()
  {
    image(bird[(frame/24)%BIRD],x,y);
    x+=unit;
    frame++;
  }
}