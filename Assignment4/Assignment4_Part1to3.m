%Question 1: Wiener filtering
N = 1000;
% Part 1: Execute for variance 0.01
% Generate 1000-sample WGN sequence x
x = randn(N,1);
% Filter x and normalise variance to obtain output y[n]
w = [1 2 3 2 1];
y = filter(w,[1],x);
stdy = std(y);
y = y / stdy;
w = w';
wnorm = w / stdy;
% Generate noise signal 
noise = randn(N,1);
% Set its standard deviation to 0.1 (variance = 0.01)
stdnoise = 0.1;
noise0 = noise * stdnoise/std(noise);
% Generate z[n]
z = y + noise0;
% Compute SNR in dB for z
SNRz = snr(y, noise0);

% Define Nw
Nw = 4;
% Calculate p (CCF of z and x)
praw = xcorr(x,z);
rzx0index = N;
rzxnegativeNwindex = rzx0index-Nw;
pflipped = praw(rzxnegativeNwindex:rzx0index);
p = flipud(pflipped);
% Calculate R (autucorrelation matx)
rxx = xcorr(x);
rxx0index = N;
rxxpositiveNwindex = rxx0index+Nw;
rxxcol = rxx(rxx0index:rxxpositiveNwindex);
R = toeplitz(rxxcol); 
% Find optimal coefficient vector of Wiener filter
Rinverse = inv(R);
wopt = Rinverse*p;
% Find difference between optimal filter and unknown system coefficients 
wdiff = wopt - wnorm;
meanwdiff = mean(wdiff);

%Part 2: Repeat for range of variances between 0.1 and 10
variances = [0.1 0.5 1 2 5 10];

%Find w for variances(1)=0.1
stdnoise1 = sqrt(variances(1));
noise1 = noise * stdnoise1;
z1 = y + noise1;
SNRz1 = snr(y, noise1);
praw1 = xcorr(x,z1);
pflipped1 = praw1(rzxnegativeNwindex:rzx0index);
p1 = flipud(pflipped1);
wopt1 = Rinverse*p1;
wdiff1 = wopt1 - wnorm;
meanwdiff1 = mean(wdiff1);

%Find w for variances(2)=0.5 
stdnoise2 = sqrt(variances(2));
noise2 = noise * stdnoise2;
z2 = y + noise2;
SNRz2 = snr(y, noise1);
praw2 = xcorr(x,z2);
pflipped2 = praw2(rzxnegativeNwindex:rzx0index);
p2 = flipud(pflipped2);
wopt2 = Rinverse*p2;
wdiff2 = wopt2 - wnorm;
meanwdiff2 = mean(wdiff2);

%Find w for variances(3)=1 
stdnoise3 = sqrt(variances(3));
noise3 = noise * stdnoise3;
z3 = y + noise3;
SNRz3 = snr(y, noise3);
praw3 = xcorr(x,z3);
pflipped3 = praw3(rzxnegativeNwindex:rzx0index);
p3 = flipud(pflipped3);
wopt3 = Rinverse*p3;
wdiff3 = wopt3 - wnorm;
meanwdiff3 = mean(wdiff3);

%Find w for variances(4)=2
stdnoise4 = sqrt(variances(4));
noise4 = noise * stdnoise4;
z4 = y + noise4;
SNRz4 = snr(y, noise4);
praw4 = xcorr(x,z4);
pflipped4 = praw4(rzxnegativeNwindex:rzx0index);
p4 = flipud(pflipped4);
wopt4 = Rinverse*p4;
wdiff4 = wopt4 - wnorm;
meanwdiff4 = mean(wdiff4);

%Find w for variances(5)=5
stdnoise5 = sqrt(variances(5));
noise5 = noise * stdnoise5;
z5 = y + noise5;
SNRz5 = snr(y, noise5);
praw5 = xcorr(x,z5);
pflipped5 = praw5(rzxnegativeNwindex:rzx0index);
p5 = flipud(pflipped5);
wopt5 = Rinverse*p5;
wdiff5 = wopt5 - wnorm;
meanwdiff5 = mean(wdiff5);

%Find w for variances(6)=10
stdnoise6 = sqrt(variances(6));
noise6 = noise * stdnoise6;
z6 = y + noise6;
SNRz6 = snr(y, noise6);
praw6 = xcorr(x,z6);
pflipped6 = praw6(rzxnegativeNwindex:rzx0index);
p6 = flipud(pflipped6);
wopt6 = Rinverse*p6;
wdiff6 = wopt6 - wnorm;
meanwdiff6 = mean(wdiff6);

