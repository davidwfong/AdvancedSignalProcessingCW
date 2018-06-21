function [xhat_se, e_se, aevol_se, xhat_sr, e_sr, aevol_sr, xhat_ss, e_ss, aevol_ss] = signlms(x,adaptationgain,processorder)
%valid for input processorder = 2
N = length(x);
delay1 = zeros(1,1);
delay2 = zeros(2,1);
xd1 = vertcat(delay1,x); 
xd2 = vertcat(delay2,x);

a_se = zeros(processorder+1,1);
a_sr = zeros(processorder+1,1);
a_ss = zeros(processorder+1,1);
aevol_se = zeros(processorder+1,N);
aevol_sr = zeros(processorder+1,N);
aevol_ss = zeros(processorder+1,N);
xhat_se = zeros(N,1);
xhat_sr = zeros(N,1);
xhat_ss = zeros(N,1);
e_se = zeros(N,1);
e_sr = zeros(N,1);
e_ss = zeros(N,1);

for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n));
    xsmall = xn(2:end);
    
    asmall_se = a_se(2:end);
    asmall_sr = a_sr(2:end);
    asmall_ss = a_ss(2:end);
    xhat_se(n) = (asmall_se')*xsmall;
    xhat_sr(n) = (asmall_sr')*xsmall;
    xhat_ss(n) = (asmall_ss')*xsmall;
    e_se(n) = x(n) - xhat_se(n); 
    e_sr(n) = x(n) - xhat_sr(n); 
    e_ss(n) = x(n) - xhat_ss(n);
    a_se = a_se + adaptationgain*sign(e_se(n))*xn;
    a_sr = a_sr + adaptationgain*e_sr(n)*sign(xn);
    a_ss = a_ss + adaptationgain*sign(e_ss(n))*sign(xn);
    aevol_se(:,n) = a_se;    
    aevol_sr(:,n) = a_sr;    
    aevol_ss(:,n) = a_ss;
end
end
