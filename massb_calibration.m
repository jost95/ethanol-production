%% Estmating the pseudo-stoichiometric coefficients in proposed model
% Input parameters for different training trials
total_in = [10; 20; 10];
glucose_in = [1; 1; 10];
volume = [100; 100; 100];
initial_glucose = [50; 50; 50];
initial_biomass = [1; 1; 1];

% Steady state solutions (manually read from training data)
x1_ss = [0.021945; 0.046896; 0.022411];
x2_ss = [0.27944; 0.27232; 2.85070];
x3_ss = [0.13972; 0.13616; 1.42540];

% Estimate pseudo-stoichiometric coefficients
% By linear regression at steady state
k1 = x2_ss\(x1_ss - glucose_in);
k3 = x2_ss\x3_ss;