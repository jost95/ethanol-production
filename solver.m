%% Ethanol Fermentation solver

function dxdt = solver(~,x,total_in,glucose_in,volume)
% -------- SYSTEM PARAMETERS -------
% Stoichiometric coefficients
k1 = -1;
k2 = 1; % normalized around bio mass generation
k3 = 2;
k4 = 2;

% Dilution rate
D = total_in/volume; % per hour

% Gas exchange rate (empircally derived)
kla_co2 = (0.0051 + 0.0014)/2 * 3600; % per hour

% Saturated gas concentrations (empircally derived)
kh_co2 = 1.496; % Harry's constant, gram per liter and atm
p_co2 = 0.056; % Partial pressure CO2, atm
max_co2 = kh_co2*p_co2; % gram per liter

% State vectors
rates = [k1, k2, k3, k4];

% Kenetic model
mu_max = 0.662; % maximum biomass rate (per hour)
ks = 1.342; % velocity constant (per hour)
max_ethanol = 95.40; % gram per liter

% Activator
mu_by_glucose = x(1)/(ks + x(1));

% Prohibitor
mu_by_ethanol = 1-(x(3)/max_ethanol);

% Combined kinetic model
total_mu = mu_max*mu_by_glucose*mu_by_ethanol;
r = total_mu*x(2);

dxdt = zeros(4,1);
dxdt(1) = rates(1)*r + D*(glucose_in - x(1));
dxdt(2) = rates(2)*r + D*(0 - x(2));
dxdt(3) = rates(3)*r + D*(0 - x(3));
dxdt(4) = rates(4)*r + D*(0 - x(4)) + kla_co2*(max_co2 - x(4));
end