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
  
  @Override
  void move(String direction, color c) {
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

  @Override
  void die() {
    
  }

 @Override
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

  @Override
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

  @Override
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

  @Override
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