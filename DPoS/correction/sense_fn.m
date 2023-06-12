function [con_1, con_2]=sense_fn(p)
theta = pi/6;
kappa = 1;
beta=(10^(-84.5/10))/1000;
gamma=4;
d0=1;
R=1000;
N=100; 
t=50;
lambda = N/(pi*R^2);
f = 30;

con_1 = -(pi*d0^2*lambda*(kappa*p(1)/beta)^(2/gamma)) + 2*f+1;
con_2 =-(t*lambda/2*d0^2*(kappa*p(1)/beta)^(2/gamma)*(theta-sin(theta)+2*(sin(theta/2))^2*cot(pi/t)))+1;
% con_2=-(k*((p(2))^(2/gamma))*(asin(y_p1_p2/(w*((p(2))^(1/gamma)))))+k*((p(1))^(2/gamma))*(asin(y_p1_p2/(w*((p(1))^(1/gamma)))))-(y_p1_p2*((w*((p(2))^(2/gamma))/(2*((p(1))^(1/gamma))) ))+sqrt((k*(p(1))^(2/gamma)-k*(p(2))^(2/gamma)+((k*(p(2))^(4/gamma))/(4*(p(1))^(2/gamma)))))))-1+2*f;
