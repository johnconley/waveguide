function mirrorwave2d(type, n0, n1, n2, d1, d2, k, kappa, t)

if (strcmp(type, 'te') == 1) %% type == 'te'
    A = mirrorTE(n0, n1, n2, d1, d2, k, kappa);
    b = [-1;-sqrt(kappa^2-n0^2*k^2);0;0;0];
    x = A\b;
else %% type == 'tm'
    return
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
f2 = @(y) x(4)*exp(a2*y) + x(5)*exp(-a2*y);

w = (2.998*10^8)*k;
ftime = exp(-1i*w*t);

% define the input values
n = 100;
left = linspace(-d2, 0, n);
middle = linspace(0, d1, n);
right = linspace(d1, d2, n);

% calculate u(y)
lvals = f0(left)*ftime;
mvals = f1(middle)*ftime;
rvals = f2(right)*ftime;
y = [lvals, mvals, rvals];

% calculate u(x)
x = linspace(0, 2*d2, 3*n);
x = exp(1i*kappa*x);

% combine x and y and plot
vals = kron(x,y);
vals = reshape(vals,3*n,3*n);
imagesc(real(vals));
colorbar;

xlabel('x','Interpreter','LaTex','FontSize',14);
ylabel('y','Interpreter','LaTex','FontSize',14);
set(gca,'XTickLabel','','YTickLabel','');
hold on
p1=[100,1];
p2=[100,300];
plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','k','LineWidth',2);
p1=[200,1];
p2=[200,300];
plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','k','LineWidth',2);

end
