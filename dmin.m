function D = dmin(A,B,C) %function returns as D shortest distance from line AB to circle center C

n=20;
i=1;
for t=0:1/n:1
    M=A+t*(B-A);
    d(i)=norm(C-M);
    i=i+1;
end
    
D=min(d);
end