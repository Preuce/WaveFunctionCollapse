/** collapse
* computes the collapse of a tile
*/
public void collapse(String img, Tile tile){
  collapse(img, tile.x, tile.y);
}

/** collapse
* computes the collapse of a tile
*/
public void collapse(String img, int x, int y){
  Operation ope = new Operation(new Tile(x, y), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), new ArrayList<>(), take_out(get_map(x, y), img));
  //suppression des prototypes valides dans tile
  set_map(x, y, new ArrayList<String>());
  //modification des tiles adjacentes
  
  //pour chaque côté de la tile:
  //on regarde la socket
  //on parcours l'ensemble des voisins potentiels pour trouver les prototypes qui possèdent cette sockets sur le côté opposé
  //on prend la case adjacente, on fait l'intersection avec les voisins acceptés par tile sur ce socket
  
  //on charge l'objet associé au nom img -> shape split[0] variation[1]
  String split[] = split(img, '_');
  for(int i = 0; i < DICO.size(); i++){
    //Récupération de l'objet
    JSONObject obj = DICO.getJSONObject(i);
    
    //si on a le bon objet dans le dictionnaire
    if(obj.getString("name").equals(split[0])){
      //Récupération du bon prototype dans les variations de obj
      JSONObject sockets = obj.getJSONArray("variations").getJSONObject(int(split[1]));
        
        //différents sockets
        String left_socket = sockets.getString("left");
        String top_socket = sockets.getString("top");
        String right_socket = sockets.getString("right");
        String bottom_socket = sockets.getString("bottom");
        
        //les futurs listes de voisins
        ArrayList<String> left_neighbors = new ArrayList<>();
        ArrayList<String> top_neighbors = new ArrayList<>();
        ArrayList<String> right_neighbors = new ArrayList<>();
        ArrayList<String> bottom_neighbors = new ArrayList<>();
        
        //pour chaque AUTRE objet possible
        for(int j = 0; j < DICO.size(); j++){
          JSONObject candidate = DICO.getJSONObject(j);
          //pour chaque variation de cet objet
          for(int k = 0; k < candidate.getJSONArray("variations").size(); k++){
            JSONObject prototype = candidate.getJSONArray("variations").getJSONObject(k);
            
            //on vérifie que le côté opposé est le bon type de socket
            //tile gauche
            if(is_valid_socket(prototype.getString("right"), left_socket)){
              //on place un nombre d'occurrence de cette variation équivalent au poids de l'objet
              for(int n = 0; n < candidate.getInt("weight"); n++){
                left_neighbors.add(candidate.getString("name")+"_"+prototype.getInt("rotation"));
              }
            }
            
            //tile haute
            if(is_valid_socket(prototype.getString("bottom"), top_socket)){
              //on place un nombre d'occurrence de cette variation équivalent au poids de l'objet
              for(int n = 0; n < candidate.getInt("weight"); n++){
                top_neighbors.add(candidate.getString("name")+"_"+prototype.getInt("rotation"));
              }
            }
            
            //tile droite
            if(is_valid_socket(prototype.getString("left"), right_socket)){
              //on place un nombre d'occurrence de cette variation équivalent au poids de l'objet
              for(int n = 0; n < candidate.getInt("weight"); n++){
                right_neighbors.add(candidate.getString("name")+"_"+prototype.getInt("rotation"));
              }
            }
            
            //tile basse
            if(is_valid_socket(prototype.getString("top"), bottom_socket)){
              //on place un nombre d'occurrence de cette variation équivalent au poids de l'objet
              for(int n = 0; n < candidate.getInt("weight"); n++){
                bottom_neighbors.add(candidate.getString("name")+"_"+prototype.getInt("rotation"));
              }
            } 
          }
        }
        
        //pas collé à gauche
        if(x > 0){
          //récupération de l'état antérieur
          ope.left_tile = get_map(x-1, y);
          //mise à jour de la grille
          set_map(x-1, y, intersection(get_map(x-1, y), left_neighbors));
        }
        //pas collé en haut
        if(y > 0){
          //récupération de l'état antérieur
          ope.top_tile = get_map(x, y-1);
          //mise à jour de la grille
          set_map(x, y-1, intersection(get_map(x, y-1), top_neighbors));
        }
        //pas collé à droite
        if(x < DIMGRID-1){
          //récupération de l'état antérieur
          ope.right_tile = get_map(x+1, y);
          //mise à jour de la grille
          set_map(x+1, y, intersection(get_map(x+1, y), right_neighbors));
        }
        //pas collé en bas
        if(y < DIMGRID-1){
          //récupération de l'état antérieur
          ope.bottom_tile = get_map(x, y+1);
          //mise à jour de la grille
          set_map(x, y+1, intersection(get_map(x, y+1), bottom_neighbors));
        }
        //mise à jour de la pile d'opérations
        stack.add(ope);
      //on a trouvé le bon prototype  
      break;
    }
  }
}

//stocker une tile (coordonnées) avec une pièce (image), l'état des voisins pré-collapse
  
/** decollapse
* removes the last operation from the stack and backtracks the grid
*/
public void decollapse(){
  if(stack.size() > 0){
    Operation last_op = stack.get(stack.size()-1);
    
    System.out.println("De-stack (" + last_op.tile.x + ", " + last_op.tile.y + ") : " + stack.size() + " -> " + (stack.size()-1));
    
    Tile last_tile = last_op.tile;
    //mettre à jour les différentes tiles
    if(!last_op.left_tile.isEmpty() /*!= null*/){
      set_map(last_tile.x-1, last_tile.y, last_op.left_tile); 
    }
    
    if(!last_op.top_tile.isEmpty() /*!= null*/){
      set_map(last_tile.x, last_tile.y-1, last_op.top_tile);
    }
    
    if(!last_op.right_tile.isEmpty() /*!= null*/){
      set_map(last_tile.x+1, last_tile.y, last_op.right_tile);
    }
    
    if(!last_op.bottom_tile.isEmpty() /*!= null*/){
      set_map(last_tile.x, last_tile.y+1, last_op.bottom_tile);
    }
    set_map(last_tile, last_op.curr_tile);
    clear_tile(last_op.tile);
    stack.remove(stack.size()-1);
  }
}
