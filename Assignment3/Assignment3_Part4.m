%Part 1
%generate London landline nubmer
number = [0 2 0 0 0 0 0 0 0 0 0];
for i = 4:11
    number(i) = -1 + randi(10);
end
LondonLandlineNumber = number
%generate frequency vectors
fc1 = [697 770 852 941];
fc2 = [1209 1336 1477];
f1 = zeros(11,1);
f2 = zeros(11,1);
for i = 1:11
    if number(i) == 0
        f1(i) = fc1(4);
        f2(i) = fc2(2);
    elseif number(i) == 1
        f1(i) = fc1(1);
        f2(i) = fc2(1);
    elseif number(i) == 2
        f1(i) = fc1(1);
        f2(i) = fc2(2);
    elseif number(i) == 3
        f1(i) = fc1(1);
        f2(i) = fc2(3);
    elseif number(i) == 4
        f1(i) = fc1(2);
        f2(i) = fc2(1);
    elseif number(i) == 5
        f1(i) = fc1(2);
        f2(i) = fc2(2);
    elseif number(i) == 6
        f1(i) = fc1(2);
        f2(i) = fc2(3);
    elseif number(i) == 7
        f1(i) = fc1(3);
        f2(i) = fc2(1);
    elseif number(i) == 8
        f1(i) = fc1(3);
        f2(i) = fc2(2);
    elseif number(i) == 9
        f1(i) = fc1(3);
        f2(i) = fc2(3);
    end
end
%compute y 
segmenttime = 0.25;
fs = 32768;
Ts = 1/fs;
segmentlength =  segmenttime / Ts;
N = segmentlength*21;
segmentnumber = 1;
digit = 1;
for n = 1:N
    if rem(segmentnumber,2) == 0
        y(n) = 0;
    elseif rem(segmentnumber,2) == 1
        y(n) = sin(2*pi*f1(digit)*n/fs) + sin(2*pi*f2(digit)*n/fs);
    end
    if rem(n,segmentlength) == 0
        if rem(segmentnumber,2) == 0
            digit = digit + 1;
        end
        segmentnumber = segmentnumber + 1;
    end
end
%plot y
range2keys = 1:3*segmentlength;
y2keys = y(1:3*segmentlength);
figure
plot(range2keys / fs, y2keys)
xlim([0,0.75])
title('Segments 1 to 3 of Dial Tone Pad Signal')
xlabel('Time (seconds)')
ylabel('Magnitude')

