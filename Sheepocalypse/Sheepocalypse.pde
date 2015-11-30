Entity sheeps[]; //<>//
Entity jugador;
Button buttons[];
Obstacle obstacles[];
Map mapa;
boolean pause;
int NumSh, NumBu, NumOb;

void setup()
{
  frameRate(3);
  textMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  textSize(100);
  presentacion();
  frameRate(50);
  jugador= new Player();
  mapa = new Map1(jugador);
  size(1024, 576);
  sheeps = mapa.getSheeps();
  buttons = mapa.getButtons();
  obstacles = mapa.getObstacles();
  jugador.setxy(mapa.getx(),mapa.gety());
  NumSh = mapa.NumSheeps();
  NumBu = mapa.NumButtons();
  NumOb = mapa.NumObstacles();
  pause = false;
}
  
public void draw()
{
  if(jugador.getx() > 1024)
  {
    nextLevel();
  }
  else
  {
  PImage fondo = mapa.getFondo();
  background(fondo);    
  for(int i=0; i<NumBu; i++)
  {
    buttons[i].check();
    image(buttons[i].getSprite(), buttons[i].getx(), buttons[i].gety());
  }
  for(int i=0; i<NumOb; i++)
  {
    image(obstacles[i].getSpriteActual(), obstacles[i].getx(), obstacles[i].gety());
  }
  image(jugador.getSpriteActual(), jugador.getx(), jugador.gety(), 100, 100);
  for(int i=0; i< NumSh; i++)
  {
    if(pause == false)
      sheeps[i].move("", color(0,1,0));
    image(sheeps[i].getSpriteActual(), sheeps[i].getx(), sheeps[i].gety(), 100, 100);
  }
  PImage stop;
  if(!jugador.live)
  {
    pause = false; //<>//
    fill(0);
    rect(width / 2, height / 2, 300, 100);
    fill(255);
    text("RETRY?", width / 2 - 150, height / 2 + 25);
  }
  if(pause)
  {
    stop = loadImage("continue.png");
    fill(255);
    text("PAUSE", width / 2 - 150, height / 2 + 25);
  }
  else
  {
    stop = loadImage("pause.png");
  }
  image(stop, 10, 10, 20, 20);
  }
  println(frameRate + "  " + frameCount);
}

void reset()
{
  jugador= new Player();
  mapa = new Map1(jugador);
  sheeps = mapa.getSheeps();
  buttons = mapa.getButtons();
  obstacles = mapa.getObstacles();
  jugador.setxy(mapa.getx(),mapa.gety());
  NumSh = mapa.NumSheeps();
  NumBu = mapa.NumButtons();
  NumOb = mapa.NumObstacles();  
}

void nextLevel()
{
  mapa = mapa.nextMap(jugador);
  sheeps = mapa.getSheeps();
  buttons = mapa.getButtons();
  obstacles = mapa.getObstacles();
  jugador.setxy(mapa.getx(),mapa.gety());
  NumSh = mapa.NumSheeps();
  NumBu = mapa.NumButtons();
  NumOb = mapa.NumObstacles();  
}

public void keyPressed()
{
  if(pause == false)
  {
    color c= color(0,1,0);
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
    if(keyCode==ENTER)
    {
      if(jugador.live)
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
      else
      {
        reset();
      }
    }
      redraw();
  }
} 

void mousePressed()
{
  loop();
  if(!jugador.live)
  {
    if(height/2 - 50 < mouseY && mouseY < height/2 + 50)
    {
      if(width/2 - 150 < mouseX && mouseX < width/2 + 150)
      {
        reset();
      }
    }
  }
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

void presentacion()
{
  background(0);
  imageMode(CENTER);
  text("SHEEPOCALYPSE",width/5, height/2 - 200);
  text("loading...",width/4, height/2 + 200);
  image(loadImage("PJ1.png"), width/2, height/2, 100, 100);
}