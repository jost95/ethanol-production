%% Ethanol Fermentation solver

function dxdt = solver(~,x,total_in,glucose_in,oxygen_in,volume)
% -------- SYSTEM PARAMETERS -------
% Stoichiometric coefficients
k1 = 1;
k2 = 3;
k3 = 1; % normalized around bio mass generation
k4 = 2;
k5 = 2;

% Dilution rate
D = total_in/volume; % per hour

% Gas exchange rate (empircally derived)
kla_oxygen = (0.0070 + 0.0049)/2 * 3600; % per hour
kla_co2 = (0.0051 + 0.0014)/2 * 3600; % per hour

% Saturated gas concentrations (empircally derived)
sat_conc_oxygen = 7.15/1000; % gram per liter
sat_conc_co2 = 14.42/1000; % gram per liter

% State vectors
rates = [-k1, -k2, k3, k4, k5];

% Kenetic model
u_max = 0.662; % maximum biomass rate (per hour)
ks = u_max/2; % velocity constant (per hour)
ethanol_max = 95.40; % gram per liter
beta = 1.29; % dimensionless prohibiotion constant

% Activators
mu_by_glucose = x(1)/(ks + x(1));
mu_by_oxygen = x(2)/(ks + x(2));

% Prohibitors
mu_by_ethanol = 1-(x(4)/ethanol_max)^beta;

% Combined kinetic model
total_mu = u_max*mu_by_glucose*mu_by_oxygen*mu_by_ethanol;
rho = total_mu*x(3);

dxdt = zeros(5,1);
dxdt(1) = rates(1)*rho + D*(glucose_in - x(1));
dxdt(2) = rates(2)*rho + D*(oxygen_in - x(2)) + kla_oxygen*(sat_conc_oxygen - x(2));
dxdt(3) = rates(3)*rho + D*(0 - x(3));
dxdt(4) = rates(4)*rho + D*(0 - x(4));
dxdt(5) = rates(5)*rho + D*(0 - x(5)) + kla_co2*(sat_conc_co2 - x(5));
end