function animscattwave(type, n0, n1, n2, a, k, kappa, t_max)
% animscattwave - animates scattwave2d through time
%
% type - 'te' or 'tm'
% n0 - Refractive index of first layer
% n1 - Refractive index of second layer
% n2 - Refractive index of third layer
% a - Thickness of second layer
% k - Overall wavenumber
% kappa - Wavenumber in the x direction
% t_max
%
% Conley October 2013

c = 2.998*10^8;
step = (2*pi)/(60*c*k);

figure;

for t = 0:step:t_max   
    scattwave2d(type, n0, n1, n2, a, k, kappa, t);
    drawnow;
end

close

end
