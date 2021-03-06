function [g,h] = constraints(x,A,B,C,R,ptno,circleno) %Passing arguments intermediary pt(s), startpt,endpt,circlecenter,circle radius

X = [A;x;B]; %for 1 intermediary point, we calc dmin(X1 to X2, then X2 to X3)
%Similarly, for n intermediary points, last iteration is X(ptno+1) to X(ptno+2)

for j=1:circleno
    for i = 1:ptno+1
        g(i+j*(ptno+1))=R(j)-dmin(X(i,:),X(i+1,:),C(j,:));
    end 
end
h=[];
end