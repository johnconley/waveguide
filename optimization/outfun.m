function stop = outfun(x,optimValues,state)
    stop = false;
    
    switch state
        case 'init'
            hold on
        case 'iter'
            xs = [xs; x];
            plot(x(1),x(2),'o');
            text(x(1)+.15,x(2),num2str(optimValues.iteration));
            title('Sequence of points computed by fmincon');
        case 'done'
            hold off
        otherwise
    end
end