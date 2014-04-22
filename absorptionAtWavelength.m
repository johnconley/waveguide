function c = absorptionAtWavelength(type, k, n0, n1, n2, d)
% c - current generated in a three-layer waveguide with incident wave
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
% todo: write for other types of waveguides


% this takes longer, but finds maximum current over all incident angles
% but be careful, when calling currentAcrossSpectrum the max current for
% each wavelength may not have same incident angle
% thetas = linspace(pi/6, pi/3, 100);
% c = -Inf;
% for theta = thetas
% 	c = max(c, currentAtAngle(theta));
% end
c = absorptionAtAngle(pi/4);

function c = absorptionAtAngle(theta)
kappa = k * sin(theta);

if (strcmp(type, 'te') == 1) %% type == 'te'
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

c = (inFlux - outFlux) / inFlux; % this is absorption, must change to current
end % end currentAtAngle
end % end currentAtWavelength

