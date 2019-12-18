%% Differential Equations for Ethanol Fermentation

function dxdt = model(~,x,total_in,glucose_in,volume,rates,mu_max,ks,max_ethanol)
% Dilution rate
D = total_in/volume; % per hour

% CONSTANTS (from literature)
kla_co2 = (0.0051 + 0.0014)/2 * 3600; % CO2 exchange rate per hour
kh_co2 = 1.496; % Harry's constant, gram per liter and atm
p_co2 = 0.056; % partial pressure CO2, atm
max_co2 = kh_co2*p_co2; % gram per liter

% KINETIC MODEL
mu_by_glucose = x(1)/(ks + x(1)); % activator
mu_by_ethanol = 1-x(3)/max_ethanol; % inhibitor
total_mu = mu_max*mu_by_glucose*mu_by_ethanol;
r = total_mu*x(2);

% Differential equations
dxdt = zeros(4,1);
dxdt(1) = rates(1)*r + D*(glucose_in - x(1));
dxdt(2) = rates(2)*r + D*(0 - x(2));
dxdt(3) = rates(3)*r + D*(0 - x(3));
dxdt(4) = rates(4)*r + D*(0 - x(4)) + kla_co2*(max_co2 - x(4));
end