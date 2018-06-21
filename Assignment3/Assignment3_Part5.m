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

%Part a
N1 = length(trial1RRI)
pgmtrial1RRI = pgm(trial1RRI);
pgmtrial1RRI = pgmtrial1RRI(1:N1/2);
range1 = 1:N1/2;
figure
plot(range1,pgmtrial1RRI)
xlim([0,N1/2])
ylim([0,4])
xlabel('Normalised Frequency (x2pi/1005)')
ylabel('Magnitude')
title('Periodogram of RRI data for trial 1')

N2 = length(trial2RRI)
pgmtrial2RRI = pgm(trial2RRI);
pgmtrial2RRI = pgmtrial2RRI(1:N2/2);
range2 = 1:N2/2;
figure
plot(range2,pgmtrial2RRI)
xlim([0,N2/2])
ylim([0,4])
xlabel('Normalised Frequency (x2pi/997)')
ylabel('Magnitude')
title('Periodogram of RRI data for trial 2')

N3 = length(trial3RRI)
pgmtrial3RRI = pgm(trial3RRI);
pgmtrial3RRI = pgmtrial3RRI(1:N3/2);
range3 = 1:N3/2;
figure
plot(range3,pgmtrial3RRI)
xlim([0,N3/2])
ylim([0,4])
xlabel('Normalised Frequency (x2pi/1015)')
ylabel('Magnitude')
title('Periodogram of RRI data for trial 3')

segmentlength = 50000/250; %number of samples in 50s of trial data / number of samples per RRI data sample
s = 1:segmentlength;
%Trial 1
trial1segment1 = trial1RRI(0*segmentlength+1:1*segmentlength);
trial1segment2 = trial1RRI(1*segmentlength+1:2*segmentlength);
trial1segment3 = trial1RRI(2*segmentlength+1:3*segmentlength);
trial1segment4 = trial1RRI(3*segmentlength+1:4*segmentlength);
trial1segment5 = trial1RRI(4*segmentlength+1:5*segmentlength);
trial1psdsegment1 = pgm(trial1segment1);
trial1psdsegment2 = pgm(trial1segment2);
trial1psdsegment3 = pgm(trial1segment3);
trial1psdsegment4 = pgm(trial1segment4);
trial1psdsegment5 = pgm(trial1segment5);
trial1psds = [trial1psdsegment1 ; trial1psdsegment2 ; trial1psdsegment3 ; trial1psdsegment4 ; trial1psdsegment5];
trial1averagedpgm = mean(trial1psds,1);
figure
plot(s, trial1averagedpgm)
xlim([0, segmentlength/2])
ylim([0,4])
xlabel('Normalised Frequency (x2pi/200)')
ylabel('Magnitude')
title('Average periodogram of 5 50s segments of RRI data for trial 1')

%Trial 2
trial2segment1 = trial2RRI(0*segmentlength+1:1*segmentlength);
trial2segment2 = trial2RRI(1*segmentlength+1:2*segmentlength);
trial2segment3 = trial2RRI(2*segmentlength+1:3*segmentlength);
trial2segment4 = trial2RRI(3*segmentlength+1:4*segmentlength);
trial2psdsegment1 = pgm(trial2segment1);
trial2psdsegment2 = pgm(trial2segment2);
trial2psdsegment3 = pgm(trial2segment3);
trial2psdsegment4 = pgm(trial2segment4);
trial2psds = [trial2psdsegment1 ; trial2psdsegment2 ; trial2psdsegment3 ; trial2psdsegment4];
trial2averagedpgm = mean(trial2psds,1);
figure
plot(s, trial2averagedpgm)
xlim([0, segmentlength/2])
ylim([0,4])
xlabel('Normalised Frequency (x2pi/200)')
ylabel('Magnitude')
title('Average periodogram of 4 50s segments of RRI data for trial 2')

%Trial 3
trial3segment1 = trial3RRI(0*segmentlength+1:1*segmentlength);
trial3segment2 = trial3RRI(1*segmentlength+1:2*segmentlength);
trial3segment3 = trial3RRI(2*segmentlength+1:3*segmentlength);
trial3segment4 = trial3RRI(3*segmentlength+1:4*segmentlength);
trial3segment5 = trial3RRI(4*segmentlength+1:5*segmentlength);
trial3psdsegment1 = pgm(trial3segment1);
trial3psdsegment2 = pgm(trial3segment2);
trial3psdsegment3 = pgm(trial3segment3);
trial3psdsegment4 = pgm(trial3segment4);
trial3psdsegment5 = pgm(trial3segment5);
trial3psds = [trial3psdsegment1 ; trial3psdsegment2 ; trial3psdsegment3 ; trial3psdsegment4 ; trial3psdsegment5];
trial3averagedpgm = mean(trial3psds,1);
figure
plot(s, trial3averagedpgm)
xlim([0, segmentlength/2])
ylim([0,4])
xlabel('Normalised Frequency (x2pi/200)')
ylabel('Magnitude')
title('Average periodogram of 5 50s segments of RRI data for trial 3')