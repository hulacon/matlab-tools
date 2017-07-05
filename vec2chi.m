function [chi2 p] = vec2chi(inVec)
% returns chi2 value for a vector of counts
% jbh 11/24/14


nCells = numel(inVec);
dF = nCells - 1; %yeah?

expect = mean(inVec);
oe = inVec-expect;
oe2 = oe.*oe;
chi2 = sum(oe2./expect);
p=1-chi2cdf(chi2,dF);