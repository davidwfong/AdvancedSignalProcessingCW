function periodogram = pdf(v)

%figure %Part 1 Figure 1, Part 2 Figure 1 to 3
histogram(v,'Normalization','pdf');
xlim([-3 3])
ylim([0 0.5])
hold on
title('Estimated pdf for sample length N')
xlabel('sample')
hold off

