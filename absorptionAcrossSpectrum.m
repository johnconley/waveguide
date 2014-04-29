function a = absorptionAcrossSpectrum(type, n0, n2, d)
% calculate absorptionAtWavelength at each wavelength and
% multiply by width of interval. Sum all of these
% So essentially we're only varying d. We can create a graph of current v.
% wavelength.
% This is only for silicon
%
% type - 'te' or 'tm'
% n0 - Refractive index of layer 0 (assumed to be real)
% n2 - Refractive index of layer 2 (assumed to be real)
% d - Thickness of the active layer in microns
%
% Conley April 2014

f = refIxFnc;

% gaussian quadrature
numNodes = 10;
[lambdas, weights] = quadr.gauss(numNodes);
lambdas = (3*lambdas+5)/8; % [.25, 1] microns
weights = 3*weights/8;
a = 0;
for j = 1:numNodes
    w = weights(j);
    lambda = lambdas(j);
    k = 2*pi/lambda;
    n1 = f(lambda);
    
    % I don't think this works anymore
    aj = absorptionAtWavelength(type, lambda, n0, n2, d, f) * k * real(n1) * imag(n1);
    a = a + w * aj;
end
end