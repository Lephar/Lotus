long[] haar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=lval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=lval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=lval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=lval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  return buffer;
}

PImage rhaar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=rval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=rval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=rval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=rval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(buffer[buffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*buffer[i]/buffer[buffer.length-1]);
  image.updatePixels();
  
  return image;
}

PImage ghaar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,ARGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=gval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=gval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=gval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=gval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(buffer[buffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*buffer[i]/buffer[buffer.length-1]);
  image.updatePixels();
  
  return image;
}

PImage bhaar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=bval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=bval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=bval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=bval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(buffer[buffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*buffer[i]/buffer[buffer.length-1]);
  image.updatePixels();
  
  return image;
}

PImage lhaar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=lval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=lval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=lval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=lval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(buffer[buffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*buffer[i]/buffer[buffer.length-1]);
  image.updatePixels();
  
  return image;
}

PImage chaar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=cval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=cval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=cval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=cval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(buffer[buffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*buffer[i]/buffer[buffer.length-1]);
  image.updatePixels();
  
  return image;
}