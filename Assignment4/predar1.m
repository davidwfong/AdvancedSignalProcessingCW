function [xhat, e, aevol] = predar1(x, adaptationgain, processorder)
%valid for input processorder = 1
N = length(x);
delay1 = zeros(1,1);
xd1 = vertcat(delay1,x); 
a = zeros(processorder+1,1);
aevol = zeros(processorder+1,N);
xhat = zeros(N,1); 
e = zeros(N,1); 
for n = 1:N
    xn = vertcat(x(n),xd1(n));
    xsmall = xd1(n);
    asmall = a(2:end);
    xhat(n) = (asmall')*xsmall;
    e(n) = x(n) - xhat(n);
    a = a + adaptationgain*e(n)*xn;
    aevol(:,n) = a;
end
end