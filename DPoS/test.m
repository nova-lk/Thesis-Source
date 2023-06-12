clear all;
close all;

x = 0:1:1000;
y = 2*x.^2 + x;
g=2*x;

plot(x,y,x,g), legend ('BPFT', 'PoW')
set(gca, 'YScale', 'log')