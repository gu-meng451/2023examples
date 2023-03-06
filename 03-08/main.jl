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

plot(f, -1, 7)
plot!(L, -1, 7)
plot!(S, -1, 7)
scatter!(X,Y, marker=3)