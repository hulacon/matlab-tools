function [f h] = marghist(data,varargin)
% [f h] = marghist(data,...)
%
% makes a 'pretty' scatterhist plot which also allows groups (distinct
% nx2 filled cells in input) with optional group labels
%
% can specify various parameters preceded by strings, including:
%
% 'GroupLabels':    cell containing labels for distributions in data
% 'XYLabels':       cell containing labels for axes
% 'FocalPoints':    cell containing emphasized coordinates w/in each
%                   distribution
% 'Colormap':       specify colormap to use (string) or supply actual nx3 cmap
% 'ShowScatter':    set false for hiding scatter plot (e.g. in case you just
%                   want to plot focal points in the scatter axis).
% 'MarkerSize':     set size of the markers for the scatter
% 'YAxis'/XAxis':   override axes values with specified limits
%
%
% f: figure handle, h: axes handles
% 
% jbh 2/16/14


%% Assign defaults, etc
if ~iscell(data)
    data = {data};
end
% defaults
xylabels = {'x','y'};
grplabels = [];
focalpts = [];
cmap = 'jet';
scatterflag = true;
msz = 5; % marker size
lwd = 2;
xaxis = [];
yaxis = [];

for aa = 1:2:length(varargin)
    switch varargin{aa}
        case 'XYLabels'
            xylabels = varargin{aa+1};
        case 'GroupLabels'
            grplabels = varargin{aa+1};
        case 'FocalPoints'
            focalpts = varargin{aa+1};
        case 'Colormap'
            cmap = varargin{aa+1};
        case 'ShowScatter'
            scatterflag = varargin{aa+1};
        case 'MarkerSize'
            msz = varargin{aa+1};
        case 'LineWidth'
            lwd= varargin{aa+1};
        case 'XAxis'
            xaxis = varargin{aa+1};
        case 'YAxis'
            yaxis = varargin{aa+1};
    end
end

%% organize things, set up aesthic preferences

numGroups=length(data);
% clrs = ('rgbck')'; %meh
if ischar(cmap)
    cfunc=str2func(cmap);
    cmap=cfunc(numGroups*5);
end

clrs = cmap(round(linspace(1,size(cmap,1),numGroups)),:);

% get face/edge colors for foci
% fclrs = brighten(clrs,1);
% eclrs = brighten(clrs,-.9);
fclrs = clrs;
eclrs = zeros(size(clrs));



% extract key bits of data
allData =vertcat(data{:});


%% plot things
% get handle info and tweak various things
h = scatterhist(allData(:,1),allData(:,2),'Location','NorthEast');
% put axes labels in sensible locations
set(h(1),'XAxisLocation','bottom','YAxisLocation','left');
% make scatter larger than default (and densities smaller)
scatloc = get(h(1),'Position');
scatloc([3 4]) = .7;
set(h(1),'Position',scatloc);
if ~isempty(yaxis)
    ylim(h(1),yaxis);
end

if ~isempty(xaxis)
    xlim(h(1),xaxis);
end

% toploc = get(h(2),'Position');
% rightloc = get(h(3),'Position');

% make room, set up...
cla(h(1));cla(h(2));cla(h(3));

% some other bs for getting focal pts on top
dots =[];
plops = [];

% loop over groups doing things...
for nn = 1:numGroups
    
    
    axes(h(1));
    hold on
    if scatterflag
        dots(nn)=scatter(data{nn}(:,1),data{nn}(:,2),msz,clrs(nn,:),'filled');
    end
    % focal pts
    if ~isempty(focalpts)
        plops(nn,1)=plot(focalpts{nn}(1),focalpts{nn}(2),'+','MarkerSize',10,'Color',eclrs(nn,:));
        plops(nn,2)=plot(focalpts{nn}(1),focalpts{nn}(2),'o','MarkerSize',10,...
            'MarkerEdgeColor',eclrs(nn,:),'MarkerFaceColor',fclrs(nn,:));
    end
    hold off
    
    
    
    %ksdensity data
    [xY xX] = ksdensity(data{nn}(:,1));
    [yY yX] = ksdensity(data{nn}(:,2));
    
    axes(h(2));
    xlim(xlim(h(1)));
    ylim('auto');
    hold on
    plot(xX,xY,'Color',clrs(nn,:),'LineWidth',lwd);
    if ~isempty(focalpts)
        plot([focalpts{nn}(1) focalpts{nn}(1)],[min(xY) max(xY)],':','Color',clrs(nn,:),...
            'LineWidth',lwd*.7);
    end

    hold off
    
    axes(h(3));
    xlim('auto');
    ylim(ylim(h(1)));
    % ylim('auto');
    hold on
    l(nn)=plot(yY,yX,'Color',clrs(nn,:),'LineWidth',lwd);
    if ~isempty(focalpts)
        plot([min(yY) max(yY)],[focalpts{nn}(2) focalpts{nn}(2)],':','Color',clrs(nn,:),...
            'LineWidth',lwd*.7);
    end    
    hold off
    
end

if ~isempty(grplabels)
    L=legend(l,grplabels,'Location','Best');
    set(L,'Position',[.82 .88 .1 .1]); % move legend somewhere sensible
    legend boxoff
end


% label, scale, etc
set(h(1),'Children',vertcat(plops(:),dots(:)));
xlabel(h(1),xylabels{1});ylabel(h(1),xylabels{2});
set(gcf,'Color','w');
f = gcf; % get both


