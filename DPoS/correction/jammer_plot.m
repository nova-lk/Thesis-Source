clear all;
close all;



R=100; %Radius of Transmitter
gamma = 2.5; %pothloss exponent
% beta_D = -6; %beta for downlink
% beta_U = -6; %beta for uplink
beta_D = 10^(-6/10); %beta for downlink
beta_U = 10^(-6/10); %beta for uplink

x0=0; %Tx x coordinate
y0=0; %Tx y coordinate 
x1=21.21; %Jammer x coordinate
y1=21.21; %Jammer y coordinate
% P_J=0.05; %Power of Jammer
% P_s=1; %Power of signal
sigma = 0; %Sigma for upload

x_U = x0; %center of upload circle (same as Tx)
y_U = y0; %center of upload circle (same as Tx)

x = 40;
y = 20;
P_s = 1;
dF = sqrt((x0-x)^2 + (y0-y)^2);
dJ = sqrt((x1-x)^2 + (y1-y)^2);
% dFJ = sqrt((x0-x1)^2 + (y0-y1)^2);
P_J = (dJ/dF)^(gamma) * (P_s/beta_D);



d_RJ = sqrt((x0-x1)^2+(y0-y1)^2); %distance from Jammer to Rx
%R_U = sqrt((P_s/(beta_U*(P_J/(d_RJ^gamma)+sigma^2)))^(2/gamma)); %Radius of Upload circle
R_U = sqrt((P_s/(beta_U*(((P_J)/(d_RJ^gamma))+(sigma^2))))^(2/gamma));
alpha_D = ((beta_D*P_J)^(2/gamma))/((P_s)^(2/gamma));

x_D = (alpha_D*x0 - x1)/(alpha_D-1);  %Jamming center x coordinate
y_D = (alpha_D*y0 - y1)/(alpha_D-1); %Jamming center y coordinate
%R_D = sqrt((alpha_D*(x0-x1)^2+alpha_D*(y0-y1)^2)/(alpha_D-1)); %Radius of Jamming circle
R_D = sqrt((alpha_D*(x0-x1)^2+alpha_D*(y0-y1)^2))/(alpha_D-1);

if R_D<0 % stop if R_D is negative
    return
end

%call circle function with x, y, radius, and color
hold on
txcircle(x0,y0,R,'r') %Tx coverage
txcircle(x_D,y_D,R_D,'g') %Jammer Circle
txcircle(x_U, y_U, R_U,'b') %Upload area

plot(0,0,'r*') %Mark Tx Node on the plot

legend('Tx Area','Jammer','Upload', 'Transmitter')


hold off




