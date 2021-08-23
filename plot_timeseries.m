
function [] = plot_figure1(state_prior, state_posterior, observations)
    [state_length,  days] = size(state_prior)
    x = 1: days;

    figure()
    %% Layer 1
    lyr = 1;
    subplot(3, 1, lyr)
    hold on

    for i = 1: days - 1
        plot([i, i+1], [state_posterior(lyr, i), state_prior(lyr, i+1)],'bo-', 'LineWidth', 1)
    end
    plot(x, observations(:, lyr), 'm^', 'MarkerSize', 8, 'LineWidth', 1)
    ylim([0.3, 0.6])
    xlim([1 9])
    %% Layer 2
    lyr = 2;
    subplot(3, 1, lyr)
    hold on
    for i = 1: days - 1
        plot([i, i+1], [state_posterior(lyr, i), state_prior(lyr, i+1)],'bo-', 'LineWidth', 1)
    end
    plot(x, observations(:, lyr), 'm^', 'MarkerSize', 8, 'LineWidth', 1)
    ylim([0.3, 0.6])
    xlim([1 9])

    %% Layer 3
    lyr = 3;
    subplot(3, 1, lyr)
    hold on
    for i = 1: days - 1
        plot([i, i+1], [state_posterior(lyr, i), state_prior(lyr, i+1)],'bo-', 'LineWidth', 1)
    end
    ylim([0.3, 0.6])
    xlim([1 9])
