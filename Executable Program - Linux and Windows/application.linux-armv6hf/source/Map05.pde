class Map05 extends Map{

  public Map05(Entity jugador)
  {
    sheeps = new Sheep[3];
    buttons = new Button[1];
    obstacles = new Obstacle[5];
    fondo = loadImage("map5.png");
    x = 99;
    y = 105;
    NumSheeps = 3;
    NumButtons = 1;
    NumObstacles = 5;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 194, 411);
    sheeps[1].setxy( 581, 72);
    sheeps[2].setxy( 800, 500);
    buttons[0] = new StaticButton(490, 271);
    obstacles[0] = new Door(15, 80, 15, 80, 0, 0);
    obstacles[1] = new Door(1011, 475, 934, 370, 1, 0);
    obstacles[2] = new Door(491, 210, 389, 281, 0, 1);
    obstacles[3] = new Door(829, 443, 721, 523, 1, 0);
    obstacles[4] = new Door(571, 75, 571, 75, 0, 0);
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
    return new Map06(jugador);
  }
}