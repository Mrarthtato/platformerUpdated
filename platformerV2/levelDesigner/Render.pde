

void Render() {
    
    //prevent overscroll and nulls
    if (cam < 0) {
        cam = 0;
    }
    //render
    
    //numerate through the levelfile
    
    for (int x = cam; x < cam + levelwidth; x++) {
        for (int y = 0; y < levelfile[x].length; y++) {
            //iffile is null get out bruh dont waste cycles.
            if (levelfile[x][y] == null) {
                println("blank");
                return;
            }
            
            //iffile is not null and isnt a blank Block, then render
            if (levelfile[x][y].id != blockList[0].id) {
                stroke(0);
                // fill(levelfile[x][y].rgb);
                // make_block(x, y);
                // println("[ x = " + str(levelfile[x][y].cordx) + "]   [x actual = " + str(x) + "]");
                levelfile[x][y].render();
            }
        }
    }
    
    
    renderEntites();
    //saved text
    renderconsole();
}


void renderEntites() {
    for (entity thing : entity_list) {
        if (thing.posx > cam && thing.posx < cam + levelwidth) {
            thing.render();
        }
    }
}

void renderBlocks(int i, int j) {
    if (levelfile[i][j] == null) {
        fill(blockList[0].rgb);
    }
    if (levelfile[i][j].id != blockList[0].id) {
        fill(levelfile[i][j].rgb);
        make_block(i, j);
        
    }
    //make_block(j, i);
}

void make_block(float i, float j) {
    //real_space_cord returns where the block will be in the screen
    //then the cam * blocksize adjusts the block to be displayed at the appropiate cords.
    rect(real_space_cord(i) - (cam * blocksize), real_space_cord(j), blocksize, blocksize);
}

float real_space_cord(float x) {
    return(x * blocksize + blocksize / 2);
}
