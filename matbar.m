function [h e] = matbar(data,plotType,varargin)
% [h e] = matbar(data [, plotType, varargin])
%
% takes in matrix data where the mean of each column is plotted as a point
% in a graph with SEM error bars. outputs mean data handle, h, and errorbar
% handle, e.
% 
% plotType is optional argument which specifies how to render data:
%   -'bar': default, plots mean data a bar with typical errorbars
%   -'line': plots mean data as a line plot with typical errorbars
%   -'snakes': plots mean data as line and SEM as dotted lines above/below
%   -'patch': plots mean data as line and SEM as semi-transparent area
%   above/below
% 
% the additional arguments are passed along to the primary plotting
% function for customization purposes (e.g. passing along LineSpec
% arguments to plotting the mean data).
%
% jbh 5/7/14
% jbh 6/24/14, updated with line, snakes, and patch options


if ~exist('plotType','var')||isempty(plotType)
    plotType = 'bar';
end

Y = nanmean(data);
sem = nanstd(data)./sqrt(sum(~isnan(data)));



X = 1:length(Y); % this can be useful to have access to.

% toss column nans?
nannies = isnan(Y);
Y = Y(~nannies);
X = X(~nannies);
sem = sem(~nannies);


switch plotType
    case 'bar'
        h = bar(X,Y,varargin{:});
        hold on
        e=errorbar(X,Y,sem,'k.');
        set(e,'Marker','none')
        hold off
    case 'line'
        e=errorbar(X,Y,sem,varargin{:});
%         set(e,'Marker','.');
        h=e;        
    case 'raw'
        h=plot(data',varargin{:});
        e=[];
    case 'linestack'
        h=rawstack(data,varargin{:});
        e=[];
        
    case 'snakes'
        h=plot(X,Y,varargin{:});
        hold on
        e(1)=plot(X,Y+sem,':',varargin{:});
        e(2)=plot(X,Y-sem,':',varargin{:});
        hold off
    case 'patch'
        h=plot(X,Y,varargin{:});
        c=get(h,'Color');
        hold on
        py = [Y+sem fliplr(Y-sem)];
        px = [X fliplr(X)];
        e=patch(px,py,c,'EdgeAlpha',0,'FaceAlpha',.3);
        hold off
    case 'patchCI'
        [Y, ~, CI] = sterrmean(data);
        h=plot(X,Y,varargin{:});
        c=get(h,'Color');
        hold on
        py = [CI(1,:) fliplr(CI(2,:))];
        px = [X fliplr(X)];
        e=patch(px,py,c,'EdgeAlpha',0,'FaceAlpha',.3);
        hold off
% 	case 'patch_export'
%         h=plot(X,Y,varargin{:});
%         c=get(h,'Color');
%         hold on
%         py = [Y+sem fliplr(Y-sem)];
%         px = [X fliplr(X)];
%         e=patch(px,py,c);
%         hold off
    case {'opaquepatch','patch_export'} % for saving in .ai format
        h=plot(X,Y,varargin{:});
        c=get(h,'Color');
        hold on
        py = [Y+sem fliplr(Y-sem)];
        px = [X fliplr(X)];
        e=patch(px,py,c,'EdgeColor','none','FaceAlpha',1);
        hold off
    case 'spread'
        h=plotSpread(data,varargin{:});
        
end

return

function h = rawstack(data,varargin)
% plot raw data?

h = plot(data',varargin{:});
bw=get(h(1),'LineWidth'); % basewidth


numStep = size(data,2)-1;

% keyboard
hold on
for ss = 1:numStep
    X=ss:ss+1;
    Y=data(:,X);
    R=unique(Y,'rows');
    for rr = 1:size(R,1)
        tY = R(rr,:);
        tS = sum(ismember(Y,tY,'rows')); % scalar
        r=plot(X',tY',varargin{:});
        nw=tS*bw;
        set(r,'LineWidth',nw);
%         disp(nw);
    end
end
hold off
return
