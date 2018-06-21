function p = pgm(inputseq)

N = length(inputseq);
fftinputseq = fft(inputseq);
for f = 1:N
    psd(f) = abs(fftinputseq(f)).^2;
    p(f) = psd(f) ./ N;
end
end