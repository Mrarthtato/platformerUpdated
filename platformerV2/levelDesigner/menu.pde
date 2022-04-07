//todo make menu not specific to blocks, maybe make an extends
//todo add labels to show what each row of buttons do, eg entity or blocks/modes

class Menu {

    String toolTip = "";
    boolean hover = false;

    boolean isMouseOverMenu(){
        if (mouseY > boundingBoxTopCorner.y){
            return true;
        };
        return false;
    };

    PVector boundingBoxTopCorner = new PVector(0, 656 + 16);

    Menu() {

    }

    void render() {
        //this is the load order of the menu items
        renderMenuBackground();
        //render the cam speed
        renderCamSpeed();
        renderMap();
        renderButtons();
        //for debug tooltop enable this
        // debugToolTip();
        if (hover){
            toolTip();
        }
    }

    void renderCamSpeed(){
        text(str(camspeed), 47*blocksize, 5*blocksize);
    }

    void renderMenuBackground() {
        //make giant rectangle for background
        //todo (make mc style?)
        noStroke();
        fill(160);

        //old background render
        // rect(width / 2, real_space_cord(22), width, blocksize * 5);

        //new background based on the cords.
        rectMode(CORNERS);
        rect(boundingBoxTopCorner.x, boundingBoxTopCorner.y, width, height);
        rectMode(CENTER);


    }

    void renderButtons() {
       for (Button button : blockButtons) {

            if (type.id == button.menuItem.id) {
                stroke(0);
            };

            //check to see if button is hovered
            if (button.checkMouseCollision()) {
                hover = true;
                this.toolTip = button.menuItem.desc;

            };

            //render the button
            button.render();
        }
    }
    
    void renderMap() {
        // map position
        fill(255);
        rectMode(CORNERS);
        // rect(width / 2, height - (1 * blocksize), width - (10 * blocksize), height / 50);

        rect(
             (1 * blocksize) , height - (1 * blocksize) + 1,
            width- (1 * blocksize) , height - (1 * blocksize) - 1
            );
        rectMode(CENTER);
        cube((1 * blocksize) + cam * (0.88), height - (1 + blocksize));

    }


    void renderDrawMode() {
        //selecting draw mode
        if (drawType == 2) {
            stroke(0);
        }

        fill(0);
        cube(20 * blocksize,22 * blocksize);
        noStroke();

        // normalmode
        if (drawType == 1) {
            stroke(0);
        }
        fill(0);
        cube(21 * blocksize, 22 * blocksize);
        noStroke();
    }

    void toolTip() {
        //render a text box
        fill(0);
        rectMode(CORNERS);
        rect(mouseX,mouseY,mouseX + 140,mouseY - 20);
        rectMode(CENTER);

        //populate with text.
        fill(255);
        text(toolTip, mouseX, mouseY);
        hover = false;
    }

    void debugToolTip(){
        //put statements here
        this.toolTip = "" + nearestSqaureToMouse();
        hover = true;
    }
}

// this is called when the mouseis pressed, this processes the input.
void menuOptions() {

    //go through the block list
    for (Button i : blockButtons) {


        // println(i.checkMouseCollision());
        if (i.checkMouseCollision()) {
            type = i.menuItem;
            // println(i.menuItem.name);
        }
    }
    if (nearestSqaureToMouse().y / blocksize == 22 && nearestSqaureToMouse().x / blocksize == 47) {
        drawType = 2;
    }
    if (nearestSqaureToMouse().y / blocksize == 22 && nearestSqaureToMouse().x / blocksize == 48) {
        drawType = 1;
    }
}

Button[] blockButtons;



//here to initializebuttons
void initializeButtonList() {

    //format thearray
    blockButtons = new Button[blockList.length];

    //make the new entries
    for (int i = 0;i < blockList.length;i++) {
        PVector actualCords = gridToCord(blockListStartCord + i, 22);
        blockButtons[i] = new Button(blockList[i], actualCords.x, actualCords.y);
        // println(blockButtons[i].menuItem.name);
    }

}

//formats grid ints to actual cords on the screen.
PVector gridToCord(int x, int y) {
    return new PVector(x * blocksize + blocksize / 2, y * blocksize + blocksize / 2);
}


class Button {

    Block menuItem;
    PVector cord = new PVector();
    float buttonSize;

    Button(Block menuItem, float cordx, float cordy) {
        this.menuItem = menuItem;
        this.cord.x = cordx;
        this.cord.y = cordy;
        this.buttonSize = (width / 50);
    }

    Button(Block menuItem, float cordx, float cordy, float buttonSize) {
        this.menuItem = menuItem;
        this.cord.x = cordx;
        this.cord.y = cordy;
        this.buttonSize = buttonSize;
    }


    Boolean checkMouseCollision() {

        // checkto see if mouse cords in inside the bounds of the Button
        // assume the Block is in the middle.
        if (this.cord.x == cord().x && this.cord.y == cord().y) {
            return true;
        }
        // ifit doesnt show true then itsnot within.
        return false;
    }

    void render() {
        fill(menuItem.rgb);
        cube(this.cord.x,this.cord.y);
        noStroke();
    }
}
