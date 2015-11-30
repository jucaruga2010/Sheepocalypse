class Player extends Entity{
  public Player()
  { //<>//
    speed = 4;
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
  
  @Override
  void move(String direction, color c) {
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

  @Override
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