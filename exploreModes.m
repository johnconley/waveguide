function exploreModes(type, n0, n1, n2, a, kappa_max, k_max)
% exploreModes - creates a plot of 
%
% type - te or tm
% n0 - 
% n1 - 
% n2 - 
% a - 
% kappa_max - max value of kappa to plot
% k_max - max value of k to plot
%
% Conley September 2013

num_k = 500;
num_kappa = 500;

ks = linspace(0, k_max, num_k);
kappas = linspace(0, kappa_max, num_kappa);
dets = zeros(num_k, num_kappa);

if (strcmp(type, 'te') == 1) %% type == 'te'
    i=1;
    for k = ks
        j = 1;
        for kappa = kappas
            A = TEmatrix(n0, n1, n2, a, k, kappa);
            dets(i,j) = det(A);
            j = j + 1;
        end
        i = i + 1;
    end

else %% type == 'tm'
    i=1;
    for k = ks
        j = 1;
        for kappa = kappas
            A = TMmatrix(n0, n1, n2, a, k, kappa);
            dets(i,j) = det(A);
            j = j + 1;
        end
        i = i + 1;
    end
end

imagesc(ks, kappas, log(abs(dets)));
set(gca,'YDir','normal');
xlabel('$\kappa$','Interpreter','LaTex','FontSize',14);
ylabel('$k$','Interpreter','LaTex','FontSize',14);
colorbar;

end
