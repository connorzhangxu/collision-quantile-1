%% Search Interval for Gaussian observations

addpath(genpath('./utils/'));
addpath(genpath('./data/'));
global q k n d var

k = 10;
n = 100;



for var = 1:5
    T_l=erfinv((n-k)/n)*sqrt(2*var);
    
    d = 3;
    
    q = fzero('func_upperbound',[eps,k/(n-1)]);
    
    T_r= fzero('qinv',k/(n-1));
    
    [round(T_l,2),round(T_r,2)]
end