clear all;
close all;

load uncoded_Key_Component_5
load uncoded_Key_Component_10
load uncoded_Key_Component_15


figure, plot(components,Key_Components_5,'k-o', components,Key_Components_10,'k-^',components,Key_Components_15,'k-d');

grid on, xlabel('Threshold (Out of 30)'), ylabel('Key Recovery Probability');

legend('E_b/N_0 = 5','E_b/N_0 = 10','E_b/N_0 = 15','Location','best')