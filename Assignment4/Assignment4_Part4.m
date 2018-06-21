N = 1000;
whitenoise = randn(N,1);
% Synthesis stage common to all 4 scenarios
processorder = 2;
a = [1 -0.9 -0.2];
x = filter(a,[1],whitenoise);
% Vector for plotting
samples = 1:1:N;
% Delayed versions of signal
delay1 = zeros(1,1);
delay2 = zeros(2,1);
xd1 = vertcat(delay1,x); %x[n-1]
xd2 = vertcat(delay2,x); %x[n-2]

% Analysis stage for adaptation gain 1 = 0.01
a_1 = zeros(processorder+1,1);
aevol_1 = zeros(processorder+1,N);
xhat_1 = zeros(N,1); 
e_1 = zeros(N,1); 
mu1 = 0.01;
for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n));
    xsmall = vertcat(xd1(n),xd2(n));
    asmall = vertcat(a_1(processorder),a_1(processorder+1));
    xhat_1(n) = (asmall')*xsmall;
    e_1(n) = x(n) - xhat_1(n);
    a_1 = a_1 + mu1*e_1(n)*xn;
    aevol_1(:,n) = a_1;
end
%Test analysis system against original signal
figure
plot(samples, whitenoise);
hold on
plot(samples, xhat_1);
%plot(samples, e_1);
hold off
title('Original white noise signal versus recreated white noise from AR(2) model')
xlabel('Sample')
ylabel('Value')
legend('original signal','recreated signal')
% Analyse evolution of a1 & a2 for adaptation gain 1 = 0.01
a1_1 = aevol_1(2,:);
a2_1 = aevol_1(3,:);
figure
plot(samples, a1_1)
hold on
plot(samples, a2_1)
hold off
title('Evolution of coefficients of AR(2) process with adaptation gain 0.01')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')

% Analysis stage for adaptation gain 2 = 0.001
a_2 = zeros(processorder+1,1);
aevol_2 = zeros(processorder+1,N);
xhat_2 = zeros(N,1); 
e_2 = zeros(N,1); 
mu2 = 0.001;
for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n));
    xsmall = vertcat(xd1(n),xd2(n));
    asmall = vertcat(a_2(processorder),a_2(processorder+1));
    xhat_2(n) = (asmall')*xsmall;
    e_2(n) = x(n) - xhat_2(n);
    a_2 = a_2 + mu2*e_2(n)*xn;
    aevol_2(:,n) = a_2;
end
% Analyse evolution of a1 & a2 for adaptation gain 2 = 0.001
a1_2 = aevol_2(2,:);
a2_2 = aevol_2(3,:);
figure
plot(samples, a1_2)
hold on
plot(samples, a2_2)
hold off
title('Evolution of coefficients of AR(2) process with adaptation gain 0.001')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')

% Analysis stage for adaptation gain 3 = 0.05
a_3 = zeros(processorder+1,1);
aevol_3 = zeros(processorder+1,N);
xhat_3 = zeros(N,1); 
e_3 = zeros(N,1); 
mu3 = 0.05;
for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n));
    xsmall = vertcat(xd1(n),xd2(n));
    asmall = vertcat(a_3(processorder),a_3(processorder+1));
    xhat_3(n) = (asmall')*xsmall;
    e_3(n) = x(n) - xhat_3(n);
    a_3 = a_3 + mu3*e_3(n)*xn;
    aevol_3(:,n) = a_3;
end
% Analyse evolution of a1 & a2 for adaptation gain 3 = 0.1
a1_3 = aevol_3(2,:);
a2_3 = aevol_3(3,:);
figure
plot(samples, a1_3)
hold on
plot(samples, a2_3)
hold off
title('Evolution of coefficients of AR(2) process with adaptation gain 0.05')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')

% Analysis stage for adaptation gain 4 = 0.1
a_4 = zeros(processorder+1,1);
aevol_4 = zeros(processorder+1,N);
xhat_4 = zeros(N,1); 
e_4 = zeros(N,1); 
mu4 = 0.1;
for n = 1:N
    xn = vertcat(x(n),xd1(n),xd2(n));
    xsmall = vertcat(xd1(n),xd2(n));
    asmall = vertcat(a_4(processorder),a_4(processorder+1));
    xhat_4(n) = (asmall')*xsmall;
    e_4(n) = x(n) - xhat_4(n);
    a_4 = a_4 + mu4*e_4(n)*xn;
    aevol_4(:,n) = a_4;
end
% Analyse evolution of a1 & a2 for adaptation gain 4 = 0.1
a1_4 = aevol_4(2,:);
a2_4 = aevol_4(3,:);
figure
plot(samples, a1_4)
hold on
plot(samples, a2_4)
hold off
title('Evolution of coefficients of AR(2) process with adaptation gain 0.1')
xlabel('Sample')
ylabel('Value')
legend('a1','a2')
