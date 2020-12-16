%%  The empirical performance of average consensus based scheme as a function of time


clear all
clc
clf

addpath(genpath('./utils/'));
addpath(genpath('./data/'));

global var n k

n = 100;
k = 10;
var = 1;

load graph_100.mat

d = sum(A);

G = zeros(size(A));

for i = 1:length(A)
    
    N_i = setdiff(find(A(i,:)==1),i);
    
    for j = 1:length(A)
        
        if i==j
            
            G(i,j) = 1;
            
            for l = N_i
                
                G(i,j) = G(i,j) - (1+max(d(i),d(l)))^-1;
                
            end
            
        end
        
        if i~=j && any(j==N_i)
            
            G(i,j) = (1+max(d(i),d(j)))^-1;
            
        end
        
    end
    
end

load threshold_gaussian_100_10.mat

P = [];

C = [];

for M = 1:100
    
    M
    
    x = randn(n,1);
    
    z = x;
    
    m = mean(z);
    
    y = (n/(n-1))*(x).^2;
    
    J = zeros(1,200);
    
    c = zeros(1,200);
    
    threshold = zeros(n,1);
    
    for T = 1:200
        
        for l = 1:n
            
            if y(l) <= 10
                
                threshold(l) = T_star(floor(y(l)/0.0001)+1);
                
            else
                
                var = y(l);
                
                P0 = fzero('func',0);
                
                threshold(l) = fminsearch('threshold_symmetric',P0);
                
            end
  
        end
        
        U = boolean(abs(x)>=threshold);
        
        c(T) = sum(U);
        
        if sum(U) > k
            
            cost = sum(x.^2)/n;
              
        else
            
            cost = sum((x.^2).*(1-U))/n;
            
        end
        
        J(T) = cost;
            
        y = G*y;
   
    end
    
    P = [P; J];
    
    C = [C; c];
   
end


subplot(2,1,1)

x=[1:1:200];                  %#initialize x array
y1=mean(P)+ std(P);                      %#create first curve
y2=mean(P)-std(P);                   %#create second curve
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,'b');

hold

plot([1:1:200],mean(P))

%hold

%plot([1:1:5000],median(P))

line([1,200],[0.5678,0.5678])

line([1,200],[ 0.7031 ,0.7031])

subplot(2,1,2)

x=[1:1:200];                  %#initialize x array
y1=mean(C)+ std(C);                      %#create first curve
y2=mean(C)- std(C);                   %#create second curve
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,'b');

hold

plot([1:1:200],mean(C))

line([1,200],[ 10 ,10])
