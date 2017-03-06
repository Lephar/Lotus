import java.awt.*;
import gab.opencv.*;
import processing.video.*;

int bgx,bgy;
PImage background;
boolean up,down,left,right,space;
final int IDLE=4,WALK=12,JUMP=14,BACKWARD=-1,FORWARD=1;
ArrayList<GameObject> gameObj;
Player player;
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
  player=new Player();  
  
  (cam=new Capture(this,320,240,30)).start();
  (cv=new OpenCV(this,320,240)).loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw()
{ 
  translate(width/2,height/2);
  camera(player.x,0,(height/2.0)/tan(PI*30.0/180.0),player.x,0,0,0,1,0);
  
  image(background,background.width*(int)(-0.5+player.x/background.width),0);
  image(background,background.width*(int)(0.5+player.x/background.width),0);
  image(background,background.width*(int)(1.5+player.x/background.width),0);
  
  pushMatrix();
  translate(width/2,height/2);
  stroke(250);
  fill(0,0,255);
  rect(0,100,50,50);
  popMatrix();
  
  player.draw();
  
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
  }
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