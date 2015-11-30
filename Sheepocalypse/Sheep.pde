class Sheep extends Entity{
  int numeroOveja;
  Entity presa;
  int xPresa, yPresa;
  
  public Sheep(int n, Entity presa) 
  {
    speed = 1;
    numeroOveja = n;
    this.presa = presa;
    imgStream="frente obeja paint.jpg";
    sprites[0]=loadImage(imgStream);
    spriteActual=sprites[0];
    run();
  }
  
  @Override
  void move(String direction, color c) {
    xPresa = presa.getx();
    yPresa = presa.gety();
    double distancia = sqrt(((xPresa + this.getx())*(xPresa + this.getx()))+((yPresa + this.gety())*(yPresa + this.gety())));
    
    if(distancia < 120)
    {
      
    }
    else
    {
      boolean mov = true;
      float rdm = random(0)*4;
      if(0<rdm && rdm<1)
      {
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx()+j, this.gety() - 15 - i) == c)
              mov = false;
        up(mov);
      }
      if(1<rdm && rdm<2)
      {
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx()+j, this.gety() + 15 + i) == c)
              mov = false;
        down(mov);
      }
      if(2<rdm && rdm<3)
      {
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx() - 15 - i, this.gety()+j) == c)
              mov = false;
        left(mov);
      }
      if(3<rdm && rdm<4)
      {
        for(int i=0;i<3;i++)
          for(int j=-14;j<15;j+=7)
            if( get(this.getx() + 15 + i, this.gety()+j) == c)
              mov = false;
        right(mov);
      
      }
    }
    println(distancia);
    if(distancia < 40)
      presa.hurt();
  }

  @Override
  void die() {
    // TODO Auto-generated method stub
    
  }
  
  @Override
  void hurt() {
    // TODO Auto-generated method stub
    
  }
  
  @Override
  public void run()
  {
    move("", color(0,0,0));
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
