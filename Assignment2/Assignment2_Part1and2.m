%Part 1
x = randn(1000,1);
unbiasedEstimatex = xcorr(x,'unbiased');
figure %Part 1 Figure 1
k = -999:1:999
plot(k,unbiasedEstimatex)
xlim([-999 999])
title('ACF for 1000-sample realisation of WGN')
xlabel('Lag')
figure %Part 1 Figure 2
plot(k,unbiasedEstimatex)
axis([-999 999 -2000/100 2000/100])
zoom(2000/100)
title('ACF for 1000-sample realisation of WGN zoomed to lag<50')
xlabel('Lag')
y = filter(ones(9,1),[1],x)
unbiasedEstimatey = xcorr(y,'unbiased')
figure %Part 1 Figure 3
l = -999:1:999
stem(l,unbiasedEstimatey)
xlim([-20,20])
title('ACF estimate for MA filtered 1000-sample realisation of WGN')
xlabel('Lag')

%Part 2
figure %Part 2 Figure 1
ccfxy = xcorr(x,y,'unbiased')
stem(l,ccfxy)
xlim([-20,20])
title('CCF between input and output of filter for WGN signal')
xlabel('Lag')
