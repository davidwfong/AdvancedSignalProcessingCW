function [yhat, e, wevol] = lmsgearshift(x,z,initadaptationgain,filterorder)
N = length(x);
w = zeros(filterorder,1);
wevol = zeros(filterorder,N);
yhat = zeros(N,1);
e = zeros(N,1);
adaptationgain = initadaptationgain;
shift = zeros(filterorder-1,1);
xnew = vertcat(shift,x);
%Calculate minimum mean squared error i.e. MSE of Wiener Filter
praw = xcorr(x,z);
rzx0index = N;
rzxnegativeNwindex = rzx0index-(filterorder-1);
pflipped = praw(rzxnegativeNwindex:rzx0index);
p = flipud(pflipped)
rxx = xcorr(x);
rxx0index = N;
rxxpositiveNwindex = rxx0index+(filterorder-1);
rxxcol = rxx(rxx0index:rxxpositiveNwindex);
R = toeplitz(rxxcol);
Rinverse = inv(R);
wopt = Rinverse*p;
zsquared = z.^2;
term1 = mean(zsquared)
term2 = 2*(wopt')*p
term3 = (wopt')*R*wopt
msemin = term1 - term2 + term3
threshold = 0.1*msemin;
shiftgears = true;
for n = 1:N
    xn = xnew(n:n+filterorder-1);
    xn = flipud(xn);
    yhat(n) = (w')*xn;
    e(n) = z(n) - yhat(n);
    mse = e(n)^2;
    msediff = mse-msemin;
    if (msediff <= threshold) & (shiftgears == true)
        changepoint = n
        adaptationgain = adaptationgain/5;
        shiftgears = false;
    end
    w = w + adaptationgain*e(n)*xn;
    wevol(:,n) = w; 
end
end
