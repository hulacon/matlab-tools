function [q1a q2a q3a q4a] = avgByQuartile(xVals,yVals)
% [q1a q2a q3a q4a] = avgByQuartile(xVals,yVals)
% 
% returns and renders average y values (yVals) for each quartile of x
% values (xVals). Assumes inputs are vectors and can only handle one set of
% factors (for the time being).
% 
% jbh 12/4/12



qbs = quantile(xVals,3);

q1 = xVals<=qbs(1);
qlab{1} = [num2str(min(xVals)) ' to ' num2str(qbs(1))];
y1 = yVals(q1);
q1a=mean(y1);
sem1=std(y1)/sqrt(length(y1));

q2 = (xVals>qbs(1))&(xVals<=qbs(2));
qlab{2} = ['> ' num2str(qbs(1)) ' to ' num2str(qbs(2))];
y2 = yVals(q2);
q2a=mean(y2);
sem2=std(y2)/sqrt(length(y2));

q3 = (xVals>qbs(2))&(xVals<=qbs(3));
qlab{3} = ['> ' num2str(qbs(2)) ' to ' num2str(qbs(3))];
y3 = yVals(q3);
q3a=mean(y3);
sem3=std(y3)/sqrt(length(y3));

q4 = xVals>qbs(3);
qlab{4} = ['> ' num2str(qbs(3)) ' to ' num2str(max(xVals))];
y4 = yVals(q4);
q4a=mean(y4);
sem4=std(y4)/sqrt(length(y4));


% plot
figure;
bar([q1a q2a q3a q4a]);
hold on 
errorbar(1:4,[q1a q2a q3a q4a],[sem1 sem2 sem3 sem4],'k.')
hold off
set(gca,'XTickLabel',qlab);