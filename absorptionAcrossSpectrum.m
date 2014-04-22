function c = absorptionAcrossSpectrum(type, n0, n2, d)
% construct list of tuples of wavelength, complex refractive index
% iterate through tuples, calculate currentAtWavelength at each and
% multiply by width of interval. Sum all of these
% So essentially we're only varying d. We can create a graph of current v.
% wavelength.
% This is only for silicon
%
% n0 - Refractive index of layer 0 (assumed to be real)
% n2 - Refractive index of layer 2 (assumed to be real)
% d - Thickness of the active layer in microns
%
% Conley April 2014

% read data from files
refIxReal = csvread('si_ref_ix_real.txt');
extCoef = csvread('si_ref_ix_imag.txt');
numVals = size(refIxReal, 1);

% zip together real and imaginary parts of refractive index
refractiveIndexes = zeros([numVals, 2]);
for i = 1:numVals
    refractiveIndexes(i, 1) = refIxReal(i, 1)/1000; % scale from nm to microns
    refractiveIndexes(i, 2) = refIxReal(i, 2) + 1i*extCoef(i, 2);
end

% estimate integral of current generated over spectrum
lambdas = refractiveIndexes(:, 1);
y = refractiveIndexes(:, 2);
refIxFnc = spline(lambdas, y);
f = @(lambda) ppval(refIxFnc, lambda); % takes wavelength in microns, returns complex n

% gaussian quadrature
numNodes = 10;
[lambdas, weights] = quadr.gauss(numNodes);
lambdas = (3*lambdas+5)/8;
weights = 3*weights/8;
c = 0;
% for j = 1:numNodes
%     w = weights(j);
%     lambda = lambdas(j);
%     k = 2*pi/lambda;
%     n1 = f(lambda);
%     
%     cj = currentAtWavelength(type, k, n0, n1, n2, d) * k * real(n1) * imag(n1);
%     c = c + w * cj;
% end

lambda = .35;
k = 2*pi/lambda;
n1 = f(lambda);
c = absorptionAtWavelength(type,k,n0,n1,n2,d);
end