
Button[] blockButtons;

//here to initializebuttons
void initializeButtonList() {

    //format thearray
    blockButtons = new Button[blockList.length];

    //make the new entries
    for (int i = 0;i < blockList.length;i++) {
        PVector actualCords = gridToCord(blockListStartCord + i, 22);
        // blockButtons[i] = new Button(blockList[i], actualCords.x, actualCords.y);
        blockButtons[i] = new Button(blockList[i], actualCords.x, height - (blocksize * 3) + height%blocksize);
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

    Boolean checkMouseCollision() {

        // checkto see if mouse cords in inside the bounds of the Button
        // assume the Block is in the middle.
        if (this.cord.x == cord().x && this.cord.y == cord().y) {
            return true;
        };
        // ifit doesnt show true then itsnot within.
        return false;

        
    };

    void render() {
        fill(menuItem.rgb);
        cube(this.cord.x,this.cord.y);
        noStroke();
    };
}
