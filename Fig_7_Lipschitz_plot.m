%%  Optimal threshold  and its derivative as functions of the variance

addpath(genpath('./utils/'));
addpath(genpath('./data/'));
load threshold_gaussian_new.mat

sigma = 0:0.0001:10;

DT = zeros(1,length(sigma)-1);

for t=0:length(sigma)-2
    
    DT(t+1) = (T_star(t+2)-T_star(t+1))/(sigma(t+2)-sigma(t+1));
    
end


DT = [DT DT(length(DT))];

plot(sigma,T_star)
hold on
plot(sigma(1:10:100001),DT(1:10:100001))
axis([0 2 0 3])