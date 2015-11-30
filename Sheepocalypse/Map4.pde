class Map4 extends Map{
  public Map4(Entity jugador)
  {
    sheeps = new Sheep[5];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map4.png");
    x = 60;
    y = 285;
    NumSheeps = 5;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 330, 510);
    sheeps[1].setxy( 610, 400);
    sheeps[2].setxy( 610, 280);
    sheeps[3].setxy( 930, 280);
    sheeps[4].setxy( 930, 500);
    buttons[0] = new NormalButton(750, 140);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
    obstacles[1] = new Door(1010, 275, 960, 340, 1, 0);
    obstacles[2] = new Door(800, 85, 850, 20, 1, 0);
    obstacles[3] = new Door(915, 410, 770, 410, 1, 1);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddEntity(sheeps[2]);
    buttons[0].AddEntity(sheeps[3]);
    buttons[0].AddEntity(sheeps[4]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  @Override
  Map nextMap(Entity jugador)
  {
    return new Map1(jugador);
  }
}
