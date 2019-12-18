%% Analytic solutions to simplified differential equations

% Declare symbolic variables
syms x1 x2 x3

% Construct variable vector
x_v = [x1 x2 x3];

% Set parameters
x1_in = 1;
D = 10/100;
mu_max = 0.662;
Ks = mu_max/2;
x3_max = 95.40;
k1 = 1;
k2 = 1;
k3 = 2;

% Construct model expressions
mu_by_glucose = x1/(Ks + x1);
mu_by_ethanol = 1 - x3/x3_max;
mu_total = mu_max*mu_by_glucose*mu_by_ethanol;
r = mu_total*x2;

exp1 = k1*r + D*(x1_in - x1);
exp2 = k2*r + D*(0 - x2);
exp3 = k3*r + D*(0 - x3);
exps = [exp1, exp2, exp3];

% Solve at steady state
[x1_opt, x2_opt, x3_opt] = solve(exps == 0,x_v);

% Convert to numeric values
x1_opt = double(x1_opt);
x2_opt = double(x2_opt);
x3_opt = double(x3_opt);

% Construct solution vectors
x_sol_1 = [x1_opt(1), x2_opt(1), x2_opt(1)]
x_sol_2 = [x1_opt(2), x2_opt(2), x2_opt(2)]
x_sol_3 = [x1_opt(3), x2_opt(3), x2_opt(3)]

% Compute Jacobian
J = jacobian(exps, x_v);

% Evaluate Jacobian at steady state, extract solutions from each component
J1 = double(subs(J, x_v, x_sol_1))
J2 = double(subs(J, x_v, x_sol_2))
J3 = double(subs(J, x_v, x_sol_3))

% Compute eigen values
lamda1 = eig(J1)
lamda2 = eig(J2)
lamda3 = eig(J3)