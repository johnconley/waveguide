% interactive choice of initial point for 2d henon map. barnett 9/18/07


a = 1.25; b = -0.3;                        % Henon params
%a = 0.36; b = 0.4;
%a = 1.4; b = 0.3;
f = @(x) [a-x(1,:).^2+b*x(2,:);  x(1,:)]; % Henon map (vec func) w/ params a,b

N = 1000;                                  % how many its
x = zeros(2, N+1);
figure;
disp('Henon map: click on graph to choose initial conditions, Ctrl-C to end');
while 1                                   % infinite loop for IC choices
  x(:,1) = ginput(1);
  hold off; plot(x(1,1), x(2,1), 'ko');
  for n=1:N
    x(:,n+1) = f(x(:,n));
  end
  ns = 1:N+1;                             % choose what to plot
  hold on; plot(x(1,ns), x(2,ns), '-', 'color', [.7 .7 1]);  % light lines
  plot(x(1,ns), x(2,ns), '.', 'markersize', 1);
  axis equal; axis([-2 2 -2 2]); % view region
end
% done
