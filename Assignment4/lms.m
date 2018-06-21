function [yhat, e, wevol] = lms(x,z,adaptationgain,filterorder)
%x is the input data vector of size (N,1)
%z is the noisy output data vector of size (N,1)
%adaptation gain is what is varied 
%filter order is Nw+1
%yhat is adaptive filter output
%e is the error
N = length(x);
w = zeros(filterorder,1);
wevol = zeros(filterorder,N);
yhat = zeros(N,1);
e = zeros(N,1);
shift = zeros(filterorder-1,1);
xnew = vertcat(shift,x);
for n = 1:N
    xn = xnew(n:n+filterorder-1);
    xn = flipud(xn);
    yhat(n) = (w')*xn;
    e(n) = z(n) - yhat(n); 
    w = w + adaptationgain*e(n)*xn;
    wevol(:,n) = w;  
end

end