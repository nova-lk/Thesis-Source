function [con_1, con_2]=tx_pw(p)
K=1;
d_0=1;
gamma=4;
beta_1=(10^(-84.5/10))/1000;
k=((d_0)^2)*(K/beta_1)^(2/gamma);
w=sqrt(k);
f=10;
lambda=(1/(pi*1000));

y_p1_p2=sqrt(k*(p(2))^(2/gamma)-((k*(p(2))^(4/gamma))/(4*(p(1))^(2/gamma))));

con_1=-(lambda*pi*k*(p(1)^(2/gamma)))+3*f+1;
con_2=-(k*((p(2))^(2/gamma))*(asin(y_p1_p2/(w*((p(2))^(1/gamma)))))+k*((p(1))^(2/gamma))*(asin(y_p1_p2/(w*((p(1))^(1/gamma)))))-(y_p1_p2*(((w*((p(2))^(2/gamma))/(2*((p(1))^(1/gamma))) ))+sqrt((k*(p(1))^(2/gamma)-k*(p(2))^(2/gamma)+((k*(p(2))^(4/gamma))/(4*(p(1))^(2/gamma))))))))-1+2*f;
% con_2=-(k*((p(2))^(2/gamma))*(asin(y_p1_p2/(w*((p(2))^(1/gamma)))))+k*((p(1))^(2/gamma))*(asin(y_p1_p2/(w*((p(1))^(1/gamma)))))-(y_p1_p2*((w*((p(2))^(2/gamma))/(2*((p(1))^(1/gamma))) ))+sqrt((k*(p(1))^(2/gamma)-k*(p(2))^(2/gamma)+((k*(p(2))^(4/gamma))/(4*(p(1))^(2/gamma)))))))-1+2*f;
