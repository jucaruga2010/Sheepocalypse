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
  
  abstract void check();
  
  void AddObstacle(Obstacle ob)
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
  
  void AddEntity(Entity ent)
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
  
  int getx()
  {
    return x;
  }
  
  int gety()
  {
    return y;
  }
  
  PImage getSprite()
  {
    return sprite;
  }  
}