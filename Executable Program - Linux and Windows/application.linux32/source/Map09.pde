class Map09 extends Map{

  public Map09(Entity jugador)
  {
    sheeps = new Sheep[2];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map9.png");
    x = 60;
    y = 285;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 90, 510);
    sheeps[1].setxy( 940, 491);
    buttons[0] = new StaticButton(420, 78);
    obstacles[0] = new Door(15, 395, 15, 395, 0, 0);
    obstacles[1] = new Door(1000, 70, 935, 12, 1, 0);
    obstacles[2] = new Door(555, 412, 645, 488, 0, 1);
    obstacles[3] = new Door(420, 150, 327, 74, 0, 1);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  @Override
  Map nextMap(Entity jugador)
  {
    return new Map01(jugador);
  }
}