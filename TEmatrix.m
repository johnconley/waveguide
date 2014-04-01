function A = TEmatrix(n0, n1, n2, a, k, kappa)
% Amatrix - creates a matrix for the TE wave system
% 
% n0 - 
% n1 - 
% n2 - 
% a - 
% k - wavenumber
% kappa - frequency in the x direction
%
% Conley September 2013

% tolerance
tol = .06;

% define the exponents
a0 = sqrt(kappa^2-n0^2*k^2);
a1 = sqrt(kappa^2-n1^2*k^2);
a2 = sqrt(kappa^2-n2^2*k^2);

% kappa roughly equals n1*k
if (abs(kappa - n1*k) <= tol)
    if (kappa > n0*k)
        row1 = [1, -1, 0, 0];
        row2 = [a0, 0, 0, 0];
    else
        row1 = [1, -1, 0, 0];
        row2 = [-a0, 0, 0, 0];
    end
    
    if (kappa > n2*k)
        row3 = [0, 1, a, -exp(-a2*a)];
        row4 = [0, 0, 1, a2*exp(-a2*a)];
    else
        row3 = [0, 1, a, -exp(a2*a)];
        row4 = [0, 0, 1, -a2*exp(a2*a)];
    end
%     A = [1, -1, -1, 0;
%         a0, 0, 0, 0;
%         0, 1, a, -exp(-a2*a);
%         0, 0, 1, a2*exp(-a2*a)];
    A = [row1;
        row2;
        row3;
        row4];
    
else
    if (kappa > n0*k)
        row1 = [1, -1, -1, 0];
        row2 = [a0, -a1, a1, 0];
    else
        row1 = [1, -1, -1, 0];
        row2 = [-a0, -a1, a1, 0];
    end
    
    if (kappa > n2*k)
        row3 = [0, exp(a1*a), exp(-a1*a), -exp(-a2*a)];
        row4 = [0, a1*exp(a1*a), -a1*exp(-a1*a), a2*exp(-a2*a)];
    else
        row3 = [0, exp(a1*a), exp(-a1*a), -exp(a2*a)];
        row4 = [0, a1*exp(a1*a), -a1*exp(-a1*a), -a2*exp(a2*a)];
    end
    
    A = [row1;
        row2;
        row3;
        row4];

end
end