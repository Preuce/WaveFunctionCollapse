/** get_map
* returns a value from the grid
*/
public ArrayList<String> get_map(Tile tile){
  return get_map(tile.x, tile.y);
}

public ArrayList<String> get_map(int x, int y){
  return placement_map.get(x).get(y);
}

/** set_map
* sets a value on the grid
*/
public void set_map(Tile tile, ArrayList<String> v){
  set_map(tile.x, tile.y, v);
}

public void set_map(int x, int y, ArrayList<String> v){
  placement_map.get(x).set(y, new ArrayList<>(v));
}

public ArrayList<String> take_out(ArrayList<String> list, String s){
  ArrayList<String> copy = new ArrayList<>(list);
  do{}while(copy.remove(s));
  return copy;
}

/** force_place
* forcefully place a tile on the grid and collapses
*/
public void force_add(int x, int y, String prototype){
  //affichage de l'image
  set_image(prototype, x, y);
  //mise à jour de la grille
  collapse(prototype, x, y);
}

/** init_map
* initializes placement_map
*/
public void init_map(){
  //initialisation de la liste complète des prototypes et variations
  ArrayList<String> protos = new ArrayList<>();
  //pour chaque objet
  for(int i = 0; i < DICO.size(); i++){
    String name = DICO.getJSONObject(i).getString("name");
    //pour chaque variation
    for(int j = 0; j < DICO.getJSONObject(i).getJSONArray("variations").size(); j++){
      //nombre d'occurrence équivalent au poids
      for(int n = 0; n < DICO.getJSONObject(i).getInt("weight"); n++){
        protos.add(name + "_" + j);
      }
    }
  }
  
  PROTOTYPES = protos;
  
  for(int i = 0; i < DIMGRID; i++){
    ArrayList<ArrayList<String>> col = new ArrayList<>();
    for(int j = 0; j < DIMGRID; j++){
      col.add(protos);
    }
    placement_map.add(col);
  }
}

void clear_map(){
  for(ArrayList<ArrayList<String>> l1 : placement_map){
    for(ArrayList<String> l2 : l1){
      l2.clear();
    }
    l1.clear();
  }
  placement_map.clear();
  stack.clear();
}

/** get_least_entropy
* returns the tile with the least entropy
*/
public Tile get_least_entropy(){
   //Tile champ = new Tile(-1, -1);
   Tile champ = null;
   int s_champ = PROTOTYPES.size()+1;
   for(int i = 0; i < DIMGRID; i++){
     for(int k = 0; k < DIMGRID; k++){
       //mise à jour du champion
       int s_curr = get_map(i,k).stream().distinct().collect(Collectors.toList()).size();
       //System.out.println(get_map(i,k).stream().distinct().collect(Collectors.toList()));
       if(s_curr > 0 && s_curr < s_champ){
         champ = new Tile(i, k);
         //champ.x = i;
         //champ.y = k;
         s_champ = s_curr;
       }
     }
   }
   return champ;
}
