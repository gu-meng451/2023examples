##
using Pkg; Pkg.activate(".")
using LinearAlgebra
using Printf
using Plots

nx = 5
ny = nx

T_south = 0
T_east  = 50
T_north = 100
T_west  = 75

# initial guess
T0 = zeros(nx,ny)

## Apply BC
T0[:,1]   .= T_south
T0[end,:] .= T_east
T0[:,end] .= T_north
T0[1,:]   .= T_west

##
tol = 1e-6
maxIter = 5000

## Jacobi
include("jacobi.jl")
T, iter_ja = jacobi(nx,ny,tol, maxIter, T0, verbose=true)

## Gauss-Seidel
include("gs.jl")
T, iter_gs = gaussSeidel(nx,ny,tol, maxIter, T0, verbose=true)

## Plot
x = LinRange(0,1,nx)
y = LinRange(0,1,ny)

contour(x,y,transpose(T),
    fill=true,
    aspect_ratio=:equal,
    levels=20,
    xlabel="x", ylabel="y")

## Add points of the mesh
X = [xi for xi in x, j in 1:ny]
Y = [yj for i in 1:nx, yj in y ]
scatter!(X,Y,label="", color=1)

