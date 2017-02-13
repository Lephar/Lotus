PVector pos;
PImage ship, missile;
ArrayList<PVector> mpos;

void setup()
{
  size(800,600);
  frameRate(60);
  noSmooth();
  stroke(255);
  fill(255);
  
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(24);
  
  pos=new PVector(400,540);
  mpos=new ArrayList<PVector>();
  ship=loadImage("starship.png");
  ship.resize(80,0);
  missile=loadImage("missile.png");
  missile.resize(20,0);
}

void draw()
{
  background(0);
  for(int i=0; i<1024; i++) point(random(0,width),random(0,height));
  
  if(keyPressed)
  {
    if(keyCode==UP) pos.y-=2;
    else if(keyCode==DOWN) pos.y+=2;
    else if(keyCode==LEFT) pos.x-=2;
    else if(keyCode==RIGHT) pos.x+=2;
  }
  
  for(int i=0; i<mpos.size();  i++)
  {
    image(missile, mpos.get(i).x, mpos.get(i).y);
    mpos.get(i).y-=4;
  }
  
  for(int i=0; i<mpos.size();  i++) if(mpos.get(i).y<-20) mpos.remove(i);
  
  text("Hareket etmek icin ok tuslarini,\nates etmek icin bosluk tusunu kullanin.", width/2, 40);
  image(ship, pos.x, pos.y);
}

void keyPressed()
{
  if(key == ' ')
  {
    mpos.add(new PVector(pos.x,pos.y-20));
  }
}