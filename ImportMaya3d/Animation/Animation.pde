JSONObject json;
JSONObject taxi;
int f;
PImage img[];
PShape body;
int x,y,t;

void setup()
{
  size(800,600,P3D);
  frameRate(60);
  imageMode(CENTER);
  json = new JSONObject();
  json.setString("taxi","taxi");
  json.setString("bank","bank");
  json.setString("bariyer","bariyer");
  json.setString("engel","engel");
  json.setString("hidrant","hidrant");
  json.setString("YellowCab","YellowCab");
  json.setString("araba","araba");
  json.setString("bin","bin");
  saveJSONObject(json, "data.json");
  json = loadJSONObject("data.json");
  taxi = json.getJSONObject("0");
  t = taxi.getInt("t");
  x = taxi.getInt("x");
  y = taxi.getInt("y");
  if(t==0)
  {
    body=loadShape("YellowCab.obj");
  }
  /*print(id);
  if(id.equals("bin")){
  body=loadShape("bin.obj");
  zoom=10;
  }
  else if(id.equals("bank")){
  body=loadShape("bank.obj");
  zoom=10;
  }
  else if(id.equals("bariyer")){
  body=loadShape("bariyer.obj");
  zoom=10;
  }
  else if(id.equals("engel")){
  body=loadShape("engel.obj");
  zoom=10;
  }
  else if(id.equals("hidrant")){
  body=loadShape("hidrant.obj");
  zoom=10;
  }
  else if(id.equals("YellowCab")){
  body=loadShape("YellowCab.obj");
  zoom=10;
  }
  else{
  body=loadShape("araba.obj");
  zoom=10;
  }*/
}

void draw()
{
  background(255);
  //translate(x,y,-zoom*100);
  translate(x,y);
  rotateZ(PI);
  //rotateX(-mouseY*2*PI/height);
  //rotateY(-mouseX*2*PI/width);
  shape(body,0,0);
  
}

void mouseWheel(MouseEvent event)
{
  int e = (int)event.getCount();
  //zoom += e;
}