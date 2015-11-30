class Player extends Entity{
  
  public Player()
  {
    life = 3;
    speed = 2;
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "pj"+i+".jpg";
      sprites[i - 1] = loadImage(imgStream);
    }           
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "pjDamage"+i+".jpg";
      sprites[i + 3] = loadImage(imgStream);
    }  
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "pjDead"+i+".jpg";
      sprites[i + 7] = loadImage(imgStream);
    }  
    spriteActual = sprites[0];
  }
  
  @Override
  void move(String direction, color c) {
    boolean mov = true;
    boolean live = true;
    if(life <= 0)
      live = false;
    if(live)
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
  }

  @Override
  void hurt()
  {
    life -= 1;
    if(spriteActual==sprites[0])
      spriteActual=sprites[4];
    if(spriteActual==sprites[1])
      spriteActual=sprites[5];
    if(spriteActual==sprites[2])
      spriteActual=sprites[6];
    if(spriteActual==sprites[3])
      spriteActual=sprites[7];
    image(jugador.getSpriteActual(), jugador.getx(), jugador.gety(), 30, 30);
    if(spriteActual==sprites[4])
      spriteActual=sprites[0];
    if(spriteActual==sprites[5])
      spriteActual=sprites[1];
    if(spriteActual==sprites[6])
      spriteActual=sprites[2];
    if(spriteActual==sprites[7])
      spriteActual=sprites[3];
      
    if(life==0)
      die();
  }

  @Override
  void die() {
    if(spriteActual==sprites[0])
      spriteActual=sprites[8];
    if(spriteActual==sprites[1])
      spriteActual=sprites[9];
    if(spriteActual==sprites[2])
      spriteActual=sprites[10];
    if(spriteActual==sprites[3])
      spriteActual=sprites[11];
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
