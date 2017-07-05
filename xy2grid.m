function Z = xy2grid(x,y,nBins)
% Z = xy2grid(x,y[,nBins])
% 
% jbh 2/14/14

if ~exist('nBins','var')
nBins = 50;
end

xi = linspace(min(x(:)),max(x(:)),nBins);
yi = linspace(min(y(:)),max(y(:)),nBins);

xr = interp1(xi,1:numel(xi),x,'nearest');
yr = interp1(yi,1:numel(yi),y,'nearest');

Z = accumarray([xr yr], 1, [nBins nBins])'; % permuting to make it work right?
