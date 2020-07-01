function [BestChromosome] = GeneticAlgorithm(M, N, MaxGen, Pc, Pm, Er, obj)
    
%% Initialization
    [population] = initialization(M, N);

    % Calculating fitness values of the chromosomes of the initial population
    for i = 1 : M
        population.Chromosomes(i).fitness = obj(population.Chromosomes(i).Gene(:));  % obj is the Custom Fitness Function
    end

    %% Main Loop
    g = 1;
    disp(['Generation #', num2str(g)]);

    for g = 2 : MaxGen  % g is starting from 2 because we have already generated and initialized an instance of the population
        disp(['Generation #', num2str(g)]);

        for k = 1 : 2 : M

            % Selection
            [parent1, parent2] = selection(population);

            % Crossover
            [child1, child2] = crossover(parent1, parent2, Pc, 'single');

            % Mutation
            [child1] = mutation(child1, Pm);
            [child2] = mutation(child2, Pm);

            newPopulation.Chromosomes(k).Gene = child1.Gene;
            newPopulation.Chromosomes(k+1).Gene = child2.Gene;
        end

        % Calculating fitness values of the chromosomes of newPopulation after applying Selection, Crossover and Mutation opeartors
        for i = 1 : M
            newPopulation.Chromosomes(i).fitness = obj(newPopulation.Chromosomes(i).Gene(:));    % obj is the Custom Fitness Function
        end

        % Elitism
        [ newPopulation ] = elitism(population, newPopulation, Er);

        population = newPopulation;

    end
    
    [max_value, indx ] = sort([population.Chromosomes(:).fitness], 'descend');

    BestChromosome.Gene = population.Chromosomes(indx(1)).Gene;
    BestChromosome.Fitness = population.Chromosomes(indx(1)).fitness;
end