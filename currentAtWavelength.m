function c = currentAtWavelength(k, n0, n1, n2, d)
% testing with lambda=.5, n0=6, n1=4.277+.066i, n2=6, d=.05
% currently this only works for TE three-layer waveguide with incident wave
%
% k - Wavenumber in radians/micron
% n0 - Refractive index of layer 0 (assumed to be real)
% n1 - Complex refractive index of the active layer at wavelength 2*pi/k
% n2 - Refractive index of layer 2 (assumed to be real)
% d - Thickness of the active layer in microns
%
% Conley April 2014

% questions: how do I take account of units in microns?
% todo: include TM case, write for other types of waveguides


% do we want to sweep over angles???
% thetas = linspace(pi/6, pi/3, 100);
% c = 0;
% for theta = thetas
% 	c = c + currentAtAngle(theta);
% end
c = currentAtAngle(pi/4);

function c = currentAtAngle(theta)
kappa = k * sin(theta);

A = TEmatrix(n0, n1, n2, d, k, kappa);
b = [-1;-sqrt(n0^2*k^2-kappa^2);0;0];
coeffs = A\b;

a1 = sqrt(n1^2-kappa^2);

% we know kappa != k
% old quad scheme
% absU_squared = @(y) abs(coeffs(2)*exp(1i*a1.*y) + coeffs(3)*exp(-1i*a1.*y)).^2;
% c = quad(absU_squared, 0, d);

% gaussian quadrature
numNodes = 10;
[x, w] = quadr.gauss(numNodes);
x = ((x+1)*d)/2;
w = w*d/2;
u = @(y) coeffs(2)*exp(1i*a1*y) + coeffs(3)*exp(-1i*a1*y);
c = 0;
for j = 1:numNodes
    wj = w(j);
    uj = abs(u(x(j)))^2;
    c = c + wj * uj;
end % end for loop
end % end currentAtAngle
end % end currentAtWavelength
