close all;
clear all;

%load data for reference paper
prev_paper = readtable('tx power PBFT.xlsx','Range','B1:C51');
prev_paper = table2array(prev_paper);
prev_paper = transpose(prev_paper);
p1_old = prev_paper(1,:);
p2_old = prev_paper(2,:);

theta = pi/6;
kappa = 1;
beta = 3.548e-12; %-84.5 dBm
gamma = 4;
d0 = 1;
R = 1000;


N=100; %total nodes
t=60; %threshold

lambda = N/(pi*R^2);

c1 = pi*d0^2*lambda*(kappa/beta)^(2/gamma);

c2 = N - t;

c3 = t*lambda/2*d0^2*(kappa/beta)^(2/gamma)*(theta-sin(theta)+2*sin(theta/2)^2*cot(pi/t));

for f = 1:50
p1 = ((2*f+1)/c1)^2;
p2 = sqrt(p1)*(c3);
if p2<p1
    disp('P1 is greater than P2');
    return
end
power(f+0) = p1;
end


f = 1:50;

% plot(n,y1,'k--',n,y2,'k -x',n,y3,'k -+',n,y4,'k-o'), legend ('BPFT', 'PoW', 'Raft', 'Ours')
figure, plot(f,power,'k-o', f, str2double(p1_old),'r-d', f, str2double(p2_old), 'b-s');
legend('DPoS', 'Header Power, PBFT', 'Follower Power, PBFT')
set(gca, 'YScale', 'log')
grid on, xlabel('Number of Faulty Nodes'), ylabel('Transmission Power (W)');

