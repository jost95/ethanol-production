%% Variable declaration

% ------- USER DEFINED PAREMTERS --------
glucose_in = 0;
oxygen_in = 0;
total_in = glucose_in + oxygen_in; 
volume = 100;
initial_glucose = 0; % 100 grams per liter
initial_biomass = 0; % 
% ---------------------------------------

% -------- UNCONTROLLABLE PARAMETERS -------
% Product states
initial_ethonal = 0;
initial_co2 = 0;

% State vector
x = [initia_glucose; initial_oxygen; initial_biomass; initial_ethanol; initial_co2];

D = total_in/volume; % dilusion rate

% Gas loss parameters
% Harry's constant
kh_oxygen = 1;
kh_co2 = 1;

% Exchange rate
kla_oxygen = 1;
kla_co2 = 1;

% Dissolved concentrations
conc_o2 = 1;
conc_co2 = 1;

% Partial pressures
pressure_oxygen = 1;
pressure_co2 = 1;

% Stoichiometric coefficients
k1 = 2;
k2 = 2;
k3 = 1; % normalize around bio mass generation
k4 = 2;
k5 = 2;
k = [-k1, -k2, k3, k4, k5];

% Kenetic model
% foundamental constraints allready in kinetic model

u_max = 0.6; % maximum biomass rate (per hour)
ks = u_max/2;

% Activators
mu_by_glucose = glucose/(ks + glucose);
mu_by_oxygen = oxygen/(ks + oxygen);

% Prohibotr
mu_by_ethanol = 1;

% Combiend kinetic model
total_mu = u_max * mu_by_glucose * mu_by_oxygen * mu_by_ethanol;

% Calculate rho
rho = total_mu * biomass;


