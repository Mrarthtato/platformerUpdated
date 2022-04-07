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
    if (keyCode == SHIFT) {
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

void keyReleased() {
    if (keyCode == SHIFT) {
        shift = false; 
    }
}

