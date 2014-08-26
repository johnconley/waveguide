function a = totalSpectralAbsorbance(m, mirror, ix, ds, ns)
% wrapper function to optimize over thickness and refractive indices of an
% m-layer waveguide
% returns a, the proportion of incident photons absorbed (nonzero)
%
% m - number of layers in waveguide (excluding freespace, two conductive
% oxide layers, and final layer, which is either a mirror or infinite
% thickness)
% ix - 1 <= ix <= m is the index of the active layer
% ds(k) - thickness of layer k
% ns(k) - refractive index of layer k
%
% example:
% a = totalSpectralAbsorbance(3,false,3,[1,.7,.15],[1.5,2,3,1])

parentDir = fileparts(pwd());
addpath(strcat(parentDir,'/utils'));
addpath(strcat(parentDir,'/data'));

% conductive oxide layers (indium tin oxide, or ITO)
% see http://spie.org/x91028.xml?ArticleID=x91028,
% http://refractiveindex.info/legacy/?group=CRYSTALS&material=ITO,
% http://en.wikipedia.org/wiki/Transparent_conducting_film
d_ITO = .1;
n_ITO = 2+.06i;
ds = [ds(1:ix-1), d_ITO, ds(ix), d_ITO, ds(ix+1:end)];
ns = [ns(1:ix-1), n_ITO, ns(ix), n_ITO, ns(ix+1:end)];

te = 'te';
tm = 'tm';
f = refIxFnc;
i = irradianceFnc;
hc = 6.626e-34 * 3e8; % joules * m/s (Planck's constant * speed of light)

incomingPhotons = 0;
photonsAbsorbed = 0;

% gaussian quadrature
numNodes = 250;
[lambdas, weights] = quadr.gauss(numNodes);
a = .25; % min wavelength in microns
b = 1; %1.7726; % max wavelength in microns (chosen so that E >= .7 eV per photon)
lambdas = ((b-a)*lambdas + (b+a)) / 2;
weights = (b-a)*weights / 2;

for j = 1:numNodes
    w = weights(j);
    lambda = lambdas(j);
    irradiance = i(lambda);

    % photons/m^2/s/micron, calculated by irradiance * 1/E = 1/(hc/l)
    photons = irradiance*(lambda*1e-6/hc);
    
    if (lambda < 1.7726) % cutoff of .7 eV to kick up electron
        ns(ix+1) = f(lambda); % refractive index of active layer (silicon) at lambda
        k = 2*pi/lambda;
        kappa = 0; % normal incidence
        
        [teAbsorbance, ~] = solveMultilayer(te, mirror, k, kappa, ds, ns);
        [tmAbsorbance, ~] = solveMultilayer(tm, mirror, k, kappa, ds, ns);
        absorbance = (teAbsorbance + tmAbsorbance)/2;
        
        incomingPhotons = incomingPhotons + photons * w;
        photonsAbsorbed = photonsAbsorbed + (absorbance * photons) * w;
    end
end

a = (photonsAbsorbed+1)/incomingPhotons; % +1 => nonzero

end