import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Sheepocalypse extends PApplet {


Minim soundengine;
AudioSample sheep_sound; 
Entity sheeps[];
Entity jugador;
Button buttons[];
Obstacle obstacles[];
Map mapa;
boolean pause;
int NumSh, NumBu, NumOb;

public void setup()
{
  soundengine = new Minim(this);
  sheep_sound = soundengine.loadSample("sheep.mp3", 1024);
  frameRate(3);
  textMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  textSize(100);
  presentacion();
  frameRate(50);
  jugador= new Player();
  mapa = new Map01(jugador);
  
  sheeps = mapa.getSheeps();
  buttons = mapa.getButtons();
  obstacles = mapa.getObstacles();
  jugador.setxy(mapa.getx(),mapa.gety());
  NumSh = mapa.NumSheeps();
  NumBu = mapa.NumButtons();
  NumOb = mapa.NumObstacles();
  pause = false;
  sheep_sound.trigger();
}
  
public void draw()
{
  if(jugador.getx() > 1024)
  {
    nextLevel();
    sheep_sound.trigger();
  }
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
    pause = false;
    PImage retry = loadImage("retry.png");
    image(retry, width * (3.0f/4.0f), height * (3.0f/4.0f));
  }
  if(pause)
  {
    stop = loadImage("continue.png");
    PImage pause_screen = loadImage("pause_screen.png");
    image(pause_screen, width / 2, height / 2);
  }
  else
  {
    stop = loadImage("pause.png");
  }
  image(stop, 10, 10, 20, 20);
}

public void reset()
{
  jugador= new Player();
  mapa = new Map01(jugador);
  sheeps = mapa.getSheeps();
  buttons = mapa.getButtons();
  obstacles = mapa.getObstacles();
  jugador.setxy(mapa.getx(),mapa.gety());
  NumSh = mapa.NumSheeps();
  NumBu = mapa.NumButtons();
  NumOb = mapa.NumObstacles();  
}

public void nextLevel()
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
    int c= color(0,1,0);
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
          PImage stop = loadImage("pause_continue.png");
          image(stop, 10, 10, 20, 20);
        }
        else
        {
          pause = true;
          PImage stop = loadImage("pause_continue.png");
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

public void mousePressed()
{
  loop();
  if(!jugador.live)
  {
    if(height* (3.0f/4.0f)-50 < mouseY && mouseY < height* (3.0f/4.0f)+50)
    {
      if(width* (3.0f/4.0f)-150 < mouseX && mouseX < width* (3.0f/4.0f)+150)
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
        PImage stop = loadImage("pause_continue.png");
        image(stop, 10, 10, 20, 20);
      }
      else
      {
        pause = true;
        PImage stop = loadImage("pause_continue.png");
        image(stop, 10, 10, 20, 20);
      }
    }
  }
}

public void presentacion()
{
  background(0);
  imageMode(CENTER);
  text("SHEEPOCALYPSE",width/5, height/2 - 200);
  text("loading...",width/4, height/2 + 200);
  image(loadImage("PJ1.png"), width/2, height/2, 100, 100);
}
abstract class Button{
  protected int x, y;
  PImage sprite;
  Obstacle[] obs;
  Entity[] ents;
  int NumObs;
  int NumEnts;
  
  public Button(int x, int y)
  {
    this.x = x;
    this.y = y;
    NumObs = 0;
    NumEnts = 0;
    sprite=loadImage("button.png");
  }
  
  public abstract void check();
  
  public void AddObstacle(Obstacle ob)
  {
    Obstacle[] O= new Obstacle[NumObs + 1];
    if(NumObs > 0)
    {
      for(int i=0; i<NumObs; i++)
      {
        O[i] = obs[i];
      }
    }
    O[NumObs] = ob;
    obs = O;
    NumObs++;    
  }
  
  public void AddEntity(Entity ent)
  {
    Entity[] E= new Entity[NumEnts + 1];
    if(NumEnts > 0)
    {
      for(int i=0; i<NumEnts; i++)
      {
        E[i] = ents[i];
      }
    }
    E[NumEnts] = ent;
    ents = E;
    NumEnts++;
  }
  
  public int getx()
  {
    return x;
  }
  
  public int gety()
  {
    return y;
  }
  
  public PImage getSprite()
  {
    return sprite;
  }  
}
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
  
  public @Override
  void on()
  {
    x = x_open;
    y = y_open;
    spriteActual = sprites[open];
  }
  
  public @Override
  void off()
  {
    x = x_close;
    y = y_close;
    spriteActual = sprites[close];
  }
}
abstract class Entity{
  private int x, y;
  PImage spriteActual;
  PImage sprites[] = new PImage[8];
  String imgStream;
  int speed;
  boolean live;
  
