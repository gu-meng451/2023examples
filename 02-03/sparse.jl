#' ---
#' title : Sparse Array Example
#' author : T Fitzgerald
#' date : Feb 2023
#' ---

#' # Introduction

#' This is an example of making a script and then using Weave.jl 
#' to publish it.  First we'll load the packages for this problem.

using Pkg
Pkg.activate(".")
using SparseArrays
using LinearAlgebra
using Plots
using JLD2

#' # Small Example

vals = [1.0, 2.0, 3.0, 4.0, 5.0, 0.0]
idx_i = [1, 2, 4, 6, 7, 7]
idx_j = [1, 2, 4, 6, 1, 7]

A = sparse(idx_i, idx_j, vals)

spy(A, markersize=10)

#' # A large FEM example 

#' load up an FEM example stiffness matrix from an hdf5 file
jldopen("sparsedemo.h5", "r") do f
    i = f["/i"]
    j = f["/j"]
    v = f["/v"]
    global K = sparse(i, j, v)
end

spy(K)

#' ## Reordering is a thing
using AMD
#' Extract the free-free part of the stiffness matrix:
n = 1500
k1 = K[1:n, 1:n]
#' pick a reording: amd, symamd, colamd
p = amd(k1)
k2 = k1[p, p]
spy(k2)

#' Let's look at the 'in-fill' of the LU factorization
F = lu(Matrix(k2))
spy(F.L)
spy!(F.U)