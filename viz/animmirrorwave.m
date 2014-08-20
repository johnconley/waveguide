function animmirrorwave(type, n0, n1, n2, d1, d2, k, kappa, t_max)
% animmirrorwave - animates mirrorwave2d through time
% 
% type - Transverse electric (TE) or transverse magnetic (TM)
% n0 - Refractive index of first layer
% n1 - Refractive index of second layer
% n2 - Refractive index of third layer
% d1 - Thickness of second layer
% d2 - Thickness of third layer
% k - Overall wavenumber
% kappa - Wavenumber in the x direction
% t - Time
%
% Conley October 2013

c = 2.998*10^8;
step = (2*pi)/(60*c*k);

figure;

for t = 0:step:t_max
    mirrorwave2d(type, n0, n1, n2, d1, d2, k, kappa, t);
%     axis([-d2 d2 -6 6]); % fix these bounds
%     pause(1/60);
    drawnow;
end

close

end
