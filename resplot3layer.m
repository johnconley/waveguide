function resplot3layer(type, n0, n1, n2, a, kappa_min, kappa_max, k_min, k_max,res)
% resplot3layer - creates a plot of 
%
% type - te or tm
% n0 - 
% n1 - 
% n2 - 
% a - 
% kappa_max - max value of kappa to plot
% k_max - max value of k to plot
%
% Conley October 2013

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
            b=[-1;-sqrt(kappa^2-n0^2*k^2);0;0];
            X=A\b;
            x(i,j) = norm(X);
%             disp('x=');
%             disp(X);
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
            b=[-1;-sqrt(kappa^2-n0^2*k^2)/(n0^2);0;0];
            X=A\b;
            x(i,j) = norm(X);
            if ((abs(kappa - n1*k) < .1) &&(norm(X) > 1))
%                 disp('k');
%                 disp(k);
%                 disp('kappa');
%                 disp(kappa);
%                 disp('A');
%                 disp(A);
%                 disp('b');
%                 disp(b);
%                 disp('X');
%                 disp(X);
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
