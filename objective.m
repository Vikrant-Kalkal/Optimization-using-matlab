function f=objective(x,A,B)

X=[A;x;B];


f = 0;

for i=1:length(X)-1
    
    f= f + norm(X(i+1,:)-X(i,:)); %f gives the sum of lengths of the line segments
    
end 