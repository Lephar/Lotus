PImage bg;
PVector sh,pos;
PShape ch;
boolean jump;
int stat;

void settings()
{
  size(800,600,P2D);
  smooth(64);
}

void setup()
{
  frameRate(60);
  noStroke();
  //noFill();
  
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);

  bg=loadImage("background.jpg");
  bg.resize(0,height);
  pos=new PVector(0,0);
  sh=new PVector(0,20);
  jump=false;
  stat=0;
  
  ch=createShape(GROUP);
  ch.addChild(createShape(ELLIPSE,0,0,80,80));
  ch.getChild(0).setFill(color(255,0,0));
  ch.addChild(createShape(ELLIPSE,20,0,24,24));
  ch.getChild(1).setFill(color(255,255,0));
}

void draw()
{
  translate(width/2,height/2);
  
  if(keyPressed&&keyCode==LEFT)
  {
    pos.x++;
    ch.rotate(-0.036);
  }
  
  if(keyPressed&&keyCode==RIGHT)
  {
    pos.x--;
    ch.rotate(0.036);
  }
  
  if(keyPressed&&key==' ')
  {
    jump=true;
  }
  
  if(jump)
  {
    sh.y=20-40*sin(map(stat,0,30,0,PI));
    stat++;
    
    if(stat==30)
    {
      jump=false;
      sh.y=20;
      stat=0;
    }
  }
  
  pos.x=pos.x%bg.width;

  image(bg,pos.x,pos.y);
  image(bg,pos.x+bg.width,pos.y);
  image(bg,pos.x-bg.width,pos.y);
  shape(ch,sh.x,sh.y);
  text("Ziplamak icin space, hareket icin yon tuslari", 0, -height/2+40);
}

void keyPressed()
{
  if(keyCode=='0') exit();
}