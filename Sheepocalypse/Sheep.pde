class Sheep extends Entity{
  int numeroOveja;
  Entity presa;
  int xPresa, yPresa;
  
  public Sheep(int n, Entity presa) 
  {
    speed = 2;
    numeroOveja = n;
    this.presa = presa;
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "SHEEP"+i+".png";
      sprites[i - 1] = loadImage(imgStream);
    } 
    spriteActual = sprites[0];
  }
  
  @Override
  void move(String direction, color c) {
    xPresa = presa.getx();
    yPresa = presa.gety();
    double distancia = sqrt(((xPresa - this.getx() )*(xPresa - this.getx() )) + ((yPresa - this.gety() )*(yPresa - this.gety() )));
    boolean mov = true;
    float distx = sqrt((xPresa - this.getx())*(xPresa - this.getx()));
    float disty = sqrt((yPresa - this.gety())*(yPresa - this.gety()));
    if(distx > disty)
    {
      if(this.getx() < xPresa)
      {
        direction = "right";
      }
      else
      {
        direction = "left";
      }
    }
    else
    {
      if(this.gety() < yPresa)
      {
        direction = "down";
      }
      else
      {
        direction = "up";
      }
    }
    switch(direction)
      {
      case "up":
        for(int i=0;i<2;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx()+j, this.gety() - 15 - i) == c)
              mov = false;
        up(mov);
        break;
      
      case "down":
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx()+j, this.gety() + 15 + i) == c)
              mov = false;
        down(mov);
        break;
      
      case "left":
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx() - 15 - i, this.gety()+j) == c)
              mov = false;
        left(mov);
        break;
      
      case "right":
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx() + 15 + i, this.gety()+j) == c)
              mov = false;
        right(mov);
        break;
      }
    //println(distancia + " " + distx + " " + disty + " " + " " + this.getx() + " " + this.gety());
    if(distancia < 30)
      presa.hurt();
  } //<>// //<>// //<>// //<>// //<>//

  @Override
  void die() {
    // TODO Auto-generated method stub
    
  }
  
  @Override
  void hurt() {
    // TODO Auto-generated method stub
    
  } //<>// //<>//

 @Override
  void up(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[3];
    if(mov)
      this.setxy(this.getx(), this.gety() - speed);
    
  }

  @Override
  void down(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[0];
    if(mov)
      this.setxy(this.getx(), this.gety() + speed);    
  }

  @Override
  void left(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[2];
    if(mov)
      this.setxy(this.getx() - speed,this.gety());  
  }

  @Override
  void right(boolean mov) {
    // TODO Auto-generated method stub
    spriteActual=sprites[1];
    if(mov)
      this.setxy(this.getx() + speed,this.gety());
  }
}
