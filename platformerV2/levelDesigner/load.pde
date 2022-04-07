Block[][] levelfile;

String[][] arrayfy(String[] raw) {
    //the text file is in the form of lines of id values.
    //each line is the elements in a x row.
    
    String[][] arrayfied = new String[raw.length][levelheight];
    
    for (int i = 0; i < raw.length; i++) {
        arrayfied[i] = split(raw[i], "|");
    }
    
    return arrayfied;
}

Block[][] txt_to_block(String[][] lvltxt) {
    
    Block[][] lvldat = new Block[lvltxt.length][lvltxt[0].length];

    for (int x = 0; x < lvltxt.length; x++) {
        for (int y = 0; y < lvltxt[0].length; y++) {
            if (lvltxt[x][y] == null) {
                lvldat[x][y] = blockList[0];
                // println(lvldat[x][y].id);
            } else {
                    
                lvldat[x][y] = newBlock( int(lvltxt[x][y]) , x, y);
                // lvldat[x][y].cordx = cordx; //<>//
                // println(lvldat[x][y].id);
            }
            //bind cords.
            //println(x);
            //lvldat[x][y].setCords(x,y);
            
        //     println("[ x = " + str(lvldat[x][y].cordy) + "]   [x actual = " + str(y) + "]");
        }
    }
    //println(lvldat[0][0].cordx);
    return lvldat;
}





void load() {
    levelheight = int(heights / blocksize);
    levelwidth = int(widths / blocksize);
    lines = loadStrings("data/level3Fixed.txt");
    leveltxt = arrayfy(lines);
    levelfile = txt_to_block(leveltxt);
}
