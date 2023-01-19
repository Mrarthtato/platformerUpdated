//tutorial

//*****
//to load level file, drag the level.txt file from the level designer into data folder
//to replace any of the textures, simply import in a file with the same name into the data folder
//arrow keys to scroll throught the level
//*****
float cam;
float camspeed = 0.5;
boolean temp;
PImage backdrop;

void setup() {
    //size(1600, 800, P2D);
    fullScreen(P2D);
    
    rectMode(CENTER);
    imageMode(CENTER);
    initTextures();
    load();
    
    ball_setup();
}
void update_ball(float move) {
    for (int x = 0; x < balls_number; x++) {
        balls_array[x].pos.x += move * blocksize;
    }
}

void draw() {
    //background(backdrop);
    // background(255);
    scrollingBackground();
    textSize(32);
    render();
    // ball_draw();
    flickering();
    //rect(cam+width/2, height/2, 15, 15);
}

void scrollingBackground() {
    float xCord = width / 2 + cam / 3;
    float x = constrain(xCord, 0, width);
    image(backdrop, x, height / 2, width, height);
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

void render() {
    //prevent overscroll and nulls
    if (cam < 0) {
        cam = 0;
    }
    
    renderLevel();
}
float zoomFactor = 1.5;
float camY = 0;
void renderLevel() {
    //numerate through the levelfile
    //culled, only render within the screen
    //figure out where the camera is
    
    
    cam += (float(pmouseX) - width / 2) / 1000;
    camY -= (float(pmouseY) - height / 2) / 20;
    camY = constrain(camY, 0, levelfile[1].length * blocksize * zoomFactor * 2);
    println(levelfile[0].length / (blocksize * zoomFactor * 2));
    float renderWindowX = constrain(cam, 0, width);
    float renderWindowY = constrain(pmouseY - height / 2, 0, height);
    // println(renderWindowX);
    
    for (int x = int(renderWindowX); x < int(renderWindowX) + width; x++) {
        // Skip rendering for this iteration if levelfile[x] is null
        if (levelfile[x] == null) {
            continue;
        }
        //numerate through the levelfile[x]
        for (int y = 0; y < levelfile[x].length; y++) {
            // Skip rendering for this iteration if levelfile[x][y] is null or a blank block
            float posX = (renderWindowX + x * blocksize * zoomFactor) - (renderWindowX * blocksize * zoomFactor);
            float posY = camY + (y * blocksize * zoomFactor + blocksize * zoomFactor);
            if (levelfile[x][y] == 0 || (blockList[levelfile[x][y]].variations == 0)) {
                continue;
            } else{
                // Render the block
                PImage temppic = blockList[levelfile[x][y]].texture[variations[x][y]];
                float incrimentX = x - int(renderWindowX);
                
                image(temppic, posX, posY, blocksize * zoomFactor, blocksize * zoomFactor);
            }
            
            
            if (hitboxes[x][y] != 0) {
                if ((hitboxes[x][y] & 1) == 1) {
                    //up side is active
                    stroke(255, 0, 0);
                    noFill();
                    rect(posX, posY, blocksize * zoomFactor, blocksize * zoomFactor);
                }
                if ((hitboxes[x][y] & 2) == 2) {
                    // right side is active
                    stroke(0, 255, 0);
                    noFill();
                    rect(posX, posY, blocksize * zoomFactor, blocksize * zoomFactor);
                }
                if ((hitboxes[x][y] & 4) == 4) {
                    // left side is active
                    stroke(0, 0, 255);
                    noFill();
                    rect(posX, posY, blocksize * zoomFactor, blocksize * zoomFactor);
                }
                if ((hitboxes[x][y] & 8) == 8) {
                    
                    // down side is active

                }
            }
            
            
        }
    }
}



PImage frame1, frame2;
PImage[] textures;

//load initTextures before loadBlocks to load the textures and know the variation count
void initTextures() {
    frame1 = loadImage("vig_lighter.png");
    frame2 = loadImage("vig_darker.png");
    backdrop = loadImage("backdrop.jpg");
}