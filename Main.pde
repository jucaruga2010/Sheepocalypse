Entity sheeps[];
Entity jugador;
  
void setup()
{
  sheeps = new Sheep[10];
  jugador= new Player();
  size(600, 600);
  for(int i=0;i<10;i++)
    sheeps[i]= new Sheep(i); 
  jugador.setxy(width/2,height/2);
}
  
public void draw()
{
  background(0,150,0);
  image(jugador.getSpriteActual(), jugador.getx(), jugador.gety(), 30, 30);  
  set(0,0,250);
}

public void keyPressed()
{
  if(keyCode==RIGHT)
  {
    jugador.move("right");
  }
  if(keyCode==LEFT)
  {
    jugador.move("left");      
  }
  if(keyCode==UP)
  {
    jugador.move("up");      
  }
  if(keyCode==DOWN)
  {
    jugador.move("down");      
  }
  redraw();
}  
