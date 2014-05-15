function totalSpectralAbsorption(mirror, activeLayer, ds, ns)
%
%
% mirror - true if layer n+1 is a perfect mirror, false otherwise
% activeLayer - if activeLayer == j, then jth layer is active layer
% ds - d(j) = thickness of layer j
% ns - ns(j) = complex refractive index of layer j (must have one more
% index than ds to give refractive index of final layer if not mirror) 
%
% Conley May 2014

te = 'te';
tm = 'tm';
theta = 0; % normal incidence
f = refIxFnc;
i = irradianceFnc;
hc = 6.626e-34 * 3e8; % joules * m/s (Planck's constant * speed of light)

% gaussian quadrature
numNodes = 100;
[lambdas, weights] = quadr.gauss(numNodes);
a = .25; % min wavelength in microns
b = 1.7726; % max wavelength in microns (chosen so that E >= .7 eV per photon)
lambdas = ((b-a)*lambdas + (b+a)) / 2;
weights = (b-a)*weights / 2;

photonsAbsorbed = 0;
incomingPhotons = 0;
% make this more clear: as is absorption over spectrum, ps is # incident
% photons over spectrum
as=0*lambdas; ps = as;
totIrr = 0; % total irradiance

for j = 1:numNodes
    w = weights(j);
    lambda = lambdas(j);
    irradiance = i(lambda);
    totIrr = totIrr + irradiance * w;

    % photons is photons/m^2/s/micron
    % calculated by irradiance * 1/E = 1/(hc/lambda)
    photons = irradiance*(lambda*1e-6/hc);
    ps(j) = photons;
    
    if (lambda < 1.7726) % cutoff of .7 eV to kick up electron
        
        k = 2*pi/lambda; % wavenumber in radians/micron
        ns(activeLayer) = f(lambda); % complex refractive index of silicon at wavelength lambda
        kappa = k * sin(theta);
        
        teAbsorption = multilayer_solver(te, mirror, k, kappa, ds, ns);
        tmAbsorption = multilayer_solver(tm, mirror, k, kappa, ds, ns);
        
        absorption = (teAbsorption + tmAbsorption)/2;
%         absorption = 1;
        as(j) = absorption;
        incomingPhotons = incomingPhotons + photons * w;
        photonsAbsorbed = photonsAbsorbed + (absorption * photons) * w;
        fprintf('%.3g  %.3g  %.3g\n',lambda,teAbsorption,tmAbsorption);
    end
end

plot(lambdas,as,'.-',lambdas,ps/6e21,'r.-');
fprintf('total incident photons = %.3g\n', incomingPhotons);
fprintf('photons absorbed = %.3g\n', photonsAbsorbed);
fprintf('percentage absorbed = %.3g\n\n', 100*photonsAbsorbed/incomingPhotons);

% need to look over all this
%
% why?
fprintf('incoming current/m^2 = %.3g A\n', totIrr);
% is this right? must we multiply or divide by .7?
fprintf('generated current/m^2 = %.3g A\n', photonsAbsorbed*1.6e-19);
fprintf('efficiency = %.3g\n %', 100*photonsAbsorbed*1.6e-19/totIrr);
end