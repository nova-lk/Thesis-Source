clear all;
close all;

% block size
b = 0.1;
% total nodes
N = 50;

% number of new blocks
n = 0:10:100;
% blockchain
y1 = b*N*n;
% holochain with 4 backup nodes
y2=4*b*n;
% holochain with 10 backup nodes
y3=10*b*n;

plot(n,y1,'k-^',n,y2,'b -o',n,y3,'r-d'), legend ('Blockchain', 'Holochain, r=4', 'Holochain, r=10')
% set(gca, 'YScale', 'log')
grid on, xlabel('Number of New Blocks'), ylabel('Increase in Total Storage (MB)');