% Clear variables
clear all

% Add APM libraries to path for session
addpath('apm');

% Integrate model and return solution
y = apm_solve('hs71');
z = y.x;

disp(['x1: ' num2str(z.x1)])
disp(['x2: ' num2str(z.x2)])
disp(['x3: ' num2str(z.x3)])
disp(['x4: ' num2str(z.x4)])
