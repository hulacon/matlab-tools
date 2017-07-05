function [Y,S,F1,F2] = anovaCell2Vec(anovaCell)
% [Y,S,F1,F2] = anovaCell2Vec(anovaCell)
% 
% Generates vectors compatible with rm_anova2 (3 dim functionality pending)
% given a F1xF2 cell filled with vecs of Y, lengthed S.
% 
% jbh 8/12/14

aSz = size(anovaCell);
aNe = prod(aSz);

nF1=aSz(1);
nF2=aSz(2);
nS = cellfun('prodofsize',anovaCell);
assert(all(diff(nS(:))==0),'All cells must be of same size!');
nS = nS(1);

Y=vertcat(anovaCell{:});
S=repmat(1:nS,1,aNe)';
F1=repmat(sort(repmat(1:nF1,1,nS)),1,nF2)';
F2=sort(repmat(repmat(1:nF2,1,nS),1,nF1))';