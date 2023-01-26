int[][] levelfile;
int blocksize;
int levelheight;
int levelwidth;

void load() {
    //load config file
    loadConfig();
    
    //load block list data from blocklist.json
    loadBlockList();
    
    //load block textures
    loadBlockTextures();

    //load level
    byte levelByteData[] = loadBytes("level3_data.dat");
    levelfile = loadLevelData(levelByteData);

    //load hitboxes
    loadHitboxes();

    //create variations
    createVariations();
    
}

int[][] hitboxes;
void loadHitboxes(){
    hitboxes = new int[levelfile.length][levelfile[0].length];
    //loop throught level file
    for (int x = 0; x < levelfile.length; x++) {
        for (int y = 0; y < levelfile[0].length; y++) {
            //if block is not air
            if(levelfile[x][y] != 0){
                // hitboxes[x][y] = 1;
                //create hitbox
                //if block above is air
                if (y > 0) {
                    //if levelfile[x][y] is equal to either 0, 2, 5, 6 then create hitbox
                    if(levelfile[x][y-1] == 0 || levelfile[x][y-1] == 2 || levelfile[x][y-1] == 3 || levelfile[x][y-1] == 5 || levelfile[x][y-1] == 6){
                        hitboxes[x][y] |= 1;
                    }
                }
                //if block left is air
                if (x > 0) {
                    //if levelfile[x][y] is equal to either 0, 2, 5, 6 then create hitbox
                    if(levelfile[x-1][y] == 0 || levelfile[x-1][y] == 2 || levelfile[x][y-1] == 3 || levelfile[x-1][y] == 5 || levelfile[x-1][y] == 6){
                        hitboxes[x][y] |= 2;
                    }
                }
                //if block right is air
                if (x < levelfile.length) {
                    //if levelfile[x][y] is equal to either 0, 2, 5, 6 then create hitbox
                    if(levelfile[x+1][y] == 0 || levelfile[x+1][y] == 2 || levelfile[x][y-1] == 3 || levelfile[x+1][y] == 5 || levelfile[x+1][y] == 6){
                        hitboxes[x][y] |= 4;
                    }
                }
            }
        }
    }




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
    //load level data from level_data.dat
    int flatArray[] = int(flatLvlData);
    int[][] levelfile = new int[levelwidth][levelheight];
    int counter = 0;
    //load in the blocks
        for (int x = 0; x < levelfile.length; x++) {
        for (int y = 0; y < levelfile[0].length; y++) {
            levelfile[x][y] = flatArray[counter];
            counter++;
        }
    }
    return levelfile;
}



//load block list data from blocklist.json
JSONObject blockListJson;
Block[] blockList;

void loadBlockList() {
    //load block list data from blocklist.json
    blockListJson = loadJSONObject("blockList.json");
    int blockListLength = blockListJson.size();
    blockList = new Block[blockListLength];
    //load in the blocks
    for (int i = 0; i < blockListLength; i++) {
        JSONObject block = blockListJson.getJSONObject("block" + str(i));
        String name = block.getString("name");
        String description = block.getString("description");
        int id = block.getInt("id");
        blockList[i] = new Block(name, description, id);
    }
}

void loadBlockTextures() {
    //load block textures
    for (int i = 0; i < blockList.length; i++) {
        Block block = blockList[i];
        int variations = 0;
        //check for variations
        while(true) {
            String fileName;
            if (variations == 0) {
                fileName = block.name + ".png";
            } else {
                fileName = block.name + variations + ".png";
            }
            //check if file exists
            File file = dataFile(fileName);
            if (file.isFile()) {
                //if file exists add to variations
                variations++;
            } else {
                break;
            }
        }
        //set the number of variations
        block.variations = variations;
        println(block.name + " has " + variations + " variations");

        //load the textures
        block.texture = new PImage[variations];
        //load the textures
        for (int j = 0; j < variations; j++) {
            String fileName;
            if (j == 0) {
                fileName = block.name + ".png";
            } else {
                fileName = block.name + j + ".png";
            }
            block.texture[j] = loadImage(fileName);
        }
    }
}

int[][] variations;
void createVariations() {
    variations = new int[levelwidth][levelheight];
    int counter = 0;
    
    for (int x = 0; x < levelfile.length; x++) {
        for (int y = 0; y < levelfile[0].length; y++) {
            // Generate a random value using Perlin noise
            double noise = noise(x * 0.3, y * 0.3);
            // Map the noise value to a variant ID
            variations[x][y] = (int)(noise * blockList[levelfile[x][y]].variations);
            // Set the variant ID in the levelfile array
            // levelfile[x][y] = flatArray[counter];
            counter++;
        }
    }
}

class Block {
    
    //block with id name description
    
    int id;
    String desc;
    int variations;
    String name;
    PImage[] texture;
    
    Block(String name, String desc, int id, PImage texture[]) {
        this.id = id;
        this.name = name;
        this.desc = desc;
        this.texture = texture;
        this.variations = texture.length;
    }
    Block(String name, String desc, int id) {
        this.id = id;
        this.name = name;
        this.desc = desc;
    }
}
