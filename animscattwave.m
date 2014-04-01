function animscattwave(type, n0, n1, n2, a, k, kappa, t_max)
% Conley October 2013

c = 2.998*10^8;
step = (2*pi)/(60*c*k);

figure;

for t = 0:step:t_max   
    scattwave2d(type, n0, n1, n2, a, k, kappa, t);
%     axis([-a 2*a -7 7]); % fix these bounds
%     pause(1/60);
    drawnow;
    
end

close

end
