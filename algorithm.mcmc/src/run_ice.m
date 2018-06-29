function [path,lower,upper]=run_ice(fname, pts1, pts2)

A=imread(fname);
[path,lower,upper]=RJ_MCMC(double(A(:,:,1)), pts1, pts2);
  


