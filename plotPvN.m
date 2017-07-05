function pval = plotPvN(var1,var2)
% pval = plotPvN(var1,var2)
%
% plots p value of the ttest between var1 and var2 as a function of the
% number of subjects. var1 and var2 can be any vector of data
%
% jbh 7/3/12



N = length(var1);
var1name = inputname(1);
% preallocate various vars
P = zeros(N-1,1);

% default to testing vs. 0 if var2 isn't there
if ~exist('var2','var')
    var2=zeros(size(var1));
    var2name = 'Zero';
else
    var2name = inputname(2);
end

if isempty(var1name)
    var1name = 'Var1';
end
if isempty(var2name)
    var2name = 'Var2';
end

% sort by var 1 effect size
% [var1 v1o] = sort(var1);
% var2 = var2(v1o);

% keyboard

for nn = 2:N    
  [~,P(nn-1)] = ttest(var1(1:nn),var2(1:nn));
end

pval = P(end);

% plot the data

pvbs = figure;
set(pvbs,'Position',[300   300   600   400]);
set(pvbs,'NumberTitle','off');
set(pvbs,'Name','p-value by N');
title(sprintf('%s (%g) vs. %s (%g)',var1name,mean(var1),var2name,mean(var2)));

% plot...
hold on;
plot(2:N,P);
plot(get(gca,'xLim'),[.05 .05],'r--'); % .05 sig value
xlabel('Number of Subjects'); ylabel('P-Value');
ylim([0 1]); % anchor
% set(gca,'xTickLabel',2:N); 
hold off;
% gussy(pvbs);
