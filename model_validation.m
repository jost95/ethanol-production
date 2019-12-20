%% Validation of Ethanol Fermentation Model

% ------- USER DEFINED PARAMETERS FOR TEST DATA --------
total_in = 5; % liter per hour
glucose_in = 5; % gram per (liter and hour)
volume = 100; % liter 
initial_glucose = 20; % gram per liter
initial_biomass = 10; % gram per liter
% ------------------------------------------------------

% Fixed parameters
initial_ethanol = 0;
initial_co2 = 0;

% Estimated stoichiometric coefficients (see kinetic_calibration)
k1 = -3.5;
k2 = 1; % normalized around bio mass generation
k3 = 0.5;
k4 = 1;
rates = [k1, k2, k3, k4];

% Estimated kinetic constants (see massb_calibration)
mu_max = 1.6893; % maximum biomass rate (per hour)
ks = 0.3476; % velocity constant (per hour)
max_ethanol = 38.7585; % gram per liter

% LOAD ACTUAL TEST DATA
test_data = readmatrix('source_data/test.csv');
tspan_test = test_data(:,1);
y_test = test_data(:,2:5);

% Simulation results
initials = [initial_glucose; initial_biomass; initial_ethanol; initial_co2];
[~,y_sim] = ode23(@(t,y) model(t,y,total_in,glucose_in,volume,rates,mu_max,ks,max_ethanol),tspan_test,initials);

% PLOT DIFFERENCES
figure(1)

subplot(2,2,1)
loglog(tspan_test,y_sim(:,1),tspan_test(:),y_test(:,1))
title('Glucose concentration')
xlabel('Hours');
legend('Simulated','Actual')

subplot(2,2,2)
loglog(tspan_test,y_sim(:,2),tspan_test,y_test(:,2))
title('Bimoass concentration')
xlabel('Hours');
legend('Simulated','Actual')

subplot(2,2,3)
loglog(tspan_test,y_sim(:,3),tspan_test,y_test(:,3))
title('Ethanol concentration')
xlabel('Hours');
legend('Simulated','Actual')

subplot(2,2,4)
loglog(tspan_test,y_sim(:,4),tspan_test,y_test(:,4))
title('CO2 concentration')
xlabel('Hours');
legend('Simulated','Actual')
