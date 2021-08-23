close all
clear

x = [8: 0.01: 15];

figure()
% Prediction
mean1 = 10.8; std1 = 0.3;
% Observation
mean2 = 11.3; std2 = 0.5;
% BLUE: Best Linear Unbiased Estimate
std3 = (1/(1/std1^2 + 1/std1^2))^0.5
mean3 = mean1 + std1^2/(std1^2 + std2^2)*(mean2-mean1)
y1 = normpdf(x, mean1, std1);
y2 = normpdf(x, mean2, std2);
y3 = normpdf(x, mean3, std3);

% mean4 = mean2 + std2^2/(std2^2 + std1^2)*(mean1-mean2)


%%
figure()
plot(x, y1, 'b-.','LineWidth',4)
text( 10.5 , 1 , 'Forecast \rightarrow', 'fontsize', 13, 'HorizontalAlignment', 'right')
hold on
plot(x, y2, 'g--','LineWidth',4)
text( 11.75 , 0.6 , '\leftarrow Observation', 'fontsize', 13, 'HorizontalAlignment', 'left')

plot(x, y3, 'k-','LineWidth',4)
text( 10.75 , 1.6 , 'Analysis \rightarrow', 'fontsize', 13, 'HorizontalAlignment', 'right')

xlim([9.8, 12.5])
ylim([0, 2])
%%
figure()
plot(x, y1, 'b-.','LineWidth',4)
text( 10.5 , 1 , 'Forecast \rightarrow', 'fontsize', 13, 'HorizontalAlignment', 'right')
hold on
plot(x, y2, 'g--','LineWidth',4)
text( 11.75 , 0.6 , '\leftarrow Observation', 'fontsize', 13, 'HorizontalAlignment', 'left')

xlim([9.8, 12.5])
ylim([0, 2])


