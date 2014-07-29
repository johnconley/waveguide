function exploreSpectrum(lambda, minThickness, maxThickness)
n=100;
ds=linspace(minThickness, maxThickness, n);
n0=6; % refractive index in 1st layer (w/ incident wave)
n2=6; % refractive index in 3rd layer

te = @(d) absorptionAtWavelength('te', lambda, n0, n2, d, refIxFnc);
% tm = @(d) absorptionAtWavelength('te', lambda, n0, n2, d, refIxFnc);

TEabsorption = arrayfun(te, ds);
% TMabsorption = arrayfun(tm, ds);
absorption = TEabsorption;% + TMabsorption;

plot(ds, absorption);
end