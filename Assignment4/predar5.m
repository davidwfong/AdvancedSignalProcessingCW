function [xhat, e, aevol] = predar5(x, adaptationgain, processorder)
%valid for input processorder = 5
N = length(x);
delay1 = zeros(1,1);
delay2 = zeros(2,1);
delay3 = zeros(1,1);
delay4 = zeros(2,1);
delay5 = zeros(1,1);
xd1 = vertcat(delay1,x); 
xd2 = vertcat(delay2,x);
xd3 = vertcat(delay3,x);
xd4 = vertcat(delay4,x);
xd5 = vertcat(delay5,x);
a = zeros(processorder+1,1);
aevol = zeros(processorder+1,N);
xhat = zeros(N,1); 
e = zeros(N,1); 
for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n),xd3(n),xd4(n),xd5(n));
    xsmall = xn(2:end);
    asmall = a(2:end);
    xhat(n) = (asmall')*xsmall;
    e(n) = x(n) - xhat(n);
    a = a + adaptationgain*e(n)*xn;
    aevol(:,n) = a;
end
end