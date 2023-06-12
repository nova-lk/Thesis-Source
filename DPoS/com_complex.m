clear all;
close all;

n = 0:25:1000;
y1 = 2*n.^2 + n; % PBFT
y2=2*n; % PoW
y3=2*n; % Raft
y4=(n.^2) + n; % DPoS, t=N
y5=(n.^2)/2 + n; % DPoS, t=N/2
y6 = log2(n) + n; % Holochain

plot(n,y1,'r -^',n,y2,'b o',n,y3,'m --',n,y4,'k -d',n,y5,'k -s',n,y6,'r o'), legend ('PBFT', 'PoW', 'Raft', 'DPoS, t=N', 'DPoS, t=N/2', 'Holochain')
set(gca, 'YScale', 'log')
grid on, xlabel('Number of Nodes (N)'), ylabel('Communication Complexity');