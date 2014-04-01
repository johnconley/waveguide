function z = dispersionCurves(type, n0, n1, n2, a, kappa_max, k_max)

eps = 1e-12;

num_k = 100;
ks = linspace(0, k_max, num_k);

z = zeros(2, k_max);
i = 1;

if (strcmp(type, 'te') == 1) %% type == 'te'
    % find zeros for each k in grid
    for k = ks
        if k >= kappa_max
            break
        end
        
        f = @(kap) svd(TEmatrix(n0, n1, n2, a, k, kap));
        [xm ym j] = evp.gridminfit(f, k:0.03:kappa_max, struct('xtol', eps));
        for kappa = xm
            if ~ismember(kappa, z(1,:))
                z(1,i) = kappa;
                z(2,i) = k;
                i = i + 1;
            end
        end
    end
else %% type == 'tm'
    % find zeros for each k in grid
    for k = ks
        if k >= kappa_max
            break
        end
        
        f = @(kap) svd(TMmatrix(n0, n1, n2, a, k, kap));
        [xm ym j] = evp.gridminfit(f, k:0.03:kappa_max, struct('xtol', eps));
        for kappa = xm
            if ~ismember(kappa, z(1,:))
                z(1,i) = kappa;
                z(2,i) = k;
                i = i + 1;
            end
        end
    end
end

plot(z(1,:), z(2,:), '+');
xlabel('$\kappa$','Interpreter','LaTex','FontSize',14);
ylabel('$k$','Interpreter','LaTex','FontSize',14);
end
