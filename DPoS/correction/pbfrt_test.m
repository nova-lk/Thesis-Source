clear all;
close all;
fun = @(p)p(1)+p(2);
K=1;
d_0=1;
gamma=4;
beta_1=(10^(-84.5/10))/1000;
k=((d_0)^2)*(K/beta_1)^(2/gamma);
alpha=10;
w=sqrt(k);
R=1000;
P1_max=(R/w)^gamma;
P2_max=alpha*P1_max;

A = [];
b = [];
Aeq = [];
beq = [];
lb = [0,0];
ub = [P1_max,P2_max];
nonlcon = @tx_pw;
p0 = [4, 9];
p = fmincon(fun,p0,A,b,Aeq,beq,lb,ub,nonlcon)
