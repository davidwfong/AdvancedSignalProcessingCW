%Part 1
v1=rp1(100,100);
v2=rp2(100,100);
v3=rp3(100,100);
meanEnsemblev1 = mean(v1,1); 
meanEnsemblev2 = mean(v2,1); 
meanEnsemblev3 = mean(v3,1); 
stdEnsemblev1 = std(v1,0,1); 
stdEnsemblev2 = std(v2,0,1);
stdEnsemblev3 = std(v3,0,1);
figure % Part 1 Figure 1
plot(meanEnsemblev1)
hold on
plot(stdEnsemblev1)
hold off
title('Ensemble Mean and Standard Deviation vs time for stochastic process rp1')
legend('Ensemble Mean','Ensemble Standard Deviation')

figure %Part 1 Figure 2
plot(meanEnsemblev2)
hold on
plot(stdEnsemblev2)
hold off
title('Ensemble Mean and Standard Deviation vs time for stochastic process rp2')
legend('Ensemble Mean','Ensemble Standard Deviation')

figure %Part 1 Figure 3
plot(meanEnsemblev3)
hold on
plot(stdEnsemblev3)
hold off
title('Ensemble Mean and Standard Deviation vs time for stochastic process rp3')
legend('Ensemble Mean','Ensemble Standard Deviation')

%Part 2
w1=rp1(4,1000);
w2=rp2(4,1000);
w3=rp3(4,1000);
meanEnsemblew1 = mean(w1,2) 
meanEnsemblew2 = mean(w2,2) 
meanEnsemblew3 = mean(w3,2) 
stdEnsemblew1 = std(w1,0,2) 
stdEnsemblew2 = std(w2,0,2)
stdEnsemblew3 = std(w3,0,2)

%Part 3: Done on paper
