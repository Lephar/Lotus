int x,y,frame,status,direction;
final int IDLE=4,WALK=12,JUMP=14,BACKWARD=-1,FORWARD=1;
PImage idlel[],idler[],walkl[],walkr[],jumpl[],jumpr[];

void settings()
{
  size(640,480);
  noSmooth();
}

void setup()
{
  frameRate(30);
  noStroke();
  noFill();

  rectMode(CENTER);
  imageMode(CENTER);
  blendMode(REPLACE);
  
  x=0;
  y=0;
  frame=0;
  status=IDLE;
  direction=FORWARD;
  
  idlel=new PImage[IDLE];
  idler=new PImage[IDLE];
  walkl=new PImage[WALK];
  walkr=new PImage[WALK];
  jumpl=new PImage[JUMP];
  jumpr=new PImage[JUMP];
  
  for(int i=0;i<IDLE;i++) idlel[i]=loadImage("il"+i+".png");
  for(int i=0;i<IDLE;i++) idler[i]=loadImage("ir"+i+".png");
  for(int i=0;i<WALK;i++) walkl[i]=loadImage("wl"+i+".png");
  for(int i=0;i<WALK;i++) walkr[i]=loadImage("wr"+i+".png");
  for(int i=0;i<JUMP;i++) jumpl[i]=loadImage("jl"+i+".png");
  for(int i=0;i<JUMP;i++) jumpr[i]=loadImage("jr"+i+".png");
  
  for(int i=0;i<IDLE;i++) idlel[i]=crop(idlel[i]);
  for(int i=0;i<IDLE;i++) idler[i]=crop(idler[i]);
  for(int i=0;i<WALK;i++) walkl[i]=crop(walkl[i]);
  for(int i=0;i<WALK;i++) walkr[i]=crop(walkr[i]);
  for(int i=0;i<JUMP;i++) jumpl[i]=crop(jumpl[i]);
  for(int i=0;i<JUMP;i++) jumpr[i]=crop(jumpr[i]);
  
  for(int i=0;i<IDLE;i++) idlel[i].save("new/il"+i+".png");
  for(int i=0;i<IDLE;i++) idler[i].save("new/ir"+i+".png");
  for(int i=0;i<WALK;i++) walkl[i].save("new/wl"+i+".png");
  for(int i=0;i<WALK;i++) walkr[i].save("new/wr"+i+".png");
  for(int i=0;i<JUMP;i++) jumpl[i].save("new/jl"+i+".png");
  for(int i=0;i<JUMP;i++) jumpr[i].save("new/jr"+i+".png");
}

PImage crop(PImage source)
{
  source.loadPixels();
  int x1=0,x2=source.width,y1=0,y2=source.height;
  
  for(int i=0;i<source.height;i++)
  {
    int alpha=0;
    
    for(int j=0;j<source.width;j++)
    {
      if(alpha(source.pixels[i*source.width+j])!=0)
      {
        alpha=1;
        break;
      }
    }
    
    if(alpha==1)
    {
      y1=i;
      break;
    }
  }
  
  for(int i=source.height-1;i>=0;i--)
  {
    int alpha=0;
    
    for(int j=0;j<source.width;j++)
    {
      if(alpha(source.pixels[i*source.width+j])!=0)
      {
        alpha=1;
        break;
      }
    }
    
    if(alpha==1)
    {
      y2=i;
      break;
    }
  }
  
  for(int i=0;i<source.width;i++)
  {
    int alpha=0;
    
    for(int j=0;j<source.height;j++)
    {
      if(alpha(source.pixels[i+j*source.width])!=0)
      {
        alpha=1;
        break;
      }
    }
    
    if(alpha==1)
    {
      x1=i;
      break;
    }
  }
  
  for(int i=source.width-1;i>=0;i--)
  {
    int alpha=0;
    
    for(int j=0;j<source.height;j++)
    {
      if(alpha(source.pixels[i+j*source.width])!=0)
      {
        alpha=1;
        break;
      }
    }
    
    if(alpha==1)
    {
      x2=i;
      break;
    }
  }
  
  return source.get(x1,y1,x2-x1,y2-y1);
}

PImage replace(PImage source)
{
  source.loadPixels();
  PImage image=createImage(source.width,source.height,ARGB);
  for(int i=0; i<source.pixels.length; i++)
    if(alpha(source.pixels[i])==0) image.pixels[i]=color(255,0,0);
    else image.pixels[i]=source.pixels[i];
  image.updatePixels();
  return image;
}

void draw()
{
  background(255);
  translate(width/2,height/2);
  
  if(status==IDLE)
    if(direction==BACKWARD) image(idlel[frame/30%IDLE],x,y);
    else image(idler[frame/30%IDLE],x,y);
  else if(status==WALK)
    if(direction==BACKWARD) image(walkl[frame/3%WALK],x,y);
    else image(walkr[frame/3%WALK],x,y);
  else if(status==JUMP)
    if(direction==BACKWARD) image(jumpl[frame/4%JUMP],x,y);
    else image(jumpr[frame/4%JUMP],x,y);
  frame++;
}

void keyPressed()
{
  if(key=='1') status=IDLE;
  else if(key=='2') status=WALK;
  else if(key=='3') status=JUMP;
  else if(key=='4') direction=FORWARD;
  else if(key=='5') direction=BACKWARD;
}