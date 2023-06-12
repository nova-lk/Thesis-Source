clear all;
close all;
fun = @(p)p(1);

theta = pi/6;
kappa = 1;
beta=(10^(-84.5/10))/1000;
gamma=4;
d0=1;
R=1000;
N=100; %total nodes
t=60; %threshold

lambda = N/(pi*R^2);

A = [];
b = [];
Aeq = [];
beq = [];
lb = [0];
ub = [];
nonlcon = @sense_fn;
p0 = [1];
p = fmincon(fun,p0,A,b,Aeq,beq,lb,ub,nonlcon)