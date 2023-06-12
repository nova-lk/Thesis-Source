clear all

theta = pi/6;
k = 1;
beta = 3.548e-12; %-84.5 dBm
gamma = 4;
d0 = 1;
R = 1000;
lambda = 1/(10000*pi);

N=100; %total nodes
t=60; %threshold



c1 = pi*d0^2*lambda*(k/beta)^(2/gamma);

c2 = N - t;

c3 = t*lambda/2*d0^2*(k/beta)^(2/gamma)*(theta-sin(theta)+2*sin(theta/2)^2*cot(pi/t));