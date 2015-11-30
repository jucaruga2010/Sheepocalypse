abstract class Map{

  Sheep[] sheeps;
  Button[] buttons;
  Obstacle[] obstacles;
  PImage fondo;
  int NumSheeps, NumButtons, NumObstacles;
  int x, y;
  
  int getx()
  {
    return x;
  }
  
  int gety()
  {
    return y;
  }
  
  Sheep[] getSheeps()
  {
    return sheeps;
  }
  
  Button[] getButtons()
  {
    return buttons;
  }
  
  Obstacle[] getObstacles()
  {
    return obstacles;
  }
  
  PImage getFondo()
  {
    return fondo;
  }
  
  int NumSheeps()
  {
    return NumSheeps;
  }
  
  int NumButtons()
  {
    return NumButtons;
  }
  
  int NumObstacles()
  {
    return NumObstacles;
  }
  
  abstract Map nextMap(Entity jugador);
}
  