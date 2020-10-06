clc;
close all;
clear all;
A=[1,9]; %initial starting point
B=[9,1]; %final point
C=[5,5]; %circle center

rectangle('Position',[4 0 2 4]);
rectangle('Position',[4 6 2 4]);
hold on;

seed = 100;
rng(seed);
ptno = 10;
circleno = 9;

intervalx = B(1)-A(1);
intervaly = A(1)-B(1);

C(1:round(circleno/2),1) = linspace(2,3.5,round(circleno/2));
C(round(circleno/2)+1:circleno,1) = linspace(6.5,8.7,circleno-round(circleno/2));
C(1:circleno,2) = 10 - linspace(2,8,circleno);
%R = [0.2 0.25 0.25 0.3 0.35 0.3 0.35 0.2];
for i = 1:circleno
    %C(i,1:2)=2.5*ones(1,1)+4.5*rand(1,2);
    R(i) = 0.2+rand(1)*0.3; %Radius
    circle(C(i,1),C(i,2),R(i));
    
end


%x0=transpose([1 2 3 4 6 7 8 8.5; 9 8 5 5 6 4 3 2.5]);%Initial guesses for point coordinates

%x0 = transpose([1 1 4 6 8; 8 8 5 5 3]);
x0=ones(ptno,2)+rand(ptno,2)*8;
%2 intermediary points - initial guess

%lb=[0 0 4 6 6; 6 6 4 4 0];
%ub=[4 4 4 6 10; 10 10 6 6 5];

M=[0 4];
lb(1:round(ptno/2),:)=repmat(M,round(ptno/2),1);
lb(round(ptno/2)+1,:)=[6 4];
N=[6 0];
lb(ptno-2:ptno,:) = repmat(N,3,1);

P=[4 10];
ub(1:round(ptno/2),:)=repmat(P,round(ptno/2),1);
Q=[10 6];
ub(round(ptno/2)+1:ptno-2,:) = repmat(Q,ptno-round(ptno/2)-2,1);
L=[10 4];
ub(ptno-1:ptno,:) = repmat(L,2,1);



%ub(1:ptno/2,:)=[4 6];
%ub(ptno/2+1:ptno)=[10 10];

%lb = transpose([0 0 0 0 0 6 6 6;4 4 4 4 4 4 0 0]);
%ub = transpose([4 4 4 4 10 10 10 10;6 6 6 6 10 10 10 10]);

optims = optimset('Display', 'Iter', 'TolX', 1e-6, 'Tolfun', 1e-6, 'MaxIter',100000,...
      'MaxfunEval', 30000)

x = fmincon(@(x)objective(x,A,B),x0,[],[],[],[],lb,ub,@(x)constraints(x,A,B,C,R,ptno,circleno),optims)

X = [A;x;B];
X0 = [A;x0;B];
sort(X0);

grid on;
%Display the circles.
%viscircles(C,R,'color','k');
xlim([0 10]); ylim([0 10]); 

for i = 1:ptno+1
    plot([X(i,1) X(i+1,1)],[X(i,2),X(i+1,2)],'-'); %plot(x,y) for plotting a line, plot(x1 x2, y1 y2, '-') x(i) = (x1,y1) so therefore x1(1) = a
    plot([X0(i,1) X0(i+1,1)],[X0(i,2),X0(i+1,2)],'--');
    hold on;
end

title(['Graph of optimised trajectory for ',num2str(circleno),' circles & ',num2str(ptno), ' intermediary points']);