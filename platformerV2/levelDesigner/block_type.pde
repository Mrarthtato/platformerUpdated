class Block {
    String name;
    String desc;
    color rgb;
    int id;

    //cordx and cordy are the cords of the block in the array.
    int cordx, cordy;


    Block(String name, String desc, color rgb, int id) {
        this.name = name;
        this.desc = desc;
        this.rgb = rgb;
        this.id = id;
    }
    
    Block() {
        
    }
    
    void menu_tip(int cordx, int cordy) {
        fill(rgb);
        cube(cordx * blocksize + blocksize / 2, cordy * blocksize + blocksize / 2);
        noStroke();
    }
    
    void setCords(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
    }

    void render(){
        fill(this.rgb);
        //make block
        // println(cordsInRealSpace(cordx));
        rect(cordsInRealSpace(this.cordx) - camOffset(), real_space_cord(this.cordy), blocksize, blocksize); 
    }
    float cordsInRealSpace(float axisCord){
        return(axisCord * blocksize + blocksize/2);
    }
    float camOffset(){
        return(cam * blocksize);
    }


}

class Nothing extends Block {
    Nothing() {
        this.name = "void";
        this.desc = "nothing!";
        this.rgb = color(255, 255, 255);
        this.id = 0;
    }
    Nothing(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "void";
        this.desc = "nothing!";
        this.rgb = color(255, 255, 255);
        this.id = 0;
    }
    
}

class Grass extends Block {
    Grass() {
        this.name = "grass";
        this.desc = "grassy grass!";
        this.rgb = color(76, 153, 0);
        this.id = 1;
    }
    Grass(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "grass";
        this.desc = "grassy grass!";
        this.rgb = color(76, 153, 0);
        this.id = 1;
    }
}

class Huh extends Block {
    Huh() {
        this.name = "??";
        this.desc = "placeholder";
        this.rgb = color(255, 255, 0);
        this.id = 2;
    }
    Huh(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "??";
        this.desc = "";
        this.rgb = color(255, 255, 0);
        this.id = 2;
    }
}

class Danger extends Block {
    Danger() {
        this.name = "danger";
        this.desc = "dont touch it mang";
        this.rgb = color(255, 0, 0);
        this.id = 3;
    }
    Danger(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "danger";
        this.desc = "dont touch it mang";
        this.rgb = color(255, 0, 0);
        this.id = 3;
    }
}

class Dirt extends Block {
    Dirt() {
        this.name = "dirt";
        this.desc = "regular dirt";
        this.rgb = color(153, 76, 0);
        this.id = 4;
    }
    Dirt(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "dirt";
        this.desc = "regular dirt";
        this.rgb = color(153, 76, 0);
        this.id = 4;
    }
}

class TextBox extends Block {
    TextBox() {
        this.name = "text_box";
        this.desc = "a box with text";
        this.rgb = color(67, 52, 235);
        this.id = 5;
    }
    TextBox(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "text_box";
        this.desc = "a box with text";
        this.rgb = color(67, 52, 235);
        this.id = 5;
    }
}

class Neew extends Block {
    Neew() {
        this.name = "new";
        this.desc = "";
        this.rgb = color(244, 233, 20);
        this.id = 6;
    }
    Neew(int cordx, int cordy) {
        this.cordx = cordx;
        this.cordy = cordy;
        this.name = "new";
        this.desc = "";
        this.rgb = color(244, 233, 20);
        this.id = 6;
    }
}
