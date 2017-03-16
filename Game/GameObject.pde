class GameObject
{
  float x,y, w, h; //x = x1 (baslangic x'i, w= genislik (bilinen object icin sabit), h = yükseklik(bilinen object icin sabit)
  int objectId; //hangi object yaratilacak, bunun icin bir ID gorevi gorur
  PImage objectImage;
  
  GameObject(int objectId, int x, int y)
  {
    this.x = x;
    this.objectId = objectId;
    this.y += height/3; // image'in bastirilacagi yukseklik, collision control ile alakasi yok sadece goruntu amacli
    this.w = 0;
    this.h = height/4; // player ile ayni yerde en basta, collision control bununla yapilacak
    
    
    if (objectId == 1) //cöp icin
    {
      (objectImage = loadImage("bin.png")).resize(40,50);
      w = objectImage.width;
      h +=objectImage.height; // objenin ilk referans yuksekligi + kendi yuksekligi = toplam yukseklik (collision kontrol icin)
    }
    else if(objectId == 2) //hidrant icin
    {
      (objectImage = loadImage("hidrant.png")).resize(30,40);
      w = objectImage.width;
      h +=objectImage.height;
    } 
    else if(objectId == 3) //bank icin
    {
      (objectImage = loadImage("bank.png")).resize(130,50);
      w = objectImage.width;
      h +=objectImage.height;
    } 
    else if(objectId == 4) //cubuk icin
    {
      (objectImage = loadImage("bank.png")).resize(130,50);
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

  
  
  