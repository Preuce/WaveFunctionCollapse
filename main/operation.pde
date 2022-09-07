public class Operation{
  Tile tile;
  
  ArrayList<String> left_tile;
  ArrayList<String> top_tile;
  ArrayList<String> right_tile;
  ArrayList<String> bottom_tile;
  ArrayList<String> curr_tile;
  
  public Operation(Tile t, ArrayList<String> lt, ArrayList<String> tt, ArrayList<String> rt, ArrayList<String> bt, ArrayList<String> ct){
    tile = t;
    left_tile = new ArrayList<>(lt);
    top_tile = new ArrayList<>(tt);
    right_tile = new ArrayList<>(rt);
    bottom_tile = new ArrayList<>(bt);
    curr_tile = new ArrayList<>(ct);
  }
}
