using Pkg;
Pkg.activate(".");
using Plots

include("../03-06/Spine.jl")
include("LagrangeInterp.jl")

X = [-1, 2, 3, 4, 7]
f(x) = sin(x)
Y = f.(X)

L = LagrangeInterp.interp(X,Y)
L(0.1)
S = Spline.spinterp(X,Y)
S(0.1)

scatter(X,Y, marker=3, label="control points", 
    xlabel="x", ylabel="y(x)")
plot!(L, -1, 7, label="Lagrange")
plot!(S, -1, 7, label="Spline")
plot!(f, -1, 7, label="Original function")