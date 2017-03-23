float unit;
int time, score, mode;
boolean up, down, left, right, space;
String feature[], lines[];
final int IDLE=4, WALK=12, FALL=13, JUMP=14, BACKWARD=-1, FORWARD=1, LIMIT=6, GOLD=26, BIRD=2;
ArrayList<Item> items;
ArrayList<Gold> gold;
PImage background;
Bird bird;
Player player;

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
  mode = 1;
  
  (background=loadImage("images/bg1.png")).resize(0,height);
  player=new Player();
  initObjects();
}

void initObjects()
{
  gold = new ArrayList<Gold>();
  items = new ArrayList<Item>();
  lines = loadStrings("GameData.txt");
  /*
  items.add(new Item(2,500,0));
  items.add(new Item(5,400,0));
  items.add(new Item(6,437,0));
  items.add(new Item(7,525,0));
  */
  gold.add(new Gold(300,0));
  bird = new Bird(300,0);
  
  for (int i = 0; i < lines.length; i++)
  {
    feature = lines[i].split(" ");
    items.add(new Item(Integer.parseInt(feature[0]), Integer.parseInt(feature[1]), Integer.parseInt(feature[2])));
  }
}

void initFrame()
{
  camera(player.x+player.w,height/2,(height/2.0)/tan(PI*30.0/180.0),player.x+player.w,height/2,0,0,1,0);
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
  for(int i=-1; i<16; i++) image(background,i*background.width,0);
}

void drawObjects()
{
  for(int i=0; i<items.size(); i++) items.get(i).draw();
  for(int i=0; i<gold.size(); i++) gold.get(i).draw();
  bird.draw();
}

void drawPlayer()
{
  if(left)
  {
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
    if(!leftCollision()) player.moveLeft();
  }
    
  else if(right)
  {
    player.setStatus(WALK);
    player.setDirection(FORWARD);
    if(!rightCollision()) player.moveRight();
  }
  
  if((left && right)||(!left && !right)) player.setStatus(IDLE);
  
  if(space) player.setStatus(JUMP);
  
  player.draw();
}

boolean leftCollision()
{
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