%Question 2: LMS
Nw = 4;
% lms algorith applied to different signals
[yhatz1, ez1, wevolz1] = lms(x,z1,0.01,Nw+1);
wfinalz1 = wevolz1(:,end);
[yhatz2, ez2, wevolz2] = lms(x,z2,0.01,Nw+1);
wfinalz2 = wevolz2(:,end);
[yhatz3, ez3, wevolz3] = lms(x,z3,0.01,Nw+1);
wfinalz3 = wevolz3(:,end);
[yhatz4, ez4, wevolz4] = lms(x,z4,0.01,Nw+1);
wfinalz4 = wevolz4(:,end);
[yhatz5, ez5, wevolz5] = lms(x,z5,0.01,Nw+1);
wfinalz5 = wevolz5(:,end);
[yhatz6, ez6, wevolz6] = lms(x,z6,0.01,Nw+1);
wfinalz6 = wevolz6(:,end);
% lms algorithm applied to x and z with adaptation gain = 0.01
[yhat1, e1, wevol1] = lms(x,z,0.01,Nw+1);
samples = 1:1:N;
figure
plot(samples, y)
hold on
plot(samples, yhat1)
plot(samples, e1)
hold off
title('System identification with LMS algorithm with adaptation gain of 0.01')
xlabel('Sample')
ylabel('Magnitude')
legend('Reference signal y','Estimated signal yhat','Error signal e')
%lms algorithm applied to x and z with adaptation gain = 0.1, increased
[yhat2, e2, wevol2] = lms(x,z,0.1,Nw+1);
figure
plot(samples, y)
hold on
plot(samples, yhat2)
plot(samples, e2)
hold off
title('System identification with LMS algorithm with adaptation gain of 0.1')
xlabel('Sample')
ylabel('Magnitude')
legend('Reference signal y','Estimated signal yhat','Error signal e')
%lms algorithm applied to x and z with adaptation gain = 0.001, decreased
[yhat3, e3, wevol3] = lms(x,z,0.001,Nw+1);
figure
plot(samples, y)
hold on
plot(samples, yhat3)
plot(samples, e3)
hold off
title('System identification with LMS algorithm with adaptation gain of 0.001')
xlabel('Sample')
ylabel('Magnitude')
legend('Reference signal y','Estimated signal yhat','Error signal e')
%Plot evolution of coefficients for adaptation gain = 0.002
[yhat4, e4, wevol4] = lms(x,z,0.002,Nw+1);
w0_4 = wevol4(1,:);
w1_4 = wevol4(2,:);
w2_4 = wevol4(3,:);
w3_4 = wevol4(4,:);
w4_4 = wevol4(5,:);
figure
plot(samples, w0_4)
hold on
plot(samples, w1_4)
plot(samples, w2_4)
plot(samples, w3_4)
plot(samples, w4_4)
hold off
title('Evolution of coefficients with adaptation gain of 0.002')
xlabel('Sample')
ylabel('Value')
legend('w0','w1','w2','w3','w4')
%Plot evolution of coefficients for adaptation gain = 0.01
w0_1 = wevol1(1,:);
w1_1 = wevol1(2,:);
w2_1 = wevol1(3,:);
w3_1 = wevol1(4,:);
w4_1 = wevol1(5,:);
figure
plot(samples, w0_1)
hold on
plot(samples, w1_1)
plot(samples, w2_1)
plot(samples, w3_1)
plot(samples, w4_1)
hold off
title('Evolution of coefficients with adaptation gain of 0.01')
xlabel('Sample')
ylabel('Value')
legend('w0','w1','w2','w3','w4')
%Plot evolution of coefficients for adaptation gain = 0.1
w0_2 = wevol2(1,:);
w1_2 = wevol2(2,:);
w2_2 = wevol2(3,:);
w3_2 = wevol2(4,:);
w4_2 = wevol2(5,:);
figure
plot(samples, w0_2)
hold on
plot(samples, w1_2)
plot(samples, w2_2)
plot(samples, w3_2)
plot(samples, w4_2)
hold off
title('Evolution of coefficients with adaptation gain of 0.1')
xlabel('Sample')
ylabel('Value')
legend('w0','w1','w2','w3','w4')
%Plot evolution of coefficients for adaptation gain = 0.4
[yhat5, e5, wevol5] = lms(x,z,0.4,Nw+1);
w0_5 = wevol5(1,:);
w1_5 = wevol5(2,:);
w2_5 = wevol5(3,:);
w3_5 = wevol5(4,:);
w4_5 = wevol5(5,:);
figure
plot(samples, w0_5)
hold on
plot(samples, w1_5)
plot(samples, w2_5)
plot(samples, w3_5)
plot(samples, w4_5)
hold off
title('Evolution of coefficients with adaptation gain of 0.4')
xlabel('Sample')
ylabel('Value')
legend('w0','w1','w2','w3','w4')

%Question 3: Gear Shifting
initialmu = 0.05;
[yhat6, e6, wevol6] = lms(x,z,initialmu,Nw+1);
[yhat6gs, e6gs, wevol6gs] = lmsgearshift(x,z,initialmu,Nw+1);
% Plot evolution of coefficients for basic LMS and gear shifting algorithm
w0_6 = wevol6(1,:);
w1_6 = wevol6(2,:);
w2_6 = wevol6(3,:);
w3_6 = wevol6(4,:);
w4_6 = wevol6(5,:);
figure
plot(samples, w0_6)
hold on
plot(samples, w1_6)
plot(samples, w2_6)
plot(samples, w3_6)
plot(samples, w4_6)
hold off
%xlim([1,250])
title('Evolution of coefficients with Basic LMS algorithm using adaptation gain of 0.05')
xlabel('Sample')
ylabel('Value')
legend('w0','w1','w2','w3','w4')
w0_6gs = wevol6gs(1,:);
w1_6gs = wevol6gs(2,:);
w2_6gs = wevol6gs(3,:);
w3_6gs = wevol6gs(4,:);
w4_6gs = wevol6gs(5,:);
figure
plot(samples, w0_6gs)
hold on
plot(samples, w1_6gs)
plot(samples, w2_6gs)
plot(samples, w3_6gs)
plot(samples, w4_6gs)
hold off
%xlim([1,250])
title('Evolution of coefficients with Gear shifting algorithm using adaptation gain initialised to 0.05')
xlabel('Sample')
ylabel('Value')
legend('w0','w1','w2','w3','w4')
% Plot evolution of error for basic LMS and gear shifting algorithm
figure
plot(samples, e6)
title('Evolution of error with Basic LMS algorithm using adaptation gain of 0.05')
xlabel('Sample')
ylabel('Value')
figure
plot(samples, e6gs)
title('Evolution of error with Gear shifting algorithm using adaptation gain initialised to 0.05')
xlabel('Sample')
ylabel('Value')
