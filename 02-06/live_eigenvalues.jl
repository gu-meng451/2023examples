using LinearAlgebra


A = [1 0 2;
     0 1 0;
     0 3 7.]

F = eigen(A)
F.values
F.vectors