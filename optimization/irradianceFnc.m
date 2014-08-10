function f = irradianceFnc
% Generates a function of the solar spectral irradiance between .24 2.4
% microns. Return value has units W/m^2/micron
%
% Conley April 2014

irrData = csvread('spectralIrradiance.txt');

lambdas = irrData(:, 1) / 1000; % convert input from nm to micron
i = irrData(:, 2) * 1000; % convert from W/m^2/nm to W/m^2/micron
irrFnc = spline(lambdas, i);
f = @(lambda) ppval(irrFnc, lambda);
end