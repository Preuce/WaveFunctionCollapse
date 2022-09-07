import java.util.Collections;
import java.util.stream.Collectors;
import java.util.concurrent.TimeUnit;
import java.lang.reflect.Array;
import java.util.List;
//taille de l'écran
final int SIZE = 1000;
//taille de la grille en tiles
final int DIMGRID = 20;
//taille de chaque tiles
final float IMGSIZE = SIZE/(float) DIMGRID;
//nom du JSON simplifié 
String filename = "dictionnary.json";
//dictionnaire final
JSONArray DICO = new JSONArray();
//liste des prototypes
//String[] PROTOTYPES;
ArrayList<String> PROTOTYPES;
//grille des possibilités
//ArrayList<String>[][] MAP;
ArrayList<ArrayList<ArrayList<String>>> placement_map = new ArrayList<>();
//public ArrayList<ArrayList<ArrayList<Integer>>> placement_map = new ArrayList<>();
//pile d'opérations
ArrayList<Operation> stack = new ArrayList<>();

//grille des images
//int[][] RENDER;
ArrayList<ArrayList<String>> RENDER;

//mode de parcours de la grille
enum mode {LEAST_ENT, LINEAR, SPIRALE, RANDOM, SNAKE};

int iter = -1;

boolean noloop = false;

KeyEvent k;

void settings(){
  size(SIZE, SIZE, P2D);
}

void setup(){
  background(200);
  init_dictionnary();
  init_map();
  init_render();
  if(noloop){
    noLoop();
  }
  //force_add(0, 0, "fullY_0");
  //force_add(1, 1, "miGY_0");
}

void draw(){
  //PROBLEME DANS DECOLLAPSE : "fullY", "fullG", "corG" et "miGY" sont tout à fait capable de collapse pour du 10x10
  //Le soucis vient du fait que decollapse ne "ramène" que les tile adjacentes
  //imaginons les collapse 2 - 1 - 3, où 3 n'avait qu'1 possibilité
  //On décollapse 3 -> []
  //on décollapse 2 -> 3 est toujours [] (alors qu'on a changé de branche)
  
  //solution : vu qu'on stock déjà les images dans un tableau pour l'affichage, on peut calculer les possibilités à chaque décollapse en regardant les cases adjacentes
  //Problème : Il faut qu'on garde en mémoire les possibilités qu'on a déjà testé, jusqu'à ce qu'on change de branche
  background(200);
  draw_all();
  display_infos();
  
  //TODO: passer par des listes d'entiers qui renvoient vers 1 liste de String unique
  // -> établir une liste des variations, Done : PROTOTYPES
  // -> Remplir placement_map par des entiers
  // -> Remplacer RENDER par un double array d'entiers
  // -> Modifier les listes des Operation
  // -> Remplacer les types de : get_random_possibility, get_map, set_map, intersection, 
  //TODO: faire fonctionner le backtracking
  //TODO: ajouter une limite d'occurrence à une pièce (et mettre à jour correctement cette limite lors d'un dé-collapse)
}
