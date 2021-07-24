Pong[] pong;
Generation[] gen;
int generation;
int population = 100;
int Nselected = 30;
int highscore = 0;
void setup()
{
  size(800, 500);

  //creating array
  pong = new Pong[population];
  gen = new Generation[population];


  for (int i = 0; i < population; i++){
    pong[i] = new Pong();
    gen[i] = new Generation();
  }
}

void draw()
{
  background(31);
  PongManager();

  textSize(32);
  text("gen :" + generation, (width/2)-40, 30);
}


//manage the pong game for every instance
void PongManager()
{
  int deathcount = 0;

  for (int i = 0; i < population; i++)
  {
    if (!pong[i].puck.Dead){
      pong[i].NnPushInput();
      pong[i].UpdateNN();
      pong[i].UpdatePhysics();
      pong[i].Draw();
    } 
    else
    {
      deathcount++;
    }
  }

  if (deathcount == population) {
    println("generation " +generation + " is finish"); 
    SelectBest();
  }
}

void SelectBest()
{
  for (int i = 0; i < population; i++)
  {
    gen[i].neuralNetwork = pong[i].nn;
    gen[i].neuralNetworkScore = pong[i].GetScore();
  }

  Generation temp;
  temp = new Generation();
  for (int i = 0; i < gen.length; i++) {
    for (int j = i+1; j < gen.length; j++)
    {
      if (gen[i].neuralNetworkScore > gen[j].neuralNetworkScore) {
        temp = gen[i];
        gen[i] = gen[j];
        gen[j] = temp;
      }
    }
  }


  ArrayList<Generation> newPopulation = new ArrayList<Generation>();
  for (int i = gen.length-Nselected; i < gen.length; i++) {
    newPopulation.add(gen[i]);
  }


  while (newPopulation.size() < population)
  {
    //selection des deux parent;
    Generation Parent1 = newPopulation.get(int(random(Nselected)));
    Generation Parent2 = newPopulation.get(int(random(Nselected)));

    //creation d'un nouvell enfant;
    newPopulation.add(CreateNewChild(Parent1, Parent2));
  }

  //list to array
  for (int i = 0; i < gen.length; i++)
    gen[i] = newPopulation.get(i);
    
  generation++;
  restart();
}

Generation CreateNewChild(Generation p1, Generation p2)
{
  int numberOfHidden = p1.neuralNetwork.Nhidden1;
  int numberOfOutput = p1.neuralNetwork.Nout;
  Neuron[] hidden = new Neuron[numberOfHidden];
  Neuron[] output = new Neuron[numberOfOutput];

  //p1 50% hidden
  for (int i = 0; i < numberOfHidden/2; i++) 
    hidden[i] = p1.neuralNetwork.hidden1[i].DeepCopy();

  //p2 50% hidden
  for (int i = numberOfHidden/2; i < numberOfHidden; i++)
    hidden[i] = p2.neuralNetwork.hidden1[i].DeepCopy();

  output[0] = p1.neuralNetwork.output[0].DeepCopy();
  output[1] = p2.neuralNetwork.output[1].DeepCopy();


  return new Generation(hidden, output);
}


//restarting pong instances
void restart()
{
  for (int i = 0; i < population; i++)
  {
    pong[i] = new Pong();
    pong[i].nn = gen[i].neuralNetwork;
  }
}
