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
color rgb;
int id;
int menu_cordx, menu_cordy;
block (String name,String desc,color rgb,int id){
        this.name = name;
        this.desc = desc;
        this.rgb = rgb;
        this.id = id;
}
void menu_tip(int cordx, int cordy){

        fill(rgb);
        cube(cordx*blocksize+blocksize/2,cordy*blocksize+blocksize/2);
        noStroke();
}

}