%Part 2
%analyse spectral components of y
figure
spectrogram(y, hann(segmentlength), 0, segmentlength, fs,'yaxis');
v = zoom;
v.Motion = 'vertical';
v.Enable = 'on';
title('Spectrum of Dial Tone Pad Signal')
%analyse magnitude spectrum of segments 1 to 3
ykey1 = y2keys(1:segmentlength);
Ykey1 = fft(ykey1);
P2key1 = abs(Ykey1/segmentlength);
P1key1 = P2key1(1:segmentlength/2+1);
P1key1(2:end-1) = 2*P1key1(2:end-1);
ykey2 = y2keys(2*segmentlength+1:3*segmentlength);
Ykey2 = fft(ykey2);
P2key2 = abs(Ykey2/segmentlength);
P1key2 = P2key2(1:segmentlength/2+1);
P1key2(2:end-1) = 2*P1key2(2:end-1);
figure
f = (0:(segmentlength/2))*fs/segmentlength;
plot(f,10*log10(P1key1),'b') 
hold on
plot(f,10*log10(P1key2),'r') 
hold off
xlim([600,1600])
grid on
title('Magnitude Spectrum of segments 1 to 3 of Dial Tone Pad Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
legend('Digit 0', 'Digit 2')

%Part 4
%compute channel noises with variances 1 (low), 4 (medium), 64 (high)
lowvariance = 1;
midvariance = 64;
highvariance = 400;
noise = randn(N,1);
lownoise = sqrt(lowvariance)*noise;
midnoise = sqrt(midvariance)*noise;
highnoise = sqrt(highvariance)*noise;
ylow = lownoise;
ymid = midnoise;
yhigh = highnoise;
for n = 1:N
    ylow(n) = ylow(n) + y(n);
    ymid(n) = ymid(n) + y(n);
    yhigh(n) = yhigh(n) + y(n);
end
%plot key sequence of segments 1 to 3 of y with low-variance channel noise
y2keyslow = ylow(1:3*segmentlength);
figure
plot(range2keys / fs, y2keyslow)
xlim([0,0.75])
title('Segments 1 to 3 of Dial Tone Pad Signal with low-variance channel noise')
xlabel('Time (seconds)')
ylabel('Magnitude')
%analyse spectral components of y with low-variance channel noise
figure
spectrogram(ylow, hann(segmentlength), 0, segmentlength, fs,'yaxis');
title('Spectrum of Dial Tone Pad Signal with low-variance channel noise')
%analyse magnitude spectrum of segments 1 to 3 of y with low-variance channel noise
ykey1low = y2keyslow(1:segmentlength);
Ykey1low = fft(ykey1low);
P2key1low = abs(Ykey1low/segmentlength);
P1key1low = P2key1low(1:segmentlength/2+1);
P1key1low(2:end-1) = 2*P1key1low(2:end-1);
ykey2low = y2keyslow(2*segmentlength+1:3*segmentlength);
Ykey2low = fft(ykey2low);
P2key2low = abs(Ykey2low/segmentlength);
P1key2low = P2key2low(1:segmentlength/2+1);
P1key2low(2:end-1) = 2*P1key2low(2:end-1);
yidlelow = y2keyslow(segmentlength+1:2*segmentlength);
Yidlelow = fft(yidlelow);
P2idlelow = abs(Yidlelow/segmentlength);
P1idlelow = P2idlelow(1:segmentlength/2+1);
P1idlelow(2:end-1) = 2*P1idlelow(2:end-1);
figure
f = (0:(segmentlength/2))*fs/segmentlength;
plot(f,10*log10(P1key1low),'b') 
hold on
plot(f,10*log10(P1key2low),'r') 
plot(f,10*log10(P1idlelow),'g') 
hold off
xlim([600,1600])
grid on
title('Magnitude Spectrum of segments 1 to 3 of Dial Tone Pad Signal with low-variance channel noise')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
legend('Digit 0', 'Digit 2','Idle')

%plot key sequence of segments 1 to 3 of y with medium-variance channel noise
y2keysmid = ymid(1:3*segmentlength);
figure
plot(range2keys / fs, y2keysmid)
xlim([0,0.75])
title('Segments 1 to 3 of Dial Tone Pad Signal with medium-variance channel noise')
xlabel('Time (seconds)')
ylabel('Magnitude')
%analyse spectral components of y with medium-variance channel noise
figure
spectrogram(ymid, hann(segmentlength), 0, segmentlength, fs,'yaxis');
title('Spectrum of Dial Tone Pad Signal with medium-variance channel noise')
%analyse magnitude spectrum of segments 1 to 3 of y with medium-variance channel noise
ykey1mid = y2keysmid(1:segmentlength);
Ykey1mid = fft(ykey1mid);
P2key1mid = abs(Ykey1mid/segmentlength);
P1key1mid = P2key1mid(1:segmentlength/2+1);
P1key1mid(2:end-1) = 2*P1key1mid(2:end-1);
ykey2mid = y2keysmid(2*segmentlength+1:3*segmentlength);
Ykey2mid = fft(ykey2mid);
P2key2mid = abs(Ykey2mid/segmentlength);
P1key2mid = P2key2mid(1:segmentlength/2+1);
P1key2mid(2:end-1) = 2*P1key2mid(2:end-1);
yidlemid = y2keysmid(segmentlength+1:2*segmentlength);
Yidlemid = fft(yidlemid);
P2idlemid = abs(Yidlemid/segmentlength);
P1idlemid = P2idlemid(1:segmentlength/2+1);
P1idlemid(2:end-1) = 2*P1idlemid(2:end-1);
figure
f = (0:(segmentlength/2))*fs/segmentlength;
plot(f,10*log10(P1key1mid),'b') 
hold on
plot(f,10*log10(P1key2mid),'r') 
plot(f,10*log10(P1idlemid),'g') 
hold off
xlim([600,1600])
grid on
title('Magnitude Spectrum of segments 1 to 3 of Dial Tone Pad Signal with medium-variance channel noise')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
legend('Digit 0', 'Digit 2','Idle')

%plot key sequence of segments 1 to 3 of y with high-variance channel noise
y2keyshigh = yhigh(1:3*segmentlength);
figure
plot(range2keys / fs, y2keyshigh)
xlim([0,0.75])
title('Segments 1 to 3 of Dial Tone Pad Signal with high-variance channel noise')
xlabel('Time (seconds)')
ylabel('Magnitude')
%analyse spectral components of y with high-variance channel noise
figure
spectrogram(yhigh, hann(segmentlength), 0, segmentlength, fs,'yaxis');
title('Spectrum of Dial Tone Pad Signal with high-variance channel noise')
%analyse magnitude spectrum of segments 1 to 3 of y with high-variance channel noise
ykey1high = y2keyshigh(1:segmentlength);
Ykey1high = fft(ykey1high);
P2key1high = abs(Ykey1high/segmentlength);
P1key1high = P2key1high(1:segmentlength/2+1);
P1key1high(2:end-1) = 2*P1key1high(2:end-1);
ykey2high = y2keyshigh(2*segmentlength+1:3*segmentlength);
Ykey2high = fft(ykey2high);
P2key2high = abs(Ykey2high/segmentlength);
P1key2high = P2key2high(1:segmentlength/2+1);
P1key2high(2:end-1) = 2*P1key2high(2:end-1);
yidlehigh = y2keyshigh(segmentlength+1:2*segmentlength);
Yidlehigh = fft(yidlehigh);
P2idlehigh = abs(Yidlehigh/segmentlength);
P1idlehigh = P2idlehigh(1:segmentlength/2+1);
P1idlehigh(2:end-1) = 2*P1idlehigh(2:end-1);
figure
f = (0:(segmentlength/2))*fs/segmentlength;
plot(f,10*log10(P1key1high),'b') 
hold on
plot(f,10*log10(P1key2high),'r') 
plot(f,10*log10(P1idlehigh),'g') 
hold off
xlim([600,1600])
grid on
title('Magnitude Spectrum of segments 1 to 3 of Dial Tone Pad Signal with high-variance channel noise')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
legend('Digit 0', 'Digit 2','Idle')
