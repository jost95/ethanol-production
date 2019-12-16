%% Analytic solutions to simplified differential equations

syms x1 x2 x3

x1_in = 1;
D = 10/100;
mu_max = 0.662;
Ks = mu_max/2;
x3_max = 95.40;
k1 = 1;
k2 = 1;
k3 = 2;

mu_by_glucose = x1/(Ks + x1);
mu_by_ethanol = 1 - x3/x3_max;
mu_total = mu_max*mu_by_glucose*mu_by_ethanol;
r = mu_total*x2;

eq1 = k1*r + D*(x1_in - x1) == 0;
eq2 = k2*r + D*(0 - x2) == 0;
eq3 = k3*r + D*(0 - x3) == 0;
eqs = [eq1, eq2, eq3];

[x1_opt, x2_opt, x3_opt] = solve(eqs,[x1 x2 x3]);

x1_opt = vpa(x1_opt)
x2_opt = vpa(x2_opt)
x3_opt = vpa(x3_opt)