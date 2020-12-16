function [p] = func(T)

global var % n k

n=100;
k=10;

%var = 1;


%f = @(x) boolean(abs(x)<T).*exp(-(x.^2)/(2*var))/sqrt((2*pi*var));

p = 0.5*(1+erf(T/sqrt(2*pi*var)))- 0.5*(1+erf(-T/sqrt(2*pi*var))) -(1-k/n);