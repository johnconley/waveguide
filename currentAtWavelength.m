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

% questions: do I pass in whole complex refractive index to find functions?
% do I have to take account of units anywhere (e.g. in microns)?
% todo: include TM case, write for other types of waveguides

function c = currentAtAngle(theta)
kappa = k * asin(theta);
nr = real(n1);
ni = imag(n1);

% use whole n1?
A = TEmatrix(n0, ni, n2, d, k, kappa);
b = [-1;-sqrt(n0^2*k^2-kappa^2);0;0];
coeffs = A\b;

% use whole n1?
a1 = sqrt(ni^2-kappa^2);

% we know kappa != k
absU_squared = @(y) abs(coeffs(2)*exp(1i*a1.*y) + coeffs(3)*exp(-1i*a1.*y)).^2;

c = quad(absU_squared, 0, d);
end

thetas = linspace(pi/6, pi/3, 100);
c = 0;
for theta = thetas
	c = c + currentAtAngle(theta);
    % c = quad(currentAtAngle, pi/6, pi/3);
end

end

