import interfascia.*;

//Tutorial



//********
//use mouse to edit terrain, left mouse button to delete,
//hold shift for large area selection
//use the r key to store the file into the level.txt file.
//use arrow keys to navigate left and right
//up and down arrow keys change scroll speed
//the level file is then to be put into the data folder of the platformer file to load.
//*********

int heights = 800;
int widths = 1600;
//levellength in blocks
int levellength = 6000;
int blocksize;
int levelheight;
int levelwidth;

// int cordx, cordy;
int cam;
int camspeed = 2;
boolean menu_toggled = true;
int drawType = 1;



boolean backgroundrefresh = true;
String[] savefile;
String[] lines;
String[][] leveltxt;
int block_list_start_cord = 3;

void setup() {
  size(1600, 800);
  // frame.setResizable(true);
  // surface.setResizable(true);
  blocksize = (width/50);
  rectMode(CENTER);
  //load level
  load();
  // menu();
  //load menu cordx and cordy
  for(block i: block_list){
      i.menu_cordx = block_list_start_cord + (i.id-1);
      i.menu_cordy = 22;
  }

  load_interfascia();
}

void draw() {

  background(255);
  textSize(32);
  fill(52);
  text(str(camspeed), 47*blocksize, 5*blocksize);
  Render();
  if (menu_toggled == true) {
    menu();
  }
  Mouse();
}



void Render() {
  if (cam < 0) {
    cam = 0;
  }
  //render
  for (int i=0; i<levelfile.length; i++) {
    for (int j=cam; j < cam + levelwidth; j++) {
        renderBlocks(i, j);

    }
  }
  renderEntites();
  //saved text
  renderconsole();
}
void renderEntites(){
    for (entity thing : entity_list){
        if (thing.posx > cam && thing.posx < cam + levelwidth){
            thing.render();
        }
    }
}

void renderBlocks(int i, int j){
    if (levelfile[i][j] == null){
        fill(block_list[0].rgb);
    }
      if (levelfile[i][j] != block_list[0]) {
        fill(levelfile[i][j].rgb);
        make_block(j, i);
      }
}

void make_block(float j, float i){
    rect(real_space_cord(j) - (cam*blocksize), real_space_cord(i), blocksize, blocksize);
}

float real_space_cord(float x){
    return (x*blocksize+blocksize/2);
}
