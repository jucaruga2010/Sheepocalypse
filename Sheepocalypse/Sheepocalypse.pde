Entity sheeps[];
Entity jugador;

void setup()
{
  sheeps = new Sheep[5];
  jugador= new Player();
  size(901, 527);
  jugador.setxy(18,height-25);
  for(int i=0;i<5;i++)
  {
    sheeps[i]= new Sheep(i, jugador);
    sheeps[i].setxy(width - 30, 30);
  }
}
  
public void draw()
{
  imageMode(CENTER);
  PImage fondo=loadImage("fondopruebas.png");
  background(fondo);
  image(jugador.getSpriteActual(), jugador.getx(), jugador.gety(), 30, 30);
  for(int i=0; i< 5; i++)
  {
    image(sheeps[i].getSpriteActual(), sheeps[i].getx(), sheeps[i].gety(), 30, 30);
  }
}

public void keyPressed()
{
  color c= color(0,0,0);
  if(keyCode==RIGHT)
  {    
    jugador.move("right", c);
  }
  if(keyCode==LEFT)
  {
    jugador.move("left", c);      
  }
  if(keyCode==UP)
  {
    jugador.move("up", c);      
  }
  if(keyCode==DOWN)
  {
    jugador.move("down", c);      
  }
  redraw();
} 

void mousePressed()
{
  
}