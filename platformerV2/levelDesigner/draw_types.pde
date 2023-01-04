

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
    // Store the current mouse position and camera position in local variables
    int mouseX = cordx() / blocksize;
    int mouseY = cordy() / blocksize;
    int camX = cam;

    // Calculate the direction of the dragged square
    int squareDirX = (firstptx > mouseX) ? -1 : 1;
    int squareDirY = (firstpty < mouseY) ? 1 : -1;

    // Calculate the size of the square using absolute values
    int absFirstptx = fastAbs(firstptx - mouseX);
    int absFirstpty = fastAbs(firstpty - mouseY);

    // Use a single loop to iterate over the square
    for (int j = 0; j <= absFirstpty; j++) {
        for (int i = 0; i <= absFirstptx; i++) {
            // Calculate the coordinates of the current block
            int cordx = camX + firstptx + (i * squareDirX);
            int cordy = firstpty + (j * squareDirY);

            // Update the level file with the new block
            levelfile[cordx][cordy] = newBlock(eraseOrOtherwise.id, cordx, cordy);
        }
    }

    // Update the click camera position
    clickcam = camX;
}

int fastAbs(int x) {
    // Use the ternary operator to return the absolute value of x
    return(x < 0) ? - x : x;
}
