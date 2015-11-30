class Map2 extends Map{
  public Map2(Entity jugador)
  {
    sheeps = new Sheep[2];
    buttons = new Button[1];
    obstacles = new Obstacle[3];
    fondo = loadImage("map2.png");
    x = 60;
    y = 280;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 3;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 80, 60);
    sheeps[1].setxy( 510, 370);
    buttons[0] = new StaticButton(680, 500);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
    obstacles[1] = new Door(1010, 275, 960, 210, 1, 0);
    obstacles[2] = new Door(605, 370, 605, 500, 0, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
  }
  
  @Override
  Map nextMap(Entity jugador)
  {
    return new Map3(jugador);
  }
}