  public void setxy(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  public int getx()
  {
    return x;
  }
  
  public int gety()
  {
    return y;
  }
  
  public PImage getSpriteActual()
  {
    return spriteActual;
  }
  
  public abstract void move(String direction, int c);
  public abstract void up(boolean mov);
  public abstract void down(boolean mov);
  public abstract void left(boolean mov);
  public abstract void right(boolean mov);
  public abstract void die();
}
abstract class Map{

  Sheep[] sheeps;
  Button[] buttons;
  Obstacle[] obstacles;
  PImage fondo;
  int NumSheeps, NumButtons, NumObstacles;
  int x, y;
  
  public int getx()
  {
    return x;
  }
  
  public int gety()
  {
    return y;
  }
  
  public Sheep[] getSheeps()
  {
    return sheeps;
  }
  
  public Button[] getButtons()
  {
    return buttons;
  }
  
  public Obstacle[] getObstacles()
  {
    return obstacles;
  }
  
  public PImage getFondo()
  {
    return fondo;
  }
  
  public int NumSheeps()
  {
    return NumSheeps;
  }
  
  public int NumButtons()
  {
    return NumButtons;
  }
  
  public int NumObstacles()
  {
    return NumObstacles;
  }
  
  public abstract Map nextMap(Entity jugador);
}
  
class Map01 extends Map{

  public Map01(Entity jugador)
  {
    sheeps = new Sheep[1];
    buttons = new Button[1];
    obstacles = new Obstacle[2];
    fondo = loadImage("map1.png");
    x = 60;
    y = 280;
    NumSheeps = 1;
    NumButtons = 1;
    NumObstacles = 2;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 80, 120);
    buttons[0] = new NormalButton(510, 280);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
    obstacles[1] = new Door(1010, 275, 960, 210, 1, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddObstacle(obstacles[1]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map02(jugador);
  }
}
class Map02 extends Map{

  public Map02(Entity jugador)
  {
    sheeps = new Sheep[2];
    buttons = new Button[1];
    obstacles = new Obstacle[3];
    fondo = loadImage("map2.png");
    x = 60;
    y = 280;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 3;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 80, 60);
    sheeps[1].setxy( 510, 370);
    buttons[0] = new StaticButton(680, 500);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
    obstacles[1] = new Door(1010, 275, 960, 210, 1, 0);
    obstacles[2] = new Door(605, 370, 605, 500, 0, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map03(jugador);
  }
}
class Map03 extends Map{

  public Map03(Entity jugador)
  {
    sheeps = new Sheep[6];
    buttons = new Button[0];
    obstacles = new Obstacle[1];
    fondo = loadImage("map3.png");
    x = 60;
    y = 285;
    NumSheeps = 4;
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
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map04(jugador);
  }
}
class Map04 extends Map{

  public Map04(Entity jugador)
  {
    sheeps = new Sheep[5];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map4.png");
    x = 60;
    y = 285;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 450, 510);
    sheeps[1].setxy( 920, 500);
    buttons[0] = new StaticButton(700, 120);
    obstacles[0] = new Door(0, 275, 0, 275, 0, 0);
    obstacles[1] = new Door(1010, 275, 960, 340, 1, 0);
    obstacles[2] = new Door(800, 85, 850, 20, 1, 0);
    obstacles[3] = new Door(915, 410, 770, 410, 1, 1);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map05(jugador);
  }
}
class Map05 extends Map{

  public Map05(Entity jugador)
  {
    sheeps = new Sheep[3];
    buttons = new Button[1];
    obstacles = new Obstacle[5];
    fondo = loadImage("map5.png");
    x = 99;
    y = 105;
    NumSheeps = 3;
    NumButtons = 1;
    NumObstacles = 5;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 194, 411);
    sheeps[1].setxy( 581, 72);
    sheeps[2].setxy( 800, 500);
    buttons[0] = new StaticButton(490, 271);
    obstacles[0] = new Door(15, 80, 15, 80, 0, 0);
    obstacles[1] = new Door(1011, 475, 934, 370, 1, 0);
    obstacles[2] = new Door(491, 210, 389, 281, 0, 1);
    obstacles[3] = new Door(829, 443, 721, 523, 1, 0);
    obstacles[4] = new Door(571, 75, 571, 75, 0, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map06(jugador);
  }
}
class Map06 extends Map{

  public Map06(Entity jugador)
  {
    sheeps = new Sheep[3];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map6.png");
    x = 99;
    y = 480;
    NumSheeps = 3;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 89, 120);
    sheeps[1].setxy( 939, 491);
    sheeps[2].setxy( 480, 430 );
    buttons[0] = new StaticButton(350, 120);
    obstacles[0] = new Door(10, 480, 10, 480, 0, 0);
    obstacles[1] = new Door(1015, 87, 940, 180, 1, 0);
    obstacles[2] = new Door(176, 122, 240, 76, 1, 0);
    obstacles[3] = new Door(822, 317, 895, 247, 1, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map07(jugador);
  }
}
class Map07 extends Map{

