class Bar
{
  float w = 15, h = 120;
  PVector pos = new PVector(10,(height/2));
  float spd = 5;
  boolean up,down, R,L, AI;
  color col = 255;
  
  //making the bar appear on the screen
  void show()
  {
    fill(col);
    rect(pos.x, pos.y-(h/2), w, h);
  }
  
  //Bar movement
  void move()
  {
    //bar movement from the key
    if (keyPressed) 
    {
      if(R)
      {
        if (keyCode == UP && pos.y-(h/2) >= 0) 
        {
          pos.set(pos.x, pos.y - spd);
        } 
        else if (keyCode == DOWN && pos.y+(h/2) <= height) 
        {
          pos.set(pos.x, pos.y + spd);
        }
      }
      
      if(L)
      {
        if (key == '8' && pos.y-(h/2) >= 0) 
        {
          pos.set(pos.x, pos.y - spd);
        } 
        else if (key == '2' && pos.y+(h/2) <= height) 
        {
          pos.set(pos.x, pos.y + spd);
        }
      }
    }
    
    //bar mouvement from AI
    if(AI)
    {
      if (up ) 
      {
        pos.set(pos.x, pos.y - spd);
      } 
      else if (down) 
      {
        pos.set(pos.x, pos.y + spd);
      }
    }
  }
  
}
