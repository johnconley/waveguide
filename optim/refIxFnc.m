function f = refIxFnc
% Generates a function of the refractive index of Si given a wavelength in
% microns. Should only be used for wavelengths between .2 and 2 microns
%
% Conley April 2014

% read data from files
refIxReal = csvread('SiRefractiveIndexReal.txt');
extCoef = csvread('SiRefractiveIndexImag.txt');
numVals = size(refIxReal, 1);

% zip together real and imaginary parts of refractive index
refractiveIndexes = zeros([numVals, 2]);
for i = 1:numVals
    refractiveIndexes(i, 1) = refIxReal(i, 1)/1000; % scale from nm to microns
    refractiveIndexes(i, 2) = refIxReal(i, 2) + 1i*extCoef(i, 2);
end

lambdas = refractiveIndexes(:, 1);
y = refractiveIndexes(:, 2);

refIxFnc = spline(lambdas, y);

    function n = fun(refIxFnc, lambda)
        n = ppval(refIxFnc, lambda);
        nr = real(n);
        ni = abs(imag(n));
        n = nr + 1i*ni;
    end

f = @(lambda) fun(refIxFnc, lambda);

% f = @(lambda) ppval(refIxFnc, lambda); % takes wavelength in microns, returns complex n
end