function A = mirrorTE(n0, n1, n2, d1, d2, k, kappa)
% A - matrix for the TE wave system of a three-layer waveguide with mirror
% backing
% 
% n0 - Refractive index of first layer
% n1 - Refractive index of second layer
% n2 - Refractive index of third layer
% d1 - Thickness of second layer
% d2 - Thickness of third layer
% k - Overall wavenumber
% kappa - Wavenumber in the x direction
%
% Conley October 2013

% define the exponents
a0 = sqrt(kappa^2-n0^2*k^2);
a1 = sqrt(kappa^2-n1^2*k^2);
a2 = sqrt(kappa^2-n2^2*k^2);


if (kappa > n0*k)
    row1 = [1, -1, -1, 0, 0];
    row2 = [a0, -a1, a1, 0, 0];
else
    row1 = [1, -1, -1, 0, 0];
    row2 = [-a0, -a1, a1, 0, 0];
end

row3 = [0, exp(a1*d1), exp(-a1*d1), -exp(a2*d1), -exp(-a2*d1)];
row4 = [0, a1*exp(a1*d1), -a1*exp(-a1*d1), -a2*exp(a2*d1), a2*exp(-a2*d1)];
row5 = [0, 0, 0, exp(a2*d2), exp(-a2*d2)];

A = [row1;
    row2;
    row3;
    row4;
    row5];

end
