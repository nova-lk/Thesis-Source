clear all;
close all;

n = 0:25:1000;
y1 = 2*n + 1; % PBFT
pn = @(n) (2).*(n>=1);
y2=pn(n); % PoW
y3=n+1; % Raft
y4= n; % DPoS
y5=log2(n)+1; % Holochain

plot(n,y1,'r-^',n,y2,'b -o',n,y3,'m --',n,y4,'k d',n,y5,'r -d'), legend ('PBFT', 'PoW', 'Raft', 'DPoS', 'Holochain')
set(gca, 'YScale', 'log')
grid on, xlabel('Number of Nodes (N)'), ylabel('Spectrum Requirement');