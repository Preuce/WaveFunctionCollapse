//pour chaque case, on a l'ensemble des sockets a valider
//on parcours l'ensemble des prototypes jusqu'à trouver un prototype qui a les bons sockets au bon endroit

//idéalement : on ne parcours pas tous les prototypes, on recherche intelligemment les prototypes qui pourraient fonctionner
//-> on s'intéresse à la liste de voisins valides pour chaque prototype. On ne parcours que les variations de ces prototypes

//comparer les voisins valides

public String get_random_possibility(Tile tile){
  return get_random_possibility(tile.x, tile.y);
}

/** get_random_possibility
* returns a random valid prototype
*/
public String get_random_possibility(int x, int y){
  //génère un nombre aléatoire r entre 0 et get_map(x, y).size()-1
  //System.out.println("Tile " + x + " " + y + " in get_random_possibility : " + get_map(x, y));
  return get_map(x, y).get(int(random(0, get_map(x, y).size())));
}

/** intersection
* computes the intersection of 2 lists
*/
public ArrayList<String> intersection(ArrayList<String> l1, ArrayList<String> l2){
  ArrayList<String> l = new ArrayList<>();
  for(String t : l1){
    if(l2.contains(t)){
       l.add(t);
    }
  }
  return l;
}

/** is_valid_socket
* checks if 2 sockets are compatible
*/
public boolean is_valid_socket(String s1, String s2){
  if(s1.equals(s2)){
    return s1.charAt(s1.length()-1) == 's' && s2.charAt(s2.length()-1) == 's';
  }else{
    return (s1.substring(0, s1.length()-1).equals(s2) && s1.charAt(s1.length()-1) == 'f') 
    || (s2.substring(0, s2.length()-1).equals(s1) && s2.charAt(s2.length()-1) == 'f' );
  }
}

public void print(ArrayList<String> s){
  System.out.println(s);
}

public void print(int x, int y){
  print(placement_map.get(x).get(y));
}

public void write(Tile tile, int i){
  textSize(32);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text(Integer.toString(i), IMGSIZE*tile.x, IMGSIZE*tile.y, IMGSIZE, IMGSIZE);

}

/** wfca
* main algorithm
*/
public void wfca(){
  boolean collapse = true;
  while(stack.size() < DIMGRID*DIMGRID){
    //sélectionner la case avec le moins de possibilités //besoin d'une carte des possibilités -> 3D tab ou hashmap
    Tile interest_tile = get_least_entropy();
    //plus aucune possibilité
    if(interest_tile == null){
      if(stack.size() > 0){
        decollapse();
        continue;
      }else{
        System.out.println("Could not collapse");
        collapse = false;
        break;
      }
    }
  
    //choisir une des possibilités
    String prototype = get_random_possibility(interest_tile);
    System.out.println(stack.size() + " / " + (DIMGRID*DIMGRID));
    //dessiner
    set_image(prototype, interest_tile);

    //éventuellement écrire le numéro de la tile
    //write(interest_tile, stack.size());
  
    //mettre à jour les possibilités (cases adjacentes)
    collapse(prototype, interest_tile);
  
    //repeat
  }
    if(collapse){
      System.out.println("Fully collapsed");
  }
  
}

/** wfca_ss
* wave function collapse algorithm single step
*/
public void wfca_ss(){
  if(stack.size() < DIMGRID*DIMGRID){
    //sélectionner la case avec le moins de possibilités //besoin d'une carte des possibilités -> 3D tab ou hashmap
    Tile interest_tile = get_least_entropy();
  
    //plus aucune possibilité
    /*while(interest_tile == null && stack.size() > 0){
      interest_tile = get_least_entropy();
      decollapse();
    }*/
    
    if(interest_tile == null && stack.size() > 0){
      decollapse();
    }else if(interest_tile == null && stack.size() == 0){
      System.out.println("Could not collapse");
    }
  
    /*if(interest_tile == null && stack.size() == 0){
      System.out.println("Could not collapse.");
      //noLoop();*/
    else{
  
      //choisir une des possibilités
      String prototype = get_random_possibility(interest_tile);
      //dessiner
      set_image(prototype, interest_tile);

      //éventuellement écrire le numéro de la tile
      //write(interest_tile, stack.size());
  
      //mettre à jour les possibilités (cases adjacentes)
      collapse(prototype, interest_tile);
  
      //repeat
    }
  }else{
    System.out.println("Fully collapsed");
    //noLoop();
  }
}
