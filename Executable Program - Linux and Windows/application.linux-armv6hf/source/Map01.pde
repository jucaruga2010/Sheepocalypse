class Map01 extends Map{

  public Map01(Entity jugador)
  {
    sheeps = new Sheep[1];
    buttons = new Button[1];
    obstacles = new Obstacle[2];
    fondo = loadImage("map1.png");
    x = 60;
    y = 280;
    NumSheeps = 1;
    NumButtons = 1;
    NumObstacles = 2;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 80, 120);
    buttons[0] = new NormalButton(510, 280);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
    obstacles[1] = new Door(1010, 275, 960, 210, 1, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddObstacle(obstacles[1]);
  }
  
  @Override
  Map nextMap(Entity jugador)
  {
    return new Map02(jugador);
  }
}