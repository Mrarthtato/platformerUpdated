String[][] savelevelfile;
void store() {
    String[] savefile = new String[levelfile.length];
    
    String level_name = "data/" + "level3";
    //store level
    for (int i = 0; i < levelfile.length; i++) {
        savefile[i] = "";
        for (int j = 0; j < levelfile[i].length; j++) {
            
            if (levelfile[i][j] != null) {
                savefile[i] += str(levelfile[i][j].id);
            } else {
                savefile[i] += str(blockList[0].id);
            }
            savefile[i] += "|";
        }
    }
    saveStrings(level_name + ".txt", savefile);
    
    //store data
    String[] lvl_data = {(str(levelheight) + "|" + str(levellength))};
    saveStrings(level_name + "_data.txt", lvl_data);
    console("saved...", 3);
    
}

void storeUpdatedTemp() {
    String[] savefile = new String[levelfile[0].length];
    
    String level_name = "data/" + "level3Fixed";
    //store level
    for (int i = 0; i < levelfile[0].length; i++) {
        savefile[i] = "";



        for (int j = 0; j < levelfile.length; j++) {
            
            if (levelfile[j][i] != null) {
                savefile[i] += str(levelfile[j][i].id);
            } else {
                savefile[i] += str(blockList[0].id);
            }
            savefile[i] += "|";
        }


    }
    saveStrings(level_name + ".txt", savefile);

    //store data
    String[] lvl_data = {(str(levelheight) + "|" + str(levellength))};
    saveStrings(level_name + "_data.txt", lvl_data);
    console("saved...", 3);
    
}

String arrayToString(int[] array) {
    String stringAsArray = "";
    for (int i = 0; i < array.length; i++) {
        stringAsArray += str(array[i]);
    }
    return stringAsArray;
    
}