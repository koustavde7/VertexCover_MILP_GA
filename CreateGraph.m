function [G, No_Of_Edges, possible] = CreateGraph(v,e)
    No_Of_Edges = e;
    possible = true;
    if v > 0
        G = zeros(v,v);
        max_possible_edges = v * (v - 1 ) / 2;
        if e <= max_possible_edges
            for i = 1 : v - 1
                if e > 0
                    G(i,i+1) = 1;
                    G(i+1,i) = 1;
                    e = e - 1;
                elseif e == 0
                    break
                end
            end
            if e > 0
                for i = 1 : v
                    for j = i+2 : v
                        if e > 0
                            G(i,j) = 1;
                            G(j,i) = 1;
                            e = e - 1;
                        elseif e == 0
                            break;
                        end
                    end
                    if e == 0
                        break;
                    end
                end
            end
        else
            fprintf('Graph with %d vertices along with %d Edges Not possible.\n',v,e);
            possible = false;
        end
    end
end