class GameObject
{
  float x, w, h; //x = x1 (baslangic x'i, w= genislik (bilinen object icin sabit), h = yükseklik(bilinen object icin sabit)
  int objectNum; //hangi object yaratilacak, bunun icin bir ID gorevi gorur
  PImage objectImage;
  int copW = 0;
  int copY = 0;
  
  GameObject(float x, int objectNum)
  {
    this.x = x;
    this.objectNum = objectNum;
    
    if (objectNum == 0) // cöp icin
    {
    (objectImage = loadImage("trash.png")).resize(copW,copY);
    w = objectImage.width;
    h = objectImage.height;
    }
    
    /*DENEME*/
    if (objectNum == 1)
    {
     w = 30;
     h = 30;
     pushMatrix();
     translate(width/2,height/2);
     fill(255,0,0);
     rect(x,30*height/100,w,h);
     popMatrix();
    }
    
  } 
}

  
  
  