close all;
clear all;

theta = pi/6;
kappa = 1;
beta = 3.548e-12; %-84.5 dBm
gamma = 4;
d0 = 1;
R = 1000;


N=100; %total nodes
t=50; %threshold

lambda = N/(pi*R^2);

c1 = pi*d0^2*lambda*(kappa/beta)^(2/gamma); %LHS of equation 8 without P1

c2 = N - t; %f_max is 50 

c3 = t*lambda/2*d0^2*(kappa/beta)^(2/gamma)*(theta-sin(theta)+2*sin(theta/2)^2*cot(pi/t)); %LHS of equation 15 without P1

for f = 1:50
    
p1 = ((2*f+1)/c1)^(gamma/2);
p2 = p1^(2/gamma)*(c3);
if p2<1 %when eq 15 breaks --> raise error
    disp('Eq 15 not satisfied');
    return
end
power(f) = p1;
end


f = 1:50;

plot(f,power,'k-o');
set(gca, 'YScale', 'log')
grid on, xlabel('Number of Faulty Nodes'), ylabel('Transmission Power (W)');

