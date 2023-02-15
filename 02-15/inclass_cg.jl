using LinearAlgebra
using Printf

include("cg.jl")

A = [2 -1 0.;
     -1 2 -10;
     0  -10 2];

b = [0; 1; 2];

x0 = [0;0;0]

x, iter = cg(A,b,x0, verbose=true)