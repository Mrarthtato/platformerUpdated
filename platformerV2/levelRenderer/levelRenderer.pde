//tutorial

//*****
//to load level file, drag the level.txt file from the level designer into data folder
//to replace any of the textures, simply import in a file with the same name into the data folder
//arrow keys to scroll throught the level
//*****




float reminderx;
float remindery;
int i;
int j;
int heights = 800;
int widths = 1600;
//levellength in blocks
int levellength = 6000;
int blocksize;
int levelheight;
int levelwidth;
int[][] levelfile;
float cam;
float camspeed = 0.5;
boolean temp;
String[] savefile;
String[] lines;
PImage backdrop, dirt, grass, temppic, frame1, frame2;

void setup() {
  size(1600, 800, P2D);
  backdrop = loadImage("backdrop.jpg");
  dirt = loadImage("cobble_darker.png");
  grass = loadImage("cobble.png");
  frame1 = loadImage("vig_lighter.png");
  frame2 = loadImage("vig_darker.png");
  blocksize = (width/50);
  lines = loadStrings("level.txt");
  levelheight = int(heights/blocksize);
  levelwidth = int(widths/blocksize);
  levelfile = new int[levelheight][levellength];
  savefile = new String[levelheight];
  rectMode(CENTER);
  imageMode(CENTER);
  for (i = 0; i < levelfile.length; i++) {
    for (j = 0; j < levelfile[i].length-4; j++) {
      switch(lines[i].charAt(j+4)) {
      case 'E':
        levelfile[i][j] = 0;
        break;
      case 'G':
        levelfile[i][j] = 1;
        break;
      case 'M':
        levelfile[i][j] = 2;
        break;
      case 'P':
        levelfile[i][j] = 3;
        break;
      case 'D':
        levelfile[i][j] = 4;
        break;
      default:
        levelfile[i][j] = 0;
      }
    }
  }
  ball_setup();
}
void update_ball(float move){
    for (int x = 0; x < balls_number; x++) {
      balls_array[x].pos.x += move*blocksize;
    }

}

void draw() {
  background(backdrop);

  if (keyPressed) {
    if (keyCode == LEFT) {
      if (cam > 0) {
        cam -= camspeed;
        update_ball(camspeed);
      }
    }
    if (keyCode == RIGHT) {
      cam += camspeed;
      update_ball(camspeed*-1);
    }
  }
  textSize(32);
  Render();
  ball_draw();
  flickering();
  // rect(cam+width/2, height/2, 15, 15);
}

void flickering() {
  int random;
  random = int(random(0, 20));
  if (random == 2) {

    image(frame2, width/2, height/2, width, height);
  } else {
    image(frame1, width/2, height/2, width, height);
  }
}



void player(){

}

void Render() {
  for (i=0; i<levelheight; i++) {
    for (j=int(cam); j < int(cam) + levelwidth + 3; j++) {
      if (levelfile[i][j] != 0) {
        switch(levelfile[i][j]) {
        case 1:
          temppic = grass;
          break;
        case 2:
          temppic = grass;
          break;
        case 3:
          temppic = dirt;
          break;
        case 4:
          temppic = dirt;
          break;
        }
        image(temppic, (j*blocksize) - (cam*blocksize), i*blocksize, blocksize, blocksize);
        //rect((j*blocksize) - (cam*blocksize), i*blocksize, blocksize, blocksize);
      }
    }
  }
}
