function [h] = func_upperbound(p)

global k n d

%k = 1;
%n = 10;

%d = 3;

h = k*log(p) - (n-1)*p - k*log(k) + k + k*log(n-1) + d*log(10);