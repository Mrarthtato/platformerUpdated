String[][] savelevelfile;
String level_name = "data/" + "level3";
//legacy storing of level file into text format
void storeOld() {
    String[] savefile = new String[levelfile.length];
    
    
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

void storeLvl(){
    //using the saveInts function in processing to store the level file
    //the saveInts function only stores single dimension arrays, hence we need to flatten the array

    //first create an array big enough for all of the values
    int[] flatArray = new int[levelfile.length* levelfile[0].length];
    //create a counter that counts up each time the loop is ran to flatten the loop
    int counter = 0;
    for (int i = 0; i < levelfile.length; i++) {
        for (int j = 0; j < levelfile[0].length; j++) {
            flatArray[counter] = levelfile[i][j].id;
            counter += 1;
        }
    }
    //store
    saveBytes(level_name + "_data.dat", byte(flatArray));
}

void storeConfig(){
    JSONObject levelData = new JSONObject();
    //TODO store block type data here::

    levelData.setInt("level_width", levelfile.length);
    levelData.setInt("level_height", levelfile[0].length);

    saveJSONObject(levelData, "levelConfig.json");
    println("config stored");
}

void store(){
    //store level
    storeLvl();
    ///storeConfig
    storeConfig();
}





String arrayToString(int[] array) {
    String stringAsArray = "";
    for (int i = 0; i < array.length; i++) {
        stringAsArray += str(array[i]);
    }
    return stringAsArray;
}
