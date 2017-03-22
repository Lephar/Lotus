class Item
{
  int id;
  float x,y,w,h;
  PImage image;
  
  Item(int id, int x, int y)
  {
    this.id = id;
    
    if(id==0) (image = loadImage("images/bin.png")).resize(0,int(unit*52));
    else if(id==1) (image = loadImage("images/hidrant.png")).resize(0,int(unit*42));
    else if(id==2) (image = loadImage("images/bank.png")).resize(0,int(unit*48));
    else if(id==3) (image = loadImage("images/cubuk.png")).resize(0,int(unit*54));
    else if(id==4) (image = loadImage("images/bariyer.png")).resize(0,int(unit*54));
    else if(id==5) (image = loadImage("images/araba0.png")).resize(0,int(unit*43));
    else if(id==6) (image = loadImage("images/araba1.png")).resize(0,int(unit*64));
    else if(id==7) (image = loadImage("images/araba2.png")).resize(0,int(unit*42));
    //else if(id==8) (image = loadImage("images/taxi0.png")).resize(0,int(unit*64));
    //else if(id==9) (image = loadImage("images/taxi1.png")).resize(0,int(unit*64));
    //else if(id==10) (image = loadImage("images/taxi2.png")).resize(0,int(unit*64));
    
    w = image.width;
    h = image.height;
    
    this.x = x*unit;
    this.y = (y+318)*unit-h;
  }
  
  void draw()
  {
    image(image,x,y);
  }
}