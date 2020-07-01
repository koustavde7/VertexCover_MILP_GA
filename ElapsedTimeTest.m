tstartB = tic;
B = readmatrix('test.xlsx');
elapsedTime2 = toc(tstartB);
tstartA = tic;
A = magic(10);
elapsedTime1 = toc(tstartA);