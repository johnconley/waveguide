function resplot3layer(type, n0, n1, n2, a, kappa_min, kappa_max, k_min, k_max,res)
% resplot3layer - creates a plot of 
%
% type - Transverse electric (TE) or transverse magnetic (TM)
% n0 - Refractive index of first layer
% n1 - Refractive index of second layer
% n2 - Refractive index of third layer
% a - Thickness of second layer
% kappa_max - Maximum value of kappa (wavenumber in x direction) to plot
% k_max - Maximum value of k (overall wavenumber) to plot
%
% Conley April 2014

num_k = res;
num_kappa = res;

ks = linspace(k_min, k_max, num_k);
kappas = linspace(kappa_min, kappa_max, num_kappa);
x = zeros(num_k, num_kappa);

if (strcmp(type, 'te') == 1) %% type == 'te'
    i=1;
    for k = ks
        j = 1;
        for kappa = kappas
            A = TEmatrix(n0, n1, n2, a, k, kappa);
            b=[-1;-i*conj(sqrt(n0^2*k^2-kappa^2));0;0];
            X=A\b;
            x(i,j) = norm(X);
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
            b=[-1;-i*conj(sqrt(n0^2*k^2-kappa^2))/(n0^2);0;0];
            X=A\b;
            x(i,j) = norm(X);
            if ((abs(kappa - n1*k) < .1) &&(norm(X) > 1))
                x(i,j) = 1;
            end
            j = j + 1;
        end
        i = i + 1;
    end
end

imagesc(ks, kappas, x);
set(gca,'YDir','normal');
xlabel('$\kappa$','Interpreter','LaTex','FontSize',14);
ylabel('$k$','Interpreter','LaTex','FontSize',14);
colorbar;
end
