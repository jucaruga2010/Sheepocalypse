class Door extends Obstacle{
 
  
  int x_open;
  int y_open;
  int x_close;
  int y_close;
  int open;
  int close;
  
  
  public Door(int x, int y, int x_open, int y_open, int open, int close)
  {
    this.x = x;
    this.y = y;
    x_close = x;
    y_close = y;
    this.x_open = x_open;
    this.y_open = y_open;
    this.open = open;
    this.close = close;
    sprites[0]=loadImage("VerticalDoor.png");
    sprites[1]=loadImage("HorizontalDoor.png");
    spriteActual = sprites[close];
  }
  
  @Override
  void on()
  {
    x = x_open;
    y = y_open;
    spriteActual = sprites[open];
  }
  
  @Override
  void off()
  {
    x = x_close;
    y = y_close;
    spriteActual = sprites[close];
  }
}