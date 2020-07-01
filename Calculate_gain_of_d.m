function gain = Calculate_gain_of_d(i, No_of_Edges, S, D)
    gain = 0;
    if S(i) == 0
       qij = zeros(No_of_Edges, 1);
       rij = zeros(No_of_Edges, 1);
       qij(:,1) = S(D(:,1)) | S(D(:,2));
       rij(:,1) = S(D(:,1)) & S(D(:,2));
       Old_Cost = sum(D(:,5) .* rij(:,1)) + sum(D(:,4) .* (qij - rij)) + sum(D(:,3) .* (1 - qij));
       
       %Now calculating New Cost
       S(i) = 1;
       qij(:,1) = S(D(:,1)) | S(D(:,2));
       rij(:,1) = S(D(:,1)) & S(D(:,2));
       New_Cost = sum(D(:,5) .* rij(:,1)) + sum(D(:,4) .* (qij - rij)) + sum(D(:,3) .* (1 - qij));
       gain = abs(New_Cost - Old_Cost);
    end
end