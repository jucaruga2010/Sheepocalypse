class Map07 extends Map{

  public Map07(Entity jugador)
  {
    sheeps = new Sheep[5];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map7.png");
    x = 90;
    y = 90;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy(710, 130);
    sheeps[1].setxy(90, 500);
    buttons[0] = new StaticButton(350, 112);
    obstacles[0] = new Door(10, 85, 10, 85, 0, 0);
    obstacles[1] = new Door(1014, 477, 920, 380, 1, 0);
    obstacles[2] = new Door(80, 230, 216, 286, 0, 1);
    obstacles[3] = new Door(571, 123, 480, 65, 1, 0);
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
    return new Map08(jugador);
  }
}