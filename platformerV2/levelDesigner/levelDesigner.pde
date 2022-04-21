//import interfascia.*;

//Tutorial



//********
//use mouse to edit terrain, left mouse button to delete,
//hold shift for large area selection
//use the r key to store the file into the level.txt file.
//use arrow keys to navigate left and right
//up and down arrow keys change scroll speed
//the level file is then to be put into the data folder of the platformer file to load.
//*********

void settings(){

  fullScreen();
}

void setup() {
  // size(160, 90);
  // frame.setResizable(true);
  // surface.setResizable(true);
  blocksize = (width/50);

  //initialize menu
  menu = new Menu();
  
  rectMode(CENTER);

  //load level
  load();
  
  //init buttons
  initializeButtonList();

  //load_interfascia();
}

void draw() {

  background(255);
  textSize(32);
  fill(52);

  //render
  Render();
  
  //render menu
  if (menu_toggled == true) {
    menu.render();
  }
  
  //render cursor
  RenderCursor();
  
  
}
