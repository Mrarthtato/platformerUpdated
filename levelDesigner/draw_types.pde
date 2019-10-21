int square_dirx, square_diry;

void drawSingle() {

    levelfile[cordy()/blocksize][(cordx()/blocksize)+cam]=eraseOrOtherwise;

}

void drawDouble() {
    firstptx -= (cam - clickcam);
    clickcam = cam;

  if (firstptx   > cordx()/blocksize) {
    square_dirx = -1;
  } else {
    square_dirx = 1;
  }
  if (firstpty < cordy()/blocksize) {
    square_diry = 1;
  } else {
    square_diry = -1;
  }
  if (abs((firstptx - (cordx()/blocksize))) < abs(firstpty - (cordy()/blocksize))) {
    for (int j = 0; j <= abs(firstpty - (cordy()/blocksize)); j++) {
      for (int i = 0; i <= abs((firstptx - (cordx()/blocksize))); i++) {
        levelfile[firstpty + (j*square_diry)][cam+firstptx+ (i * square_dirx)] = eraseOrOtherwise;
      }
    }
  } else
  {
    for (int i = 0; i <= abs((firstptx - (cordx()/blocksize))); i++) {
      for (int j = 0; j <= abs(firstpty - (cordy()/blocksize)); j++) {
        levelfile[firstpty + (j*square_diry)][cam+firstptx+ (i * square_dirx)] = eraseOrOtherwise;
      }
    }
  }
}
