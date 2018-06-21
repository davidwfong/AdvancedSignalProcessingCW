%Part 3
load sunspot.dat
x = sunspot(:,2);
x = detrend(x);
x = x/std(x);
numorders = 10;
acf = xcorr(x, 'unbiased');
M = length(x);
a_set = zeros(10,10);
for i = 1:numorders
    p = i;
    %Rxx(0) occurs at sample 288 of sunspot data series
    H_col = acf(288:(288+(M-1)));
    H_row = acf(288:(288+(p-1)));
    H = toeplitz(H_col, H_row);
    H_pseudoinv = pinv(H);
    a_ls = H_pseudoinv*x;
    a_set(1:p, i) = a_ls;
end

%Part 4
for i = 1:numorders
    b = 1;
    tmp = a_set(1:i, i);
    tmp = tmp';
    a = [1 -tmp];
    wgn = randn(length(x),1);
    y = filter(b,[1 a],wgn);
    y = y/std(y);
    %Find approximation error
    er = mean(y-x);
    e(i) = er^2;
end
e = e / std(e);
figure
plot(e)
xlabel('AR model order')
ylabel('Approximation error')
title('Approximation error of AR models with respect to original sunspot data')


%Part 5
figure
for i = 1:numorders
    b = 1;
    tmp = a_set(1:i, i);
    tmp = tmp';
    a = [1 -tmp];
    wgn = randn(length(x),1);
    y = filter(b,[1 a],wgn);
    y = y/std(y);
    % Find power spectrum of y using AR model order i
    subplot(3,4,i)
    pyulear(y,i)
    hold on 
    pyulear(x,2)
    hold off
    er = mean(y - x);
    e(i) = er^2;
end

%Part 6
N = 10:5:250;
for i = 1:length(N)
    x = sunspot(:,2);
    x = x(1:N(i));
    x = detrend(x);
    x = x/std(x);
    acf = xcorr(x, 'unbiased');
    M = length(x);
    p = 2; 
    % Rxx(0) occurs at sample 288 of sunspot data series
    H_col = acf((floor(N(i)/2)+1):((floor(N(i)/2)+1)+(M-1)));
    H_row = acf((floor(N(i)/2)+1):((floor(N(i)/2)+1)+(p-1)));
    H = toeplitz(H_col, H_row);
    H_inv = pinv(H);
    a_ls = H_inv*x;
        
    tmp = a_ls;
    tmp = tmp';
    a = [1 -tmp];
    b = 1;
    wgn = randn(length(x),1);
    y = filter(b,[1 a],wgn);
    y = y/std(y);
    
    MSE(i) = mean((y-x).^2);
end
figure
plot(N,MSE)
xlabel('Data length N')
ylabel('Mean Squared Error')
title('MSE for optimal AR model order 2 versus length of data series')