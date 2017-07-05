function M = cell2padmat(C,catdim,padval)
%CELL2PADMAT pad cell contents and convert to mat
%   M = cell2padmat(C,catdim,padval) pads contents of cell C with padval
%   (trailing content) in order to create single matrix concatenated along
%   catdim
% 
% jbh 7/3/13

% specifiy defaults
if nargin < 3
    padval = NaN;
end

if nargin < 2
    catdim = 1;
end

% get all sizes
aS=cellfun(@size,C,'UniformOutput',false);
aS=vertcat(aS{:});
% get maxsize
mS=max(aS);

% create cell with equal content sizes along non-catted dims
T=cell(size(C));
for cc = 1:numel(C)
    sD = mS-aS(cc,:);
    sD(catdim) = 0; % don't alter dimension which will be concatenated
    T{cc}=padarray(C{cc},sD,padval,'post');
end

% create mat
M = cat(catdim,T{:});