function animmirrorwave(type, n0, n1, n2, d1, d2, k, kappa, t_max)
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
