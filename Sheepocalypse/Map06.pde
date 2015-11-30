class Map06 extends Map{

  public Map06(Entity jugador)
  {
    sheeps = new Sheep[3];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map6.png");
    x = 60;
    y = 285;
    NumSheeps = 3;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 89, 120);
    sheeps[1].setxy( 939, 491);
    sheeps[2].setxy( 480, 430 );
    buttons[0] = new StaticButton(350, 120);
    obstacles[0] = new Door(10, 480, 10, 480, 0, 0);
    obstacles[1] = new Door(1015, 87, 930, 158, 1, 0);
    obstacles[2] = new Door(176, 122, 240, 76, 1, 0);
    obstacles[3] = new Door(822, 317, 895, 247, 1, 1);
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
    return new Map07(jugador);
  }
}
