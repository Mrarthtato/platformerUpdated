//todo make menu not specific to blocks, maybe make an extends
//todo add labels to show what each row of buttons do, eg entity or blocks/modes

class Menu {

    String toolTip = "";
    boolean hover = false;
    int backgroundHeight;
    int[] corner1;
    int[] corner2;

    boolean isMouseOverMenu(){
        if (mouseY > corner1[1] && mouseY < corner2[1]){
            if (mouseX > corner1[0] && mouseX < corner2[0]){
                return true;
            }
        }
        return false;
    };
    //default is automatically aligned to the bottom left, and is 3 high
    Menu() {
        this.corner1 = new int[] {0, height - (blocksize * 5) - height%blocksize};
        println(height);
        this.corner2 = new int[] {width, height};
    };
    //piggybacking off processing keycode constants, determine menu area.
    Menu(int alignment, int extension){
        switch(alignment){
            case LEFT:
                this.corner1 = new int[] {0,0};
                this.corner2 = new int[] {extension, height};
            break;
            case RIGHT :
                this.corner1 = new int[] {width - extension, 0};
                this.corner2 = new int[] {width, height};
            break;	
            case UP :
                this.corner1 = new int[] {0, 0};
                this.corner2 = new int[] {width, extension};
            break;
            case DOWN :
                this.corner1 = new int[] {0, height - extension};
                this.corner2 = new int[] {width, height};
            break;
        }
    };

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
        //new background based on the cords.
        rectMode(CORNERS);
        rect(corner1[0], corner1[1], corner2[0], corner2[1]);
        rectMode(CENTER);
    }

    void renderButtons() {
       for (Button button : blockButtons) {

            if (type.id == button.menuItem.id) {
                stroke(0);
            };

            //check to see if button is hovered this is in menu instead of button because of the render order.
            if (button.checkMouseCollision()) {
                println("hovering");
                hover = true;
                this.toolTip = button.menuItem.desc;
            };
            //render the button
            button.render();
        }
    };
    
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

    };


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
    };

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
    };

    void debugToolTip(){
        //put statements here
        this.toolTip = "" + nearestSqaureToMouse();
        hover = true;
    };
}

// this is called when the mouseis pressed, this processes the input.
void menuOptions() {

    //go through the block list
    for (Button i : blockButtons) {
        // println(i.checkMouseCollision());
        if (i.checkMouseCollision()) {
            type = i.menuItem;
            println(i.menuItem.name);
            break;
        }
    };
    // if (nearestSqaureToMouse().y / blocksize == 22 && nearestSqaureToMouse().x / blocksize == 47) {
    //     drawType = 2;
    // };
    // if (nearestSqaureToMouse().y / blocksize == 22 && nearestSqaureToMouse().x / blocksize == 48) {
    //     drawType = 1;
    // };
}


