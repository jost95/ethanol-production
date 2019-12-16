%% Ethanol Fermentation Model

% ------- USER DEFINED PAREMTERS --------
total_in = 10; % liter per hour
glucose_in = 1; % gram per (liter and hour)
volume = 100; % liter 
initial_glucose = 1; % gram per liter
initial_biomass = 1; % gram per liter
% ---------------------------------------

initial_ethanol = 0;
initial_co2 = 0;

% Solve differential equations
tspan = [0,20];
initials = [initial_glucose; initial_biomass; initial_ethanol; initial_co2];
[tspan,y] = ode23(@(t,y) solver(t,y,total_in,glucose_in,volume), tspan, initials);

figure(1)
plot(tspan,y(:,1),tspan,y(:,2),tspan,y(:,3))
title('Concentrations from Ethanol Fermentation');
xlabel('Hours');
ylabel('Solution');
legend('Glucose','Biomass','Ethanol')

figure(2)
t_max = 20;
plot(tspan(1:t_max),y(1:t_max,4))
title('Concentrations from Ethanol Fermentation');
xlabel('Hours');
ylabel('Solution');
legend('Carbondioxide')

