function findWave(type, n0, n1, n2, a, k, kappa_guess)
% findWave - 
%
%
%
% Conley October 2013

if (strcmp(type, 'te') == 1) %% type == 'te'
    kappa = fzero(@(kap) imag(det(TEmatrix(n0,n1,n2,a,k,kap))), kappa_guess);
    disp('kappa = ');
    disp(kappa);
    A = TEmatrix(n0,n1,n2,a,k,kappa);
else %% type == 'tm'
    kappa = fzero(@(kap) imag(det(TMmatrix(n0,n1,n2,a,k,kap))), kappa_guess);
    disp('kappa = ');
    disp(kappa);
    A = TMmatrix(n0,n1,n2,a,k,kappa);
end

[U,S,V] = svd(A);
x = V(1:4,4);
disp('x = ');
disp(x);

% check that A*x == 0

plotWave(n0,n1,n2,a,k,kappa,x);

end
