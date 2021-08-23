function [state_out] = HydroModel(state_in, weather)

    % Define matrices in model
    A = [1 0 0; 0 1 0; 0 0 1]; 
    B = [1 -1 -1; 0 0 0; 0 0 0] ; 
    C = [1 0; 1 -1; 0 1]; 
    parameter = [20 10]';
    state_out = A * state_in + B * weather * 0.001 + C * parameter  * 0.001;
    
    % Constrain range
    state_out(state_out<0.1) = 0.1;
    state_out(state_out>0.9) = 0.9;