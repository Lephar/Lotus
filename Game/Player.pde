class Player
{
  int x,y,status,direction,frame;
  float xVel, reelX, reelY; //reelX ve Y collision control icin gercek koordinat tutacak
  PImage idlel[],idler[],walkl[],walkr[],jumpl[],jumpr[];
  
  Player()
  {
    x=0;
    y=height/4; //player kaldirimda yurusun
    xVel = 0;
    frame=0;
    status=IDLE;
    direction=FORWARD;
    
    /*
      Array boyutu belirleyen degerler Game.pde classindan geliyor
    */
    idlel=new PImage[IDLE];
    idler=new PImage[IDLE];
    walkl=new PImage[WALK];
    walkr=new PImage[WALK];
    jumpl=new PImage[JUMP];
    jumpr=new PImage[JUMP];
    for(int i=0;i<IDLE;i++) (idlel[i]=loadImage("il"+i+".png")).resize(0,height/4);
    for(int i=0;i<IDLE;i++) (idler[i]=loadImage("ir"+i+".png")).resize(0,height/4);
    for(int i=0;i<WALK;i++) (walkl[i]=loadImage("wl"+i+".png")).resize(0,height/4);
    for(int i=0;i<WALK;i++) (walkr[i]=loadImage("wr"+i+".png")).resize(0,height/4);
    for(int i=0;i<JUMP;i++) (jumpl[i]=loadImage("jl"+i+".png")).resize(0,height/4);
    for(int i=0;i<JUMP;i++) (jumpr[i]=loadImage("jr"+i+".png")).resize(0,height/4);
  }
  
  void draw()
  {
    if(status==IDLE)
      if(direction==BACKWARD) image(idlel[frame/30%IDLE],x,y);
      else image(idler[frame/30%IDLE],x,y);
    else if(status==WALK)
      if(direction==BACKWARD) image(walkl[frame/3%WALK],x,y);
      else image(walkr[frame/3%WALK],x,y);
    else if(status==JUMP)
      if(direction==BACKWARD) image(jumpl[frame/4%JUMP],x,y);
      else image(jumpr[frame/4%JUMP],x,y);
    if(status==JUMP&&frame/4==JUMP)
    {
      status=IDLE;
      frame=0;
    }
    frame++;
  }
  
  void setStatus(int status)
  {
    if(this.status!=status&&this.status!=JUMP)
    {
      this.status=status;
      frame=0;
    }
  }
  
  void setDirection(int direction){this.direction=direction;}
}