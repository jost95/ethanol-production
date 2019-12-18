%% Estmating the paramters in our proposed model
% NOTE: Important to withhold one for testing purposes

% Input parameters for different training trials
total_in = [10; 20; 10; 5];
glucose_in = [1; 1; 10; 5];
volume = [100; 100; 100; 100];
initial_glucose = [50; 50; 50; 20];
initial_biomass = [1; 1; 1; 10];

% Steady state solutions (manually read from training data)
x1_ss = [0.021945; 0.046896; 0.022411; 0.010722];
x2_ss = [0.27944; 0.27232; 2.85070; 1.42620];
x3_ss = [0.13972; 0.13616; 1.42540; 0.712850];

% Part 1: Estimate pseudo-stoichiometric coefficients
% By linear regression at steady state
k1 = x2_ss(1:end-1)\(x1_ss(1:end-1) - glucose_in(1:end-1));
k3 = x2_ss(1:end-1)\x3_ss(1:end-1);

% Part 2: Estimate kinetic components
% By optimizing

train_data = readmatrix('source_data/train.csv');