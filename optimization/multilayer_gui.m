function multilayer_gui
%
% Conley May 2014
% Modeled off
% http://www.mathworks.com/matlabcentral/fileexchange/24861-41-complete-gui-examples/content/GUI_13.m

% Should change based on number of layers, which layer is active layer
% but should always have TCO
% we'll start with a two-layer

% mirror, incident angle?

S.f = refIxFnc;

S.fh = figure('units','pixels',...
              'position',[300 200 500 500],...
              'menubar','none',...
              'name','temp',...
              'numbertitle','off',...
              'resize','off');

% layer 1 refractive index
S.n1sl = uicontrol('style','slide',...
                   'unit','pix',...
                   'position',[15 450 100 30],...
                   'min',1,'max',6,'val',1.5);
S.n1ed = uicontrol('style','edit',...
                   'unit','pix',...
                   'position',[40 430 50 30],...
                   'fontsize',14,...
                   'string','1.5');
% layer 1 thickness
S.d1sl = uicontrol('style','slide',...
                   'unit','pix',...
                   'position',[130 450 100 30],...
                   'min',.001,'max',5,'val',0.5);
S.d1ed = uicontrol('style','edit',...
                   'unit','pix',...
                   'position',[155 430 50 30],...
                   'fontsize',14,...
                   'string','0.5');
% layer 2 thickness (active layer)
S.d2sl = uicontrol('style','slide',...
                   'unit','pix',...
                   'position',[245 450 100 30],...
                   'min',.001,'max',5,'val',0.5);
S.d2ed = uicontrol('style','edit',...
                   'unit','pix',...
                   'position',[270 430 50 30],...
                   'fontsize',14,...
                   'string','0.5');
% frequency of light
S.freqsl = uicontrol('style','slide',...
                   'unit','pix',...
                   'position',[360 450 100 30],...
                   'min',.25,'max',1.75,'val',0.5);
S.freqed = uicontrol('style','edit',...
                   'unit','pix',...
                   'position',[385 430 50 30],...
                   'fontsize',14,...
                   'string','0.5');

% display text
S.results = uicontrol('style','tex',...
                      'unit','pix',...
                      'position',[180 330 300 50],...
                      'backg',get(S.fh,'color'),...
                      'fontsize',18,'fontweight','bold' );

S.bg = uibuttongroup('visible','off','position',[.1 .7 .25 .1]);
% Create three radio buttons in the button group.
S.te = uicontrol('Style','radiobutton','String','TE',...
    'pos',[10 10 50 30],'parent',S.bg,'HandleVisibility','off');
S.tm = uicontrol('Style','radiobutton','String','TM',...
    'pos',[60 10 50 30],'parent',S.bg,'HandleVisibility','off');
% Initialize some button group properties. 
set(S.bg,'SelectionChangeFcn',{@selcbk,S});
set(S.bg,'SelectedObject',[S.te]);  % No selection
set(S.bg,'Visible','on');
               
sliders_edits = [S.n1sl,S.n1ed,S.d1sl,S.d1ed,S.d2sl,S.d2ed,S.freqsl,S.freqed];
set(sliders_edits,'call',{@ed_call,S});


% callback for sliders and edit boxes
function ed_call(varargin)
[h, S] = varargin{[1,3]}; % handle of caller, and structure

switch h
    case S.n1ed
        L = get(S.n1sl,{'min','max','value'});  % Get the slider's info.
        E = str2double(get(h,'string'));  % Numerical edit string.
        if E >= L{1} && E <= L{2}
            set(S.n1sl,'value',E)  % E falls within range of slider.
        else
            set(h,'string',L{3}) % User tried to set slider out of range. 
        end
    case S.n1sl
        set(S.n1ed,'string',get(h,'value')) % Set edit to current slider.
    otherwise
        % Do nothing, or whatever.
end
solve_equation(S,'te');

function selcbk(varargin)%selcbk(source,eventdata)
source = varargin{1};
eventdata=varargin{2};
S=varargin{3};
solve_equation(S,'te');
% disp(source);
% disp([eventdata.EventName,'  ',... 
%      get(eventdata.OldValue,'String'),'  ', ...
%      get(eventdata.NewValue,'String')]);
% disp(get(get(source,'SelectedObject'),'String'));

% [absorption, coeffs] = multilayer_solver(polarization, mirror, k, kappa, ds, ns)
function solve_equation(S,pol)
mirror = true;
theta = 0;

switch get(get(S.bg,'SelectedObject'),'String')
    case 'TE'
        pol = 'te';
    case 'TM'
        pol = 'tm';
end

lambda = get(S.freqsl,'value');
k = 2*pi/lambda;
kappa = k*sin(theta);
d1 = get(S.d1sl,'value');
d2 = get(S.d2sl,'value');
ds = [d1,d2];
n1 = get(S.n1sl,'value');
n2 = S.f(lambda);
ns = [n1,n2,1];

% conductive oxide layers (indium tin oxide, or ITO)
% see https://spie.org/x91028.xml,
% http://refractiveindex.info/legacy/?group=CRYSTALS&material=ITO,
% http://en.wikipedia.org/wiki/Transparent_conducting_film
d_ITO = .1;
n_ITO = 2+.06i;
ds = [d_ITO, ds, d_ITO];
ns = [n_ITO, ns(1:end-1), n_ITO, ns(end)];

[a, coeffs] = multilayer_solver(pol,mirror,k,kappa,ds,ns);

string = sprintf('absorption = %.3g',a);
set(S.results,'str',string)
