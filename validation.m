%% Ethanol Fermentation Model

% ------- USER DEFINED PARAMETERS --------
total_in = 10; % liter per hour
glucose_in = 1; % gram per (liter and hour)
volume = 100; % liter 
initial_glucose = 50; % gram per liter
initial_biomass = 1; % gram per liter
% ---------------------------------------

% Fixed parameters
initial_ethanol = 0;
initial_co2 = 0;

% Estimated stoichiometric coefficients (see 
k1 = -3.5;
k2 = 1; % normalized around bio mass generation
k3 = 0.5;
k4 = 2;

% Estimated kinetic constants
mu_max = 0.662; % maximum biomass rate (per hour)
ks = 1.342; % velocity constant (per hour)
max_ethanol = 95.40; % gram per liter

% Solve differential equations, for 3 training phases
% Phase one
% Base line parameters, high initial glucose
tspan = 0:0.1:200; 
initials = [initial_glucose; initial_biomass; initial_ethanol; initial_co2];
[tspan,y] = ode23(@(t,y) solver(t,y,total_in,glucose_in,volume), tspan, initials);

% For testing purposes

figure(1)
plot(tspan_test,y_test(:,1),tspan_test,y_test(:,2),tspan_test,y_test(:,3))
title('Test: Concentrations from Ethanol Fermentation');
xlabel('Hours');
ylabel('Solution');
legend('Glucose','Biomass','Ethanol')

% figure(2)
% t_max = 20;
% plot(tspan(1:t_max),y(1:t_max,4))
% title('Concentrations from Ethanol Fermentation');
% xlabel('Hours');
% ylabel('Solution');
% legend('Carbondioxide')

