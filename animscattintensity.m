function animscattintensity(n0, n1, n2, a, k, kappa, t_max)
% Conley November 2013

c = 2.998*10^8;
step = (2*pi)/(60*c*k);

figure;

for t = 0:step:t_max   
    scattintensity2d(n0, n1, n2, a, k, kappa, t);
%     axis([-a 2*a -7 7]); % fix these bounds
%     pause(1/60);
    drawnow;
    
end

close

end
