void menu() {
  noStroke();
  fill(160);
  //menubase
  // rect(width/2, height-height/8, width, height/4);
  // rectMode(con)
  rect(width/2, real_space_cord(22), width, blocksize*5);

  fill(255);
  //map position
  rect(width/2, height-(1*blocksize), width-(10*blocksize), height/50);
  cube((5*blocksize) + cam*(0.88), height-(1+blocksize));
  // rect(, , blocksize, blocksize, 7);

  //block_list menu

  for(block i: block_list){
      if (type == i){
          stroke(0);
      }
      i.menu_tip(block_list_start_cord+(i.id-1),22);
  }


  //rectmode
  if (drawType == 2) {
    stroke(0);
  }
  fill (0);
  cube(20*blocksize, 22*blocksize);
  noStroke();

  //normalmode
  if (drawType == 1) {
    stroke(0);
  }
  fill (0);
  cube(21*blocksize, 22*blocksize);
  noStroke();


  fill(255);
  stroke(0);
}


void menuOptions() {

  for(block i: block_list){
      if (cordy/blocksize == i.menu_cordy && cordx/blocksize == i.menu_cordx) {
        type = i;
      }
  }
  if (cordy/blocksize == 22 && cordx/blocksize == 47) {
    drawType = 2;
  }
  if (cordy/blocksize == 22 && cordx/blocksize == 48) {
    drawType = 1;
  }
}
