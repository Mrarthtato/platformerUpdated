String[][] savelevelfile;
String level_name = "data/" + "level3";

void storeLvl(){
    //using the saveInts function in processing to store the level file
    //the saveInts function only stores single dimension arrays, hence we need to flatten the array

    //first create an array big enough for all of the values
    int[] flatArray = new int[levelfile.length* levelfile[0].length];
    //create a counter that counts up each time the loop is ran to flatten the loop
    int counter = 0;
    //loop through the 2d array and store each value in the flat array
    for (int i = 0; i < levelfile.length; i++) {
        //loop through the 2d array and store each value in the flat array
        for (int j = 0; j < levelfile[0].length; j++) {
            //store the value
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
    levelData.setInt("block_size", blocksize);
    //store the level name
    levelData.setInt("level_width", levelfile.length);
    //store the level name
    levelData.setInt("level_height", levelfile[0].length);
    //store the level name
    saveJSONObject(levelData, "levelConfig.json");
    //print to console
    println("config stored");
}

void storeBlockList(){
    JSONObject blockListJson = new JSONObject();
    //store name description and id of each blocklist
    for (int i = 0; i < blockList.length; i++) {
        JSONObject block = new JSONObject();
        block.setString("name", blockList[i].name);
        block.setString("description", blockList[i].desc);
        block.setInt("id", blockList[i].id);
        blockListJson.setJSONObject("block" + str(i), block);
    }
    saveJSONObject(blockListJson, "blockList.json");
    println("block list stored");
}

void store(){
    //store level
    storeLvl();
    ///storeConfig
    storeConfig();
    //store block list
    storeBlockList();
}
String arrayToString(int[] array) {
    String stringAsArray = "";
    for (int i = 0; i < array.length; i++) {
        stringAsArray += str(array[i]);
    }
    return stringAsArray;
}
