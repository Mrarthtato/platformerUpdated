int[][] levelfile;
int blocksize;
int levelheight;
int levelwidth;

void load() {
    //load config file
    loadConfig();
    
    //load level
    byte levelByteData[] = loadBytes("level3_data.dat");
    levelfile = loadLevelData(levelByteData);
    
}

void loadConfig() {
    //load config file
    JSONObject configData;
    
    configData = loadJSONObject("levelConfig.json");
    levelheight = configData.getInt("level_height");
    levelwidth = configData.getInt("level_width");
    blocksize = configData.getInt("block_size");
    
    //take level height and divide it by the height of the screen
    //then using the level height scale the blocksize accordingly
    // blocksize = (int) (height / levelheight);
}

int dirtID = 4;
int VariantCount = 3;


int[][] loadLevelData(byte[] flatLvlData) {
    int flatArray[] = int(flatLvlData);
    int[][] levelfile = new int[levelwidth][levelheight];
    int[][] variations = new int[levelwidth][levelheight];
    int counter = 0;
    
    for (int x = 0; x < levelfile.length; x++) {
        for (int y = 0; y < levelfile[0].length; y++) {
            // Generate a random value using Perlin noise
            double noise = noise(x * 0.1, y * 0.1);
            // Map the noise value to a variant ID
            variations[x][y] = (int)(noise * VariantCount);
            // Set the variant ID in the levelfile array
            levelfile[x][y] = flatArray[counter];
            counter++;
        }
    }
    return levelfile;
}
