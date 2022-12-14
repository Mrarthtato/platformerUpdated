

void drawSingle() {
    
    //calc the cords
    int cordx = (cordx() / blocksize) + cam;
    int cordy = cordy() / blocksize;
    
    // Avoid creating a new object if the coordinates are out of bounds
    if (cordx < 0 || cordx >= levelfile.length || cordy < 0 || cordy >= levelfile[0].length) {
        return;
    }
    
    
    //set the cord with a new block with cords set.
    levelfile[cordx][cordy] = newBlock(eraseOrOtherwise.id, cordx, cordy);
    
}
int squareDirX, squareDirY;

void drawDouble() {
    
    //calc the first point
    firstptx -= (cam - clickcam);
    clickcam = cam;
    
    //determine the direction of the dragged sqaure, draggin and scrolling is put into account.
    
    //compare the points: where is the mouse going releative to the original first point? this determines the direction
    squareDirX = (firstptx > cordx() / blocksize) ? - 1 : 1;
    squareDirY = (firstpty < cordy() / blocksize) ? 1 : - 1;
    //using absolutevalue, we can first calculate the size of the sqaure, to make a for statment,
    //then at the end, multiply by the direction established above.
    
    int absFirstptx = fastAbs((firstptx - (cordx() / blocksize)));
    int absFirstpty = fastAbs(firstpty - (cordy() / blocksize));
    
    for (int j = 0; j <= absFirstpty; j++) {
        for (int i = 0; i <= absFirstptx; i++) {
            int cordx = cam + firstptx + (i * squareDirX);
            int cordy = firstpty + (j * squareDirY);
            
            levelfile[cordx][cordy] = newBlock(eraseOrOtherwise.id, cordx, cordy);
        }
    }
}

int fastAbs(int x) {
    // Use the ternary operator to return the absolute value of x
    return(x < 0) ? - x : x;
}
