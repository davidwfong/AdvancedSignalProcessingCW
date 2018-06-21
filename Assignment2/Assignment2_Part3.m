% Part 1
a1 = -2.5 + (2.5-(-2.5))*rand(100,1);
a2 = -1.5 + (1.5-(-1.5))*rand(100,1);
figure
for n = 1:1000
    i = randi(100);
    j = randi(100);
    if (a1(i)+a2(j) < 1) & (a2(j)-a1(i) < 1) & (abs(a2(j)) < 1)
        plot(a1(i),a2(j),'r*')
        hold on
    end
end
hold off
title('Stability plot for N = 1000')
xlabel('a1')
ylabel('a2')

%Part 2
load sunspot.dat %data in 2nd column of variable sunspot
sunspotdata = sunspot(:,2);
sunspotdata5 = sunspotdata(1:5);
sunspotdata20 = sunspotdata(1:20);
sunspotdata250 = sunspotdata(1:250);
sunspotdata5zeromean = sunspotdata5 - mean(sunspotdata5);
sunspotdata20zeromean = sunspotdata20 - mean(sunspotdata20);
sunspotdata250zeromean = sunspotdata250 - mean(sunspotdata250);
acfsunspotdata5 = xcorr(sunspotdata5,'coeff');
acfsunspotdata20 = xcorr(sunspotdata20,'coeff');
acfsunspotdata250 = xcorr(sunspotdata250,'coeff');
acfsunspotdata5zeromean = xcorr(sunspotdata5zeromean,'coeff');
acfsunspotdata20zeromean = xcorr(sunspotdata20zeromean,'coeff');
acfsunspotdata250zeromean = xcorr(sunspotdata250zeromean,'coeff');

figure

j = -4:1:4;
subplot(3,1,1)
stem(j,acfsunspotdata5,'b');
hold on
stem(j,acfsunspotdata5zeromean,'r');
hold off
axis([-4 4 -1 1])
legend('Empirical','Zero mean')
title('ACF for sunspot data length N=5')
xlabel('Lag')

k = -19:1:19;
subplot(3,1,2)
stem(k,acfsunspotdata20,'b');
hold on
stem(k,acfsunspotdata20zeromean,'r');
hold off
axis([-19 19 -1 1])
legend('Empirical','Zero mean')
title('ACF for sunspot data length N=20')
xlabel('Lag')

l = -249:1:249;
subplot(3,1,3)
stem(l,acfsunspotdata250,'b');
hold on
stem(l,acfsunspotdata250zeromean,'r');
hold off
axis([-249 249 -1 1])
legend('Empirical','Zero mean')
title('ACF for sunspot data length N=250')
xlabel('Lag')

figure 
stem(l,acfsunspotdata250,'b');
hold on
stem(l,acfsunspotdata250zeromean,'r');
hold off
axis([-249 249 -1 1])
xlim([0 25])
legend('Empirical','Zero mean')
title('ACF for sunspot data length N=250 for lags satisfying empirical bound')
xlabel('Lag')

%Part 3
sunspotdata5standardized = (sunspotdata5 - mean(sunspotdata5))/std(sunspotdata5);
sunspotdata20standardized = (sunspotdata20 - mean(sunspotdata20))/std(sunspotdata20);
sunspotdata250standardized = (sunspotdata250 - mean(sunspotdata250))/std(sunspotdata250);

for i = 2:10
    [arcoefs1,E,K] = aryule(sunspotdata20,i);
    pacfsunspotdata = -K;
    [arcoefs2,Es,Ks] = aryule(sunspotdata20standardized,i);
    pacfsunspotdatastandardized = -Ks;

    figure 
    stem(pacfsunspotdata,'b')
    hold on
    stem(pacfsunspotdatastandardized,'r')
    hold off
    xlabel('Lag')
    legend('Empirical','Zero mean')
    title('PACF for sunspot time series')
end

