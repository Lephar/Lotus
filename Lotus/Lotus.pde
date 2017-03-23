import java.awt.*;
import gab.opencv.*;
import processing.video.*;

float unit;
int time, score, mode;
boolean up, down, left, right, space, shift, initialized;
boolean neg, neu, pos;
String feature[], lines[];
final int IDLE=4, WALK=12, FALL=13, JUMP=14, BACKWARD=-1, FORWARD=1, LIMIT=6, GOLD=26, BIRD=2;
ArrayList<Item> items;
ArrayList<Gold> gold;
Rectangle face, faces[];
PImage bus, flag, background;
PGraphics east, west, north;
Player player;
Capture cam;
OpenCV cv;

void settings()
{
  //fullScreen(P3D);
  size(640,480,P3D);
  noSmooth();
}

void setup()
{
  frameRate(60);
  
  unit = height/360.0;
  up = down = left = right = space = false;
  neu = neg = pos = false;
  mode = 1;
  score = 0;
  time = 180;
  initialized = false;
  
  (background = loadImage("images/bg1.png")).resize(0,height);
  image(background,0,0);
  textAlign(CENTER,CENTER);
  textSize(36*unit);
  fill(0);
  text("TIN-H\n Loading...",width/2,height/2);
}

void draw()
{
  if(!initialized) initObjects();
  
  else if(mode==0)
  {
    //drawMenu();
  }
  
  else if(mode==1)
  {
    drawBackground();
    drawObjects();
    drawPlayer();
    control();
  }
  
  else if(mode==2) drawSuccess();
  else if(mode==3) drawFailure();
}

void initObjects()
{
  textSize(16*unit);
  textAlign(CENTER);
  
  (cam=new Capture(this,320,240,15)).start();
  (cv=new OpenCV(this,cam.width,cam.height)).loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  west=createGraphics(cam.width,cam.height,P3D);
  north=createGraphics(cam.width,cam.height);
  east=createGraphics(cam.width,cam.height);
  
  west.imageMode(CENTER);
  north.imageMode(CENTER);
  east.imageMode(CENTER);
  
  (bus = loadImage("images/otobus.png")).resize(0,int(112*unit));
  (flag = loadImage("images/bayrak1.png")).resize(int(60*unit),int(120*unit));
  
  player = new Player();
  gold = new ArrayList<Gold>();
  items = new ArrayList<Item>();
  
  lines = loadStrings("GameData.txt");

  for (int i = 0; i < lines.length; i++)
  {
    feature = lines[i].split(" ");
    items.add(new Item(Integer.parseInt(feature[0]), Integer.parseInt(feature[1]), Integer.parseInt(feature[2])));
  }
  
  lines = loadStrings("GoldData.txt");

  for (int i = 0; i < lines.length; i++)
  {
    feature = lines[i].split(" ");
    gold.add(new Gold(Integer.parseInt(feature[0]), Integer.parseInt(feature[1]), Integer.parseInt(feature[2])));
  }
  
  initialized = true;
}

void drawBackground()
{
  camera(player.x+player.w,height/2,(height/2.0)/tan(PI*30.0/180.0),player.x+player.w,height/2,0,0,1,0);
  
  for(int i=-1; i<6; i++) image(background,i*background.width,0);
  image(bus,width/3-bus.width,310*unit-bus.height);
  image(flag,4250*unit,310*unit-flag.height);
  fill(255,0,0);
  text("Time: "+time,player.x+player.w-width/2+9*width/10,height/10);
  text("Score: "+score,player.x+player.w-width/2+9*width/10,2*height/10);
  if(time==0) mode=3;
  if(frameCount%60==0) time--;
}

void drawObjects()
{
  for(int i=0; i<items.size(); i++) items.get(i).draw();
  for(int i=0; i<gold.size(); i++) gold.get(i).draw();
}

void drawPlayer()
{
  if(left)
  {
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
    if(!leftCollision()) player.moveLeft();
    if(shift && !leftCollision()) player.moveLeft();
  }
    
  else if(right)
  {
    player.setStatus(WALK);
    player.setDirection(FORWARD);
    if(!rightCollision()) player.moveRight();
    if(shift && !rightCollision()) player.moveRight();
  }
  
  if((left && right)||(!left && !right)) player.setStatus(IDLE);
  
  if(space) player.setStatus(JUMP);
  
  player.draw();
}

void drawSuccess()
{
  fill(0,127,0);
  textSize(36*unit);
  text("You Win!",player.x+player.w/2,2*height/5);
  textSize(24*unit);
  text("You have collected " + score + " score in " + (180-time) + " seconds!",player.x+player.w/2,3*height/5);
}

void drawFailure()
{
  fill(0,127,0);
  textSize(36*unit);
  text("You Lost :(",player.x+player.w/2,2*height/5);
  textSize(24*unit);
  text("You have collected " + score + " score in " + 180 + " seconds.",player.x+player.w/2,3*height/5);
}

boolean leftCollision()
{
  if(player.x<=width/3) return true;
  
  boolean collision=false;
  
  for(int i=0; i<items.size(); i++)
  {
    Item item = items.get(i);
    
    if(player.x<item.x+item.w && player.x>item.x && player.y+player.h>item.y)
    {
      collision=true;
      break;
    }
  }
  
  return collision;
}

boolean rightCollision()
{
  boolean collision=false;
  
  for(int i=0; i<items.size(); i++)
  {
    Item item = items.get(i);
    
    if(player.x+player.w>item.x && player.x+player.w<item.x+item.w && player.y+player.h>item.y)
    {
      collision=true;
      break;
    }
  }
  
  if(player.x+player.w>4250*unit) mode=2;
  
  return collision;
}

void keyPressed()
{
  if(key==' ') space=true;
  else if(keyCode==UP) up=true;
  else if(keyCode==DOWN) down=true;
  else if(keyCode==LEFT) left=true;
  else if(keyCode==RIGHT) right=true;
  else if(keyCode==SHIFT) shift=true;
}
 
void keyReleased()
{
  if(key==' ') space=false;
  else if(keyCode==UP) up=false;
  else if(keyCode==DOWN) down=false;
  else if(keyCode==LEFT) left=false;
  else if(keyCode==RIGHT) right=false;
  else if(keyCode==SHIFT) shift=false;
  
}