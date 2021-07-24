class Puck 
{ 
  PVector pos = new PVector(width/2,height/2);
  PVector spd = new PVector(0,0);
  color col = 255;
  float r = 25/2;
  float speed = 5;
  Boolean Dead = false;
  int Score;
  
  Puck() 
  {
    reset();
  }
  
  void show()
  {
    noStroke();
    fill(col);
    ellipse(pos.x,pos.y,25,25);
  }
  
  //reset the puck
  void reset()
  {
    pos.set(width/2,height/2);
    float angle = random(-PI/4, PI/4);
    spd.set(speed * cos(angle),speed * sin(angle));
  }
  
  void update()
  {
    pos.set(pos.x + spd.x, pos.y + spd.y);
  }
  
  //make the ball bouce of the wall
  void rebond()
  {
    if(pos.y-r < 0 || pos.y+r > height)
    {
      spd.set(spd.x,spd.y*-1);
    }
  }
  
  void goal()
  {
    if(pos.x+r < 0)
    {
      Dead = true;
      //reset();
    }
  }
  
  //make the ball bounce from the left bar
  void checkPaddleLeft(Bar p) 
  {
    if (pos.y - r < p.pos.y + p.h/2 && pos.y + r > p.pos.y - p.h/2 && pos.x - r < p.pos.x + p.w/2) {
      if (pos.x > p.pos.x) {
        float diff = pos.y - (p.pos.y - p.h/2);
        float rad = radians(45);
        float angle = map(diff, 0, p.h, -rad, rad);
        spd.set(speed * cos(angle),speed * sin(angle));
        pos.x = p.pos.x + p.w/2 + r;
        Score++;
      }
    }
  }
  
  //make the ball bounce from the right bar
  void checkPaddleRight(Bar p) 
  {
    if (pos.y - r < p.pos.y + p.h/2 && pos.y + r > p.pos.y - p.h/2 && pos.x > p.pos.x - p.w/2) {
      if (pos.x < p.pos.x) {
        float diff = pos.y - (p.pos.y - p.h/2);
        float angle = map(diff, 0, p.h, radians(225), radians(135));
        spd.set(speed * cos(angle),speed * sin(angle));
        pos.x = p.pos.x - p.w/2;
      }
    }
  }
}
