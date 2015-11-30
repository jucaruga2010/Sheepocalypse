class Map3 extends Map{
  public Map3(Entity jugador)
  {
    sheeps = new Sheep[6];
    buttons = new Button[0];
    obstacles = new Obstacle[1];
    fondo = loadImage("map3.png");
    x = 60;
    y = 285;
    NumSheeps = 6;
    NumButtons = 0;
    NumObstacles = 1;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 80, 50);
    sheeps[1].setxy( 80, 526);
    sheeps[2].setxy( 220, 100);
    sheeps[3].setxy( 220, 476);
    sheeps[4].setxy( 420, 100);
    sheeps[5].setxy( 420, 476);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
  }
  
  @Override
  Map nextMap(Entity jugador)
  {
    return new Map4(jugador);
  }
}
