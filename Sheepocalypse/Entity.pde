abstract class Entity{
  private int x, y;
  PImage spriteActual;
  PImage sprites[] = new PImage[8];
  String imgStream;
  int speed;
  boolean live;
  
  void setxy(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  int getx()
  {
    return x;
  }
  
  int gety()
  {
    return y;
  }
  
  PImage getSpriteActual()
  {
    return spriteActual;
  }
  
  abstract void move(String direction, color c);
  abstract void up(boolean mov);
  abstract void down(boolean mov);
  abstract void left(boolean mov);
  abstract void right(boolean mov);
  abstract void die();
}