%% Estimating kinetic components in proposed model
% By global optimization

% Initial educated guess for parameters being optimized
mu_max = 0.662;
ks = 1.342;
max_ethanol = 95.40;
params = [mu_max ks max_ethanol];
lb = [0 0 0]; % params cannot be negative

% Load objective function
obj_func = @objective;

% Use non gradient optimization algorithm
options = optimoptions('patternsearch','display','iter');
par_opt = patternsearch(obj_func,params,[],[],[],[],lb,[],[],options)