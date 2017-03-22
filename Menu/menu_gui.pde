GButton start_button; 
GButton exit_button; 

public void start_button(GButton source, GEvent event) {
  println("start_button");
}

public void exit_button(GButton source, GEvent event) {
  System.exit(0);
}

public void createGUI(){

  surface.setTitle("TIN-H");
  start_button = new GButton(this, 50, 100, 237, 104);
  start_button.setIcon("start.png", 1, GAlign.EAST, GAlign.LEFT, GAlign.TOP);
  start_button.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  start_button.addEventHandler(this, "start_button");
  exit_button = new GButton(this, 350, 100, 237, 104);
  exit_button.setIcon("exit.png", 1, GAlign.EAST, GAlign.LEFT, GAlign.MIDDLE);
  exit_button.setLocalColorScheme(GCScheme.RED_SCHEME);
  exit_button.addEventHandler(this, "exit_button");
}