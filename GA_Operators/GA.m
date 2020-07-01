% Genetic Algorithm V 1.0

clear
clc
%% Controlling Parameters
M = 100; % Number of Chromosomes (Candidate Solutions)
N = 10; % Number of Genes (Variables or features)
MaxGen = 10;   % Maximum number of generations
Pc = 0.85;   % Probability of Cross Over or Crossover Fraction (Stochastic Parameter)
Pm = 0.01;   % Probability of Mutation or Mutation Fraction (Stochastic Parameter)
Er = 0.2;   % Elitism Ratio (Stochastic Parameter)

%% Initialization
[population] = initialization(M, N);

% Calculating fitness values of the chromosomes of the initial population
for i = 1 : M
    population.Chromosomes(i).fitness = Sphere(population.Chromosomes(i).Gene(:));  % Sphere is the Custom Fitness Function
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
        newPopulation.Chromosomes(i).fitness = Sphere(newPopulation.Chromosomes(i).Gene(:));    % Sphere is the Custom Fitness Function
    end

    % Elitism
    [ newPopulation ] = elitism(population, newPopulation, Er);
    
    population = newPopulation;
    
end