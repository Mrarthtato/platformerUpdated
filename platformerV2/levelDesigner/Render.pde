

void Render() {
    //prevent overscroll and nulls
    if (cam < 0) {
        cam = 0;
    }
    
    //numerate through the levelfile
    for (int x = cam; x < cam + width; x++) {
        // Skip rendering for this iteration if levelfile[x] is null
        if (levelfile[x] == null) {
            continue;
        }
        
        for (int y = 0; y < levelfile[x].length; y++) {
            // Skip rendering for this iteration if levelfile[x][y] is null or a blank block
            if (levelfile[x][y] == null || levelfile[x][y].id == blockList[0].id) {
                continue;
            }
            
            stroke(0);
            levelfile[x][y].render();
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
    float x = real_space_cord(i) - (cam * blocksize);
    float y = real_space_cord(j);
    
    rect(x, y, blocksize, blocksize);
}

float real_space_cord(float x) {
    return(x * blocksize + blocksize / 2);
}
