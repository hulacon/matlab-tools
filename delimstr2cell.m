function strCell = delimstr2cell(str,delim)
% strCell = delimstr2cell(str,delim)
% 
% outputs cells of strs delimited by delim in input str
% 
% jbh 10/14/16

delimLen = length(delim);

delimInds = strfind(str,delim);


