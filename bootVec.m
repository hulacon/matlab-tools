function bootInfo = bootVec(vec)
% bootInfo = bootVec(vec)
% 
% Randomly flips sign of each value within the vector across some number of
% iterations and returns the values for inferring relation of observed to
% null.
% 
% jbh 3/22/14


% params
Niter = 5000;
vlen=length(vec);

% rng (comment out the below if you want uncontrolled seed)
rng(42);

bootInfo.actData = vec;
bootInfo.actMean = nanmean(vec);

% create sign flip matrix
sfmat=round(rand([vlen Niter]))*2-1;

% create dist matrix
distmat = repmat(vec,1,Niter);
distmat = sfmat.*distmat;

bootInfo.distMatrix = distmat;
bootInfo.distMean = nanmean(distmat);

bootInfo.p = mean(bootInfo.distMean>bootInfo.actMean);