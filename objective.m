%% Objective function for our model

function cost = objective(params)
% Define constants for trial
total_in = 10;
glucose_in = 1;
volume = 100;
initial_glucose = 50;
initial_biomass = 1;
initial_ethanol = 0;
initial_co2 = 0;

% Define already estimated parameters
k1 = -3.5;
k2 = 1;
k3 = 0.5;
k4 = 1;
rates = [k1 k2 k3 k4];

% Split variables being optimized
mu_max = params(1);
ks = params(2);
max_ethanol = params(3);

% Read training data, only consider first mode
% 200h with 0.1 intervals yields first 2000 instances
train_data = readmatrix('source_data/train.csv');
train_data = train_data(1:2000,:);

% Simulation
tspan = train_data(:,1); 
initials = [initial_glucose; initial_biomass; initial_ethanol; initial_co2];
[~,y] = ode23(@(t,y) model(t,y,total_in,glucose_in,volume,rates,mu_max,ks,max_ethanol),tspan,initials);

% Calculate cost
diff = y-train_data(:,2:5);
norms = vecnorm(diff');
cost = sum(norms);

end