function plotWave(n0, n1, n2, a, k, kappa, x)
% plotWave - plots a TE wavefunction
%
% n0 - 
% n1 - 
% n2 - 
% a - 
% k - wavenumber
% kappa - frequency in the x direction
% x - vector containing coefficients of functions
%
% Conley October 2013

% define the exponents and functions
n0exp = sqrt(kappa^2-n0^2*k^2);
n1exp = sqrt(kappa^2-n1^2*k^2);
n2exp = sqrt(kappa^2-n2^2*k^2);

f0 = @(y) x(1)*exp(n0exp*y);
f1 = @(y) x(2)*exp(n1exp*y) + x(3)*exp(-n1exp*y);
f2 = @(y) x(4)*exp(-n2exp*y);

% define the input values
step = 100;
left = linspace(-a, 0, step);
middle = linspace(0, a, step);
right = linspace(a, 2*a, step);

% calculate and plot the function
lvals = f0(left);
mvals = f1(middle);
rvals = f2(right);

domain = [left, middle, right];
range = [lvals, mvals, rvals];
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
