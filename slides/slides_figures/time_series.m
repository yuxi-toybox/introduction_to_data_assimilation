close all
clear
x0 = [0:0.1:100];
y0 = -0.1 * (x0 - 20) .* (x0 - 80)

x1 = [0:0.1:40];
y1 = -0.1 * (x1 - 20) .* (x1 - 80)

x2 = [40:0.1:70];
y2 = -0.1 * (x2 - 20) .* (x2 - 80) + 30

x3 = [70:0.1:100];
y3 = -0.1 * (x3 - 20) .* (x3 - 80) + 10

x4 = [40 70]
y4 = [140 20]
v0 = 2;

%%
figure()
plot(x0, y0, 'g-','LineWidth',4)

yticks([])
xticks([])
xlim([0 100])
ylim([-200 200])

%%
figure()
plot(x0, y0, 'g-','LineWidth',4)
hold on
plot(x4, y4, 'k^','LineWidth',3)

yticks([])
xticks([])
xlim([0 100])
ylim([-200 200])

%%
figure()
plot(x1, y1, 'b-','LineWidth',4)
hold on
plot(x2, y2, 'b-','LineWidth',4)

plot(x3, y3, 'b-','LineWidth',4)

plot(x4, y4, 'k^','LineWidth',3)

yticks([])
xticks([])
xlim([0 100])
ylim([-200 200])

% text( 10.5 , 1 , 'Prediction \rightarrow', 'fontsize', 13, 'HorizontalAlignment', 'right')



