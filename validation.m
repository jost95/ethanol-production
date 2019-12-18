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

% Estimated stoichiometric coefficients (see calibration)
k1 = -3.5;
k2 = 1; % normalized around bio mass generation
k3 = 0.5;
k4 = 2; % not evaluated, only for reference
rates = [k1, k2, k3, k4];

% Estimated kinetic constants (see calibration)
mu_max = 0.662; % maximum biomass rate (per hour)
ks = 1.342; % velocity constant (per hour)
max_ethanol = 95.40; % gram per liter

% Simulation results
tspan_test = 0:0.1:200; 
initials = [initial_glucose; initial_biomass; initial_ethanol; initial_co2];
[tspan_test,y_test] = ode23(@(t,y) model(t,y,total_in,glucose_in,volume,rates,mu_max,ks,max_ethanol),tspan_test,initials);

% LOAD ACTUAL TEST DATA

% PLOT DIFFERENCE
figure(1)
plot(tspan_test,y_test(:,1),tspan_test,y_test(:,2),tspan_test,y_test(:,3))
title('Concentrations from Ethanol Fermentation');
xlabel('Hours');
ylabel('Concentrations');
legend('Glucose','Biomass','Ethanol')

% CO2 PLOT (only for reference)
figure(2)
plot(tspan(1:t_max),y(1:t_max,4))
title('CO2 concentration from Ethanol Fermentation');
xlabel('Hours');
ylabel('CO2 concentration');
legend('Carbondioxide')

