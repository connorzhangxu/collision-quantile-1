%%  The empirical performance of quantile estimation decentralized scheme as a function of time


clear all
clc
clf

addpath(genpath('./utils/'));
addpath(genpath('./data/'));

global tau n y k

n=100;
k=10;

tau = (n-k)/n + 1/(2*n);

load graph_100.mat

%rng(1)

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

P = [];

C = [];

for rounds = 1:100
    
    %tic
    
    J = [];
    
    c = [];
    
    x = randn(length(G),1);
    
    y = abs(x);
    
    w = 0*ones(n,1);
    
    rounds
    
    T = 0;
    
    while T<500
        
        T = T+1;
        
        for i=1:n
            
            if y(i) - w(i) >= 0
                
                s(i) = -tau;
                
            elseif y(i) - w(i) < 0
                
                s(i) = 1-tau;
                
            end
            
        end
              
        a = 1;
        b = 0.51;
        
        w = G*w - (a/(T)^b)*s;
        
        U = boolean(round(y,4)>=round(w,4));
        
        c = [c sum(U)];
        
        if sum(U) > k
            
            cost = sum(x.^2)/n;
            
        else
            
            cost = sum((x.^2).*(1-U))/n;
            
        end
        
        J = [ J cost] ;
        
    end
    
    P = [P;J];
    
    C = [C; c];
   
end

%% Plot 
subplot(2,1,1)


x=[1:1:500];                  %#initialize x array
y1=mean(P)+ std(P);           %#create first curve
y2=mean(P)-std(P);            %#create second curve
X=[x,fliplr(x)];              %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];            %#create y values for out and then back
fill(X,Y,'b');

hold

plot([1:1:500],mean(P),'w')

%hold

%plot([1:1:5000],median(P))

line([1,500],[0.5678,0.5678],'color','w')

line([1,500],[0.7031 ,0.7031])

subplot(2,1,2)

x=[1:1:500];                  %#initialize x array
y1=mean(C)+ std(C);           %#create first curve
y2=mean(C)- std(C);           %#create second curve
X=[x,fliplr(x)];              %#create continuous x value array for plotting
Y=[y1,fliplr(y2)];            %#create y values for out and then back
fill(X,Y,'b');
axis([0, 500, 8, 12])

hold

plot([1:1:500],mean(C))

line([1,500],[10 ,10])