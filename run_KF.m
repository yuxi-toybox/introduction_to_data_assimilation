%% Loading data
clear
close all
% cd 'H:\My Drive\Slides\Introduction_DA\scripts'
weathers = load('data\ExampleData.csv');
observations = load('data\Obs.csv');

%% Model initial conditions
state= [0.3 0.3 0.3]';

%% KF matrices
% Define observational matrix H.
H = [1 0 0; 0, 1, 0];
% Set model and observational error variance by estimation.
Q = [0.1 0 0; 0 0.1 0; 0 0 0.1].^2;
R = [0.1 0; 0, 0.1].^2;
% Set  initial error covariance by guess. 
% Note that P, Q, R are symmetric matrices.
P = [0.1 0 0; 0 0.1 0; 0 0 0.1].^2;

%% Run the model in a loop.
days = length(weathers);
% Create empty matrices to save data.
state_prior = nan(length(state),days);
state_posterior = nan(size(state_prior));
P_all = nan([size(P) days]);
tmp = size(H);
K_all = nan(length(state), tmp(1), days);

for i = 1 : days
    % get daily data
    weather = weathers (i, :)';
    obs = observations (i, :)';
    state = HydroModel(state, weather);
    state_prior(:, i) = state;

    % Check if observation is available. 
    % If yes, run data assimilation to update the state vector.
    if ~isnan(obs)
        K = P * H' * (H * P * H' + R ) ^ (-1); 
        P = (1 - K * H) * P;
        state = state + K * (obs - H * state); 
        % Save or export the values of theta, K, P if necessary.
        P_all(:,:,i) = P;
        K_all(:,:,i) = K;
        disp('State is updated.')
    else
        disp('Observation is not available!')
    end
    state_posterior(:, i) = state;
end

%% Check output
state_prior
state_posterior
plot_timeseries(state_prior, state_posterior, observations)

