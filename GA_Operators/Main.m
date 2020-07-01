% main 

clear
clc

%% Controlling Parameters

Problem.obj = @Sphere;
Problem.nVar = 50;

M = 100; % Number of Chromosomes (Candidate Solutions)
N = Problem.nVar; % Number of Genes (Variables or features)
MaxGen = 10;   % Maximum number of generations
Pc = 0.85;   % Probability of Cross Over or Crossover Fraction (Stochastic Parameter)
Pm = 0.01;   % Probability of Mutation or Mutation Fraction (Stochastic Parameter)
Er = 0.2;   % Elitism Ratio (Stochastic Parameter)

[BestChromosome] = GeneticAlgorithm(M, N, MaxGen, Pc, Pm, Er, Problem.obj)