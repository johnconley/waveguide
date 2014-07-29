function proportionPhotonsAbsorbed = maxSpectralAbsorption(d)
% e = number of electrons kicked up

te = 'te';
tm = 'tm';

% ds=linspace(minThickness, maxThickness, n);
n0=1; % refractive index in 1st layer (w/ incident wave)
n2=4; % refractive index in 3rd layer

f = refIxFnc;
i = irradianceFnc;
hc = 6.626e-34 * 3e8; % joules * m/s (Planck's constant * speed of light)

photonsAbsorbed = 0;
incomingPhotons = 0;

tic;
% gaussian quadrature
numNodes = 100;
[lambdas, weights] = quadr.gauss(numNodes);
a = .25; % min wavelength in microns
b = 1.7726; % max wavelength in microns (chosen so that E >= .7 eV per photon)
lambdas = ((b-a)*lambdas + (b+a)) / 2;
weights = (b-a)*weights / 2;

% make this more clear: as is absorption over spectrum, ps is # incident
% photons over spectrum
as=0*lambdas; ps = as;
totIrr = 0; % total irradiance

for j = 1:numNodes
    w = weights(j);
    lambda = lambdas(j);
    irradiance = i(lambda);
    totIrr = totIrr + irradiance * w;

    % p is photons/m^2/s/micron
    % calculated by irradiance * 1/E = 1/(hc/l)
    photons = irradiance*(lambda*1e-6/hc);
    ps(j) = photons;
    
    if (lambda < 1.7726) % cutoff of .7 eV to kick up electron
        n1 = f(lambda);
        ds = [d];
        ns = [n1, n2];
        [teAbsorption, ~] = multilayer_solver(te, false, 2*pi/lambda, 0, ds, ns);
        [tmAbsorption, ~] = multilayer_solver(tm, false, 2*pi/lambda, 0, ds, ns);
%         teAbsorption = absorptionAtWavelength(te, lambda, n0, n2, d, f);
%         tmAbsorption = absorptionAtWavelength(tm, lambda, n0, n2, d, f);
        absorption = (teAbsorption + tmAbsorption)/2;
%         absorption = 1;
        as(j) = absorption;
        incomingPhotons = incomingPhotons + photons * w;
        photonsAbsorbed = photonsAbsorbed + (absorption * photons) * w;
    end
end
fprintf('time = %.3g s\n\n',toc);

proportionPhotonsAbsorbed = photonsAbsorbed / incomingPhotons;

plot(lambdas,as,'.-',lambdas,ps/6e21,'r.-');
fprintf('total incident photons = %.3g\n', incomingPhotons);
fprintf('photons absorbed = %.3g\n', photonsAbsorbed);
fprintf('percentage absorbed = %.3g\n\n', proportionPhotonsAbsorbed*100);

% need to look over all this
% why?
fprintf('incoming current/m^2 = %.3g A\n', totIrr);
% is this right?
fprintf('generated current/m^2 = %.3g A\n', photonsAbsorbed*1.6e-19);
fprintf('efficiency = %.3g\n %', 100*photonsAbsorbed*1.6e-19/totIrr);
end