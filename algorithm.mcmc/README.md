# Markov Chain Monte Carlo
Markov Chain Monte Carlo (MCMC) is an approximate inference technique that can be applied on any probabilistic graphical model. The most common variant, and the one implemented in SPIDAL, is called Gibbs Sampling. 

# Exemplar application
[Project:Ice sheet layer finding with confidence estimation](http://vision.soic.indiana.edu/papers/icelayers2014icip.pdf) is one case of using mcmc to solve a real problem.
![Exemplar application](https://github.com/hpcanalytics/Hidden-Markov-Model/blob/master/resource/icelayers2014icip-thumb.png)  

***************************************************
MCMC-based ice layer finding
(c) 2014 Stefan Lee, Jerome Mitchell, David Crandall

Please see README for instructions on how to use,
LICENSE for licensing information.

For details on the technique, please see:
Stefan Lee Jerome Mitchell David J. Crandall Geoffrey C. Fox,
"ESTIMATING BEDROCK AND SURFACE LAYER BOUNDARIES AND CONFIDENCE
INTERVALS IN ICE SHEET RADAR IMAGERY USING MCMC", in International
Conference on Pattern Recognition 2014.

Also see our project website: vision.soic.indiana.edu/icelayers

This work was supported in part by the National Science Foundation (CNS-0723054,
OCI-0636361, IIS-1253549, ANT-0424589) and by a NASA Earth and Space Science
Fellowship (NNX13AN82H). Thanks to the Center for the Remote Sensing of
Ice Sheets (CReSIS) for providing datasets.
***************************************************


This code implements a Gibbs sampler for estimating the position as we
as our confidence of surface and bedrock layers in ground penetrating
radar imagery.

The code assumes a Linux system. Compiling under Mac OS is possible but
requires some hacking; compiling under Windows probably requires more hacking.

To compile, simply run "make".

To run:
```
./MCMC input.png output.png
```
The output shows the estimated bedrock and ice surface boundaries. For each
boundary, we show the expected location as well as 95% confidence intervals
on either side, which give a measure of uncertainty. Please see our paper above
for more details.

We have included some sample images in the sample-images directory.

Other compile options:
```
make mcmc (produces non-optimized code that may possibly be more accurate)

make debug (produces non-optimized code like above but also outputs images in the run folder every 100 iterations showing state of sampler)

make clean (removes generated executables)

make mex (version for Matlab integration)
```
