function ret = percentAbsorbed(ni)
n0=3.5;
n1=1+1i*ni;
n2=3.5;
d=1;
k=9.6;
kappa=7.5;
A = TEmatrix(n0, n1, n2, d, k, kappa);
b = [-1;-i*conj(sqrt(n0^2*k^2-kappa^2));0;0];
coeffs = A\b;

c1 = coeffs(1);
c4 = coeffs(4);
f_in = n0*k;
f_out = n0*k*abs(c1)^2+n2*k*abs(c4)^2;
ret = (f_in - f_out) / f_in;
end