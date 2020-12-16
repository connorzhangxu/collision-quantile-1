n = 1000;

%clf
%hold

while 1
    


x = rand(n,1);

y = rand(n,1);

%subplot(1,3,3)

scatter(x,y)

hold

axis 'equal'

r = sqrt(log2(n)/n)

A = zeros(n);


for i = 1:n
    
    for j = 1:n
        
        if norm([x(i)-x(j),y(i)-y(j)],2)<=r
            
            A(i,j)=1;
            
            line([x(i),x(j)],[y(i),y(j)])
            
        end
        
    end
    
end

D=sum(A);
    
L=diag(D)-A;
    
E=eig(L);
    
E=sort(E);
    
if E(2)>0.001
        
    break
    
end

end
    
%save('graph_100_2.mat','A','D','L')
        
