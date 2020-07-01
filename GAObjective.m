function y = GAObjective(x, v, No_of_Edges, CV, D)
%     pi = x(1:v)';
%     qij = x(v+1:v+No_of_Edges)';
%     rij = x(v+No_of_Edges+1:v+2*No_of_Edges)';
    pi = x';
    qij = zeros(No_of_Edges,1);
    rij = zeros(No_of_Edges,1);
    qij(:,1) = pi(D(:,1),1) | pi(D(:,2),1);
    rij(:,1) = pi(D(:,1),1) & pi(D(:,2),1);
    vertexCost = sum(CV * pi);
    y = vertexCost + sum(D(:,5) .* rij(:,1))  + sum(D(:,4) .* (qij - rij)) + sum(D(:,3) .* (1 - qij));
end