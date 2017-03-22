float unit;
int time, score, mode;
boolean up, down, left, right, space;
String feature[], lines[];
final int IDLE=4, WALK=12, FALL=13, JUMP=14, BACKWARD=-1, FORWARD=1, LIMIT=6;
PImage background;
ArrayList<Item> items;

Player player;

void settings()
{
  fullScreen(P3D);
  //size(640,480);
  noSmooth();
}

void setup()
{
  frameRate(60);
  unit = height/360.0;
  up = down = left = right = space = false;
  mode = 1;
  
  (background=loadImage("images/bg1.png")).resize(0,height);
  player=new Player();
  initObjects();
}

void initObjects()
{
  items = new ArrayList<Item>();
  lines = loadStrings("GameData.txt");
  
  for (int i = 0; i < lines.length; i++)
  {
    feature = lines[i].split(" ");
    //items.add(new Item(Integer.parseInt(tempArr[0]), Integer.parseInt(tempArr[1]), Integer.parseInt(tempArr[2])));
    items.add(new Item(2,430,0));
  }
}

void initFrame()
{
  camera(player.x, height/2, (height/2.0)/tan(PI*30.0/180.0), player.x, height/2, 0, 0, 1, 0);
}

void draw()
{
  if(mode==0)
  {
    //drawMenu();
  }
  
  else if(mode==1)
  {
    //score();
    //detect();
    initFrame();
    drawBackground();
    drawObjects();
    drawPlayer();
  }
  
  else if(mode==2)
  {
    //drawFinish();
  }
}

void drawBackground()
{
  image(background,0,0);
  image(background,background.width,0);
  image(background,-background.width,0);
}

void drawObjects()
{
  for(int i=0; i<items.size(); i++) items.get(i).draw();
}

void drawPlayer()
{
  if(left)
  {
    if(!leftCollision()) player.moveLeft();
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
  }
    
  else if(right)
  {
    if(!rightCollision()) player.moveRight();
    player.setStatus(WALK);
    player.setDirection(FORWARD);
  }
  
  if((left && right)||(!left && !right)) player.setStatus(IDLE);
  
  if (space)
  {
    player.setStatus(JUMP);
  }
  
  player.draw();
}

boolean leftCollision()
{
  boolean collision=false;
  
  for(int i=0; i<items.size(); i++)
  {
    Item item = items.get(i);
    
    if(player.x<item.x+item.w+unit*4 && player.x>item.x && player.y+player.h>item.y)
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
    
    if(player.x+player.w>item.x-unit*4 && player.x+player.w<item.x+item.w && player.y+player.h>item.y)
    {
      collision=true;
      break;
    }
  }
  
  return collision;
}

void mouseClicked()
{
  println(player.x + " " + items.get(0).x);
  println((player.x+player.w) + " " + (items.get(0).x+items.get(0).w));
  println(mouseX + " " + mouseY);
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