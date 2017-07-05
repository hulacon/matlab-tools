function P = quickT(X,shush)
% P = quickT(X,shush)
%
% produces a tvalue from the test of X vs. 0.  if X has two columns, then
% produces tval of the difference (paired ttest). If shush is true, then
% doesn't print anything to command line.
% jbh 7/5/17

% reshape into column ifneedbe
if isvector(X)
    X = reshape(X,length(X),1);
end

if size(X,2)>1
    
    [H,P,CI,STATS] = ttest(X(:,1),X(:,2));
    
else
    
    [H,P,CI,STATS] = ttest(X);
    
end

[xbar se] = sterrmean(X);

if ~exist('shush','var')||~shush
    fprintf('\nx:\t%f\nse:\t%f\nt:\t%f\ndf:\t%d\np:\t%f\n',xbar,se,STATS.tstat,STATS.df,P);
end