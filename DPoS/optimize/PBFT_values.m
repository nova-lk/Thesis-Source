k1 = 1;
d0 = 1;
beta = 3.548e-12; %-84.5 dBm
gamma = 4;
alpha = 10;
R = 1000;
lambda = 1/(1000*pi);



k = d0^2*(k1/beta)^(2/gamma);
omega = sqrt(k);

p1_max = (R/omega)^(2/gamma);

p2_max = alpha * p1_max;

p2 = k*p2^(1/2)*asin(sqrt(k*p2^(1/2)-(k*p2)/(4*p1^(1/2)))/(omega*p2^(1/4)))+k*p1^(1/2)*asin(sqrt(k*p2^(1/2)-(k*p2)/(4*p1^(1/2)))/(omega*p1^(1/4)))-sqrt(k*p2^(1/2)-(k*p2)/(4*p1^(1/2)))*((omega*p2^(1/2))/(2*p1^(1/4))+sqrt(k*p1^(1/2)-k*p2^(1/2)+(k*p2)/(4*p1^(1/2))));


c1 = lambda*pi*k;