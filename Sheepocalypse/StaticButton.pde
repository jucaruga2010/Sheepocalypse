class StaticButton extends Button{
  
  public StaticButton(int x, int y)
  {
    super(x, y);
  }
  
  @Override
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