class GameObject
{
  float x,y, w, h; //x = x1 (baslangic x'i, w= genislik (bilinen object icin sabit), h = yükseklik(bilinen object icin sabit)
  int objectId; //hangi object yaratilacak, bunun icin bir ID gorevi gorur
  PImage objectImage;
  
  /* nesnelerin genislik ve yükseklikleri belirlensin onceden */
  int copW = 32;
  int copY = 40;
  
  GameObject(int objectId, int x, int y)
  {
    this.x = x;
    this.objectId = objectId;
    this.y += height/3; // image'in bastirilacagi yukseklik, collision control ile alakasi yok sadece goruntu amacli
    this.w = 0;
    this.h = height/4; // player ile ayni yerde en basta, collision control bununla yapilacak
    
    
    if (objectId == 1) //cöp icin
    {
      (objectImage = loadImage("bin.png")).resize(copW,copY);
      w = objectImage.width;
      h +=objectImage.height; // objenin ilk referans yuksekligi + kendi yuksekligi = toplam yukseklik (collision kontrol icin)
    }
    /*BURASI GENISLETILECEK */
    else
    {
      (objectImage = loadImage("bin.png")).resize(64,64); // bin.png degisecek, gecici bu
      w = objectImage.width;
      h +=objectImage.height;
    } 
  }
  
  void draw()
  {
    image(objectImage,x,y);
  }
  
  /*
  float arrangeY(float y)
  {
    float diff = Math.abs(player.h-this.h);
    float retVal =  y+ (height/3);
    
    return retVal;
  }
  */
}

  
  
  