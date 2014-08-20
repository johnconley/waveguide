function resplotmirror(type, n0, n1, n2, d1, d2, kappa_max, k_max)
% resplotmirror - plots resonances of mirror-backed waveguide with incident
% light
% 
% type - Transverse electric (TE) or transverse magnetic (TM)
% n0 - Refractive index of first layer
% n1 - Refractive index of second layer
% n2 - Refractive index of third layer
% d1 - Thickness of second layer
% d2 - Thickness of third layer
% kappa_max - Maximum value of kappa (wavenumber in x direction)
% k_max - Maximum value of k (overall wavenumber)
%
% Conley October 2013

num_k = 500;
num_kappa = 500;

ks = linspace(0, k_max, num_k);
kappas = linspace(0, kappa_max, num_kappa);
x = zeros(num_k, num_kappa);

if (strcmp(type, 'te') == 1) %% type == 'te'
    i=1;
    for k = ks
        j = 1;
        for kappa = kappas
            A = mirrorTE(n0, n1, n2, d1, d2, k, kappa);
            b=[-1;-sqrt(kappa^2-n0^2*k^2);0;0;0];
            X=A\b;
            x(i,j) = norm(X);
%             disp('x=');
%             disp(X);
            j = j + 1;
        end
        i = i + 1;
    end

else %% type == 'tm'
    
end

imagesc(ks, kappas, x);
set(gca,'YDir','normal');
xlabel('$\kappa$','Interpreter','LaTex','FontSize',14);
ylabel('$k$','Interpreter','LaTex','FontSize',14);
colorbar;
end
