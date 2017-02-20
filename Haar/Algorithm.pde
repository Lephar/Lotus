long[][] haar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  
  for(int i=0; i<raw.width; i++)
    for(int j=0; j<raw.height; j++)
      if(i==0) buffer[i]=lval(raw.pixels[i]);
      else if(i<raw.width) buffer[i]=lval(raw.pixels[i])+buffer[i-1];
      else if(i%raw.width==0) buffer[i]=lval(raw.pixels[i])+buffer[i-raw.width];
      else buffer[i]=lval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
    
  return buffer;
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
  long rbuffer[]=new long[raw.pixels.length],gbuffer[]=new long[raw.pixels.length],bbuffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0)
    {
      rbuffer[i]=rval(raw.pixels[i]);
      gbuffer[i]=gval(raw.pixels[i]);
      bbuffer[i]=bval(raw.pixels[i]);
    }
    
    else if(i<raw.width)
    {
      rbuffer[i]=rval(raw.pixels[i])+rbuffer[i-1];
      gbuffer[i]=gval(raw.pixels[i])+gbuffer[i-1];
      bbuffer[i]=bval(raw.pixels[i])+bbuffer[i-1];
    }
    
    else if(i%raw.width==0)
    {
      rbuffer[i]=rval(raw.pixels[i])+rbuffer[i-raw.width];
      gbuffer[i]=gval(raw.pixels[i])+gbuffer[i-raw.width];
      bbuffer[i]=bval(raw.pixels[i])+bbuffer[i-raw.width];
    }
    
    else
    {
      rbuffer[i]=rval(raw.pixels[i])+rbuffer[i-1]+rbuffer[i-raw.width]-rbuffer[i-raw.width-1];
      gbuffer[i]=gval(raw.pixels[i])+gbuffer[i-1]+gbuffer[i-raw.width]-gbuffer[i-raw.width-1];
      bbuffer[i]=bval(raw.pixels[i])+bbuffer[i-1]+bbuffer[i-raw.width]-bbuffer[i-raw.width-1];
    }
    
  for(int i=0; i<raw.pixels.length; i++)
    if(rbuffer[rbuffer.length-1]==0||gbuffer[gbuffer.length-1]==0||bbuffer[bbuffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*rbuffer[i]/rbuffer[rbuffer.length-1],255*gbuffer[i]/gbuffer[gbuffer.length-1],255*bbuffer[i]/bbuffer[bbuffer.length-1]);
  image.updatePixels();
  
  return image;
}