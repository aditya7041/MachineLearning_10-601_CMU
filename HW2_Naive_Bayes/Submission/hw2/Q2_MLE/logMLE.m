function [ ] = logMLE()

theta = 0.01:.01:0.5; 

x = [1 0 3 5 18 14 5 7 13 9 0 17 4 24 3];

y5= sum(x(1:5))*log(1-theta) + 5*log(theta);
y10 =  sum(x(1:10))*log(1-theta) + 10*log(theta);
y15 = sum(x(1:15))*log(1-theta) + 15*log(theta);

figure
plot(theta,y5)
xlabel('theta');
ylabel('y(log MLE)');
title('Log MLE (5 points)');

figure
plot(theta,y10)
xlabel('theta');
ylabel('y(log MLE)');
title('Log MLE (10 points)');

figure
plot(theta,y15)
xlabel('theta');
ylabel('y(log MLE)');
title('Log MLE (15 points)');

end

