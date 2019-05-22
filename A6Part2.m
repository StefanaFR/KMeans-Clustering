% Stefana Rusu - Assignment 6 - part 2
tic

load fisheriris
[idx,C] = kmeans(meas, 3, 'MaxIter', 100);

C
toc