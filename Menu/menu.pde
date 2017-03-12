PImage image,bg;
PImage animate[];
int i;
import g4p_controls.*;
import processing.sound.*;
SoundFile file;

public void setup(){
  size(480, 320, JAVA2D);
  createGUI();
  image=loadImage("character.png");
  animate=new PImage[72];
  for(int i=0;i<6;i++) for(int j=0;j<12;j++) 
  (animate[i*12+j]=image.get(j*165,i*292,165,292)).resize(60,0);
  bg=loadImage("denemefoto.jpg");
  bg.resize(1000,height);
  file = new SoundFile(this, "fon_music.mp3");
  file.play();
  file.rate(0.5);
  file.loop();
  i=0;
}

public void draw(){
  background(230);
  image(bg,i,0);
  image(bg,i+bg.width,0);
  image(animate[frameCount/2%64],200,height/2);
 
  i--;
  if(i<=-1000)
    i=0;
}