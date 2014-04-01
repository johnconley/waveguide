function scattwave2d(type, n0, n1, n2, a, k, kappa, t)
% scattwave2d - plots
%
% n0 - 
% n1 - 
% n2 - 
% a - 
% k - wavenumber
% kappa - frequency in the x direction
%
% Conley October 2013

if (strcmp(type, 'te') == 1) %% type == 'te'
    A = TEmatrix(n0, n1, n2, a, k, kappa);
    b = [-1;-sqrt(kappa^2-n0^2*k^2);0;0];
    x = A\b;
else %% type == 'tm'
    A = TMmatrix(n0, n1, n2, a, k, kappa);
    b = [-1;-sqrt(kappa^2-n0^2*k^2)/(n0^2);0;0];
    x = A\b;
end

% define the exponents and functions
a0 = sqrt(kappa^2-n0^2*k^2);
a1 = sqrt(kappa^2-n1^2*k^2);
a2 = sqrt(kappa^2-n2^2*k^2);

if (kappa > n0*k)
    f0 = @(y) exp(a0*y)+x(1)*exp(a0*y);
else
    f0 = @(y) exp(a0*y)+x(1)*exp(-a0*y);
end
f1 = @(y) x(2)*exp(a1*y) + x(3)*exp(-a1*y);
if (kappa > n2*k)
    f2 = @(y) x(4)*exp(-a2*y);
else
    f2 = @(y) x(4)*exp(a2*y);
end

w = (2.998*10^8)*k;
ftime = exp(-1i*w*t);

% define the input values
n = 100;
left = linspace(-a, 0, n);
middle = linspace(0, a, n);
right = linspace(a, 2*a, n);

% calculate u(y)
lvals = f0(left)*ftime;
mvals = f1(middle)*ftime;
rvals = f2(right)*ftime;
y = [lvals, mvals, rvals];

% calculate u(x)
x = linspace(0, 3*a, 3*n);
x = exp(1i*kappa*x);

% combine x and y and plot
vals = kron(x,y);
vals = reshape(vals,3*n,3*n);
imagesc(real(vals));
colorbar;

end
