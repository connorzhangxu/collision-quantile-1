function [p] = qinv(T)

global q var



p = 1 - (0.5*(1+erf(T/sqrt(2*pi*var)))- 0.5*(1+erf(-T/sqrt(2*pi*var)))) - q;


