% start with 1 layer, active layer
% this means freespace => TCO => Si => TCO => mirror/freespace

% optimizing over ns, ds
% ds = [d1,d2,...,dm]
% ns = [n1,n2,...,nm+1]

m = 1;
mirror = false;
ix = 1;
ns = [1,1];

% fmincon finds minimum, so to find max of multilayer_wrapper we find min
% of inverse
% f = @(ds) 1/multilayer_wrapper(m, mirror, ix, ds, ns);

% min = .1;
% max = 5;
% num = 100;
% dvals = linspace(min,max,num);
% for  j=1:numel(dvals), as(j)=1/f(dvals(j)); end
% plot(dvals,as);
% 
% % [xb,fb,flag,outp]=fmincon(f,[1],[],[],[],[],[0.001],[5],[],optimset('display','iter'))


m=2;
mirror = true;
ix = 2;
f = @(params) 1/multilayer_wrapper(m, mirror, ix, params(1:m), params(m+1:end));
[xb,fb,flag,outp]=fmincon(f,[0.1574,0.005,3.2776,1,1],[],[],[],[],[.001,.001,1,1,1],[5,5,5,1,5],[],optimset('display','iter'))
% initial vector [1,1,1,1,1] outputs [.3923,1.4449,3.0769,1,1] (a=.3489)
% initial vector [1,.05,1,1,1] outputs NaN
% initial vector [1,1,1,1,2] outputs [.0523,4.8006,2.8283,1,5] (a=.4760)
% initial vector [1,1,1,1,1] with mirror outputs [.3418,.8646,2.9787,1,1]
% (a=.4412)
% initial vector [.0523,4.8006,2.8283,1,5] with mirror outputs
% [.0415,4.7981,3.0608,1,5] (a=.5731)
% ------------------------------------------
% with 250 quadrature points
% mirror [.0523,4.8006,2.8283,-,-] -> [0.0386,4.9323,3.2695,-,-] (a=.7617)
% mirror [1,1,1,-,-] -> [0.2761,4.7689,3.2858,-,-] (a=.7486)
% mirror [0.1574,4.8506,3.2776,-,-] -> [0.1641,5,3.2315,-,-] (a=.7547)
% ^^ initial params are average of previous two maxima

