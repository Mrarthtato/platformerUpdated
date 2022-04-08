int firstptx, firstpty;
int secondptx, secondpty;



void RenderCursor() {
    fill(210,100);
    cube(nearestSqaureToMouse().x, nearestSqaureToMouse().y);
}


void mouseDragged() {
    if (menu_toggled == true) {
        if (menu.isMouseOverMenu()) {
            return;
        };
        draggingdraw();
    };
    
    draggingdraw();
    
    
}
void draggingdraw() {
    
    switch(drawType) {
        //regular
        case 1:
            drawSingle();
            break;
        case 2:
            drawDouble();
            break;
        
    };
    if (shift == true) {
        drawDouble();
    };
}
Block eraseOrOtherwise;
int clickcam;

void mousePressed() {
    
    if (mouseButton == RIGHT) {
        eraseOrOtherwise = blockList[0];
    }
    if (mouseButton == LEFT) {
        
        if (menu_toggled == true) {
            if (menu.isMouseOverMenu()) {
                menuOptions();
                return;
            } else {
                eraseOrOtherwise = type;
            }
        } else {
            eraseOrOtherwise = type;
        }
        
        
    }
    
    switch(drawType) {
        case 1:
            drawSingle();
            break;
        // case 2:
        // break;
    }
    firstptx = cord(pmouseX) / blocksize;
    firstpty = cord(pmouseY) / blocksize;
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
    switch(keyCode) {
        case SHIFT:
            shift = true;
            break;
        case LEFT:
            cam -= camspeed;
            break;
        case RIGHT:
            cam += camspeed;
            break;
        case UP:
            camspeed += 1;
            break;
        case DOWN:
            if (camspeed > 1) {
                camspeed -= 1;
            }
            break;
    };
    if (key == 'r' || key == 'R') {
        store();
    }
    if (key == 'm' || key == 'M') {
        menu_toggled = !menu_toggled;
    }
}

void keyReleased() {
    if (keyCode == SHIFT) {
        shift = false; 
    }
}

