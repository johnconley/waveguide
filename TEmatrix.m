function A = TEmatrix(n0, n1, n2, a, k, kappa)
% A - matrix for the TE wave system
% 
% n0 - 
% n1 - 
% n2 - 
% a - 
% k - wavenumber
% kappa - frequency in the x direction
%
% Conley April 2014

% tolerance
tol = .06;

% define the exponents
a0 = sqrt(n0^2*k^2-kappa^2);
a1 = sqrt(n1^2*k^2-kappa^2);
a2 = sqrt(n2^2*k^2-kappa^2);

% kappa roughly equals n1*k
if (abs(kappa - n1*k) <= tol)
    row1 = [1, -1, 0, 0];
    row2 = [-1i*a0, 0, 0, 0];
    row3 = [0, 1, a, -exp(1i*a2*a)];
    row4 = [0, 0, 1, -1i*a2*exp(1i*a2*a)];
else
    row1 = [1, -1, -1, 0];
    row2 = [-1i*a0, -1i*a1, 1i*a1, 0];
    row3 = [0, exp(1i*a1*a), exp(-1i*a1*a), -exp(1i*a2*a)];
    row4 = [0, 1i*a1*exp(1i*a1*a), -1i*a1*exp(-1i*a1*a), -1i*a2*exp(1i*a2*a)];
end

A = [row1;
    row2;
    row3;
    row4];

end