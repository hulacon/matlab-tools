function RT = rttrim(RT)
% RT = rttrim(RT)
% 
% takes a vector or mat of RTs and recursively removes any data points outside of
% 3 stdev from the mean. if matrix, drops rows if ANY are outliers!
% 
%  jbh 2/15/12
% 
% rtstd = nanstd(RT);
% rtM = nanmean(RT);
% rtOs = RT>(rtM+3*rtstd)|RT<(rtM-3*rtstd);

rtOs = any(abs(zscore(RT))>3,2);
if any(rtOs)
    RT = RT(~rtOs,:);
    RT = rttrim(RT);
end