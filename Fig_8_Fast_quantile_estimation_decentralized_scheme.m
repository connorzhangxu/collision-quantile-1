%%  The empirical performance of fast quantile estimation decentralized scheme as a function of time

clear all
clc
clf

addpath(genpath('./utils/'));
addpath(genpath('./data/'));

global tau n k var

n=100;
k=10;

H = 1000;

tau = (n-k)/n + 1/(2*n);

load graph_100_2.mat

load threshold_gaussian_100_10.mat

rng(1)

d = sum(A);

G = zeros(size(A));

for i = 1:length(A)
    
    N_i = setdiff(find(A(i,:)==1),i);
    
    for j = 1:length(A)
        
        if i==j
            
            G(i,j) = 1;
            
            for l = N_i
                
                G(i,j) = G(i,j) - (max(d(i),d(l)))^-1;
                
            end
            
        end
        
        if i~=j && any(j==N_i)
            
            G(i,j) = (max(d(i),d(j)))^-1;
            
        end
        
    end
    
end

s = zeros(n,1);

T = 0;

%tic

P = [];

C = [];

for rounds = 1:100
    
    J = [];
    
    c = [];
    
    % Set switching time
    
%     R = 0;
    R = 22;

    
    % Gaussian
    x = randn(n,1);
    
    % Laplace
    %x = laprnd(n,1);
    
    y = (x).^2;
    
    threshold = 100*ones(n,1);
    
    %threshold = abs(x);
    
    for T = 1:R
        
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
        
        if sum(U) > k
            
            cost = sum(x.^2)/n;
            
        else
            
            cost = sum((x.^2).*(1-U))/n;
            
        end
        
        J = [J cost];
        
        c = [c sum(U)];
        
        y = G*y;
        
    end
    
    for l = 1:n
        
        if y(l) <= 10
            
            threshold(l) = T_star(floor(y(l)/0.0001)+1);
            
        else
            
            var = y(l);
            
            P0 = fzero('func',0);
           
            threshold(l) = fminsearch('threshold_symmetric',P0);
            
        end
        
    end
    
    w = threshold;
   
    z = abs(x);
    
    rounds
    
    T = 0;
    
    while T<H-R
        
        T = T+1;
        
        for i=1:n
            
            if z(i) - w(i) >= 0
                
                s(i) = -tau;
                
            elseif z(i) - w(i) < 0
                
                s(i) = 1-tau;
                
            end
            
        end
        
        a = 1;
        b = 0.51;
        
        w = G*w - (a/(T)^b)*s;
        
        U = boolean(round(z,4)>=round(w,4));
        
        c = [c sum(U)];
        
        if sum(U) > k
            
            cost = sum(x.^2)/n;
            
        else
            
            cost = sum((x.^2).*(1-U))/n;
            
        end
        
        J = [J cost] ;
        
    end
    
    P = [P;J];
    
    C = [C;c];
    
end

%%
subplot(2,1,1)

%fanChart([1:1:5000], P','mean')

%plot([1:1:5000], median(P))

%plot([1:1:5000], mean(P))

x=[1:1:H];                  %#initialize x array
y1=mean(P)+ std(P);         %#create first curve
y2=mean(P)-std(P);          %#create second curve
X=[x,fliplr(x)];            %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];          %#create y values for out and then back
fill(X,Y,'b');
axis([0, 500, 0, 1.5])
hold

plot([1:1:H],mean(P),'w')

line([1,H],[0.5678,0.5678])

subplot(2,1,2)

x=[1:1:H];                  %#initialize x array
y1=mean(C)+ std(C);                      %#create first curve
y2=mean(C)- std(C);                   %#create second curve
X=[x,fliplr(x)];                %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];              %#create y values for out and then back
fill(X,Y,'b');
axis([0, 500, 5, 15])
hold

plot([1:1:H],mean(C),'w')

line([1,H],[ 10 ,10])



