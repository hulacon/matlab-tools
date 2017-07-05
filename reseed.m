function reseed
% reseed
%
% reseeds random based on clock (using matlab version specific method)
%
% jbh 9/21/2011

if verLessThan('matlab', '7.7')
    rand('seed',sum(100*clock));
else
    currStream = RandStream.getGlobalStream;
    if currStream.Seed == 0 % (should only be done ONCE per session)
        RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));
    end
end