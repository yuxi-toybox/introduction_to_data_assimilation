
function [] = plot_timeseries_EnKF(X_prior, X_posterior, observations, X_prior_ensemble, X_posterior_ensemble, obs_ensemble)
    [state_length, ensemble_size, days] = size(X_prior_ensemble)
    x = 1 : days;

    figure()
    %% Layer 1    
    subplot(3, 1, 1)
    lyr = 1;
    hold on
    for i = 1: days - 1
        for j = 1: ensemble_size
            plot([i, i+1], [X_posterior_ensemble(lyr, j, i), X_prior_ensemble(lyr, j, i+1)],'--', 'Color', [1,1,1] * 0.8, 'LineWidth', 1)
        end
        plot([i, i+1], [X_posterior(lyr, i), X_prior(lyr, i+1)],'bo-', 'LineWidth', 1)

    end
    plot(x, observations(:, lyr), 'm^', 'MarkerSize', 8, 'LineWidth', 1)
    for j = 1: ensemble_size
        plot(x, reshape(obs_ensemble(lyr, j, :), 1, days),'^', 'Color', [1,1,1] * 0.6, 'MarkerSize', 5, 'LineWidth', 0.5)
    end
    ylim([0.3, 0.6])
    xlim([1 9])
   
    %% Layer 2    
    lyr = 2;
    subplot(3, 1, lyr)
    hold on
    for i = 1: days - 1
        for j = 1: ensemble_size
            plot([i, i+1], [X_posterior_ensemble(lyr, j, i), X_prior_ensemble(lyr, j, i+1)],'--', 'Color', [1,1,1] * 0.8, 'LineWidth', 1)
        end
        plot([i, i+1], [X_posterior(lyr, i), X_prior(lyr, i+1)],'bo-', 'LineWidth', 1)

    end
    plot(x, observations(:, lyr), 'm^', 'MarkerSize', 8, 'LineWidth', 1)
    for j = 1: ensemble_size
        plot(x, reshape(obs_ensemble(lyr, j, :), 1, days),'^', 'Color', [1,1,1] * 0.6, 'MarkerSize', 5, 'LineWidth', 0.5)
    end
    ylim([0.3, 0.6])
    xlim([1 9])
   
    %% Layer 3   
    lyr = 3;
    subplot(3, 1, lyr)
    hold on
    for i = 1: days - 1
        for j = 1: ensemble_size
            plot([i, i+1], [X_posterior_ensemble(lyr, j, i), X_prior_ensemble(lyr, j, i+1)],'--', 'Color', [1,1,1] * 0.8, 'LineWidth', 1)
        end
        plot([i, i+1], [X_posterior(lyr, i), X_prior(lyr, i+1)],'bo-', 'LineWidth', 1)
    end
    ylim([0.3, 0.6])
    xlim([1 9])
   
end