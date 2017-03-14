class GameObject
{
  float x,y, w, h; //x = x1 (baslangic x'i, w= genislik (bilinen object icin sabit), h = yükseklik(bilinen object icin sabit)
  int objectId; //hangi object yaratilacak, bunun icin bir ID gorevi gorur
  PImage objectImage;
  
  /* nesnelerin genislik ve yükseklikleri belirlensin onceden */
  int copW = 0;
  int copY = 0;
  
  GameObject(int objectId, int x, int y)
  {
    this.x = x;
    this.objectId = objectId;
    this.y = y;
    this.w = 0;
    
    /* DENEME
    if (objectId == 0)
    {
    (objectImage = loadImage("trash.png")).resize(copW,copY);
    w = objectImage.width;
    h = objectImage.height;
    }
    */
    
    (objectImage = loadImage("tempSekil.jpg")).resize(45,45);
    w = objectImage.width;
    //h = objectImage.height;
    h = arrangeY(y);
    
  }
  void draw()
  {
    image(objectImage,x,arrangeY(y));
  }
  
  float arrangeY(float y)
  {
    float diff = Math.abs(player.h-this.h);
    float retVal =  y+ (height/4);
    
    return retVal;
  }
}

  
  
  