  public Map07(Entity jugador)
  {
    sheeps = new Sheep[5];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map7.png");
    x = 90;
    y = 90;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy(710, 130);
    sheeps[1].setxy(90, 500);
    buttons[0] = new StaticButton(350, 112);
    obstacles[0] = new Door(10, 85, 10, 85, 0, 0);
    obstacles[1] = new Door(1014, 477, 920, 380, 1, 0);
    obstacles[2] = new Door(80, 230, 216, 286, 0, 1);
    obstacles[3] = new Door(571, 123, 480, 65, 1, 0);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map08(jugador);
  }
}
class Map08 extends Map{

  public Map08(Entity jugador)
  {
    sheeps = new Sheep[5];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map8.png");
    x = 100;
    y = 280;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 921, 109);
    sheeps[1].setxy( 100, 475);
    buttons[0] = new StaticButton(270, 60);
    obstacles[0] = new Door(14, 285, 14, 285, 0, 0);
    obstacles[1] = new Door(1010, 490, 921, 400, 1, 0);
    obstacles[2] = new Door(184, 468, 280, 390, 1, 0);
    obstacles[3] = new Door(535, 235, 610, 145, 0, 1);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map09(jugador);
  }
}
class Map09 extends Map{

  public Map09(Entity jugador)
  {
    sheeps = new Sheep[2];
    buttons = new Button[1];
    obstacles = new Obstacle[4];
    fondo = loadImage("map9.png");
    x = 60;
    y = 285;
    NumSheeps = 2;
    NumButtons = 1;
    NumObstacles = 4;
    for(int i=0; i < NumSheeps; i++)
    {
      sheeps[i]= new Sheep(jugador);
    }
    sheeps[0].setxy( 90, 510);
    sheeps[1].setxy( 940, 491);
    buttons[0] = new StaticButton(420, 78);
    obstacles[0] = new Door(15, 395, 15, 395, 0, 0);
    obstacles[1] = new Door(1000, 70, 935, 12, 1, 0);
    obstacles[2] = new Door(555, 412, 645, 488, 0, 1);
    obstacles[3] = new Door(420, 150, 327, 74, 0, 1);
    buttons[0].AddEntity(jugador);
    buttons[0].AddEntity(sheeps[0]);
    buttons[0].AddEntity(sheeps[1]);
    buttons[0].AddObstacle(obstacles[1]);
    buttons[0].AddObstacle(obstacles[2]);
    buttons[0].AddObstacle(obstacles[3]);
  }
  
  public @Override
  Map nextMap(Entity jugador)
  {
    return new Map01(jugador);
  }
}
class NormalButton extends Button{
  
  public NormalButton(int x, int y)
  {
    super(x, y);
  }
  
  public @Override
  void check()
  {
    boolean press = false;
    for(int i=0;i<NumEnts;i++)
    {
      if(x - 50 < ents[i].getx() && ents[i].getx() < x + 50
      && y - 50 < ents[i].gety() && ents[i].gety() < y + 50)
      {
        press = true;
      }
    }
    if(press)
    {
      for(int j=0; j<NumObs; j++)
      {
        obs[j].on();
      }
    }
    else
    {
      for(int j=0; j<NumObs; j++)
      {
        obs[j].off();
      }
    }
  }
}
abstract class Obstacle{
  protected int x, y;
  PImage spriteActual;
  PImage sprites[] = new PImage[2];
  
  public int getx()
  {
    return x;
  }
  
  public int gety()
  {
    return y;
  }
  
  public PImage getSpriteActual()
  {
    return spriteActual;
  }
  
