class GameObject
{
  float x, w, h; //x = x1 (baslangic x'i, w= genislik (bilinen object icin sabit), h = yükseklik(bilinen object icin sabit)
  int objectNum; //hangi object yaratilacak, bunun icin bir ID gorevi gorur
  PImage objectImage;
  
  GameObject(float x, int objectNum)
  {
    this.x = x;
    this.objectNum = objectNum;
  }
  
  
  //if ( objectnum == 0 ) -> bu, object araba demek. Arabanin x uzulugu 15tir(bize kalmis); y'si 10 olsun(bize kalmis);
    // w = 15;
    // h = 10;
    //image = car.png
    
    //if ( objectnum == 3 ) -> bu, object cöop demek. copun x uzulugu 5tir(bize kalmis); y'si 13 olsun(bize kalmis);
    // w = 5;
    // h = 13;
    //image = cop.png
}

  
  
  