%Part 4
N = 250;
for i = 0:1:50
    [arcoefs3,VarS] = aryule(sunspotdata250standardized,i);
    lossfunction(i+1) = log(VarS);
    MDL(i+1) = lossfunction(i+1)+(i*log(N))/N;
    AIC(i+1) = lossfunction(i+1)+(2*i)/N;
end
p = 0:1:50;
figure
plot(p,MDL,'r')
hold on
plot(p,AIC,'b')
plot(p,lossfunction,'m')
hold off
xlabel('Model Order')
ylabel('Magnitude')
title('Model order selection criteria comparison')
legend('Minimum Description length','Akaike information Criterion','Loss function')


smallN = 5;
for j = 0:1:5
    [arcoefs3,VarS] = aryule(sunspotdata5standardized,j);
    lossfunctionsmall(j+1) = log(VarS);
    AICc(j+1) = lossfunctionsmall(j+1)+((2*j)/smallN) + ((2*j*(j+1))/(smallN-j-1));
end

figure
plot(p,lossfunction,'m')
hold on
plot(p,AICc,'g')
xlim([0 5])
xlabel('Model Order')
ylabel('Magnitude')
title('Model order selection criteria comparison for small sample size')
legend('Loss function','Corrected Akaike information Criterion')


%Part 5
ar1 = ar(sunspotdata250,1);
ar2 = ar(sunspotdata250,2);
ar10 = ar(sunspotdata250,10);

predm1ar1 = predict(ar1,sunspotdata250,1);
predm1ar2 = predict(ar2,sunspotdata250,1);
predm1ar10 = predict(ar10,sunspotdata250,1);

predm2ar1 = predict(ar1,sunspotdata250,2);
predm2ar2 = predict(ar2,sunspotdata250,2);
predm2ar10 = predict(ar10,sunspotdata250,2);

predm5ar1 = predict(ar1,sunspotdata250,5);
predm5ar2 = predict(ar2,sunspotdata250,5);
predm5ar10 = predict(ar10,sunspotdata250,5);

predm10ar1 = predict(ar1,sunspotdata250,10);
predm10ar2 = predict(ar2,sunspotdata250,10);
predm10ar10 = predict(ar10,sunspotdata250,10);

sample = 0:1:249;

figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm1ar1,'r')
plot(sample,predm1ar2,'y')
plot(sample,predm1ar10,'m')
hold off
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=1')
legend('Empirical data','AR(1)','AR(2)','AR(10)')
figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm1ar1,'r')
plot(sample,predm1ar2,'y')
plot(sample,predm1ar10,'m')
hold off
xlim([0 49])
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=1')
legend('Empirical data','AR(1)','AR(2)','AR(10)')

figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm2ar1,'r')
plot(sample,predm2ar2,'y')
plot(sample,predm2ar10,'m')
hold off
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=2')
legend('Empirical data','AR(1)','AR(2)','AR(10)')
figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm2ar1,'r')
plot(sample,predm2ar2,'y')
plot(sample,predm2ar10,'m')
hold off
xlim([0 49])
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=2')
legend('Empirical data','AR(1)','AR(2)','AR(10)')

figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm5ar1,'r')
plot(sample,predm5ar2,'y')
plot(sample,predm5ar10,'m')
hold off
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=5')
legend('Empirical data','AR(1)','AR(2)','AR(10)')
figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm5ar1,'r')
plot(sample,predm5ar2,'y')
plot(sample,predm5ar10,'m')
hold off
xlim([0 49])
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=5')
legend('Empirical data','AR(1)','AR(2)','AR(10)')

figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm10ar1,'r')
plot(sample,predm10ar2,'y')
plot(sample,predm10ar10,'m')
hold off
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=10')
legend('Empirical data','AR(1)','AR(2)','AR(10)')
figure
plot(sample,sunspotdata250,'b')
hold on
plot(sample,predm10ar1,'r')
plot(sample,predm10ar2,'y')
plot(sample,predm10ar10,'m')
hold off
xlim([0 49])
xlabel('Sample Number')
ylabel('Magnitude')
title('Sunspot Time series prediction for horizon m=10')
legend('Empirical data','AR(1)','AR(2)','AR(10)')