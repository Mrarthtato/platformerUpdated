int firstptx, firstpty;
int secondptx, secondpty;
int cordx, cordy;

int cord(float mouse){
        return int(mouse - (mouse% blocksize) + blocksize/2);
}
int cordx(){
    return cord(pmouseX);
}
int cordy(){
    return cord(pmouseY);
}

void Mouse() {
        cursor_cube();
}
void cursor_cube(){
        cordx = cordx();
        cordy = cordy();

        if (cordx < 0) {
                cordx = 0;
        }
        if (cordx > width-blocksize) {
                cordx = width-blocksize;
        }
        if (cordy < 0) {
                cordy = 0;
        }
        if (cordy > height-blocksize) {
                cordy = height-blocksize;
        }
        fill(210,100);
        cube(cordx, cordy);
}


void mouseDragged() {
        switch(drawType) {
        //regular
        case 1:
                drawSingle();
                break;
        case 2:
                drawDouble();
                break;

        }
        if (shift == true) {
                drawDouble();
        }
}

block eraseOrOtherwise;
int clickcam;
void mousePressed() {

        if (mouseButton == RIGHT) {
                eraseOrOtherwise = block_list[0];
        }
        if (mouseButton == LEFT) {
                eraseOrOtherwise = type;
        }
        if (menu_toggled == true) {
                menuOptions();
        }
        switch(drawType) {
        case 1:
                drawSingle();
                break;
                // case 2:
                // break;
        }
        firstptx = cord(pmouseX)/blocksize;
        firstpty = cord(pmouseY)/blocksize;
        clickcam = cam;
}

void mouseReleased() {
        if (drawType == 2 || shift == true) {
                backgroundrefresh = true;
                drawDouble();
        }
}


void mouseWheel(MouseEvent event) {
        cam += event.getCount();
}

boolean shift = false;

void keyPressed() {
        if (keyCode == SHIFT){
            shift = true;
        }
        if (keyCode == LEFT) {
                cam -= camspeed;
        }
        if (keyCode == RIGHT) {
                cam += camspeed;
        }
        if (keyCode == UP) {
                camspeed += 1;
        }
        if (keyCode == DOWN) {
                if (camspeed > 1) {
                        camspeed -= 1;
                }
        }
        if (key == 'r') {
                store();
        }
        if (key == 'm') {
                menu_toggled = !menu_toggled;
        }
}
