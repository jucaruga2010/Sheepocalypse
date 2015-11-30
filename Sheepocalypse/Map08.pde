class Map08 extends Map{

  public Map08(Entity jugador)
  {
    sheeps = new Sheep[5];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map8.png");
    x = 100;
    y = 280;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 921, 109);
    sheeps[1].setxy( 100, 475);
    buttons[0] = new StaticButton(270, 60);
    obstacles[0] = new Door(14, 285, 14, 285, 0, 0);
    obstacles[1] = new Door(1010, 490, 921, 400, 1, 0);
    obstacles[2] = new Door(184, 468, 280, 390, 1, 0);
    obstacles[3] = new Door(535, 235, 610, 145, 0, 1);
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
    return new Map09(jugador);
  }
}