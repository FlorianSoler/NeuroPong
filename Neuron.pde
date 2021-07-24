class Neuron
{
  float bias;
  FloatList weight;
  float out;

  Neuron(int in){
    weight = new FloatList();
    CreateWeight(in);
  }

  Neuron(float b, FloatList w, float o){
    bias = b;
    weight = w;
    out = o;
  }

  //forward pass from the weight, bias and input array
  void Fpass(float[] input){
    
    float sum = 0;
    for (int i = 0; i < input.length; i++){
      sum += weight.get(i)*input[i];
    }
    
    out = Sigmoid(sum+bias*1);
  }

  void WeightMutation(){
    for (int i = 0; i < weight.size(); i++){
      weight.set(i, weight.get(i)*(weight.get(i)*(random(1)*0.05)));
    }
  }

  //create the random weight
  void CreateWeight(int input){
    bias = random(1);
    
    for (int x = 0; x < input; x++){
      weight.append(random(1));
    }
  }
  
  Neuron DeepCopy(){
    FloatList temp = new FloatList();
    temp.append(weight);  
    
    Neuron n = new Neuron(bias, temp, out);
    return n;
  }

  //activation function
  float Sigmoid(float f){
    return 1/(1+exp(-f));
  }
}
