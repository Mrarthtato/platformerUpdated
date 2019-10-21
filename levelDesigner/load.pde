block[][] levelfile;

String[][] arrayfy(String[] raw){
        String[][] arrayfied = new String[raw.length][levelwidth];

        for (int i = 0; i < raw.length; i++) {
                arrayfied[i] = split(raw[i], "|");
        }
        return arrayfied;
}
block[][] txt_to_block(String[][] lvltxt){
        block[][] lvldat = new block[levelheight][lvltxt[1].length];
        for (int i = 0; i < lvldat.length; i++) {
                if (i < lvltxt.length) {
                        for(int j = 0; j < lvltxt[i].length; j++) {
                                if (lvltxt[i][j] == null) {
                                        lvldat[i][j] = block_list[0];
                                } else {

                                        lvldat[i][j] = block_list[int(lvltxt[i][j])];
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

void load(){
        lines = loadStrings("data/level3.txt");
        levelheight = int(heights/blocksize);
        levelwidth = int(widths/blocksize);
        leveltxt = arrayfy(lines);
        levelfile = txt_to_block(leveltxt);
        // println(leveltxt[23][1]);
        // println(levelfile[23][50]);
        // store();
}
