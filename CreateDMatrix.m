function D = CreateDMatrix(G, No_of_Edges)
    No_V = size(G);
    No_E = No_of_Edges;
    x = 1;
    D = zeros(No_of_Edges, 5);
    
    %Allocating edges in D
    for i = 1 : No_V(1)
        for j = i+1 : No_V(1)
            if G(i,j) == 1
                D(x,1) = i;
                D(x,2) = j;
                x = x + 1;
            end
        end
    end
    
    %Now allocating d0(e)
    rng(0,'twister');
    r = (100 - 0) .* rand(1,No_E);
    r = r';
    D(:,3)  = D(:,3) + r;
    
    %Now allocating d2(e)
    r = (D(:,3)' - 0) .* rand(1,No_E);
    r = r';
    D(:,5)  = D(:,5) + r;
    
    %Now allocating d1(e)
    r = ((((D(:,3) + D(:,5)) / 2)' - D(:,5)') .* rand(1,No_E)) + D(:,5)';
    r = r';
    D(:,4) = D(:,4) + r;
end