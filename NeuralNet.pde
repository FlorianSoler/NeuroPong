class NeuralNet
{ 
  //neural network params
  int Ninput = 3;
  int Nhidden1 = 6;
  int Nout = 2;
  
  //movement trigger value
  float Trig = 0.9;
  
  //creating layer
  FloatList input = new FloatList();
  Neuron[] hidden1;
  FloatList outH = new FloatList();
  Neuron[] output;
  FloatList outO = new FloatList();
  
  //creating list
  NeuralNet()
  {
    InitNeuron();
  }
  
  //assigning rnd value to the weight
  void InitNeuron(){
    hidden1 = new Neuron[Nhidden1];
    output = new Neuron[Nout];
    
    for (int i = 0; i < Nhidden1; i++)
      hidden1[i] = new Neuron(Ninput);
    
    for (int i = 0; i < Nout; i++)
      output[i] = new Neuron(Nhidden1);
  }
  
  void Mutation()
  {
    for (int i = 0; i < hidden1.length; i++) 
    {
      hidden1[i].WeightMutation();
    }
    
    for (int i = 0; i < output.length; i++) 
    {
      output[i].WeightMutation();
    }
  }
  
  //Feed forward pass of the input data
  void NNpass(){
    outH.clear();
    outO.clear();
    
    //input to hidden pass
    for (int i = 0; i < hidden1.length; i++){
      hidden1[i].Fpass(input.array());
      outH.append(hidden1[i].out);
    }
    
    //hidden to output pass
    for (int i = 0; i < output.length; i++){
      output[i].Fpass(outH.array());
      outO.append(output[i].out);
    }
    
    //println(outO);
    
  }
  
  //debuging 
  void PrintWeight(Neuron[] neurons){
    for (int i = 0; i < neurons.length; i++) 
    {
      println(neurons[i].weight);
    }
  }
  
  void Sethidden(Neuron[] neurons){
    hidden1 = neurons;
  }
  
  void SetOutput(Neuron[] neurons){
    output = neurons;
  }
  
  //makes nn ouput usable in bar mouvement
  Boolean[] OutputToTrig(FloatList inputs){
    Boolean[] controlOutputs;
    int numberOfInput = inputs.size();
    
    controlOutputs = new Boolean[numberOfInput];
    
    for(int i = 0; i < numberOfInput; i++)
    {
      controlOutputs[i] = inputs.get(i) >= Trig; //testing if the nn is in the trigger val;
    }
    
    return controlOutputs;
  }
  
}
