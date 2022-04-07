

void drawSingle() {
    
    //calc the cords
    int cordx = (cordx() / blocksize) + cam;
    int cordy = cordy() / blocksize;
    
    //set the cord with a new block with cords set.
    saveNewBlock(eraseOrOtherwise.id, cordx, cordy);
    
}
int squareDirX, squareDirY;

void drawDouble() {
    
    //calc the first point
    firstptx -= (cam - clickcam);
    clickcam = cam;
    
    //determine the direction of the dragged sqaure, draggin and scrolling is put into account.
    
    //compare the points
    if (firstptx > cordx() / blocksize) {
        squareDirX = -1;
    } else {
        squareDirX = 1;
    }
    
    if (firstpty < cordy() / blocksize) {
        squareDirY = 1;
    } else {
        squareDirY = -1;
    }
    
    //using absolutevalue, we can first calculate the size of the sqaure, to make a for statment,
    //then at the end, multiply by the direction established above.
    
    if (abs((firstptx - (cordx() / blocksize))) < abs(firstpty - (cordy() / blocksize))) {
        //for all the blocks within the highlighted area...
        
        for (int j = 0; j <= abs(firstpty - (cordy() / blocksize)); j++) {
            for (int i = 0; i <= abs((firstptx - (cordx() / blocksize))); i++) {
                
                int cordx = cam + firstptx + (i * squareDirX);
                int cordy = firstpty + (j * squareDirY);
                
                saveNewBlock(eraseOrOtherwise.id, cordx, cordy);
                
            }
        }
    } else
        {
        for (int i = 0; i <=  abs((firstptx - (cordx() / blocksize))); i++) {
            for (int j = 0; j <=  abs(firstpty - (cordy() / blocksize)); j++) {
                
                int cordx = cam + firstptx + (i * squareDirX);
                int cordy = firstpty + (j * squareDirY);
                
                saveNewBlock(eraseOrOtherwise.id, cordx, cordy);
                
            }
        }
    }
}
