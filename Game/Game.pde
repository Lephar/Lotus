int bgx,bgy;
PImage background;
boolean up,down,left,right,space;
Player player;
ArrayList<GameObject> gameObj;
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
  (background=loadImage("bg1.png")).resize(0,height);
  gameObj = new ArrayList<GameObject>();
  player=new Player();  
  
  /* OYLESINE BIR OBJECT EKLEMESI */
  pushMatrix();
  translate(width/2,height/2);
  stroke(250);
  fill(0,0,255);
  rect(0,100,50,50);
  popMatrix();
}

void draw()
{
  translate(width/2,height/2);
  camera(player.x,0,(height/2.0)/tan(PI*30.0/180.0),player.x,0,0,0,1,0);
  
  image(background,background.width*(int)(-0.5+player.x/background.width),0);
  image(background,background.width*(int)(0.5+player.x/background.width),0);
  image(background,background.width*(int)(1.5+player.x/background.width),0);
  
  player.draw();
  
  if(keyPressed) println("bgx: " + bgx);
  if(left)
  {
    player.x--;
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
  }
  
  if(right)
  {
    player.x++;
    player.setStatus(WALK);
    player.setDirection(FORWARD);
  }
  
  if((left && right)||(!left && !right)) player.setStatus(IDLE);
  
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