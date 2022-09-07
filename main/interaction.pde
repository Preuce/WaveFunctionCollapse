public void display_infos(){
  textSize(16);
  fill(255, 0, 255);
  textAlign(CORNER);
  int x = (int) (mouseX/IMGSIZE);
  int y = (int) (mouseY/IMGSIZE);
  text(Integer.toString(x) + ", " + Integer.toString(y), mouseX, mouseY);
  
  text(to_String(get_map(x, y)), mouseX, mouseY+32);
}

public String to_String(ArrayList<String> list){
  String res = "[";
  for(int i = 0; i < list.size(); i++){
    res += list.get(i);
    if(i%3 == 0){
      res += "\n";
    }else{
      res += ", ";
    } 
  }
  res += "]";
  return res;
}

void keyPressed(){
  System.out.println(keyCode);
  if(keyCode == 39 /*flèche droite*/){
    wfca_ss();
  }else if(keyCode == 37 /*flèche gauche*/){
    decollapse();
    /*try{
      TimeUnit.MILLISECONDS.sleep(400);
    }catch(Exception e){};*/
  }else if(keyCode == 83 /*s*/){
    wfca();
  }else if(keyCode == 82 /*r*/){
    clear_render();
    clear_map();
    init_map();
  }
}
