function dielzguide(om, shape, plot, verb)

% transmission with Rokhlin hypersingular-cancel scheme
% For Conley to explore guided modes in xy-plane diel, which prop in z.
% Barnett 11/9/13
% Modified Conley 11/14/13
% clear; verb = 0;
%ke = -2i; ki = 5;                       % force ext/int wave#
% or set up using guide w/ index:
% om = 2; % overall freq (k)
n = 2;  % interior refractive index
kap = 1.3*om; % z-propagation const (into the screen)
ke = sqrt(om^2-kap^2);     % note can be positive imag
ki = sqrt((n*om)^2-kap^2);
fprintf('ke,ki = %.3g+%.3gi, %.3g+%.3gi\n',real(ke),imag(ke),real(ki),imag(ki))

N = 80;
if (strcmp(shape, 'tref') == 1)
    s = segment.smoothstar(N, 0.3, 3);                % smooth closed segment
end
if (strcmp(shape, 'circ') == 1)
    s = segment(N, [0 1 0 2*pi]);
end
% This is the dielectric waveguide cross-section in xy-plane.
di = domain(s, 1); di.k = ki;
de = domain([], [], s, -1); de.k = ke;                      % exterior
if verb>1, figure; di.plot; hold on; de.plot; axis equal; end
o.quad = 'm';                                     % Kress spectral quadr
s.addinoutlayerpots('d', o);                      % new double-sided layerpot
s.addinoutlayerpots('s', o);                      % "
setmatch(s, [1 -1], [1 -1]);  % u+ - u- = 0, and un+ - un- = 0 ("TM" maybe)
p = bvp([de di]);
p.fillquadwei; p.sqrtwei = p.sqrtwei*0+1; % use no sqrt weighting

if plot
    % Now sweep over prop consts looking for modes...
    kaps = n*om*sin(pi/2*(1:199)/200); % z-prop consts (kap<om otherwise breaks)
    %kaps = linspace(7,7.05,50); kaps = linspace(5.1,5.3,50); % for om=5
    ss = nan(2*N, numel(kaps)); % array for min singular values
    for i=1:numel(kaps), kap = kaps(i);
      ke = sqrt(om^2-kap^2); ki = sqrt((n*om)^2-kap^2); di.k = ki; de.k = ke; %set k
      fprintf('ke,ki = %.12g+%.12gi, %.12g+%.12gi\n',real(ke),imag(ke),real(ki),imag(ki))
      p.fillbcmatrix;
      ss(:,i) = svd(p.A);
    end
    figure; plot(kaps,ss,'+-'); axis([min(kaps) max(kaps) 0 1]); % look for zeros
end

if verb % show the vector closest to the nullspace at given kap:
    kap = 2.78;%3.51; %5.188; %7.0355; % solve at one k
    ke = sqrt(om^2-kap^2); ki = sqrt((n*om)^2-kap^2); di.k = ki; de.k = ke; %set k
    fprintf('ke,ki = %.12g+%.12gi, %.12g+%.12gi\n',real(ke),imag(ke),real(ki),imag(ki))
    p.fillbcmatrix;
    [U S V] = svd(p.A); sig = diag(S); min(sig)
    p.co = V(:,end); % set up coeffs as the last singular vector (min sing val)
    opts.dx = 0.03; opts.bb = [-2 2 -2 2]; figure;
    tic; p.showsolution(opts); fprintf('\tgrid eval in %.2g sec\n', toc);
    hold on; plot([s.x;s.x(1)], '-k');
end % ignore the fuzz around the curve (due to layer potentials)
% you may need to reduce the scale eg caxis(1e-3*[-1 1])
% to actually see the mode
end
