%% Ethanol Fermentation Model

% ------- USER DEFINED PARAMETERS --------
total_in = 10; % liter per hour
glucose_in = 1; % gram per (liter and hour)
volume = 100; % liter 
initial_glucose = 50; % gram per liter
initial_biomass = 1; % gram per liter
% ---------------------------------------

initial_ethanol = 0;
initial_co2 = 0;

% Solve differential equations, for 3 training phases
% Phase one
% Base line parameters, high initial glucose
tspan_1 = 0:0.1:200; 
initials_1 = [initial_glucose; initial_biomass; initial_ethanol; initial_co2];
[tspan_1,y_1] = ode23(@(t,y) solver(t,y,total_in,glucose_in,volume), tspan_1, initials_1);

% Phase 2
tspan_2 = 200:0.1:400;
initials_2 = y_1(end,:);
total_in_new = 20; % changing flow rate
[tspan_2,y_2] = ode23(@(t,y) solver(t,y,total_in_new,glucose_in,volume), tspan_2, initials_2);

% Phase 3
tspan_3 = 400:0.1:600;
initials_3 = y_2(end,:);
glucose_in_new = 10; % changing glucose flow
[tspan_3,y_3] = ode23(@(t,y) solver(t,y,total_in,glucose_in_new,volume), tspan_3, initials_3);

% Merge phases
tspan = [tspan_1; tspan_2; tspan_3];
y = [y_1; y_2; y_3];

% Save data to file
csvwrite('output/train.csv', [tspan, y]);

figure(1)
plot(tspan,y(:,1),tspan,y(:,2),tspan,y(:,3))
title('Train: Concentrations from Ethanol Fermentation');
xlabel('Hours');
ylabel('Solution');
legend('Glucose','Biomass','Ethanol')

% Generate data for testing phase, change many parameters
tspan_test = 0:0.1:200;
initial_biomass_test = 10;
initial_glucose_test = 20;
total_in_test = 5;
glucose_in_test = 5;
initials_test = [initial_glucose_test; initial_biomass_test; initial_ethanol; initial_co2];
[tspan_test,y_test] = ode23(@(t,y) solver(t,y,total_in_test,glucose_in_test,volume), tspan_test, initials_test);

% Save data to file
csvwrite('output/test.csv', [tspan_test, y_test]);

figure(2)
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

