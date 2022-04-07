int square_dirx, square_diry;

void drawSingle() {

//calc the cords
  int cordx = (cordx()/blocksize)+cam;
  int cordy = cordy()/blocksize;
  
  //set the cord with a new block with cords set.
  saveNewBlock(eraseOrOtherwise.id, cordx, cordy);
  
}

void drawDouble() {

  //calc the first point
  firstptx -= (cam - clickcam);
  clickcam = cam;
  
  //determine the direction of the dragged sqaure, draggin and scrolling is put into account.

  //compare the points
  if (firstptx > cordx()/blocksize) {
    square_dirx = -1;
  } else {
    square_dirx = 1;
  }

  if (firstpty < cordy()/blocksize) {
    square_diry = 1;
  } else {
    square_diry = -1;
  }

  //using absolute value, we can first calculate the size of the sqaure, to make a for statment,
  //then at the end, multiply by the direction established above.

  if (abs((firstptx - (cordx()/blocksize))) < abs(firstpty - (cordy()/blocksize))) {
    //for all the blocks within the highlighted area...

    for (int j = 0; j <= abs(firstpty - (cordy()/blocksize)); j++) {
      for (int i = 0; i <= abs((firstptx - (cordx()/blocksize))); i++) {
        
        int cordx = cam + firstptx + (i * square_dirx);
        int cordy = firstpty + (j * square_diry);

        saveNewBlock(eraseOrOtherwise.id, cordx, cordy);

      }
    }
  } else
  {
    for (int i = 0; i <= abs((firstptx - (cordx()/blocksize))); i++) {
      for (int j = 0; j <= abs(firstpty - (cordy()/blocksize)); j++) {

        int cordx = cam+firstptx+ (i * square_dirx);
        int cordy = firstpty + (j * square_diry);

        saveNewBlock(eraseOrOtherwise.id, cordx, cordy);

      }
    }
  }
}
