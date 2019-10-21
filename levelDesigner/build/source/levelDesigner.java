import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import interfascia.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class levelDesigner extends PApplet {



//Tutorial



//********
//use mouse to edit terrain, left mouse button to delete,
//hold shift for large area selection
//use the r key to store the file into the level.txt file.
//use arrow keys to navigate left and right
//up and down arrow keys change scroll speed
//the level file is then to be put into the data folder of the platformer file to load.
//*********

int heights = 800;
int widths = 1600;
//levellength in blocks
int levellength = 6000;
int blocksize;
int levelheight;
int levelwidth;

// int cordx, cordy;
int cam;
int camspeed = 2;
boolean menu_toggled = true;
int drawType = 1;



boolean backgroundrefresh = true;
String[] savefile;
String[] lines;
String[][] leveltxt;
int block_list_start_cord = 3;

public void setup() {
  
  // frame.setResizable(true);
  // surface.setResizable(true);
  blocksize = (width/50);
  rectMode(CENTER);
  //load level
  load();
  // menu();
  //load menu cordx and cordy
  for(block i: block_list){
      i.menu_cordx = block_list_start_cord + (i.id-1);
      i.menu_cordy = 22;
  }

  load_interfascia();
}

public void draw() {

  background(255);
  textSize(32);
  fill(52);
  text(str(camspeed), 47*blocksize, 5*blocksize);
  Render();
  if (menu_toggled == true) {
    menu();
  }
  Mouse();
}



public void Render() {
  if (cam < 0) {
    cam = 0;
  }
  //render
  for (int i=0; i<levelfile.length; i++) {
    for (int j=cam; j < cam + levelwidth; j++) {
        renderBlocks(i, j);

    }
  }
  renderEntites();
  //saved text
  renderconsole();
}
public void renderEntites(){
    for (entity thing : entity_list){
        if (thing.posx > cam && thing.posx < cam + levelwidth){
            thing.render();
        }
    }
}

public void renderBlocks(int i, int j){
    if (levelfile[i][j] == null){
        fill(block_list[0].rgb);
    }
      if (levelfile[i][j] != block_list[0]) {
        fill(levelfile[i][j].rgb);
        make_block(j, i);
      }
}

public void make_block(float j, float i){
    rect(real_space_cord(j) - (cam*blocksize), real_space_cord(i), blocksize, blocksize);
}

public float real_space_cord(float x){
    return (x*blocksize+blocksize/2);
}
//name, desc, r, g, b, id
block[] block_list = {
        new block("void","",color(0,0,0),0),
        new block("grass","",color(76,153,0),1),
        new block("??","",color(255,255,0),2),
        new block("danger","",color(255,0,0),3),
        new block("dirt","",color(153,76,0),4),
        new block("text_box","",color(67,52,235),5),
        new block("new","",color(244,233,20),6),
};
block type = block_list[1];


class block {
String name;
String desc;
int rgb;
int id;
int menu_cordx, menu_cordy;
block (String name,String desc,int rgb,int id){
        this.name = name;
        this.desc = desc;
        this.rgb = rgb;
        this.id = id;
}
public void menu_tip(int cordx, int cordy){

        fill(rgb);
        cube(cordx*blocksize+blocksize/2,cordy*blocksize+blocksize/2);
        noStroke();
}

}
float displaySeconds;
float seconds;
String consoleMessage;
public void console(String message, float howManySeconds){
    consoleMessage = message;
    displaySeconds = seconds + howManySeconds;
}

public void renderconsole(){
    seconds += 1/frameRate;
    // println (seconds);
    if (seconds <= displaySeconds){
        fill(0);
        textSize(32);
        text(consoleMessage, 10, 30);
    }
}
public void cube(float x,float y){
        rect(x, y, blocksize, blocksize, 7);
}
int square_dirx, square_diry;

public void drawSingle() {

    levelfile[cordy()/blocksize][(cordx()/blocksize)+cam]=eraseOrOtherwise;

}

public void drawDouble() {
    firstptx -= (cam - clickcam);
    clickcam = cam;

  if (firstptx   > cordx()/blocksize) {
    square_dirx = -1;
  } else {
    square_dirx = 1;
  }
  if (firstpty < cordy()/blocksize) {
    square_diry = 1;
  } else {
    square_diry = -1;
  }
  if (abs((firstptx - (cordx()/blocksize))) < abs(firstpty - (cordy()/blocksize))) {
    for (int j = 0; j <= abs(firstpty - (cordy()/blocksize)); j++) {
      for (int i = 0; i <= abs((firstptx - (cordx()/blocksize))); i++) {
        levelfile[firstpty + (j*square_diry)][cam+firstptx+ (i * square_dirx)] = eraseOrOtherwise;
      }
    }
  } else
  {
    for (int i = 0; i <= abs((firstptx - (cordx()/blocksize))); i++) {
      for (int j = 0; j <= abs(firstpty - (cordy()/blocksize)); j++) {
        levelfile[firstpty + (j*square_diry)][cam+firstptx+ (i * square_dirx)] = eraseOrOtherwise;
      }
    }
  }
}
entity[] entity_types = {
    new text("sign", 0, 0, "message inside this box"),
    // new mob("doggo", 0, 0)

};
entity[] entity_list = {
    new text("sign", 5, 10, "message inside this box"),
    new mob("doggo", 30, 10),
    // new entity("watever", 5, 40),

};
interface behaviour{
    public void render();
}
class entity {
    String name;
    float posx, posy;

    entity(String name, float posx, float posy){
        this.name = name;
        this.posx = posx;
        this.posy = posy;
    }

    public void render(){
        fill(color(0,0,255));
        cube(posx, posy);
    }

}
class text extends entity implements behaviour{
    String message;

    text(String name, float posx, float posy,String message){
        super(name, posx, posy);
        this.message = message;
    }
    public void render(){
        fill(color(0,0,255));
        make_block(posx, posy);
    }
}
class mob extends entity implements behaviour{
    mob(String name, float posx, float posy){
        super(name, posx, posy);
    }
    public void render(){
        fill(color(0,255,255));
        make_block(posx, posy);
    }
}
int firstptx, firstpty;
int secondptx, secondpty;
int cordx, cordy;

public int cord(float mouse){
        return PApplet.parseInt(mouse - (mouse% blocksize) + blocksize/2);
}
public int cordx(){
    return cord(pmouseX);
}
public int cordy(){
    return cord(pmouseY);
}

public void Mouse() {
        cursor_cube();
}
public void cursor_cube(){
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


public void mouseDragged() {
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
public void mousePressed() {

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

public void mouseReleased() {
        if (drawType == 2 || shift == true) {
                backgroundrefresh = true;
                drawDouble();
        }
}


public void mouseWheel(MouseEvent event) {
        cam += event.getCount();
}

boolean shift = false;

public void keyPressed() {
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
block[][] levelfile;

public String[][] arrayfy(String[] raw){
        String[][] arrayfied = new String[raw.length][levelwidth];

        for (int i = 0; i < raw.length; i++) {
                arrayfied[i] = split(raw[i], "|");
        }
        return arrayfied;
}
public block[][] txt_to_block(String[][] lvltxt){
        block[][] lvldat = new block[levelheight][lvltxt[1].length];
        for (int i = 0; i < lvldat.length; i++) {
                if (i < lvltxt.length) {
                        for(int j = 0; j < lvltxt[i].length; j++) {
                                if (lvltxt[i][j] == null) {
                                        lvldat[i][j] = block_list[0];
                                } else {

                                        lvldat[i][j] = block_list[PApplet.parseInt(lvltxt[i][j])];
                                }
                        }
                } else {
                        for(int j = 0; j < lvltxt[1].length; j++) {
                                lvldat[i][j] = block_list[0];
                        }
                }
        }
        return lvldat;
}

public void load(){
        lines = loadStrings("data/level3.txt");
        levelheight = PApplet.parseInt(heights/blocksize);
        levelwidth = PApplet.parseInt(widths/blocksize);
        leveltxt = arrayfy(lines);
        levelfile = txt_to_block(leveltxt);
        // println(leveltxt[23][1]);
        // println(levelfile[23][50]);
        // store();
}
public void menu() {
  noStroke();
  fill(160);
  //menubase
  // rect(width/2, height-height/8, width, height/4);
  // rectMode(con)
  rect(width/2, real_space_cord(22), width, blocksize*5);

  fill(255);
  //map position
  rect(width/2, height-(1*blocksize), width-(10*blocksize), height/50);
  cube((5*blocksize) + cam*(0.88f), height-(1+blocksize));
  // rect(, , blocksize, blocksize, 7);

  //block_list menu

  for(block i: block_list){
      if (type == i){
          stroke(0);
      }
      i.menu_tip(block_list_start_cord+(i.id-1),22);
  }


  //rectmode
  if (drawType == 2) {
    stroke(0);
  }
  fill (0);
  cube(20*blocksize, 22*blocksize);
  noStroke();

  //normalmode
  if (drawType == 1) {
    stroke(0);
  }
  fill (0);
  cube(21*blocksize, 22*blocksize);
  noStroke();


  fill(255);
  stroke(0);
}


public void menuOptions() {

  for(block i: block_list){
      if (cordy/blocksize == i.menu_cordy && cordx/blocksize == i.menu_cordx) {
        type = i;
      }
  }
  if (cordy/blocksize == 22 && cordx/blocksize == 47) {
    drawType = 2;
  }
  if (cordy/blocksize == 22 && cordx/blocksize == 48) {
    drawType = 1;
  }
}
String[][] savelevelfile;
public void store() {
        String[] savefile = new String[levelfile.length];

        String level_name = "data/" + "level3";
        //store level
        for (int i = 0; i < levelfile.length; i++) {
                savefile[i] = "";
                for (int j = 0; j < levelfile[i].length; j++) {

                    if (levelfile[i][j] != null){
                        savefile[i] += str(levelfile[i][j].id);
                    } else {
                        savefile[i] += str(block_list[0].id);
                    }
                    savefile[i] += "|";
                }
                // print("done");
                // savefile[i] += "line";
        }
        saveStrings(level_name + ".txt", savefile);

        //store data
        String[] lvl_data = { (str(levelheight) + "|" + str(levellength))};
        saveStrings(level_name + "_data.txt", lvl_data);
        console("saved...", 3);

}
public void text_input(){
    

}
GUIController c;
IFTextField t;
IFLabel l;

public void load_interfascia(){

  c = new GUIController(this);
  t = new IFTextField("Text Field", 25, 30);
  l = new IFLabel("", 25, 70);;
  // t.setHeight(200);

  c.add(t);
  c.add(l);

  t.addActionListener(this);

}

public void actionPerformed(GUIEvent e) {
  if (e.getMessage().equals("Completed")) {
    l.setLabel(t.getValue());
  }
}
  public void settings() {  size(1600, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "levelDesigner" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
