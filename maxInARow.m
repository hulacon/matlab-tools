function miar = maxInARow(X)
% miar = maxInARow(X)
%
% returns the maximum number of neighboring elements, miar, that are identical for
% a numerical vector, X
%
% jbh 2/7/11

Y = ~diff(X); % neighboring elements
Yc = 1; % 1 is zero neighboring elements...

while any(Y)
% still some neighboring elements...
        Yc = Yc+1;
        Y = diff(find(Y))==1;
end
miar = Yc;

