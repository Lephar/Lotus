PImage image,bg;
PImage animate[];
int i;
import g4p_controls.*;


public void setup(){
  size(480, 320, JAVA2D);
  createGUI();
  customGUI();
  image=loadImage("character.png");
  animate=new PImage[72];
  for(int i=0;i<6;i++) for(int j=0;j<12;j++) 
  (animate[i*12+j]=image.get(j*165,i*292,165,292)).resize(60,0);
  // Place your setup code here
  
}

public void draw(){
  background(230);
 
  image(animate[frameCount/2%64],200,height/2);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}