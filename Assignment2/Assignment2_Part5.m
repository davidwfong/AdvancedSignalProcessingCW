load('RAW_3.mat')
figure
t = time;
value = data;
samplingfreq = fs;
%Start of first trial at 0.1390s = sample 1 
%End of first trial at 251.6000s = sample 251462
%Start of second trial at 252.8000s = sample 252662
%End of second trial at 502.1000s = sample 501962
%Start of third trial at 502.6000s = sample 502462
%End of third trial at 756.5040s = sample 756366
trial1 = t(1:251462);
value1 = value(1:251462);
figure
plot(value1)
[trial1RRI, fs1RRI] = ECG_to_RRI(value1,samplingfreq);
%create RRI file for trial 1

trial2 = t(1:501962-252662+1);
value2 = value(252662:501962);
figure
plot(value2)
[trial2RRI, fs2RRI] = ECG_to_RRI(value2,samplingfreq);
%create RRI file for trial 2

trial3 = t(1:756366-502462+1);
value3 = value(502462:756366);
figure
plot(value3)
[trial3RRI, fs3RRI] = ECG_to_RRI(value3,samplingfreq);
%create RRI file for trial 3

%Part 1
for i = 1:length(trial1RRI)
    heartrate(i) = 60 / trial1RRI(i);
end

for j = 1:length(trial1RRI)/10
    sigmah = heartrate((10*(j-1)+1):(10*(j-1)+10));
    heartratesmooth1(j) =  (1/10)*1*sum(sigmah);
    heartratesmooth2(j) =  (1/10)*0.6*sum(sigmah);
end

figure
pdf(heartrate)
title('Probability Density Estimate of original heart rate')

figure
pdf(heartratesmooth1)
title('Probability Density Estimate of averaged heart rate with alpha = 1')

figure
pdf(heartratesmooth2)
title('Probability Density Estimate of averaged heart rate with alpha = 0.6')


%Part 3
trial1RRIzeromean = detrend(trial1RRI);
trial2RRIzeromean = detrend(trial2RRI);
trial3RRIzeromean = detrend(trial3RRI);

acftrial1RRI = xcorr(trial1RRIzeromean);
acftrial2RRI = xcorr(trial2RRIzeromean);
acftrial3RRI = xcorr(trial3RRIzeromean);

figure
range1 = -(length(trial1RRIzeromean)-1):1:(length(trial1RRIzeromean)-1);
stem(range1, acftrial1RRI,'.')
xlim([-(length(trial1RRIzeromean)-1),(length(trial1RRIzeromean)-1)])
xlabel('Lag')
title('ACF of RRI data for trial 1')

figure
range2 = -(length(trial2RRIzeromean)-1):1:(length(trial2RRIzeromean)-1);
stem(range2, acftrial2RRI,'.')
xlim([-(length(trial2RRIzeromean)-1),(length(trial2RRIzeromean)-1)])
xlabel('Lag')
title('ACF of RRI data for trial 2')

figure
range3 = -(length(trial3RRIzeromean)-1):1:(length(trial3RRIzeromean)-1);
stem(range3, acftrial3RRI,'.')
xlim([-(length(trial3RRIzeromean)-1),(length(trial3RRIzeromean)-1)])
xlabel('Lag')
title('ACF of RRI data for trial 3')

%Part 4
[arcoefs1,E1,K1] = aryule(trial1RRIzeromean,10);
pacftrial1RRI = -K1;
figure 
stem(pacftrial1RRI)
xlabel('Lag')
title('PACF of RRI data for trial 1')

[arcoefs2,E2,K2] = aryule(trial2RRIzeromean,30);
pacftrial2RRI = -K2;
figure 
stem(pacftrial2RRI)
xlabel('Lag')
title('PACF of RRI data for trial 2')

[arcoefs3,E3,K3] = aryule(trial3RRIzeromean,10);
pacftrial3RRI = -K3;
figure 
stem(pacftrial3RRI)
xlabel('Lag')
title('PACF of RRI data for trial 3')

N1 = length(trial1RRIzeromean);
N2 = length(trial2RRIzeromean);
N3 = length(trial3RRIzeromean);

for i = 0:1:50
    [arcoefs1,E1] = aryule(trial1RRIzeromean,i);
    lossfunction1(i+1) = log(E1);
    MDL1(i+1) = lossfunction1(i+1)+(i*log(N1))/N1;
    AIC1(i+1) = lossfunction1(i+1)+(2*i)/N1;
    
    [arcoefs2,E2] = aryule(trial2RRIzeromean,i);
    lossfunction2(i+1) = log(E2);
    MDL2(i+1) = lossfunction2(i+1)+(i*log(N2))/N2;
    AIC2(i+1) = lossfunction2(i+1)+(2*i)/N2;
    
    [arcoefs3,E3] = aryule(trial3RRIzeromean,i);
    lossfunction3(i+1) = log(E3);
    MDL3(i+1) = lossfunction3(i+1)+(i*log(N3))/N3;
    AIC3(i+1) = lossfunction3(i+1)+(2*i)/N3;
end

p = 0:1:50;

figure
plot(p,MDL1,'r')
hold on
plot(p,AIC1,'b')
plot(p,lossfunction1,'m')
hold off
xlabel('Model Order')
ylabel('Magnitude')
title('Model order selection criteria comparison for trial 1 RRI data')
legend('Minimum Description length','Akaike information Criterion','Loss function')

figure
plot(p,MDL2,'r')
hold on
plot(p,AIC2,'b')
plot(p,lossfunction2,'m')
hold off
xlabel('Model Order')
ylabel('Magnitude')
title('Model order selection criteria comparison for trial 2 RRI data')
legend('Minimum Description length','Akaike information Criterion','Loss function')

figure
plot(p,MDL3,'r')
hold on
plot(p,AIC3,'b')
plot(p,lossfunction3,'m')
hold off
xlabel('Model Order')
ylabel('Magnitude')
title('Model order selection criteria comparison for trial 3 RRI data')
legend('Minimum Description length','Akaike information Criterion','Loss function')
