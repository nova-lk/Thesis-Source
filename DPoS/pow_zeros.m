
x = [1:7];


y = [0.00134 0.01421 0.23439 4.19905 48.7342 860.574 20979.2];



plot(x,y)
set(gca, 'YScale', 'log')
grid on, xlabel('Number of Zeros'), ylabel('Time (s)');