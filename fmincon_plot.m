function fmincon_plot
% f = @(x) (x(1)-1).^2 + 0.1*(x(2)-0.5).^2 + .7;
% fmincon(f,[0;0], [],[],[],[],[0;0], [2;2]);
% format long g;
% ans
% 
% [xb,fb,flag,outp]=fmincon(f,[0;0], [],[],[],[],[0;0], [2;2])
% [xb,fb,flag,outp]=fmincon(f,[0;0],[],[],[],[],[0;0],[2;2],[],optimset('display','iter'))

xs = [];
x0 = [10;17];%[-30;15];%
% f = @(x) (x(1)-1).^2 + 0.1*(x(2)-0.5).^2 + .7;
f = @(x) (x(1)-1).^2 + 100*(x(2)-x(1).^2).^2;
dom = linspace(0,2);
r = dom;

x = fmincon(f,x0,[],[],[],[],[0;0],[100;100],[],optimset('outputfcn',@outfun,'display','iter'));

function stop = outfun(x,optimValues,state)
    stop = false;
    
    switch state
        case 'init'
            hold on
        case 'iter'
            xs = [xs; [x(1),x(2)]];
            plot(x(1),x(2),'o');
            text(x(1)+.1,x(2),num2str(optimValues.iteration));
            title('Sequence of points computed by fmincon');
        case 'done'
            hold off
        otherwise
    end
end
disp(xs);

end