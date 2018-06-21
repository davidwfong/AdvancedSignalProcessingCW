N = 10000;
samples = 1:1:N;
% Get input for AR parameter identification
whitenoise = randn(N,1);
a = [1 -0.9 -0.2];
xAR = filter(a,[1],whitenoise);
% Set parameters
adaptationgainAR = 0.005;
processorderAR = 2;

%Apply basic LMS and retrieve coefficients
[xhat_basicAR, e_basicAR, aevol_basicAR] = predar2(xAR,adaptationgainAR,processorderAR);
a1_basicAR = aevol_basicAR(2,:);
a2_basicAR = aevol_basicAR(3,:);
%Apply sign LMS algorithms and retrieve coefficients
[xhat_seAR, e_seAR, aevol_seAR, xhat_srAR, e_srAR, aevol_srAR, xhat_ssAR, e_ssAR, aevol_ssAR] = signlms(xAR,adaptationgainAR,processorderAR);
a1_seAR = aevol_seAR(2,:);
a2_seAR = aevol_seAR(3,:);
a1_srAR = aevol_srAR(2,:);
a2_srAR = aevol_srAR(3,:);
a1_ssAR = aevol_ssAR(2,:);
a2_ssAR = aevol_ssAR(3,:);
% Plot evolution of a1 & a2 for signed error LMS identification
figure
plot(samples, a1_seAR)
hold on
plot(samples, a1_basicAR)
plot(samples, a2_seAR)
plot(samples, a2_basicAR)
hold off
title('Evolution of coefficients for AR(2) using Signed Error LMS for adaptation gain 0.005')
xlabel('Sample')
ylabel('Value')
legend('a1 signed error LMS','a1 basic LMS','a2 signed error LMS','a2 basic LMS')
% Plot evolution of a1 & a2 for signed regressor LMS identification
figure
plot(samples, a1_srAR)
hold on
plot(samples, a1_basicAR)
plot(samples, a2_srAR)
plot(samples, a2_basicAR)
hold off
title('Evolution of coefficients for AR(2) using Signed Regressor LMS for adaptation gain 0.005')
xlabel('Sample')
ylabel('Value')
legend('a1 signed regressor LMS','a1 basic LMS','a2 signed regressor LMS','a2 basic LMS')
% Plot evolution of a1 & a2 for sign - sign LMS identification
figure
plot(samples, a1_ssAR)
hold on
plot(samples, a1_basicAR)
plot(samples, a2_ssAR)
plot(samples, a2_basicAR)
hold off
title('Evolution of coefficients for AR(2) using Sign-Sign LMS for adaptation gain 0.005')
xlabel('Sample')
ylabel('Value')
legend('a1 sign-sign LMS','a1 basic LMS','a2 sign-sign LMS','a2 basic LMS')

% Get input "a" sound for Speech Recognition
fs_high = 44100;
secondsforN = N/fs_high;
recObj_a = audiorecorder(fs_high, 16, 1);
disp('Start a')
recordblocking(recObj_a, secondsforN*30);
disp('End of a recording.');
xSR = getaudiodata(recObj_a);
xSR = xSR((15*N)+1:(16*N));
%Set parameters
adaptationgainSR = 0.005;
processorderSR = 2;
%Apply basic LMS and retrieve coefficients
[xhat_basicSR, e_basicSR, aevol_basicSR] = predar2(xSR, adaptationgainSR, processorderSR)
a1_basicSR = aevol_basicSR(2,:);
a2_basicSR = aevol_basicSR(3,:);
%Apply sign LMS algorithms and retrieve coefficients
[xhat_seSR, e_seSR, aevol_seSR, xhat_srSR, e_srSR, aevol_srSR, xhat_ssSR, e_ssSR, aevol_ssSR] = signlms(xSR,adaptationgainSR,processorderSR);
a1_seSR = aevol_seSR(2,:);
a2_seSR = aevol_seSR(3,:);
a1_srSR = aevol_srSR(2,:);
a2_srSR = aevol_srSR(3,:);
a1_ssSR = aevol_ssSR(2,:);
a2_ssSR = aevol_ssSR(3,:);
% Plot evolution of a1 & a2 for signed error LMS identification
figure
plot(samples, a1_seSR)
hold on
plot(samples, a1_basicSR)
plot(samples, a2_seSR)
plot(samples, a2_basicSR)
hold off
title('Evolution of coefficients for "a" sound using Signed Error LMS for adaptation gain 0.005')
xlabel('Sample')
ylabel('Value')
legend('a1 signed error LMS','a1 basic LMS','a2 signed error LMS','a2 basic LMS')
% Plot evolution of a1 & a2 for signed regressor LMS identification
figure
plot(samples, a1_srSR)
hold on
plot(samples, a1_basicSR)
plot(samples, a2_srSR)
plot(samples, a2_basicSR)
hold off
title('Evolution of coefficients for "a" sound using Signed Regressor LMS for adaptation gain 0.005')
xlabel('Sample')
ylabel('Value')
legend('a1 signed regressor LMS','a1 basic LMS','a2 signed regressor LMS','a2 basic LMS')
% Plot evolution of a1 & a2 for sign - sign LMS identification
figure
plot(samples, a1_ssSR)
hold on
plot(samples, a1_basicSR)
plot(samples, a2_ssSR)
plot(samples, a2_basicSR)
hold off
title('Evolution of coefficients for "a" sound using Sign-Sign LMS for adaptation gain 0.005')
xlabel('Sample')
ylabel('Value')
legend('a1 sign-sign LMS','a1 basic LMS','a2 sign-sign LMS','a2 basic LMS')

