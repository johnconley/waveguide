function [absorption, coeffs] = multilayer_solver(polarization, mirror, k, kappa, ds, ns)
%
% polarization - 'te' for transverse electric and 'tm' for trasnverse
% magnetic
% mirror - true if layer n+1 is a perfect mirror, false otherwise
% k - overall wavenumber in freespace
% kappa - overall wavenumber in the x direction
% ds - d(j) = thickness of layer j
% ns - ns(j) = complex refractive index of layer j (must have one more
% index than ds to give refractive index of final layer if not mirror)


% check input: k != 0, length(ns) = length(ds)+1, ds(j) > 0,
% ns(j) != 0 (except for last one)

i = 1i;
m = length(ds); % number of layers (excluding freespace and final infinite layer)
size = 2*m + 2;

if (strcmp(polarization, 'tm') == 1)
    tm = true;
else
    tm = false;
end

% change ds so that ds(j) is distance from j-(j+1) boundary to
% freespace-waveguide boundary
for j=2:m
    ds(j) = ds(j-1) + ds(j);
end


n0 = 1; % refractive index of freespace
a0 = sqrt((n0*k)^2 - kappa^2);
n1 = ns(1); % refractive index of first layer
a1 = sqrt((n1*k)^2 - kappa^2);
nf = ns(m+1); % refractive index of last layer (mirror or other)
if mirror
    nf = 0;
end

A = zeros(size);

A(1,1) = 1;
A(1,2) = -1;
A(1,3) = -1;
A(2,1) = -i*conj(a0);
A(2,2) = -i*a1;
A(2,3) = i*a1;

if tm
    A(2,1) = A(2,1)/n0^2;
    A(2,2) = A(2,2)/n1^2;
    A(2,3) = A(2,3)/n1^2;
end

% what happens if kappa roughly equals n*k?
for layer = 1:m
    r = 2*layer + 1;
    c = 2*layer;
    
    d = ds(layer);
    
    % current layer
    n = ns(layer);
    a = sqrt((n*k)^2 - kappa^2);
    % next layer
    nn = ns(layer+1);
    aa = sqrt((nn*k)^2 - kappa^2);
    
    A(r,c) = exp(i*a*d);
    A(r+1,c) = i*a*exp(i*a*d);
    A(r,c+1) = exp(-i*a*d);
    A(r+1,c+1) = -i*a*exp(-i*a*d);
    A(r,c+2) = -exp(i*aa*d);
    A(r+1,c+2) = -i*aa*exp(i*aa*d);
    if (layer < m)
        A(r,c+3) = -exp(-i*aa*d);
        A(r+1,c+3) = i*aa*exp(-i*aa*d);
    end
    
    % won't work if mirror
    if tm
        A(r+1,c) = A(r+1,c)/n^2;
        A(r+1,c+1) = A(r+1,c+1)/n^2;
        A(r+1,c+2) = A(r+1,c+2)/nn^2;
        if (layer < m)
            A(r+1,c+3) = A(r+1,c+3)/nn^2;
        end
    end
    
end

b = zeros(size, 1);
b(1) = -1;
b(2) = -i*conj(a0);
if tm
    b(2) = b(2)/n0^2;
end

coeffs = A\b;

inFlux = n0*k;
outFlux = n0*k*abs(coeffs(1))^2 + nf*k*abs(coeffs(size))^2;

absorption = (inFlux - outFlux) / inFlux;

end