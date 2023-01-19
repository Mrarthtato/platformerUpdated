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

float cam;
float camspeed = 0.5;
boolean temp;
String[] savefile;
String[] lines;
PImage backdrop, temppic;

void setup() {
    //size(1600, 800, P2D);
    fullScreen(P2D);
    
    rectMode(CENTER);
    imageMode(CENTER);
    loadBlocks();
    load();
    
    ball_setup();
}
void update_ball(float move) {
    for (int x = 0; x < balls_number; x++) {
        balls_array[x].pos.x += move * blocksize;
    }
    
}

void init() {
    blocksize = (width / 50);
    lines = loadStrings("level.txt");
    levelheight = int(heights / blocksize);
    levelwidth = int(widths / blocksize);
    levelfile = new int[levelheight][levellength];
    savefile = new String[levelheight];
    
    for (i = 0; i < levelfile.length; i++) {
        for (j = 0; j < levelfile[i].length - 4; j++) {
            switch(lines[i].charAt(j + 4)) {
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
}






void draw() {
    //background(backdrop);
    background(255);
    textSize(32);
    Render();
    // ball_draw();
    flickering();
    //rect(cam+width/2, height/2, 15, 15);
}

void flickering() {
    int random;
    random = int(random(0, 20));
    if (random == 2) {
        
        image(frame2, width / 2, height / 2, width, height);
    } else {
        image(frame1, width / 2, height / 2, width, height);
    }
}



void player() {
    
}

void Render() {
    
    
    //prevent overscroll and nulls
    if (cam < 0) {
        cam = 0;
    }
    
    // cam = 0;
    
    //numerate through the levelfile
    //culled, only render within the screen
    for (int x = int(cam); x < int(cam) + width; x++) {
        // Skip rendering for this iteration if levelfile[x] is null
        if (levelfile[x] == null) {
            continue;
        }
        //todo add variations
        for (int y = 0; y < levelfile[x].length; y++) {
            // Skip rendering for this iteration if levelfile[x][y] is null or a blank block
            if (levelfile[x][y] == 0 || (blockList[levelfile[x][y]].variations == 0)) {
                continue;
            } else{
                temppic = blockList[levelfile[x][y]].texture[variations[x][y]];
                image(temppic,(x * blocksize) - (cam * blocksize), y * blocksize + blocksize, blocksize, blocksize);
                //rect((j*blocksize) - (cam*blocksize), i*blocksize, blocksize, blocksize);
            }
        }
    }
    fill(0);
    rect(0,0,blocksize,blocksize);
}
IntDict blockIdVariations;
PImage dirt, grass, grass2, frame1, frame2, dirt2, dirt3;
PImage[] textures;

//load initTextures before loadBlocks to load the textures and know the variation count
void initTextures() {
    blockIdVariations = new IntDict();
    dirt = loadImage("dirt.png");
    dirt2 = loadImage("dirt2.png");
    dirt3 = loadImage("dirt3.png");
    blockIdVariations.set("dirt", 3);
    grass = loadImage("grass.png");
    grass2 = loadImage("grass2.png");
    blockIdVariations.set("grass", 2);
}
void loadBlocks() {
    backdrop = loadImage("backdrop.jpg");
    dirt = loadImage("dirtNew.png");
    dirt2 = loadImage("dirt2.png");
    dirt3 = loadImage("dirt3.png");
    grass = loadImage("grass.png");
    frame1 = loadImage("vig_lighter.png");
    frame2 = loadImage("vig_darker.png");
}
void loadVariation(int variations) {
    
}
