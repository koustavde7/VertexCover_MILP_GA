function [CV, Gain_Mat] = CalVrtxCost(v, D, No_of_Edges)
    CV = zeros(1,v);
    S = zeros(1,v);
    Gain_Mat = zeros(v, 100);
    for i = 1 : v
        avg_gain = 0;
        for j = 1 : 100
            S(1,:) = randi([0, 1],1,v);
            gain = Calculate_gain_of_d(i, No_of_Edges, S, D);
            avg_gain = avg_gain + gain;
            Gain_Mat(i,j) = gain;
        end
        avg_gain = avg_gain / 100;
        CV(i) = avg_gain;
    end
end