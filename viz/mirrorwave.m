function mirrorwave(type, n0, n1, n2, d1, d2, k, kappa, t)
% mirrorwave - plots mirror-backed waveguide with incident light in the y
% dimension
% 
% type - Transverse electric (TE) or transverse magnetic (TM)
% n0 - Refractive index of first layer
% n1 - Refractive index of second layer
% n2 - Refractive index of third layer
% d1 - Thickness of second layer
% d2 - Thickness of third layer
% k - Overall wavenumber
% kappa - Wavenumber in the x direction
% t - Time
%
% Conley October 2013

if (strcmp(type, 'te') == 1) %% type == 'te'
    A = mirrorTE(n0, n1, n2, d1, d2, k, kappa);
    b = [-1;-sqrt(kappa^2-n0^2*k^2);0;0;0];
    x = A\b;
else %% type == 'tm'
    return
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
f2 = @(y) x(4)*exp(a2*y) + x(5)*exp(-a2*y);

w = (2.998*10^8)*k;
ftime = exp(-1i*w*t);

% define the input values
step = 100;
left = linspace(-d2, 0, step);
middle = linspace(0, d1, step);
right = linspace(d1, d2, step);

% calculate and plot the function
lvals = f0(left)*ftime;
mvals = f1(middle)*ftime;
rvals = f2(right)*ftime;

domain = [left, middle, right];
range = [lvals, mvals, rvals];

plot(domain, real(range));

end
