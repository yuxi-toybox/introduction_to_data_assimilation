%% Loading data
clear
close all
% cd 'H:\My Drive\Slides\Introduction_DA\scripts'
weathers = load('data\ExampleData.csv');
observations = load('data\Obs.csv');

%% Model initial conditions
state= [0.3 0.3 0.3]';

%% EnKF settings.
% Define observational matrix H.
H = [1 0 0; 0, 1, 0];
% Set model and observational error variance by estimation.
R = [0.03 0; 0, 0.03].^2;
% Set uncertainty for weather, initial conditions and observations.
error_weather = [5 3 1]';
error_init = [0.1 0.1 0.1]';
error_obs = [0.03 0.03]';

%% Generate ensemble.
ensemble_size = 5;
% Perturb initial conditions.
X = repmat(state, 1, ensemble_size);
for i = 1:length(state)
    X(i, :) =  X(i, :) + randn(1, ensemble_size) * error_init(i);
end

% Create empty matrices to save data.
days = length(weathers);
X_prior = nan(length(state), days);
X_prior_ensemble = nan(length(state), ensemble_size, days);
X_posterior = nan(size(X_prior));
X_posterior_ensemble = nan(size(X_prior_ensemble));
tmp = size(H);
obs_ensemble = nan(tmp(1), ensemble_size, days);
K_all = nan(length(state), tmp(1), days);
P_all = nan(length(state), length(state), days);

%% Run the model in a loop.
for i = 1 : days
    % Get daily data
    weather = weathers (i, :)';
    obs = observations (i, :)';
    % Perturb weather forces. f is a matrix of no_of_weather by
    % ensemble_size.
    f = repmat(weather, 1, ensemble_size);
    for j = 1:length(weather)
        f(j, :) = f(j, :) + randn(1, ensemble_size) * error_weather(j);
    end
    % Run stochastic model. Note that X and f are matrices in EnKF rather
    % than vectors in KF.
    X = HydroModel(X, f);
    X_prior_ensemble(:, :, i) = X;
    X_prior(:, i) = mean(X, 2);
    
    % Check if observation is available. 
    % If yes, run data assimilation to update the state vector.
    if ~isnan(obs)
        % Perturb observation (y).
        y = repmat(obs, 1, ensemble_size);
        for j = 1:length(obs)
            y(j, :) = y(j, :) + randn(1, ensemble_size) * error_obs(j);
        end
        % Run EnKF
        X_mean = mean(X, 2);
        D = X - repmat(X_mean, 1, ensemble_size);
        P = D * D' / (1 + ensemble_size);
        K = P * H' * (H * P * H' + R) ^ (-1); 
        X = X + K * (y - H * X);
        % Save or export the values of theta, K, P if necessary.
        P_all(:,:,i) = P;
        K_all(:,:,i) = K;
        obs_ensemble(:, :, i) = y;
        disp('State is updated.')
    else
        disp('Observation is not available!')
    end
    X_posterior_ensemble(:, :, i) = X;
    X_posterior(:, i) = mean(X, 2);
end

%% Check output
X_prior
X_posterior
obs_ensemble
plot_timeseries_EnKF(X_prior, X_posterior, observations, X_prior_ensemble, X_posterior_ensemble, obs_ensemble)