  public abstract void on();
  public abstract void off();
}
class Player extends Entity{
  public Player()
  {
    speed = 5;
    live = true;
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "PJ"+i+".png";
      sprites[i - 1] = loadImage(imgStream);
    }           
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "pjDead"+i+".png";
      sprites[i + 3] = loadImage(imgStream);
    } 
    spriteActual = sprites[0];
  }
  
  public @Override
  void move(String direction, int c) {
    boolean mov = true;
    if(live)
      switch(direction)
      {
      case "up":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx() + j, this.gety() - 49 - i) == c)
              mov = false;
        up(mov);
        break;
      
      case "down":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx()+j, this.gety() + 49 + i) == c)
              mov = false;
        down(mov);
        break;
      
      case "left":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx() - 49 - i, this.gety()+j) == c)
              mov = false;
        left(mov);
        break;
      
      case "right":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx() + 49 + i, this.gety()+j) == c)
              mov = false;
        right(mov);
        break;
      }
  }

  public @Override
  void die() {
    if(spriteActual==sprites[0])
      spriteActual=sprites[4];
    if(spriteActual==sprites[1])
      spriteActual=sprites[5];
    if(spriteActual==sprites[2])
      spriteActual=sprites[6];
    if(spriteActual==sprites[3])
      spriteActual=sprites[7];
    live=false;
  }

  public @Override
  void up(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[3];
    if(mov)
      this.setxy(this.getx(), this.gety() - speed);
    
  }

  public @Override
  void down(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[0];
    if(mov)
      this.setxy(this.getx(), this.gety() + speed);    
  }

  public @Override
  void left(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[2];
    if(mov)
      this.setxy(this.getx() - speed,this.gety());  
  }

  public @Override
  void right(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[1];
    if(mov)
      this.setxy(this.getx() + speed,this.gety());
  }
  
}
class Sheep extends Entity{
  Entity presa;
  int xPresa, yPresa;
  int changeDir, changeSprite;
  
  public Sheep(Entity presa) 
  {
    speed = 2;
    this.presa = presa;
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "SHEEP"+i+".png";
      sprites[i - 1] = loadImage(imgStream);
    } 
    spriteActual = sprites[0];
    changeDir = 0;
    changeSprite = 0;
  }
  
  public @Override
  void move(String direction, int c) {
    xPresa = presa.getx();
    yPresa = presa.gety();
    double distancia = sqrt(((xPresa - this.getx() )*(xPresa - this.getx() )) + ((yPresa - this.gety() )*(yPresa - this.gety() )));
    boolean mov = true;
    float distx = sqrt((xPresa - this.getx())*(xPresa - this.getx()));
    float disty = sqrt((yPresa - this.gety())*(yPresa - this.gety()));
    if( (distx > disty && changeDir < 15) || (-15 >= changeDir))
    {
      int oldx = this.getx();
      if(this.getx() < xPresa)
      {
        direction = "right";
      }
      else
      {
        direction = "left";
      }
      if(changeDir== -15)
        changeDir = 0;
      if(oldx == this.getx())
        changeDir++;
    }
    else
    {
      int oldy = this.gety();
      if(this.gety() < yPresa)
      {
        direction = "down";
      }
      else
      {
        direction = "up";
      }
      if(changeDir== 15)
        changeDir = 0;
      if(oldy == this.gety())
        changeDir--;
    }
    switch(direction)
      {
      case "up":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx() + j, this.gety() - 49 - i) == c)
              mov = false;
        up(mov);
        break;
      
      case "down":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx()+j, this.gety() + 49 + i) == c)
              mov = false;
        down(mov);
        break;
      
      case "left":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx() - 49 - i, this.gety()+j) == c)
              mov = false;
        left(mov);
        break;
      
      case "right":
        for(int i=-1;i<1;i++)
          for(int j=-45; j<46; j+=3)
            if( get(this.getx() + 49 + i, this.gety()+j) == c)
              mov = false;
        right(mov);
        break;
      }
    if(distancia < 55)
      presa.die();
  }

  public @Override
  void die() {
    
  }

 public @Override
  void up(boolean mov) {
    changeSprite++;
    if(changeSprite > 3)
    {
      spriteActual=sprites[3];
      changeSprite = 0;
    }
    if(mov)
      this.setxy(this.getx(), this.gety() - speed);
    
  }

  public @Override
  void down(boolean mov) {
    changeSprite++;
    if(changeSprite > 3)
    {
      spriteActual=sprites[0];
      changeSprite = 0;
    }
    if(mov)
      this.setxy(this.getx(), this.gety() + speed);    
  }

  public @Override
  void left(boolean mov) {
    changeSprite--;
    if(changeSprite < -3)
    {
      spriteActual=sprites[2];
      changeSprite = 0;
    }
    if(mov)
      this.setxy(this.getx() - speed,this.gety());  
  }

  public @Override
  void right(boolean mov) {
    changeSprite--;
    if(changeSprite < -3)
    {
      spriteActual=sprites[1];
      changeSprite = 0;
    }
    if(mov)
      this.setxy(this.getx() + speed,this.gety());
  }
}
class StaticButton extends Button{
  
  public StaticButton(int x, int y)
  {
    super(x, y);
  }
  
  public @Override
  void check()
  {
    boolean press = false;
    for(int i=0;i<NumEnts;i++)
    {
      if(x - 50 < ents[i].getx() && ents[i].getx() < x + 50
      && y - 50 < ents[i].gety() && ents[i].gety() < y + 50)
      {
        press = true;
      }
    }
    if(press)
    {
      for(int j=0; j<NumObs; j++)
      {
        obs[j].on();
      }
    }
  }
}
  public void settings() {  size(1024, 576); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Sheepocalypse" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
