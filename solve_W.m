%% SMVSC
function [normW,p1,p2]= solve_W(F1,F2,lambda,p1,p2)
TW1       =  F1*F1';
TW2       =  F2*F2';
TW        = (p1*TW1+p2*TW2);

lambda = lambda/(2);
W = max(TW - lambda,0) + min(TW + lambda,0);
normW=(W+W')/2;
%% update the weights µ1 and µ2
p1=norm(normW - TW1, 'fro');
p2=norm(normW - TW2, 'fro');
P_temp=p1+p2;
p1 =  p1/P_temp;
p2 =  p2/P_temp;
end