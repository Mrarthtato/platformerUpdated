//tutorial

//******
//this is a physics demo of the collisions and physics system
//this is still WIP, but by dragging your mouse you could produce a slingshot effect that can be used to make collisions
//press space bar to create more objects at the location of your mouse.
//this is just a demo of what the physics engine is capable of once intergrated into the final product.
//******




PVector mouse_vel;
float mouse_pressx, mouse_pressy;
ball[] balls_array = new ball[500];
int balls_number = 2;
boolean havent_pressed = true;
boolean gravity = true;

void ball_setup() {
  balls_array[0] = new ball(50, new PVector(400, 400), new PVector(0, 0), 255, 255, 255, 1);
  balls_array[1] = new ball(50, new PVector(100, 400), new PVector(0, 0), 255, 0, 255, 1);
}

void mousePressed() {
  mouse_pressx = mouseX;
  mouse_pressy = mouseY;
}

void ball_draw() {
  // background (0);
  for (int x = 0; x < balls_number; x++) {
    balls_array[x].ball_to_ball(x);
    balls_array[x].collision();
    balls_array[x].phy();
    balls_array[x].render();
  }
  for (int x = 0; x < balls_number; x++) {
    if (gravity){
    balls_array[x].force = new PVector(0, -9.81/frameRate);
    }
    else{
      balls_array[x].force = new PVector(0, 0);
    }
  }

  if (mousePressed) {
    stroke(255);
    line(mouse_pressx, mouse_pressy, mouseX, mouseY);
    balls_array[0].pos.x = mouseX;
    balls_array[0].pos.y = mouseY;
    balls_array[0].vel.set(0, 0);
  }
}
void mouseReleased() {
  balls_array[0].vel.y -= mouse_pressy - mouseY;
  balls_array[0].vel.x -= mouse_pressx - mouseX;
}
void keyPressedBall() {
  if (key == ' ') {
    if (havent_pressed) {
      balls_array[balls_number] = new ball(50, new PVector(mouseX, mouseY), new PVector(0, 0), int(random(0, 255)), int(random(0, 255)), int(random(0, 255)), 1);
      balls_number += 1;
    }
    havent_pressed = false;
  }
}
void keyReleased() {
  havent_pressed = true;
}
