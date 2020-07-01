function[parent1, parent2] = selection(population)

    M = length(population.Chromosomes); % M is the number of individuals
    
    % Fitness values can be negative because fitness function calculates fitness values based on gene values provided. In case of roulette wheel, -ve fitness values cause problems. So we have to scale fitness values if found -ve. 
    if any([ population.Chromosomes(:).fitness ] < 0)
        % Fitness scaling function : f_scaled = a * f + b where a  = 1 and b = minimum of the fitness values
        a = 1;
        b = min([ population.Chromosomes(:).fitness ]);
        b = abs(b);
        
        scaled_fitness = a .* [population.Chromosomes(:).fitness ] + b + 1;
        normalized_fitness = [ scaled_fitness ] ./ sum([scaled_fitness]); % if all fitness values are same and -5 and we add +5 to make all of them +ve, the sum is 0 and we may encounter divide by zero exception. To avoid this we can add 1 to the expression i.e. .... + b + 1
    else
        normalized_fitness = [population.Chromosomes(:).fitness] ./ sum([population.Chromosomes(:).fitness]);    % [] is used to return the result of the structure as a vector
    end
    
    [sorted_fitness_values, sorted_idx] = sort(normalized_fitness, 'descend');
    
    for i = 1 : M
        temp_population.Chromosomes(i).Gene = population.Chromosomes(sorted_idx(i)).Gene;
        temp_population.Chromosomes(i).fitness = population.Chromosomes(sorted_idx(i)).fitness;
        temp_population.Chromosomes(i).normalized_fitness = normalized_fitness(sorted_idx(i));
    end

    cumsum  = zeros(1, M);

    for i = 1 : M
        for j = i : M
            cumsum(i) = cumsum(i) + temp_population.Chromosomes(j).normalized_fitness;
        end
    end

    % Step 3 : to select two of the individuals as parents
    R = rand(); % in [0,1]
    parent1_idx = length(cumsum);
    for i = 1 : length(cumsum)
        if R > cumsum(i)
            parent1_idx = i - 1;
            break;
        end
    end
    
    parent2_idx = parent1_idx;
    
    while parent2_idx == parent1_idx % to skip the same parent 
        R = rand(); % in [0,1]
        for i = 1 : length(cumsum)
            if R > cumsum(i)
                parent2_idx = i - 1;
                break;
            end
        end
    end
    
    parent1 = temp_population.Chromosomes(parent1_idx);
    parent2 = temp_population.Chromosomes(parent2_idx);
end