function findZeros(type, n0, n1, n2, a, kappa_max, k, num_kappa)

eps = 10^(-3);

kappas = linspace(0, kappa_max, num_kappa);

if (strcmp(type, 'te') == 1) %% type == 'te'
    for kappa = kappas
        A = TEmatrix(n0, n1, n2, a, k, kappa);
        if abs(det(A)) <= eps
            val = fzero(@(kap) imag(det(TEmatrix(n0,n1,n2,a,k,kap))), kappa);
            plot(val,k,'+');
            hold on;
        end
    end
else %% type == 'tm'
    for kappa = kappas
        A = TMmatrix(n0, n1, n2, a, k, kappa);
        if abs(det(A)) <= eps
            val = fzero(@(kap) imag(det(TMmatrix(n0,n1,n2,a,k,kap))), kappa);
            plot(val,k,'+');
            hold on;
        end
    end
end

end
