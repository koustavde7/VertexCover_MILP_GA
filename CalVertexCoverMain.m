% prompt1 = 'Enter Number of Vertices : ';
% v = input(prompt1);
% prompt2 = 'Enter Number of Edges : ';
% e = input(prompt2);
for i = 26 : 28
    T = readtable('Data_to_Calculate.xlsx');
    S = T.Variables;
    v = S(i,1);
    e = S(i,2);
    if v > 0
        [G, No_of_Edges, possible] = CreateGraph(v,e);
        if possible == true
            D = CreateDMatrix(G, No_of_Edges);
            rng(3,'twister');
            [CV, Gain_Mat] = CalVrtxCost(v, D, No_of_Edges);
            %First calculating Vertex Cover using MILP Technique and estimating
            %execution Time
            tMILPStart = tic;
            [MILPXSol,VCoverMILPfval] = MILPVCover(v, No_of_Edges, CV, D);
            MILPExecTime = toc(tMILPStart);

            %Next calculating Vertex Cover using GA and estimating execution time
            tGAStart = tic;
            [GAXSol,GAfval] = GAObjMain(v, No_of_Edges, CV, D, MILPXSol, VCoverMILPfval);
            GAExecTime = toc(tGAStart);

            %Write Data to file
            Vertices = v;
            Edges = e;
            MILPExeTime = round(MILPExecTime,3);
            GAExeTime = round(GAExecTime,3);
            MILPfuncval = round(VCoverMILPfval,2);
            GAfuncval = round(GAfval,2);
            if MILPfuncval == GAfuncval
                Solution = 'Optimal';
            else
                Solution = GAfuncval;
            end
            T = table(Vertices,Edges,MILPExeTime,MILPfuncval,GAExeTime,GAfuncval,Solution);
            filename = ['GVCP' num2str(v) '-' num2str(e) '.xlsx'];
            DeleteFile(filename);
            writetable(T,filename);
        end
    end
end