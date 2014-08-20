function threelayergui(type, n0, n1, n2, a, kappa_min, kappa_max, k_min, k_max)
% threelayergui Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% Conley November 2013
% Code modeled off 
% http://www.mathworks.com/matlabcentral/fileexchange/24861-41-complete-gui-examples/content/GUI_27.m

t = 10^(-9);
res = 500;

S.fh = figure('Visible', 'on',...
             'Name', 'Resonance plot of three-layer one-dimensional waveguide');

% display resonance plot
resplot3layer(type, n0, n1, n2, a, kappa_min, kappa_max, k_min, k_max, res);

% axes stuff
S.ax = gca;
set(S.ax, 'units', 'pixels');
S.xlim = [0 kappa_max];
S.ylim = [0 k_max];
S.axpos = get(S.ax, 'pos');
S.dx = diff(S.xlim);
S.dy = diff(S.ylim);

S.kappa = 0;
S.k = 0;

S.tx(1) = uicontrol('style','tex',...
                    'unit','pix',...
                    'posit',[50 390 250 20],...
                    'backg',get(S.fh,'color'),...
                    'fontsize',11,'fontweight','bold',... 
                    'string','Current Pointer Location:');
% This textbox will display the current position of the mouse.
S.tx(2) = uicontrol('style','tex',...
                    'unit','pix',...
                    'position',[310 390 120 20],...
                    'backg',get(S.fh,'color'),...
                    'fontsize',11,'fontweight','bold' );

set(S.fh, 'windowbuttondownfcn', {@buttondown,S});
set(S.fh, 'windowbuttonupfcn', {@buttonup,S});
set(S.fh, 'windowbuttonmotionfcn', {@buttonmotion,S});

% callbacks
    function buttondown(varargin)
        S = varargin{3};  % Get the structure.
        F = get(S.fh,'currentpoint');  % The current point w.r.t the figure.
        % Figure out of the current point is over the axes or not -> logicals.
        tf1 = S.axpos(1) <= F(1) && F(1) <= S.axpos(1) + S.axpos(3);
        tf2 = S.axpos(2) <= F(2) && F(2) <= S.axpos(2) + S.axpos(4);
        
        if tf1 && tf2
            % Calculate the current point w.r.t. the axes.
            kappa =  S.xlim(1) + (F(1)-S.axpos(1)).*(S.dx/S.axpos(3));
            k =  S.xlim(1) + (F(2)-S.axpos(2)).*(S.dy/S.axpos(4));
            S.kappa = kappa;
            S.k = k;
        end
    end
        
    function buttonup(varargin)
        S = varargin{3};  % Get the structure.
        F = get(S.fh,'currentpoint');  % The current point w.r.t the figure.
        % Figure out of the current point is over the axes or not -> logicals.
        tf1 = S.axpos(1) <= F(1) && F(1) <= S.axpos(1) + S.axpos(3);
        tf2 = S.axpos(2) <= F(2) && F(2) <= S.axpos(2) + S.axpos(4);
        
        if tf1 && tf2
            % Calculate the current point w.r.t. the axes.
            kappa =  S.xlim(1) + (F(1)-S.axpos(1)).*(S.dx/S.axpos(3));
            k =  S.xlim(1) + (F(2)-S.axpos(2)).*(S.dy/S.axpos(4));
            animscattwave(type, n0, n1, n2, a, k, kappa, t);
        end
    end

    function buttonmotion(varargin)
        S = varargin{3};  % Get the structure.
        F = get(S.fh,'currentpoint');  % The current point w.r.t the figure.
        % Figure out of the current point is over the axes or not -> logicals.
        tf1 = S.axpos(1) <= F(1) && F(1) <= S.axpos(1) + S.axpos(3);
        tf2 = S.axpos(2) <= F(2) && F(2) <= S.axpos(2) + S.axpos(4);
        
        if tf1 && tf2
            % Calculate the current point w.r.t. the axes.
            kappa =  S.xlim(1) + (F(1)-S.axpos(1)).*(S.dx/S.axpos(3));
            k =  S.xlim(1) + (F(2)-S.axpos(2)).*(S.dy/S.axpos(4));
            set(S.tx(2),'str',num2str([kappa, k],3))
        end
    end
end