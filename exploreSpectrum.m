function exploreSpectrum(min, max)
n=100;
ds=linspace(min, max, n);
n0=6;
n2=6;

te = @(d) absorptionAcrossSpectrum('te', n0, n2, d);
%tm = @(d) absorptionAcrossSpectrum('tm', n0, n2, d);

TEabsorption = arrayfun(te, ds);
% TMcurrents = arrayfun(tm, ds);
absorption = TEabsorption;% + TMcurrents;

plot(ds, absorption);
end