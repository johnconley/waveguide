function [ns, ds, a] = optimize(m, mirror, ix, ds, ns)

dsMin = zeros(1, m) + .001;
nsMin = zeros(1, m+1) + 1;
minVals = cat(2, dsMin, nsMin);

dsMax = zeros(1, m) + 5;
nsMax = zeros(1, m+1) + 5;
maxVals = cat(2, dsMax, nsMax);

startVal = cat(2,ds,ns);

% fmincon finds minimum, so to find max of totalSpectralAbsorbance we find min
f = @(params) 1 / totalSpectralAbsorbance(m, mirror, ix, params(1:m), params(m+1:end));
[xb, fb, flag, outp] = fmincon(f,startVal,[],[],[],[],minVals,maxVals,[],optimset('display','iter'));

ns = xb(1:m);
ds = xb(m+1:end);
a = 1 / fb;

end