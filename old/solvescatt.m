function solvescatt(type, n0, n1, n2, a, k)

eps = 1e-12;

f = @(kap) 1/norm(TEmatrix(n0,n1,n2,a,k,kap)\[-1;-sqrt(kap^2-n0^2*k^2);0;0]);
% [xm ym j] = evp.gridminfit(f, 0.03:0.03:k, struct('xtol', eps));
domain = linspace(0,k,500);
range = zeros(500);
i = 1;
for kappa = domain
    range(i)=f(kappa);
    i = i+1;
end

plot(domain,range);

end
