objective = @(p) p;
p0 = 1;

A = [];
B = [];
Aeq = [];
Beq = [];
lb = 0;
ub = [];
nonlicon =@nlcon;

p = fmincon(objective,p0,A,B,Aeq,Beq,lb,ub,nonlicon)

disp(p)