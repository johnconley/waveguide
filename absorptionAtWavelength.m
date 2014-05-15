function a = absorptionAtWavelength(pol, lambda, n0, n2, d, f)
% a - absorption in a three-layer waveguide with incident wave
% currently this only works for TE three-layer waveguide with incident wave
%
% pol - 'te' or 'tm'
% lambda - Wavelength in microns
% n0 - Refractive index of layer 0 (assumed to be real)
% n2 - Refractive index of layer 2 (assumed to be real)
% d - Thickness of the active layer in microns
%
% Conley April 2014

% questions: how do I take account of units in microns?
% todo: write for other types of waveguides


% this takes longer, but finds maximum current over all incident angles
% but be careful, when calling currentAcrossSpectrum the max current for
% each wavelength may not have same incident angle
% thetas = linspace(pi/6, pi/3, 100);
% c = -Inf;
% for theta = thetas
% 	c = max(c, currentAtAngle(theta));
% end

k = 2*pi/lambda; % wavenumber in radians/micron
n1 = f(lambda); % complex refractive index of silicon at wavelength lambda

theta = 0; % normal incidence
kappa = k * sin(theta);

if (strcmp(pol, 'te') == 1) %% type == 'te'
    A = TEmatrix(n0, n1, n2, d, k, kappa);
    b = [-1;-1i*conj(sqrt(n0^2*k^2-kappa^2));0;0];
    coeffs = A\b;
else %% type == 'tm'
    A = TMmatrix(n0, n1, n2, d, k, kappa);
    b=[-1;-1i*conj(sqrt(n0^2*k^2-kappa^2))/(n0^2);0;0];
    coeffs = A\b;
end

c1 = coeffs(1);
c4 = coeffs(4);

inFlux = n0*k;
outFlux = n0*k*abs(c1)^2+n2*k*abs(c4)^2;

a = (inFlux - outFlux) / inFlux; % this is absorption, must change to current
end

