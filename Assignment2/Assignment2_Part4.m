load NASDAQ.mat
dates = NASDAQ.Date; %time values of closing prices
closingprices = NASDAQ.Close; %closing prices
N = length(closingprices)
datenum = 1:1:N;
figure
plot(datenum, closingprices)

%Part a
for i = 1:10
    [arcoefs,E,K] = aryule(closingprices,i);
    pacfNASDAQ = -K;
    figure 
    stem(pacfNASDAQ,'b')
    xlabel('Lag')
    title('PACF for NASDAQ closing prices')
end


for i = 0:1:20
    lossfunction(i+1) = log(E);
    MDL(i+1) = lossfunction(i+1)+(i*log(N))/N;
    AIC(i+1) = lossfunction(i+1)+(2*i)/N;
end
order = 0:1:20;
figure
plot(order,MDL,'r')
hold on
plot(order,AIC,'b')
hold off
xlabel('Model Order')
ylabel('Magnitude')
title('MDL and AIC for NASDAQ time series')
legend('Minimum Description length','Akaike information Criterion')

%Part ci 
acfx = xcorr(closingprices);
acfmax = max(acfx)

datapoints = 1:50:1001
datapointstimesacfmax = datapoints.*acfmax
variance = 1:50:1001
variancesquared = variance.^2
variancetransposed = variance.'
variancesquaredtransposed = variancesquared.'

numCRLBtheta2 = 2*variancesquaredtransposed
denomCRLBtheta2 = 1./datapoints
numCRLBtheta1 = variancetransposed
denomCRLBtheta1 = 1./datapointstimesacfmax

figure
CRLBtheta2 = numCRLBtheta2 * denomCRLBtheta2
heatmap(datapoints,variance,CRLBtheta2)
xlabel('Number of data points')
ylabel('True variance')
title('CRLB for estimated variance parameter')

figure
CRLBtheta1 = numCRLBtheta1 * denomCRLBtheta1
heatmap(datapoints,variance,CRLBtheta1)
xlabel('Number of data points')
ylabel('True variance')
title('CRLB for estimated a1 parameter')

%Part cii
[arcoefs,E,K] = aryule(closingprices,1);
variancea1 = abs(K /(N*acfmax))
