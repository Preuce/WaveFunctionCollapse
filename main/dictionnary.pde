//le but est de générer le dictionnaire complet (poids, sockets, rotations)
//à partir d'un mini dictionnaire d'entrée contenant des pièces + sockets + poids
// (en gros automatiser la gestion des rotations)

public void init_dictionnary(){
  //import du dictionnaire simplifié
  JSONArray miniDICO = loadJSONArray(filename);
  
  //pour chaque pièce à considérer
  for(int i = 0; i < miniDICO.size(); i++){
    //récupération de l'objet
    JSONObject obj = miniDICO.getJSONObject(i);
    
    //préparation d'un nouvel objet
    JSONObject newobj = new JSONObject();
    
    //récupération et transfert du header
    newobj.setString("name", obj.getString("name"));
    newobj.setInt("weight", obj.getInt("weight"));
    newobj.setJSONArray("variations", new JSONArray());
    //préparation du corps
    //indice de rotation
    int rotation = 0;
    //liste des string représentant les sockets de la pièce (pour pouvoir accéder par indice)
    ArrayList<String> sockets = new ArrayList<>(4);
    sockets.add(obj.getString("bottom"));
    sockets.add(obj.getString("right"));
    sockets.add(obj.getString("top"));
    sockets.add(obj.getString("left"));
    
    ArrayList<String> code = new ArrayList<>(4){{for(int i=0; i < 4; i++){add("");}}};
    
    do{
      //concaténation des String des sockets dans l'ordre pour faire des comparaisons
      code.set(rotation, sockets.get((0 + rotation)%4) + sockets.get((1 + rotation)%4) + sockets.get((2 + rotation)%4) + sockets.get((3 + rotation)%4));
      //permet d'éviter les duplicatas
      if(!code.get(rotation).equals(code.get((rotation + 1)%4)) 
      && !code.get(rotation).equals(code.get((rotation + 2)%4))
      && !code.get(rotation).equals(code.get((rotation + 3)%4))){
        //nouvelle variation
        JSONObject variation = new JSONObject();
        //inscription de l'indice de rotation
        variation.setInt("rotation", rotation);
        //inscription des sockets
        variation.setString("left", sockets.get((3 + rotation)%4));
        variation.setString("top", sockets.get((2 + rotation)%4));
        variation.setString("right", sockets.get((1 + rotation)%4));
        variation.setString("bottom", sockets.get((0 + rotation)%4));
        //ajout de la variation
        newobj.getJSONArray("variations").setJSONObject(rotation, variation);
      }
      rotation++; 
    }while(rotation < 4);
    
    DICO.setJSONObject(i, newobj);
  }
  
}
