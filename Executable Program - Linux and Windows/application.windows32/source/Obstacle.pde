abstract class Obstacle{
  protected int x, y;
  PImage spriteActual;
  PImage sprites[] = new PImage[2];
  
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
  
  abstract void on();
  abstract void off();
}