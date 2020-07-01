%% Constraint Function
function [c, ceq] = GAObjConstraints(x, v, No_of_Edges, D)
    pi = x(1:v)';
    qij = x(v+1:v+No_of_Edges)';
    rij = x(v+No_of_Edges+1:v+2*No_of_Edges)';
%     x1 = pi(D(:,1),1);
%     x2 = pi(D(:,2),1);
%     c = [2 * qij - x1 - x2 - 1; - 2 * qij + x1 + x2; x1 + x2 - 2 * rij - 1; - x1 - x2 + 2 * rij];
%     ceq = [];
%     qij = zeros(No_of_Edges,1);
%     rij = zeros(No_of_Edges,1);
%     qij(:,1) = pi(D(:,1),1) | pi(D(:,2),1);
%     rij(:,1) = pi(D(:,1),1) & pi(D(:,2),1);
    x1 = pi(D(:,1),1);
    x2 = pi(D(:,2),1);
    c = [2 * qij - x1 - x2 - 1; x1 + x2 - 2 * qij; x1 + x2 - 2 * rij - 1; 2 * rij - x1 - x2];
    ceq = [];
end