class Player extends Entity{

  public Player()
  {    
    for(int i = 1 ; i < 5; i++)//cargamos las imagenes en el vector 
    {
      imgStream = "pj"+i+".jpg";
      sprites[i - 1] = loadImage(imgStream);
    }           
        
    spriteActual = sprites[0];
  }
  
  @Override
  void move(String direction) {
    // TODO Auto-generated method stub
    switch(direction)
    {
    case "up":
      up();
      break;
    case "down":
      down();
      break;
    case "left":
      left();
      break;
    case "right":
      right();
      break;
    }
  }

  @Override
  void die() {
    // TODO Auto-generated method stub
    
  }

  @Override
  void up() {
    // TODO Auto-generated method stub
    spriteActual=sprites[3];
    this.setxy(this.getx(), this.gety() - 3);
    
  }

  @Override
  void down() {
    // TODO Auto-generated method stub
    spriteActual=sprites[0];
    this.setxy(this.getx(), this.gety() + 3);    
  }

  @Override
  void left() {
    // TODO Auto-generated method stub
    spriteActual=sprites[2];
    this.setxy(this.getx() - 3,this.gety());  
  }

  @Override
  void right() {
    // TODO Auto-generated method stub
    spriteActual=sprites[1];  
    this.setxy(this.getx() + 3,this.gety());
  }
  
}
