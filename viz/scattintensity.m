function scattintensity(n0, n1, n2, a, k, kappa, t)
% Conley November 2013

A = TEmatrix(n0, n1, n2, a, k, kappa);
b = [-1;-sqrt(kappa^2-n0^2*k^2);0;0];
te_sol = A\b;

A = TMmatrix(n0, n1, n2, a, k, kappa);
b = [-1;-sqrt(kappa^2-n0^2*k^2)/(n0^2);0;0];
tm_sol = A\b;

% define exponents and wave functions
a0 = sqrt(kappa^2-n0^2*k^2);
a1 = sqrt(kappa^2-n1^2*k^2);
a2 = sqrt(kappa^2-n2^2*k^2);

if (kappa > n0*k)
    te0 = @(y) exp(a0*y) + te_sol(1)*exp(a0*y);
    tm0 = @(y) exp(a0*y) + tm_sol(1)*exp(a0*y);
    tm0_prime = @(y) a0*exp(a0*y) + a0*tm_sol(1)*exp(a0*y);
else
    te0 = @(y) exp(a0*y)+te_sol(1)*exp(-a0*y);
    tm0 = @(y) exp(a0*y)+tm_sol(1)*exp(-a0*y);
    tm0_prime = @(y) a0*exp(a0*y) - a0*tm_sol(1)*exp(a0*y);
end
te1 = @(y) te_sol(2)*exp(a1*y) + te_sol(3)*exp(-a1*y);
tm1 = @(y) tm_sol(2)*exp(a1*y) + tm_sol(3)*exp(-a1*y);
tm1_prime = @(y) a1*tm_sol(2)*exp(a1*y) - a1*tm_sol(3)*exp(-a1*y);
if (kappa > n2*k)
    te2 = @(y) te_sol(4)*exp(-a2*y);
    tm2 = @(y) tm_sol(4)*exp(-a2*y);
    tm2_prime = @(y) -a2*tm_sol(4)*exp(-a2*y);
else
    te2 = @(y) te_sol(4)*exp(a2*y);
    tm2 = @(y) tm_sol(4)*exp(a2*y);
    tm2_prime = @(y) a2*tm_sol(4)*exp(-a2*y);
end

% define constants and intensity functions
eps0 = n0^2;
eps1 = n1^2;
eps2 = n2^2;
% what is mu???
mu = 2;

% intensity0 = @(y) eps0*te0(y).^2 + (tm0_prime(y)/(eps0*mu)).^2+(kappa*tm0(y)/(eps0*mu)).^2;
% intensity1 = @(y) eps1*te1(y).^2 + (tm1_prime(y)/(eps1*mu)).^2+(kappa*tm1(y)/(eps1*mu)).^2;
% intensity2 = @(y) eps2*te2(y).^2 + (tm2_prime(y)/(eps2*mu)).^2+(kappa*tm2(y)/(eps2*mu)).^2;
intensity0 = @(y) (1/(eps0*mu*mu))*((tm0_prime(y)).^2+(kappa*tm0(y)).^2);
intensity1 = @(y) (1/(eps1*mu*mu))*((tm1_prime(y)).^2+(kappa*tm1(y)).^2);
intensity2 = @(y) (1/(eps2*mu*mu))*((tm2_prime(y)).^2+(kappa*tm2(y)).^2);

w = (2.998*10^8)*k;
ftime = exp(-1i*w*t);
disp('intensity at time');
y = -.245
disp(intensity0(y)*ftime);
disp('intensity with no time');
disp(intensity0(y));
disp('u(y)');
disp(tm0(y));
disp('uprime(y)');
disp(tm0_prime(y));
disp('my intensity');
myint = (tm0_prime(y)/(eps0*mu))^2+(kappa*tm0(y)/(eps0*mu))^2;
disp(myint);

% define the input values
n = 100;
left = linspace(-a, 0, n);
middle = linspace(0, a, n);
right = linspace(a, 2*a, n);

% calculate and plot the function
lvals = intensity0(left)*ftime;
mvals = intensity1(middle)*ftime;
rvals = intensity2(right)*ftime;

domain = [left, middle, right];
range = [lvals, mvals, rvals];

plot(domain, real(range));

end