function scattwave(type, n0, n1, n2, a, k, kappa, t)
% scattwave - plots
%
% n0 - 
% n1 - 
% n2 - 
% a - 
% k - wavenumber
% kappa - frequency in the x direction
%
% Conley October 2013

if (strcmp(type, 'te') == 1) %% type == 'te'
    A = TEmatrix(n0, n1, n2, a, k, kappa);
    b = [-1;-sqrt(kappa^2-n0^2*k^2);0;0];
    x = A\b;
else %% type == 'tm'
    A = TMmatrix(n0, n1, n2, a, k, kappa);
    b = [-1;-sqrt(kappa^2-n0^2*k^2)/(n0^2);0;0];
    x = A\b;
end

% define the exponents and functions
a0 = sqrt(kappa^2-n0^2*k^2);
a1 = sqrt(kappa^2-n1^2*k^2);
a2 = sqrt(kappa^2-n2^2*k^2);

if (kappa > n0*k)
    f0 = @(y) exp(a0*y)+x(1)*exp(a0*y);
else
    f0 = @(y) exp(a0*y)+x(1)*exp(-a0*y);
end
f1 = @(y) x(2)*exp(a1*y) + x(3)*exp(-a1*y);
if (kappa > n2*k)
    f2 = @(y) x(4)*exp(-a2*y);
else
    f2 = @(y) x(4)*exp(a2*y);
end

w = (2.998*10^8)*k;
ftime = exp(-1i*w*t);

% define the input values
step = 100;
left = linspace(-a, 0, step);
middle = linspace(0, a, step);
right = linspace(a, 2*a, step);

% calculate and plot the function
lvals = f0(left)*ftime;
mvals = f1(middle)*ftime;
rvals = f2(right)*ftime;

domain = [left, middle, right];
range = [lvals, mvals, rvals];

% plot(domain, real(range));
m = max(real(range));

figure;
ha = area([0 a], [2*m 2*m], -2*m);
hold on
plot(domain, real(range), 'r');
axis([-a 2*a -m m]);
hold off

xlabel('y','Interpreter','LaTex','FontSize',14);
ylabel('u(y)','Interpreter','LaTex','FontSize',14);

end
