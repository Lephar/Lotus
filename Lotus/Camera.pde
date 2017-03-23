void control()
{
  int index, value;
  
  if(cam.available()) cam.read();
  
  west.beginDraw();
  west.translate(west.width/2,west.height/2);
  west.rotate(-PI/6);
  west.image(cam.get(),0,0);
  west.endDraw();
  
  north.beginDraw();
  north.translate(north.width/2,north.height/2);
  north.image(cam.get(),0,0);
  north.endDraw();
  
  east.beginDraw();
  east.translate(west.width/2,west.height/2);
  east.rotate(PI/6);
  east.image(cam.get(),0,0);
  east.endDraw();
  
  if(frameCount%10==0)
  {
    neu = neg = pos = false;
    
    cv.loadImage(north.get());
    faces=cv.detect();
    
    if(faces.length>0) neu=true;
    else
    {
      cv.loadImage(west.get());
      faces=cv.detect();
    }
    
    if(!neu && faces.length>0) neg=true;
    else if(!neu)
    {
      cv.loadImage(east.get());
      faces=cv.detect();
    }
    
    if(!neu && !neg && faces.length>0) pos=true;
    
    if(neu||neg||pos)
    {
      value=0;
      index=-1;
      
      for(int i=0; i<faces.length; i++) if(value<faces[i].height)
      {
        value=faces[i].height;
        index=i;
      }
      
      face=faces[index];
    }
    
    println(neg + " " + neu + " " + pos);
  }
  
  noFill();
  stroke(255,255,0);
  strokeWeight(2);
  pushMatrix();
  translate(player.x+player.w-width/2+cam.width,0);
  scale(-1,1);
  image(cam.get(),0,0);
  if(face!=null && faces.length!=0) rect(face.x,face.y,face.width,face.height);
  left = neg;
  right = pos;
  popMatrix();
}

PImage mirror(PImage raw)
{
  raw.loadPixels();
  PImage mirror=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<mirror.width;i++) for(int j=0;j<mirror.height;j++) mirror.pixels[i+j*mirror.width]=raw.pixels[raw.width-i-1+j*raw.width];
  mirror.updatePixels();
  return mirror;
}