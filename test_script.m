n0=1;
n1=2;
n2=1;
pol='te';
k=3.8;
kappa=1.2;

ds=[1];
ns=[n1,n2];
mirror=0;



if (strcmp(pol, 'te') == 1) %% type == 'te'
    A = TEmatrix(n0, n1, n2, ds(1), k, kappa);
    b = [-1;-1i*conj(sqrt(n0^2*k^2-kappa^2));0;0];
    coeffs = A\b;
else %% type == 'tm'
    A = TMmatrix(n0, n1, n2, ds(1), k, kappa);
    b=[-1;-1i*conj(sqrt(n0^2*k^2-kappa^2))/(n0^2);0;0];
    coeffs = A\b;
end

c1 = coeffs(1);
c4 = coeffs(4);

inFlux = n0*k;
outFlux = n0*k*abs(c1)^2+n2*k*abs(c4)^2;

a = (inFlux - outFlux) / inFlux; % this is absorption, must change to current

fprintf('old way:\n');
disp(coeffs);
fprintf('absorption = %d\n\n',a);

[a, coeffs] = multilayer_solver(pol,mirror,k,kappa,ds,ns);

fprintf('new way:\n');
disp(coeffs);
fprintf('absorption = %d\n\n', a);
