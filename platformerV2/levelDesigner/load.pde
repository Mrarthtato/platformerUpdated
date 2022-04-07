Block[][] levelfile;

String[][] arrayfy(String[] raw) {
    //the text file is in the form of lines of id values.
    //each line is the elements in a x row.
    
    String[][] arrayfied = new String[raw.length][levelheight];
    
    //setting into array.
    for (int i = 0; i < raw.length; i++) {
        arrayfied[i] = split(raw[i], "|");
    }
    
    return arrayfied;
}

Block[][] txt_to_block(String[][] lvltxt) {
    
    Block[][] lvldat = new Block[lvltxt.length][lvltxt[0].length];
    //go thru the list according the x/y
    for (int x = 0; x < lvltxt.length; x++) {
        for (int y = 0; y < lvltxt[0].length; y++) {
            
            if (lvltxt[x][y] == null) {
                //if text is empty, populate with an empty block
                lvldat[x][y] = newBlock(0, x, y);
            } else {
                //if the text is not empty then makenew block
                lvldat[x][y] = newBlock( int(lvltxt[x][y]) , x, y);
            }
        }
    }

    //return finished level data.
    return lvldat;
}





void load() {

    //set data first, TODO: load level height and width from file
    levelheight = int(heights / blocksize);
    levelwidth = int(widths / blocksize);
    //load text
    lines = loadStrings("data/level3.txt");
    //send text into array
    leveltxt = arrayfy(lines);
    //send array into level file.
    levelfile = txt_to_block(leveltxt);
}
