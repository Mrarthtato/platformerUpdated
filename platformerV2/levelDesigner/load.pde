Block[][] levelfile;

void load() {
    //load config file
    JSONObject configData;
    
    configData = loadJSONObject("levelConfig.json");
    levelheight = configData.getInt("level_height");
    levelwidth = configData.getInt("level_width");
    blocksize = configData.getInt("block_size");
    
    //load level
    byte levelByteData[] = loadBytes("level3_data.dat");
    levelfile = loadLevelData(levelByteData);
    
}


Block[][] loadLevelData(byte[] flatLvlData) {
    int flatArray[] = int(flatLvlData);
    Block[][] levelfile = new Block[levelwidth][levelheight];
    int counter = 0;
    for (int x = 0; x < levelfile.length; x++) {
        for (int y = 0; y < levelfile[0].length; y++) {
            // if (flatArray[counter] == null){
            //     levelfile[x][y] = newBlock(0, x, y);
        // } else {
            levelfile[x][y] = newBlock(flatArray[counter] , x, y);
        // }
            counter++;
        }
    }
    return levelfile;
}
