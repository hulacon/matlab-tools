function lowlog = islower(inString)
% lowlog = islower(inString)
% 
% returns logical vector which is true for lower case strings
% 
% jbh 10/8/13

lowlog = bsxfun(@eq,inString,lower(inString));