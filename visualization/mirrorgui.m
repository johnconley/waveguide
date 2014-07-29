function mirrorlayergui(type, n0, n1, n2, d1, d2, kappa_max, k_max)
% mirrorlayergui Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% Conley November 2013
% Code modeled off 
% http://www.mathworks.com/matlabcentral/fileexchange/24861-41-complete-gui-examples/content/GUI_27.m

t = 2*10^(-9);

S.fh = figure('Visible', 'on',...
             'Name', 'Resonance plot of three-layer one-dimensional waveguide');

% display resonance plot
resplotmirror(type, n0, n1, n2, d1, d2, kappa_max, k_max);

% axes stuff
S.ax = gca;
set(S.ax, 'units', 'pixels');
S.xlim = [0 kappa_max];
S.ylim = [0 k_max];
S.axpos = get(S.ax, 'pos');
S.dx = diff(S.xlim);
S.dy = diff(S.ylim);

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

set(S.fh, 'windowbuttondownfcn', {@bdfcn,S});
set(S.fh, 'windowbuttonmotionfcn', {@bmfcn,S});

% callbacks
    function bdfcn(varargin)
        S = varargin{3};  % Get the structure.
        F = get(S.fh,'currentpoint');  % The current point w.r.t the figure.
        % Figure out of the current point is over the axes or not -> logicals.
        tf1 = S.axpos(1) <= F(1) && F(1) <= S.axpos(1) + S.axpos(3);
        tf2 = S.axpos(2) <= F(2) && F(2) <= S.axpos(2) + S.axpos(4);
        
        if tf1 && tf2
            % Calculate the current point w.r.t. the axes.
            kappa =  S.xlim(1) + (F(1)-S.axpos(1)).*(S.dx/S.axpos(3));
            k =  S.xlim(1) + (F(2)-S.axpos(2)).*(S.dy/S.axpos(4));
            animmirrorwave(type, n0, n1, n2, d1, d2, k, kappa, t);
        end
    end

    function bmfcn(varargin)
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