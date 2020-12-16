function [J] = threshold_symmetric(T)

%global var % n k 

n=100;
k=10;
var = 1;

%f = @(x) boolean(abs(x)<T).*exp(-(x.^2)/(2*var))/sqrt((2*pi*var));

%p1 = integral(f,-Inf,Inf,'RelTol',10^-30,'AbsTol',10^-30)

p = erf(T/sqrt(2*var));

J = binocdf(k-1,n-1,1-p);

%g = @(x) boolean(abs(x)>=T).*x.^2.*exp(-(x.^2)/(2*var))/sqrt((2*pi*var));

%J1 =  integral(g,-Inf,Inf)

%J = var - 2*(2*T*exp(-T^2/(2*var))+sqrt(2*pi*var)*(1-erf(T/sqrt(2*var))))*(2*sqrt(2*pi/var))^-1*F;
