function [a, b] = numFromStr(str, adjFlag)
% [a, b] = numFromStr(str, adjFlag)
%
% uses str2double to identify numbers from a specified string (str)
%
% a is logical vector the same length as str with 1 where str is numerical
% and 0 otherwise
%
% b is a numeric array of the numbers in str
% If adjFlag is specified, adjacent digits are made into single numbers
% 
% jbh 7/6/2010, updated 3/2017

if ~exist('adjFlag','var')
    adjFlag = false;
end

nums = arrayfun(@str2double,str); % get numbers or NaN for non-numbers

a = ~imag(nums)&~isnan(nums); % figure out which are real numbers (damn i&j)

b = nums(a);


if adjFlag
    numOn = find(diff(a)==1)+1;
    numOff = find(diff(a)==-1);
    if numel(numOff) < numel(numOn)
        numOff(end+1) = length(a);
    end
    
    b=arrayfun(@(x,y) str2double(str(x:y)),numOn,numOff);
    
end