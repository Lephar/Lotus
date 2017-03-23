class Gold
{
  int id, frame;
  float x, y, w, h;
  boolean collected;
  PImage gold[];
  
  Gold(int id, int x, int y)
  {
    this.id = id;
    w = unit*24;
    if(id==1) w *= 1.4;
    h = w;
    this.x = x*unit;
    this.y = (y+300)*unit-h;
    collected = false;
    
    frame=0;
    gold = new PImage[GOLD];
    for(int i=0; i<GOLD; i++) (gold[i] = loadImage("images/g"+i+".png")).resize(0,int(h));
  }
  
  void draw()
  { 
    if(!collected)
    {
      checkCollected();
      imageMode(CENTER);
      image(gold[(frame/2)%GOLD],x+w/2,y+h/2);
      imageMode(CORNER);
      frame++;
    }
  }
  
  void checkCollected()
  {
    if((((player.x<=x+w && player.x>=x) || (player.x+player.w>=x && player.x+player.w<=x+w))
    && ((player.y<=y+h && player.y>=y) || (player.y+player.h>=y && player.y+player.h<=y+h)))
    || (((x<player.x+player.w && x>player.x) || (x+w<player.x+player.w && x+w>player.x))
    && ((y<player.y+player.h && y>player.y) || (y+h<player.y+player.h && y+h>player.y))))
    {
      score+=id*10+10;
      collected=true;
    }
  }
}