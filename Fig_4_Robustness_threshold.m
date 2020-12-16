%%  Monte-Carlo Simulation for robustness with respect to the disturbances on the mean

addpath(genpath('./utils/'));
addpath(genpath('./data/'));
n=1000;
k=100;
var = 1;

sample_paths = [];

for i = 1:100
    
    P = [];
    
    T = 1000;
    
    D = -1+2*rand(n,1);
    
    for epsilon = 0:0.05:1
        
        J = 0;
        
        for t=1:T
            
            M = epsilon*D;
            
            O = randn(n,1)+M;
            
            U = boolean(abs(O)>=1.7361);
            
            sum(U);
            
            if sum(U) > k
                
                cost = sum(O.^2)/n;
                
            else
                
                cost = sum((O.^2).*(1-U))/n;
                
            end
            
            J = J + cost;
            
        end
        
        P = [P J/T];
        
    end
    
    
    sample_paths = [sample_paths; P];
    
end

P = sample_paths;

%%
x=[0:0.05:1];                  %#initialize x array
y1=mean(P)+ std(P);                      %#create first curve
y2=mean(P)- std(P);                   %#create second curve
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,'b');

hold

plot([0:0.05:1],mean(P),'w')

%line([0,1],[ 0.8178 , 0.8178])
%line([0,1],[ 0.7031 , 0.7031])
line([0,1],[ 0.6213 , 0.6213])

%fanChart([0:0.05:1],sample_paths','mean')
