% main function for GA
function [GAXSol,GAfval] = GAObjMain(v, No_of_Edges, CV, D, MILPXSol, VCoverMILPfval)
    % CV = [3;5;6;9];
    % D = [ 1 2 7 5 2 ; 1 3 3 2 2 ; 1 4 4 1 1 ; 2 3 3 2 1 ; 3 4 2 2 1 ];
    fitness = @(x)GAObjective(x, v, No_of_Edges, CV, D);
    %nvars = v + 2 * No_of_Edges;
    nvars = v;
    lb = zeros(1,nvars);
    ub = ones(1,nvars);
    IntCon = [1:nvars];
    ConsFcn = @(x)GAObjConstraints(x, v, No_of_Edges, D);
    rng(2,'twister');
    
    %fminconOptions = optimoptions(@fmincon);
    %opts = optimoptions(@ga);
    %options = optimoptions(opts,'HybridFcn',{@fmincon, fminconOptions});
    options = optimoptions('ga');
    %options = optimoptions('patternsearch');
%     options = optimoptions('gamultiobj');
%     options = optimoptions('gamultiobj',...
%     'CreationFcn',@popFun,...
%     'CrossoverFcn',@crossoverBinary,...
%     'MutationFcn',@mutFun);
    if nvars <= 5
        PopSize = 50;
    elseif nvars < 100
        PopSize = 200;
    elseif nvars >= 100 && nvars < 200
        PopSize = 400;
    elseif nvars >= 200 && nvars < 300
        PopSize = 600;
    else
        PopSize = ceil(2 * nvars);    
    end
    %options.PopulationSize = 500;
    %op = optimoptions(options,'MutationFcn',@mutationadaptfeasible);
    %options.InitialPopulationRange = [0; VCoverMILPfval-100];
    %options.UseVectorized = true;
    %if round(GAfval,3) > round(VCoverMILPfval,3)
    %x0 = ones(1, nvars);
    %x0 = repmat(x0, options.PopulationSize, 1);
    %options.InitialPopulation = randi(1E+4,options.PopulationSize,nvars)*1E-3;
    [GAXSol,GAfval] = ga(fitness, nvars, [], [], [], [], lb, ub, [], IntCon);
    %if round(GAfval,2) > round(VCoverMILPfval,2) 
        %options.InitialPopulation = randi([0,1],(options.PopulationSize - 1),nvars);
        %options.InitialPopulation = [options.InitialPopulation; round(MILPXSol.pi')];
        %[GAXSol,GAfval] = ga(fitness, nvars, [], [], [], [], lb, ub, ConsFcn, IntCon, options);
        %[GAXSol,GAfval] = ga(fitness, nvars, [], [], [], [], lb, ub, [], IntCon, options);
        %options.ScaleMesh = 'off';
        %options.TolMesh = 0.9;
        %[GAXSol,GAfval] = patternsearch(fitness, zeros(1,nvars), [], [], [], [], lb, ub, ConsFcn, options);
        %[GAXSol,GAfval] = gamultiobj(fitness, nvars, [], [], [], [], lb, ub, [], options);
    %end
end