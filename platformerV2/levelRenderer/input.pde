void keyPressed() {
    switch(keyCode) {
        case LEFT:
            cam -= camspeed;
            update_ball(camspeed);
            break;
        case RIGHT:
            cam += camspeed;
            update_ball(camspeed *-  1);
            break;
        case UP:

            break;
        case DOWN:

            break;
    };
    keyPressedBall();
}

void mouseWheel(MouseEvent event) {
    // cam += event.getCount();
    zoomFactor += event.getCount() * 0.1;

}