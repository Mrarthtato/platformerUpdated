
Button[] blockButtons;

//here to initializebuttons
void initializeButtonList() {
    
    //format thearray
    blockButtons = new Button[blockList.length];
    
    //make the new entries
    for (int i = 0;i < blockList.length;i++) {
        PVector actualCords = gridToCord(blockListStartCord + i, 22);
        // blockButtons[i] = new Button(blockList[i], actualCords.x, actualCords.y);
        blockButtons[i] = new Button(blockList[i], actualCords.x, height - (blocksize * 3) + height % blocksize);
        // println(blockButtons[i].menuItem.name);
    };
};

class Button {
    
    Block menuItem;
    PVector cord = new PVector();
    float buttonSize;
    
    Button(Block menuItem, float cordx, float cordy) {
        this.menuItem = menuItem;
        this.cord.x = cordx;
        this.cord.y = cordy;
        this.buttonSize = (width / 50);
    };
    
    Button(Block menuItem, float cordx, float cordy, float buttonSize) {
        this.menuItem = menuItem;
        this.cord.x = cordx;
        this.cord.y = cordy;
        this.buttonSize = buttonSize;
    };
    
    float[] corner1 = new float[2];
    float[] corner2 = new float[2];
    
    
    Boolean checkMouseCollision() {
        
        // checkto see if mouse cords in inside the bounds of the Button
        // assume the Block is in the middle.
        
        //pre compute blocksize/2
        int halfBlockSize = blocksize / 2;
        //calculate the corners
        corner1[0] = this.cord.x - halfBlockSize;
        corner1[1] = this.cord.y - halfBlockSize;
        corner2[0] = this.cord.x + halfBlockSize;
        corner2[1] = this.cord.y + halfBlockSize;
        //check to see if mouse is inside the bounds of the box, if not, return false.
        return mouseX > corner1[0] && mouseX < corner2[0] && mouseY > corner1[1] && mouseY < corner2[1];
    }
    
    
    void render() {
        fill(menuItem.rgb);
        cube(this.cord.x,this.cord.y);
        noStroke();
        
        if (this.checkMouseCollision()) {
            fill(210,100);
            cube(this.cord.x, this.cord.y);
        }
    };
}
