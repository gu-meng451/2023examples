using SparseArrays
using Plots
using JLD2

vals = [1., 2., 3., 4., 5., 0.]
idx_i= [ 1, 2, 4, 6, 7, 7]
idx_j= [ 1, 2, 4, 6, 1, 7]

A = sparse(idx_i, idx_j, vals)

spy(A, markersize=10)


## load up an FEM example stiffness matrix
jldopen("sparsedemo.h5", "r") do f
    i = f["/i"]
    j = f["/j"]
    v = f["/v"]
    global K = sparse(i,j,v)
end

spy(K)
