using Pkg
Pkg.activate(".")
using SparseArrays
using LinearAlgebra
using Plots
using JLD2

vals = [1.0, 2.0, 3.0, 4.0, 5.0, 0.0]
idx_i = [1, 2, 4, 6, 7, 7]
idx_j = [1, 2, 4, 6, 1, 7]

A = sparse(idx_i, idx_j, vals)

spy(A, markersize=10)

## load up an FEM example stiffness matrix
jldopen("sparsedemo.h5", "r") do f
    i = f["/i"]
    j = f["/j"]
    v = f["/v"]
    global K = sparse(i, j, v)
end

spy(K)

## Reordering is a thing
using AMD
# Extract the free-free part of the stiffness matrix:
n = 1500
k1 = K[1:n, 1:n]
# pick a reording: amd, symamd, colamd
p = amd(k1)
k2 = k1[p, p]
spy(k2)

# Let's look at the 'in-fill' of the LU factorization
F = lu(Matrix(k2))
spy(F.L)
spy!(F.U)