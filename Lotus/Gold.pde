class Gold
{
  int frame;
  float x, y, w, h;
  PImage gold[];
  
  Gold(int x, int y)
  {
    w = unit*32;
    h = unit*32;
    this.x = x*unit;
    this.y = (y+300)*unit-h;
    
    frame=0;
    gold = new PImage[GOLD];
    for(int i=0; i<GOLD; i++) (gold[i] = loadImage("images/g"+i+".png")).resize(0,int(h));
  }
  
  void draw()
  {
    imageMode(CENTER);
    image(gold[(frame/2)%GOLD],x+w/2,y+h/2);
    imageMode(CORNER);
    frame++;
  }
}