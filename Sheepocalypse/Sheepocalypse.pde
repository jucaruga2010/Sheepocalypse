Entity sheeps[];
Entity jugador;
boolean pause;

void setup()
{
  sheeps = new Sheep[1];
  jugador= new Player();
  size(901, 527);
  jugador.setxy(18,height-25);
  for(int i=0;i<1;i++)
  {
    sheeps[i]= new Sheep(i, jugador);
    sheeps[i].setxy(width - 30, 30);
  }
  pause = false;
  fill(0);
  textSize(60);
  textMode(CENTER);
}
  
public void draw()
{
  imageMode(CENTER);
  PImage fondo=loadImage("fondopruebas.png");
  background(fondo);
  image(jugador.getSpriteActual(), jugador.getx(), jugador.gety(), 30, 30);
  for(int i=0; i< 1; i++)
  {
    if(pause == false)
      sheeps[i].move("", color(0,0,0));
    image(sheeps[i].getSpriteActual(), sheeps[i].getx(), sheeps[i].gety(), 30, 30);
  }
  PImage stop;
  if(pause)
  {
    stop = loadImage("continue.png");
    text("pause", width / 2, height / 2);
  }
  else
  {
    stop = loadImage("pause.png");
  }
  image(stop, 10, 10, 20, 20);
}

public void keyPressed()
{
  if(pause == false)
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
} 

void mousePressed()
{
  loop();
  if(0 < mouseY && mouseY < 20)
  {
    if(0 < mouseX && mouseX < 20)
    {
      if(pause)
      {
        pause = false;
        PImage stop = loadImage("pause-continue.png");
        image(stop, 10, 10, 20, 20);
      }
      else
      {
        pause = true;
        PImage stop = loadImage("pause-continue.png");
        image(stop, 10, 10, 20, 20);
      }
    }
  }
}