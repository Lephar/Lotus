int bgx,bgy;
PImage background;
boolean up,down,left,right,space;
Player player;
final int IDLE=4,WALK=12,JUMP=14,BACKWARD=-1,FORWARD=1;

void setup()
{
  size(640,480,P3D);
  //fullScreen(P3D);
  frameRate(60);
  noSmooth();
  noStroke();
  fill(255,0,0);

  textSize(64);
  textMode(MODEL);
  textAlign(CENTER,CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  blendMode(BLEND);
  
  bgx=bgy=0;
  up=down=left=right=space=false;
  (background=loadImage("bg0.jpg")).resize(0,height);
  player=new Player();  
}

void draw()
{
  translate(width/2,height/2);
  image(background,bgx-background.width,bgy);
  image(background,bgx,bgy);
  image(background,bgx+background.width,bgy);
  player.draw();
  
  if(left)
  {
    bgx++;
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
  }
  
  if(right)
  {
    bgx--;
    player.setStatus(WALK);
    player.setDirection(FORWARD);
  }
  
  if((left&&right)||(!left&&!right)) player.setStatus(IDLE);
  
  if(space) player.setStatus(JUMP);
}

void keyPressed()
{
  if(key==' ') space=true;
  else if(keyCode==UP) up=true;
  else if(keyCode==DOWN) down=true;
  else if(keyCode==LEFT) left=true;
  else if(keyCode==RIGHT) right=true;
}

void keyReleased()
{
  if(key==' ') space=false;
  else if(keyCode==UP) up=false;
  else if(keyCode==DOWN) down=false;
  else if(keyCode==LEFT) left=false;
  else if(keyCode==RIGHT) right=false;
}