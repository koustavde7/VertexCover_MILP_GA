function [MILPXsol,VCoverMILPfval] = MILPVCover(v, No_of_Edges, CV, D)
    % CV = [1;2;3;4];
    % D = [ 1 2 5 3 2; 1 3 4 4 3;1 4 5 2 2;2 3 3 2 1;3 4 2 2 2];
    % CV = [3;5;6;9];
    % D = [ 1 2 7 5 2 ; 1 3 3 2 2 ; 1 4 4 1 1 ; 2 3 3 2 1 ; 3 4 2 2 1 ];
    costCover = optimproblem;
    pi = optimvar('pi',v,'Type','integer','LowerBound',0,'UpperBound',1);
    qij = optimvar('qij',No_of_Edges,'Type','integer','LowerBound',0,'UpperBound',1);
    rij = optimvar('rij',No_of_Edges,'Type','integer','LowerBound',0,'UpperBound',1);
    vertexCost = CV * pi;

    x1 = pi(D(:,1),1);
    x2 = pi(D(:,2),1);

    edgeCost = sum(D(:,5) .* rij) + sum(D(:,4) .* (qij - rij)) + sum(D(:,3) .* (1 - qij));
    cost = vertexCost + edgeCost;
    costCover.Objective = cost;

    costCover.Constraints.consqij_1 = 2 * qij - x1 - x2 <= 1;
    costCover.Constraints.consqij_2 = 2 * qij - x1 - x2 >= 0;
    costCover.Constraints.consrij_1 = x1 + x2 - 2 * rij <= 1;
    costCover.Constraints.consrij_2 = x1 + x2 - 2 * rij >= 0;
    [MILPXsol,VCoverMILPfval] = solve(costCover);
end