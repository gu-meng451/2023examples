using Pkg;
Pkg.activate(".");
using LinearAlgebra
using DifferentialEquations
using Plots

include("StateFeedback.jl")
sf = StateFeedback

A = [1 2 3
    0 1.0 4
    -1 -2.0 -10];
B = [1; -3; 6];
C = [1 0 -1]

sx = [-1, -2, -3]
K = sf.buildK(A, B, sx)

# check system:
r(t) = 0
u(x, t) = -K * x + r(t)
p = A, B, C, 0, u
function ss!(dx, x, p, t)
    A, B, C, D, u = p
    dx[:] = A * x + B * u(x, t)
end

ICx = [-1.0, 0.0, 5.0]
tspan = (0, 10.0)
prob = ODEProblem(ss!, ICx, tspan, p)
sol = solve(prob)
plot(sol)

sx_o = 10 * sx
L = sf.buildK(A', C', sx_o)'

p = A, B, C, 0, u, L
function sso!(dX, X, p, t)
    A, B, C, D, u, L = p
    n = length(B)

    x = X[1:n]
    x̂ = X[n+1:2n]

    # control action
    U = u(x̂, t)

    # observer
    y = dot(C,x) + D * U
    ŷ = dot(C,x̂) + D * U
    dX[n+1:2n] = A * x̂ + B * U + L * (y - ŷ)

    # true system
    dX[1:n] = A * x + B * U
end

ICo = [-1.0, 0.0, 5.0, 0, 0, 0]
prob = ODEProblem(sso!, ICo, tspan, p)
sol = solve(prob)
plot(sol)
