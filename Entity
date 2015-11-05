abstract class Entity extends Thread{
  private int x, y;
  PImage spriteActual;
  PImage sprites[] = new PImage[4];
  String imgStream;
  
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
  
  abstract void move(String direction);
  abstract void up();
  abstract void down();
  abstract void left();
  abstract void right();
  abstract void die();
}
