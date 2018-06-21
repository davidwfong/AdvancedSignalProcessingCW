function [xhat, e, aevol] = predar2(x, adaptationgain, processorder)
%valid for input processorder = 2
N = length(x);
delay1 = zeros(1,1);
delay2 = zeros(2,1);
xd1 = vertcat(delay1,x); 
xd2 = vertcat(delay2,x);
a = zeros(processorder+1,1);
aevol = zeros(processorder+1,N);
xhat = zeros(N,1); 
e = zeros(N,1); 
for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n));
    xsmall = xn(2:end);
    asmall = a(2:end);
    xhat(n) = (asmall')*xsmall;
    e(n) = x(n) - xhat(n);
    a = a + adaptationgain*e(n)*xn;
    aevol(:,n) = a;
end
end