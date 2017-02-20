/*
  idle : saga bakarken sabit durus
  idleR: sola bakarken ""    ""
  isReverse: sola dogru mu gitti en son
  isIdle: duragan halde mi (ziplama icin)
  xVel : x eksenindeki hiz
  posChar: char pozisyonu
*/


PImage image, idle, idleR, backGround;
PImage player[];
PVector posChar;
PVector posBg;
float xVel,yVel;
boolean isReverse, isIdle;
boolean left,right,space;
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
  isReverse = false; //En son saga mi bakiyordu sola mi
  isIdle = false; //idle durumunda ziplama icin
  
  idle = loadImage ("idle.png");
  idleR = loadImage ("idleR.png");
  backGround = loadImage("denemefoto.png");
  // f: 0-35 = kosu
  // f: 36-64 jump
  // r: 0-35 kosu (64-99)
  // r: 36-64 jump (100-127)
  
  for(int i = 0; i < 128; i++)
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

  if(!keyPressed) // hicbirseye basili degilse idle durumda beklesin
  {
    isIdle = true;
    if(!isReverse)
    {
      idle.resize(0,height/5);
      image(idle,posChar.x,height/4);
    }
    else
    {
      idleR.resize(0,height/5);
      image(idleR,posChar.x,height/4);
    }     
  }
  else if(!space && !left && !right) // spesifik tuslar disinda birseye basili ise karakter kaybolmasin mevcut durumda gorunsun
  {
    isIdle = true;
    if(!isReverse)
    {
      idle.resize(0,height/5);
      image(idle,posChar.x,height/4);
    }
    else
    {
      idleR.resize(0,height/5);
      image(idleR,posChar.x,height/4);
    } 
  }

  if (right) //sag tus basili ise
  {
    isReverse = false; //karakter reverse yöne degil saga dogru bakiyor
    isIdle = false; //idle'da degil hareket halinde
    posChar.x = posChar.x + xVel;
    posBg.x = posBg.x - (0.75*xVel);  // ARKA PLAN HAREKETI, SONRA SILINECEK GIBI
    //image(backGround,posBg.x,posBg.y);
    if(!space) image(player[frameCount%34],posChar.x,height/4);
  }
  if (left)
  {
    isReverse = true; //karakter sola yani reverse yone bakiyor
    isIdle = false; //idle'da degil hareket halinde
    posChar.x = posChar.x - xVel;
    posBg.x = posBg.x + xVel; // ARKA PLAN HAREKETI, SONRA SILINECEK GIBI
    //image(backGround,posBg.x,posBg.y);
    if(!space) image(player[64 + (frameCount%34)],posChar.x,height/4);
  }
  if(space) //space'e basildiysa
  {
    if(!isReverse) //saga bakiyorsa
    {
      if(!isIdle) //duragan halde degilse
      {
        posChar.x += xVel;
        image(player[36 + (frameCount%28)],posChar.x,height/4);
      }
      else //idle'da ise duz ziplamasi lazim (x- ekseni sabit)
      {
        image(player[36 + (frameCount%28)],posChar.x,height/4);
      }
    }
    else
    {
      if(!isIdle) //duragan halde degilse
      {
        posChar.x -= xVel;
        image(player[100 + (frameCount%27)],posChar.x,height/4);
      }
      else //idle'da ise duz ziplamasi lazim (x- ekseni sabit)
      {
        image(player[100 + (frameCount%27)],posChar.x,height/4); 
      }    
    }
  }
  
  //if(keyPressed) println(posChar.x);
}

void keyPressed()
{
  if(keyCode == LEFT) left = true;
  if(keyCode == RIGHT) right = true;
  if(keyCode == ' ') space = true;
}

void keyReleased()
{
  if(keyCode == LEFT) left = false;
  if(keyCode == RIGHT) right = false;
  if(keyCode == ' ') space = false;
}