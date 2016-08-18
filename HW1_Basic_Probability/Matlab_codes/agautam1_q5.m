function [ ] = agautam1_q5 ( )
%AGAUTAM1_Q1 Summary of this function goes here
%   Detailed explanation goes here

% Defining the parameters i.e mean, co-variance and the meshgrid 
mean = [0 0];
covariance = [1 -0.5; -0.5 1];
% 1000 samples point in both direction
x1 = -5:.01:5; 
x2 = -5:.01:5;

[X1,X2] = meshgrid(x1,x2);

% Multivariant Gaussian Function 
prob_func = mvnpdf([X1(:) X2(:)],mean,covariance);
% Reshaping to fit the axis grid i.e size(x1)*size(x2) in 2-Dimensions
prob_func = reshape(prob_func,length(x1),length(x2));

figure
% Surface of the prob_func which will plot the value along z axis
h = surf(prob_func);
% Make sure that the line grid is not there else it will be black
set(h,'LineStyle','none')
% setting the axis of the plot to fit as per the dimensions defined
axis([0 1000 0 1000 0 .2])

% labelling the axis
fprintf('Plotting the 2-D gaussian graph \n');
xlabel('x1 (1000 samples)'); 
ylabel('x2 (1000 samples)'); 
zlabel('2-D Gaussian function');
title('Sample plot : question#5 ');

scatter_plot = mvnrnd(mean,covariance,1000);

figure
fprintf('Scatter plot q#5');
plot(scatter_plot(:,1),scatter_plot(:,2),'*')
xlabel('x1');
ylabel('x2');
title('Scatter plot q#5');

end