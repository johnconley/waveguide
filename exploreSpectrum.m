n=10;
ds = linspace(.01,.4,n);
n0=6;
n2=6;
currents = zeros(n);
for i=1:n
    d = ds(i);
    currents(i) = currentAcrossSpectrum(n0,n2,d);
end
plot(ds,currents);
figure;
semilogy(ds,currents);