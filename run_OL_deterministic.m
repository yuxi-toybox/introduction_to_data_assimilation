%% Loading data
clear
close all
% cd 'H:\My Drive\Slides\Introduction_DA\scripts'
weathers = load('data\ExampleData.csv');
observations = load('data\Obs.csv');

%% Set model initial conditions
state = [0.3 0.3 0.3]';

%% Run the model in a loop.
days = length(weathers);
state_all = zeros(length(state),days);

for i = 1 : days
    % get daily data
    weather = weathers (i, :)';
    state = HydroModel(state, weather);
    state_all(:, i) = state;
end

%% Generate random observations
obs_all = state_all + randn(size(state_all))*0.2^2;
obs_all = obs_all(1:2, :)';

plot_timeseries(state_all, state_all, observations)
