int cord(float mouse) {
    return int(mouse - (mouse % blocksize) + blocksize / 2);
}
int cordx() {
    return cord(pmouseX);
}
int cordy() {
    return cord(pmouseY);
}

PVector cord() {
    return new PVector(cordx(), cordy());
}

//calculates the nearest sqaure in an axis
float nearestSqaureAxis(float cordinate, float axis) {
    
    float cord = float(cord(cordinate));
    
    if (cord < 0) {
        return 0;
    }
    
    
    if (cord > axis - blocksize) {
        return axis - blocksize;
    }
    return cord;
}

//returns a PVector of nearest sqaure to mouse.
PVector nearestSqaureToMouse() {
    return new PVector(nearestSqaureAxis(mouseX, width), nearestSqaureAxis(mouseY, height));
}
PVector nearestSqaureToCords(PVector cords) {
    
    return new PVector(nearestSqaureAxis(cords.x, width), nearestSqaureAxis(mouseY, height));
    
}

int heights = 800;
int widths = 1600;
//levellength in blocks
int levellength = 6000;
int blocksize = (width / 50);
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
int blockListStartCord = 3;

Menu menu = new Menu();

//name, desc, r, g, b, id
Block[] blockList =
{
    new Nothing(),
        new Grass(),
        new Huh(),
        new Danger(),
        new Dirt(),
        new TextBox(),
        new Neew(),
    };

//blocklist

Block newBlock(int id) {
    
    switch(id) {
        case 1:
            return new Grass();
            //break;
            case 2:
            return new Huh();
            //break;
            case 3:
            return new Danger();
            //break;
            case 4:
            return new Dirt();
            //break;
            case 5:
            return new TextBox();
            //break;
            case 6:
            return new Neew();
            //break;
            default:
            return new Nothing();
            //break;
            
    }
    
}
void saveNewBlock(int id, int cordx, int cordy) {
    levelfile[cordx][cordy] = newBlock(id, cordx, cordy);
}

Block newBlock(int id, int cordx, int cordy) {
    
    switch(id) {
        case 1:
            return new Grass(cordx, cordy);
            //break;
            case 2:
            return new Huh(cordx, cordy);
            //break;
            case 3:
            return new Danger(cordx, cordy);
            //break;
            case 4:
            return new Dirt(cordx, cordy);
            //break;
            case 5:
            return new TextBox(cordx, cordy);
            //break;
            case 6:
            return new Neew(cordx, cordy);
            //break;
            default:
            return new Nothing(cordx, cordy);
            //break;
            
    }
    
}

Block type = blockList[1];
