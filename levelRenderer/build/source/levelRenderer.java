import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class levelRenderer extends PApplet {

//tutorial

//*****
//to load level file, drag the level.txt file from the level designer into data folder
//to replace any of the textures, simply import in a file with the same name into the data folder
//arrow keys to scroll throught the level
//*****




float reminderx;
float remindery;
int i;
int j;
int heights = 800;
int widths = 1600;
//levellength in blocks
int levellength = 6000;
int blocksize;
int levelheight;
int levelwidth;
int[][] levelfile;
float cam;
float camspeed = 0.5f;
boolean temp;
String[] savefile;
String[] lines;
PImage backdrop, dirt, grass, temppic, frame1, frame2;

public void setup() {
  
  backdrop = loadImage("backdrop.jpg");
  dirt = loadImage("cobble_darker.png");
  grass = loadImage("cobble.png");
  frame1 = loadImage("vig_lighter.png");
  frame2 = loadImage("vig_darker.png");
  blocksize = (width/50);
  lines = loadStrings("level.txt");
  levelheight = PApplet.parseInt(heights/blocksize);
  levelwidth = PApplet.parseInt(widths/blocksize);
  levelfile = new int[levelheight][levellength];
  savefile = new String[levelheight];
  rectMode(CENTER);
  imageMode(CENTER);
  for (i = 0; i < levelfile.length; i++) {
    for (j = 0; j < levelfile[i].length-4; j++) {
      switch(lines[i].charAt(j+4)) {
      case 'E':
        levelfile[i][j] = 0;
        break;
      case 'G':
        levelfile[i][j] = 1;
        break;
      case 'M':
        levelfile[i][j] = 2;
        break;
      case 'P':
        levelfile[i][j] = 3;
        break;
      case 'D':
        levelfile[i][j] = 4;
        break;
      default:
        levelfile[i][j] = 0;
      }
    }
  }
  ball_setup();
}
public void update_ball(float move){
    for (int x = 0; x < balls_number; x++) {
      balls_array[x].pos.x += move*blocksize;
    }

}

public void draw() {
  background(backdrop);

  if (keyPressed) {
    if (keyCode == LEFT) {
      if (cam > 0) {
        cam -= camspeed;
        update_ball(camspeed);
      }
    }
    if (keyCode == RIGHT) {
      cam += camspeed;
      update_ball(camspeed*-1);
    }
  }
  textSize(32);
  Render();
  ball_draw();
  flickering();
  // rect(cam+width/2, height/2, 15, 15);
}

public void flickering() {
  int random;
  random = PApplet.parseInt(random(0, 20));
  if (random == 2) {

    image(frame2, width/2, height/2, width, height);
  } else {
    image(frame1, width/2, height/2, width, height);
  }
}



public void player(){

}

public void Render() {
  for (i=0; i<levelheight; i++) {
    for (j=PApplet.parseInt(cam); j < PApplet.parseInt(cam) + levelwidth + 3; j++) {
      if (levelfile[i][j] != 0) {
        switch(levelfile[i][j]) {
        case 1:
          temppic = grass;
          break;
        case 2:
          temppic = grass;
          break;
        case 3:
          temppic = dirt;
          break;
        case 4:
          temppic = dirt;
          break;
        }
        image(temppic, (j*blocksize) - (cam*blocksize), i*blocksize, blocksize, blocksize);
        //rect((j*blocksize) - (cam*blocksize), i*blocksize, blocksize, blocksize);
      }
    }
  }
}
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

public void ball_setup() {
  balls_array[0] = new ball(50, new PVector(400, 400), new PVector(0, 0), 255, 255, 255, 1);
  balls_array[1] = new ball(50, new PVector(100, 400), new PVector(0, 0), 255, 0, 255, 1);
}

public void mousePressed() {
  mouse_pressx = mouseX;
  mouse_pressy = mouseY;
}

public void ball_draw() {
  // background (0);
  for (int x = 0; x < balls_number; x++) {
    balls_array[x].ball_to_ball(x);
    balls_array[x].collision();
    balls_array[x].phy();
    balls_array[x].render();
  }
  for (int x = 0; x < balls_number; x++) {
    if (gravity){
    balls_array[x].force = new PVector(0, -9.81f/frameRate);
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
public void mouseReleased() {
  balls_array[0].vel.y -= mouse_pressy - mouseY;
  balls_array[0].vel.x -= mouse_pressx - mouseX;
}
public void keyPressed() {
  if (key == ' ') {
    if (havent_pressed) {
      balls_array[balls_number] = new ball(50, new PVector(mouseX, mouseY), new PVector(0, 0), PApplet.parseInt(random(0, 255)), PApplet.parseInt(random(0, 255)), PApplet.parseInt(random(0, 255)), 1);
      balls_number += 1;
    }
    havent_pressed = false;
  }
}
public void keyReleased() {
  havent_pressed = true;
}
class ball {
  float acc = 9.81f;
  PVector pos, vel;
  float radius;
  float r, g, b;
  float mass = 1;
  PVector force, acceleration;

  boolean stop;
  ball(float r, PVector ball_pos, PVector dir, float red, float green, float blue, float m) {
    radius = r;
    pos = ball_pos;
    vel = dir;
    if (gravity) {
      force = new PVector(0, -9.81f);
    } else {
      force = new PVector(0, 0);
    }
    acceleration = new PVector(0, 0);
    r = red;
    g = green;
    b = blue;
    mass = m;
  }
  public void phy() {
    force.mult(frameRate);
    acceleration = (force.div(frameRate));
    vel.add(acceleration);
    pos.sub(vel);
  }
  public void render() {
    fill(r, g, b);
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
  }
  public void collision() {

    float decay = 1.2f;

    if (pos.y + radius/2 >= height) {
      pos.y = height - radius/2;
      //force.y += 9.81;
      force.y += -vel.y*decay;
    }
    if (pos.y - radius/2 <= 0) {
      pos.y = 0 + radius/2;
      force.y += -vel.y*decay;
    }
    if (pos.x - radius/2 <= 0 ) {
      pos.x = 0 + radius/2;
      force.x += -decay* vel.x;
    }
    if (pos.x + radius/2 >= width) {
      pos.x = width - radius/2;
      force.x += -decay * vel.x;
    }
  }
  public void ball_to_ball(int x) {
    if (balls_number > 1) {
      for (int i = x+1; i < balls_number; i++) {
        PVector difference = PVector.sub(balls_array[i].pos, pos);
        PVector supposed = difference.copy();
        if (difference.mag() < radius) {
          println("collided");
          supposed.setMag(radius);
          //balls_array[x].pos.sub(supposed.sub(difference));
          PVector momentum_resultant = PVector.add(balls_array[i].vel, vel);

          ////1 = vf1 - vf/vi1 - vi
          ////vi1 - vi * 1= vf1 - vf
          ////vi1 - vi= vf1 - vf
          ////vf1 = vi1 - vi + vf
          ////vf =  vi - vi1 + vf1)
          ////vi is local




          //local is 1
          //vel_final = vel - 1/1 * dot(a,b)/(magnatude of (pos - balls_array[i]))^2 * (pos - balls_array[i].pos);
          //vel_final = vel - 1/1 * c/(magnatude of (b) ^2 * b;
          PVector a = PVector.sub(vel, balls_array[i].vel);
          PVector b = PVector.sub(pos, balls_array[i].pos);
          float c = PVector.dot(a, b);
          float d = b.magSq();
          PVector vel_final = vel.sub(PVector.mult(b, (c/d)));
          println(b.heading());
          println(vel_final.heading());

          PVector e = PVector.sub(balls_array[i].vel, vel);
          PVector f = PVector.sub(balls_array[i].pos, pos);
          float g = PVector.dot(e, f);
          float h = f.magSq();
          PVector vel_final_2 = vel.sub(PVector.mult(f, (g/h)));

          float sine = sin(b.heading());
          float cosine = cos(b.heading());

          //float sine = sin(vel_final.heading());
          //float cosine = cos(vel_final.heading());

          //float force_temp_x = force.x;
          //float force_temp_y = force.y;
          //float force_other_x = balls_array[i].force.x;
          //float force_other_y = balls_array[i].force.y;

          force.add(PVector.sub(vel, vel_final));
          balls_array[i].force.add(PVector.sub(balls_array[i].vel, vel_final_2));

          //force.x -= sine * force_other_x * 2;
          //force.y -= cosine * force_other_y * 2;
          //balls_array[i].force.x -= -sine * force_temp_x * 2;
          //balls_array[i].force.y -= -cosine * force_temp_y * 2;







          balls_array[x].pos.sub(supposed.sub(difference));
          //println(temp_vel.mag());
        }
      }
    }
  }

  public void hit() {
    //force.mult(-1);
  }
  public void force() {
  }
}
  public void settings() {  size(1600, 800, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "levelRenderer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
