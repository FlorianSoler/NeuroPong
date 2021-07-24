class Generation
{
  NeuralNet neuralNetwork;
  int neuralNetworkScore;

  Generation(){
    init();
  }

  Generation(Neuron[] hiddenLayer, Neuron[] outputLayer){
    init();
    neuralNetwork.Sethidden(hiddenLayer);
    neuralNetwork.SetOutput(outputLayer);
  }

  void init(){
    neuralNetwork = new NeuralNet();
  }
}
