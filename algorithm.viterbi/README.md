# Viterbi Algorithm
The Viterbi Algorithm is a fast, exact algorithm for solving for all unknown variables of a [Hidden Markov Model](https://github.com/hpcanalytics/Hidden-Markov-Model) simultaneously -- in other words, for performing MAP (Maximum A Posteriori) inference.
# Exemplar application
[Project:Layer finding in polar ice sheets](http://vision.soic.indiana.edu/papers/icesheets2012icpr.pdf) is one case of using Viterbi algorithm to solve a real problem.
![Exemplar application](https://github.com/hpcanalytics/Hidden-Markov-Model/blob/master/resource/viterbi.png) 

This library is deployed in the matlab version which you might need a matlab workspace to run the example conde  
Use function ice_gui.m to run the code, such as :  
```
ice_gui('image_path');  
```
The code will show the results of Hidden Markove Model viterbi algorithm.  

Figure 4 is the result of HMM viterbi algorithm.  
