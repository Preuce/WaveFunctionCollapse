//Nom de l'image, coordonnée en x, coordonnée en y (en case, pas en pixel)
void set_image(String img, int x, int y){
  //name_rotation
  String split[] = split(img, '_');
  //on récupère le nom du fichier à partir du nom de la pièce
  String img_name = split[0] + ".png";
  //on récupère l'indice de rotation à partir du nom de la pièce
  int r = int(split[1]);
  pushMatrix();
  translate(IMGSIZE*(x + 1/2f), IMGSIZE*(y + 1/2f));
  //rotation de l'image
  rotate(r*PI/2f);
  imageMode(CENTER);
  //chargement de l'image
  RENDER.get(x).set(y, img);
  image(loadImage(split[0] + ".png"), 0, 0, IMGSIZE, IMGSIZE);
  //image(loadImage(img_name), 0, 0, IMGSIZE, IMGSIZE);
  popMatrix();
}

void set_image(String img, Tile tile){
  set_image(img, tile.x, tile.y); 
}

void draw_image(int x, int y){
  if(RENDER.get(x).get(y) != null){
    String split[] = split(RENDER.get(x).get(y), '_');
    pushMatrix();
    translate(IMGSIZE*(x + 1/2f), IMGSIZE*(y + 1/2f));
    rotate(int(split[1])*PI/2f);
    imageMode(CENTER);
    image(loadImage(split[0]+".png"), 0, 0, IMGSIZE, IMGSIZE);
    popMatrix();
  }
}

void draw_all(){
  for(int i = 0; i < DIMGRID; i++){
    for(int j = 0; j < DIMGRID; j++){
      draw_image(i, j);
    }
  }
}

void clear_tile(Tile tile){
  clear_tile(tile.x, tile.y);
}

void clear_tile(int x, int y){
  RENDER.get(x).set(y, null);
  rectMode(CORNER);
  fill(200);
  noStroke();
  rect(x*IMGSIZE, y*IMGSIZE, IMGSIZE, IMGSIZE);
}


void clear_render(){
  for(int i = 0; i < DIMGRID; i++){
    for(int j = 0; j < DIMGRID; j++){
      clear_tile(i ,j);
    }
  }
}

public void init_render(){
  RENDER = new ArrayList<>(DIMGRID);
  for(int i = 0; i < DIMGRID; i++){
    ArrayList<String> col = new ArrayList<>(Collections.nCopies(DIMGRID, null));
    RENDER.add(col);
  } 
}
