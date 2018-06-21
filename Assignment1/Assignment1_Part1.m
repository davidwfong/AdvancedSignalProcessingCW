%%Set-up
x = rand(1000,1);
figure %Part 1 Figure 1
plot(x)
hold off
title('1000-sample realisation of Uniform Random Variable X between 0 and 1')

%%Part 1
theoreticalMeanX = 0.5*(0+1)
sampleMeanX = mean(x)
differenceMeanX = abs(theoreticalMeanX - sampleMeanX) %accuracy sample mean

%%Part 2
theoreticalStandardDevX = (1-0)/sqrt(12)
sampleStandardDevX = std(x)
differenceStandardDevX = abs(theoreticalStandardDevX - sampleStandardDevX)

%%Part 3
ensembleX10 = rand(1000,10);
meanRealisationsX = mean(ensembleX10,1)
standardDevRealisationsX = std(ensembleX10,1)
biasMeanX = theoreticalMeanX - meanRealisationsX
biasStandardDevX = theoreticalStandardDevX - standardDevRealisationsX
figure %Part 1 Figure 2
plot(meanRealisationsX)
hold on
plot(standardDevRealisationsX)
hold off
title('Ensemble parameters for 10 realisations of X')
legend('sample means of X', 'sample standard deviations of X')
xlabel('Realisation')

%%Part 4
figure %Part 1 Figure 3
theoreticalpdfX = unifpdf(x,0,1);
plot(x,theoreticalpdfX)
hold on
histogram(x,'Normalization','pdf'); 
hold off
title('Estimate vs Theoretical pdf of X')
legend('Theoretical pdf of X', 'Normalised histogram of x')

%%Part 5
y = randn(1000,1);
Y=randn;
figure %Part 1 Figure 4
plot(y)
hold off
title('1000-sample realisation of Gaussian Random Variable Y of mean 0 and standard deviation 1')
%%Part 5.1
theoreticalMeanY = 0
sampleMeanY = mean(y)
differenceMeanY = abs(theoreticalMeanY - sampleMeanY) %accuracy sample mean
%%Part 5.2
theoreticalStandardDevY = 1
sampleStandardDevY = std(y)
differenceStandardDevY = abs(theoreticalStandardDevY - sampleStandardDevY)
%%Part 5.3
ensembleY10 = randn(1000,10);
meanRealisationsY = mean(ensembleY10,1)
standardDevRealisationsY = std(ensembleY10,1)
biasMeanY = theoreticalMeanY - meanRealisationsY
biasStandardDevY = theoreticalStandardDevY - standardDevRealisationsY
figure %Part 1 Figure 5
plot(meanRealisationsY)
hold on
plot(standardDevRealisationsY)
hold off
title('Ensemble parameters for 10 realisations of Y')
legend('sample means of Y', 'sample standard deviations of Y')
xlabel('Realisation')
%%Part 5.4
figure %Part 1 Figure 6
theoreticalpdfY = normpdf(y,0,1);
plot(y,theoreticalpdfY,'.')
hold on
histogram(y,'Normalization','pdf'); 
hold off
title('Estimate vs Theoretical pdf of Y')
legend('Theoretical pdf of Y', 'Normalised histogram of y')

