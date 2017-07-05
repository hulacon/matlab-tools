function [Xbar, SEM, CI95] = sterrmean(data)
%  [Xbar, SEM, CI95] = sterrmean(data)
% 
% returns mean and standard error for input data (performs calculation
% for each column if data is matrix. Ignores nans.
% 
% added 95 CI for each column
% 
% jbh 8/12/14

Xbar = nanmean(data);
SEM = nanstd(data)./sqrt(sum(~isnan(data)));
CI95 = prctile(data,[2.5 97.5]);

