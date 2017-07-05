function scaledthing = instascale(thing)
% scaledthing = instascale(thing)
% 
% Takes in a matrix (or vec) and norms to be between 0 and 1 within column
% 
% jbh 4/17/14

btm = thing-repmat(min(thing),size(thing,1),1);
scaledthing = btm./repmat(max(btm),size(btm,1),1);
