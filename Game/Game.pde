import java.awt.*;
import gab.opencv.*;
import processing.video.*;

/* karakter yaratilmasi, hareketlerinin define edilmesi ve arka plan tanimlanmasi */
Player player;
int bgx,bgy;
PImage background;
boolean up,down,left,right,space;
final int IDLE=4,WALK=12,JUMP=14,BACKWARD=-1,FORWARD=1;

/* objelerin kendilerinin ve koordinatlarinin tanimlanmasi */
ArrayList<GameObject> gameObj; //objeleri tutan list, size = JSON'da tutulan coordinate verisi sayisi
GameObject temp;
String lines[];
int xCoord[];
int yCoord [];
int objId[];
String tempArr [];

/* goruntu isleme degiskenleri */
Capture cam;
OpenCV cv;
Rectangle faces[];
int iface,pface;

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
  lines = loadStrings("GameData.txt");
  tempArr =new String[3];
  
  player=new Player();  
  
  (cam=new Capture(this,320,240,30)).start();
  (cv=new OpenCV(this,320,240)).loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  for (int i = 0 ; i < lines.length; i++) 
    {
      tempArr = lines[i].split(" ");
      temp = new GameObject(Integer.parseInt(tempArr[0]), Integer.parseInt(tempArr[1]),Integer.parseInt(tempArr[2]));
      gameObj.add(temp);
    }
    
    /* SILINECEK */
    for (int i = 0 ; i < lines.length; i++) 
    {
      println("" + i + ": " + gameObj.get(i).objectId + " " + gameObj.get(i).x + " " + gameObj.get(i).y);
    } 
    println("player y: " + player.y + " obj y: " + gameObj.get(0).y + " obj h: " + gameObj.get(0).h); 
    /*********/
}

void draw()
{ 
  translate(width/2,height/2);
  camera(player.x,0,(height/2.0)/tan(PI*30.0/180.0),player.x,0,0,0,1,0);
  

  image(background,background.width*(int)(-0.5+player.x/background.width),0);
  image(background,background.width*(int)(0.5+player.x/background.width),0);
  image(background,background.width*(int)(1.5+player.x/background.width),0);
  
  for (int i = 0 ; i < lines.length; i++) 
   {
     gameObj.get(i).draw();
   }
   
  player.draw();
  
  if(left && !isLeftCollision())
  {
    player.x--;
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
  }
  
  if(right && !isRightCollision())
  {
    player.x++;
    player.setStatus(WALK);
    player.setDirection(FORWARD);
  }
  
  if((left && right)||(!left && !right)) player.setStatus(IDLE);
  
  if(space)
  {
    player.setStatus(JUMP);
   //player.y+=10;
  }
  
  if(cam.available()) cam.read();
  
  if(frameCount%10==0)
  {
    cv.loadImage(cam);
    faces=cv.detect();

    iface=-1;
    pface=-1;
    
    if(faces!=null && faces.length>0)
    {
      for(int i=0; i<faces.length; i++) if(pface<faces[i].width)
      {
        pface=faces[i].width;
        iface=i;
      }
      
      if(faces[iface].x*2+faces[iface].width<width/3) right=true;
      else if(faces[iface].x*2+faces[iface].width>2*width/3) left=true;
      else right=left=false;
      
      if(faces[iface].y+faces[iface].height<height/3) space=true;
      else space=false;
    }
    
    else space=right=left=false;
  }
  
  pushMatrix();
  rectMode(CORNER);
  imageMode(CORNER);
  translate(player.x-width/2+cam.width/2,-height/2);
  scale(-0.5,0.5);
  image(cam,0,0);
  noFill();
  strokeWeight(2);
  stroke(255,255,0);
  if(faces!=null) for(int i=0;i<faces.length;i++) rect(faces[i].x,faces[i].y,faces[i].width,faces[i].height);
  line(0,cam.height/2,cam.width,cam.height/2);
  line(cam.width/3,0,cam.width/3,cam.height);
  line(2*cam.width/3,0,2*cam.width/3,cam.height);
  noStroke();
  fill(255,0,0);
  if(faces!=null) for(int i=0;i<faces.length;i++) ellipse(faces[i].x+faces[i].width/2,faces[i].y+faces[i].height/2,16,16);
  noFill();
  imageMode(CENTER);
  rectMode(CENTER);
  popMatrix();
}

boolean isRightCollision()
{
  boolean val = false;
  for(int i = 0; i < gameObj.size(); i++)
  {
    if(player.x+player.w/2 >= gameObj.get(i).x-gameObj.get(i).w/2 && player.x+player.w/2 <= gameObj.get(i).x+gameObj.get(i).w/2) //X EKSENI OKEY AMA OBJENIN Y EKSENINI CEKERKEN SORUN VAR
    {
      val = true;
    }
  }
  return val;
}

boolean isLeftCollision()
{
  boolean val = false;
  for(int i = 0; i < gameObj.size(); i++)
  {
    if(player.x-player.w/2<=gameObj.get(i).x + gameObj.get(i).w/2 && player.x-player.w/2>=gameObj.get(i).x-gameObj.get(i).w/2) //X EKSENI OKEY AMA OBJENIN Y EKSENINI CEKERKEN SORUN VAR
    {
      val = true;
    }
  }
  return val;
}

/*
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
*/