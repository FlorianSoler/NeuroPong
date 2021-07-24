//Wrapper
class Pong
{
  Puck puck;
  Bar AIBAR;
  Bar wall;
  NeuralNet nn;
  color c = color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
  
  Pong()
  {
    PongInit();
  }
  
  //pong bar and puck init
  void PongInit()
  {
    nn = new NeuralNet();
    puck = new Puck();
    puck.col = c;
    AIBAR = new Bar();
    AIBAR.AI = true;
    AIBAR.col = c;
    wall = new Bar();
    wall.pos.set(width-25,height/2);
    wall.h = height;
    wall.col = c;
  }
  
  //make Fpass from the input and use the nn output to mouve the bars
  void UpdateNN()
  {
    NnPushInput();
    nn.NNpass();
    AIBAR.up = nn.OutputToTrig(nn.outO)[0];
    AIBAR.down = nn.OutputToTrig(nn.outO)[1];
  }

  //pong colosion check and puck draw
  void Draw()
  {
    puck.show();
    wall.show();
    AIBAR.show();
  }
  
  //all call for physics
  void UpdatePhysics()
  {
    puck.rebond();
    puck.update();
    puck.goal();
    puck.checkPaddleRight(wall);
    puck.checkPaddleLeft(AIBAR);
    AIBAR.move();
  }
  
  //sending input to the nn
  void NnPushInput()
  {
    nn.input.set(0, (puck.pos.x)/width);
    nn.input.set(1, (puck.pos.y)/height);
    nn.input.set(2, (AIBAR.pos.y)/height);
  }
  
  int GetScore()
  {
    return puck.Score;
  }
}
