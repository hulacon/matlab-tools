function gussy(fH)
% gussy(fH)
%
% Gussies up a figure (specified by handle fH) by changing various fonts,
% font sizes, hiding toolbars, etc.
%
% jbh 10/18/11


% params
tbsetting = 'none'; % no toolbar!
mbsetting = 'none'; % no menu bar!
bgcolor = 'w'; % white background
axesFont = 'Helvetica'; % font type of the axes
axesSize = 12; % font size of axes
labelFont = 'Helvetica'; % font type of the labels
labelSize = 14; % font size of the x and y axis labels


cf = get(fH);

% set toobar
set(fH,'ToolBar',tbsetting);

set(fH,'MenuBar',mbsetting);

% set b/g color
set(fH,'Color',bgcolor);

% loop through children, setting fonts, etc...
cfc = cf.Children;
for cc = 1:length(cfc)
    ca = get(cfc(cc));
    if isfield(ca,'type')
        if strcmp(ca.type,'axes')
            set(ca.XLabel,'FontName',labelFont); % set label fonts...
            set(ca.YLabel,'FontName',labelFont);
            set(ca.XLabel,'FontSize',labelSize); % set label fonts...
            set(ca.YLabel,'FontSize',labelSize);
            
            
            set(cfc(cc),'FontName',axesFont); % set axes fonts...
            set(cfc(cc),'FontSize',axesSize);
        end
    end
end

% myaa option...
% figure(fH);
% myaa;
% close(fH);
