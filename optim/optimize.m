function [ds, ns, a] = optimize(m, mirror, ix, ds, ns)
% given the number of layers and starting thicknesses and refractive
% indices of a solar cell, finds the maximum absorbance
%
% m - number of layers in the solar cell
% mirror - true if layer n+1 is a perfect mirror, false otherwise
% ix - 1 <= ix <= m is the index of the active layer
% ds - initial values of thicknesses
% ns - intitial values of refractive indices
%
% example:
% [ds,ns,a] = optimize(2,true,2,[2,.0633],[1,1,1])

dsMin = zeros(1,m) + .001;
nsMin = zeros(1,m+1) + 1;
minVals = cat(2,dsMin,nsMin);

dsMax = zeros(1,m) + 5;
nsMax = zeros(1,m+1) + 5;
maxVals = cat(2,dsMax,nsMax);

startVal = cat(2,ds,ns);

% fmincon finds minimum, so to find max of totalSpectralAbsorbance we find min
f = @(params) 1 / totalSpectralAbsorbance(m, mirror, ix, params(1:m), params(m+1:end));
[xb, fb, flag, outp] = fmincon(f,startVal,[],[],[],[],minVals,maxVals,[],optimset('display','iter'));

ds = xb(1:m);
ns = xb(m+1:end);
a = 1 / fb;

end