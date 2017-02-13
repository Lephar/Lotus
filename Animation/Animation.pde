PImage image, idle, idleR, backGround;
PImage player[];
PVector posChar;
PVector posBg;
float xVel,yVel;

void setup()
{
  size(800,600,P3D);
  frameRate(60);
  noFill();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  
  xVel = 1.5;
  yVel = 20;
  posChar = new PVector(0,0);
  posBg = new PVector(0,0);
  player = new PImage[128];
  
  
  idle = loadImage ("idle.png");
  idleR = loadImage ("idleR.png");
  backGround = loadImage("denemefoto.png");
  // f: 0-35 = kosu
  // f: 36-64 jump
  // r: 0-35 kosu (64-99)
  // r: 36-64 jump (100-127)
  
  for(int i = 0; i < 124; i++)
  {
    if(i <= 63) image = loadImage("f" + i +".png");
    else image = loadImage("r" + (i-64) + ".png");
    image.resize(0,height/5);
    player[i] = image;
  } 
  
}

void draw ()
{
  translate(width/2,height/2);
  //image(backGround,0,0);
  image(backGround,posBg.x,posBg.y);

  
  if(!keyPressed)
  {
      idle.resize(0,height/5);
      image(idle,posChar.x,height/4);
  }

else if (keyCode == RIGHT)
  {
    posChar.x = posChar.x + xVel;
    posBg.x = posBg.x - (0.75*xVel);
    //image(backGround,posBg.x,posBg.y);
    image(player[frameCount%34],posChar.x,height/4);
  }
  else if ( keyCode == LEFT)
  {
    posChar.x = posChar.x - xVel;
    posBg.x = posBg.x + xVel;
    //image(backGround,posBg.x,posBg.y);
    image(player[64 + (frameCount%34)],posChar.x,height/4);
  }
  else if  (key == ' ')
  {
    image(player[36 + (frameCount%28)],posChar.x,height/4);
  }
  if(keyPressed) println(posChar.x);
}