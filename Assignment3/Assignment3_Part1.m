%Part 0
pgmwgn128 = pgm(randn(128,1));
pgmwgn128real = pgmwgn128(1:length(pgmwgn128)/2)
range1 = 1:1:128/2;
figure
stem(range1,pgmwgn128real)
xlim([1,64])
xlabel('Normalised Frequency (x2pi/128)')
ylabel('Magnitude')
title('Periodogram for 128-sample WGN realisation')

pgmwgn256 = pgm(randn(256,1));
pgmwgn256real = pgmwgn256(1:length(pgmwgn256)/2)
range2 = 1:1:256/2;
figure
stem(range2,pgmwgn256real)
xlim([1,128])
xlabel('Normalised Frequency (x2pi/256)')
ylabel('Magnitude')
title('Periodogram for 256-sample WGN realisation')

N = 512;
pgmwgn512 = pgm(randn(N,1));
pgmwgn512real = pgmwgn512(1:length(pgmwgn512)/2)
n = 1:1:N/2;
figure
stem(n,pgmwgn512real)
xlim([1,N/2])
xlabel('Normalised Frequency (x2pi/512)')
ylabel('Magnitude')
title('Periodogram for 512-sample WGN realisation')

%Part 1
impulseresponse = 0.2*ones(5,1);
smoothedpgm = filter(impulseresponse, 1, pgmwgn512real);
figure
stem(n,smoothedpgm)
xlim([1,N/2])
xlabel('Normalised Frequency (x2pi/512)')
ylabel('Magnitude')
title('Periodogram of filtered WGN sequence of length 512')

%Part 2
wgn1024 = randn(1024,1);
segmentnumber = 8;
segmentindex = (1024/2)/segmentnumber;
segment1 = wgn1024(1:segmentindex);
segment2 = wgn1024(segmentindex+1:2*segmentindex);
segment3 = wgn1024(2*segmentindex+1:3*segmentindex);
segment4 = wgn1024(3*segmentindex+1:4*segmentindex);
segment5 = wgn1024(4*segmentindex+1:5*segmentindex);
segment6 = wgn1024(5*segmentindex+1:6*segmentindex);
segment7 = wgn1024(6*segmentindex+1:7*segmentindex);
segment8 = wgn1024(7*segmentindex+1:8*segmentindex);
psdsegment1 = pgm(segment1);
psdsegment2 = pgm(segment2);
psdsegment3 = pgm(segment3);
psdsegment4 = pgm(segment4);
psdsegment5 = pgm(segment5);
psdsegment6 = pgm(segment6);
psdsegment7 = pgm(segment7);
psdsegment8 = pgm(segment8);

s = 1:1:(1024/2)/segmentnumber;
figure
subplot(4,2,1)
stem(s,psdsegment1)
xlim([1,segmentindex])
title('PSD estimate of segment 1')
subplot(4,2,2)
stem(s,psdsegment2)
xlim([1,segmentindex])
title('PSD estimate of segment 2')
subplot(4,2,3)
stem(s,psdsegment3)
xlim([1,segmentindex])
title('PSD estimate of segment 3')
subplot(4,2,4)
stem(s,psdsegment4)
xlim([1,segmentindex])
title('PSD estimate of segment 4')
subplot(4,2,5)
stem(s,psdsegment5)
xlim([1,segmentindex])
title('PSD estimate of segment 5')
subplot(4,2,6)
stem(s,psdsegment6)
xlim([1,segmentindex])
title('PSD estimate of segment 6')
subplot(4,2,7)
stem(s, psdsegment7)
xlim([1,segmentindex])
title('PSD estimate of segment 7')
subplot(4,2,8)
stem(s, psdsegment8)
xlim([1,segmentindex])
title('PSD estimate of segment 8')
    
%Part 3
totalpsds = [psdsegment1 ; psdsegment2 ; psdsegment3 ; psdsegment4 ; psdsegment5 ; psdsegment6 ; psdsegment7 ; psdsegment8];
averagedpgm = mean(totalpsds,1);
figure
stem(s, averagedpgm)
xlim([1,segmentindex])
xlabel('Normalised Frequency (x2pi/128)')
ylabel('Magnitude')
title('Average periodogram of 8 segments of WGN')
