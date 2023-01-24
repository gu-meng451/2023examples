## ODE Example
using Pkg
Pkg.activate(".")
using DifferentialEquations, Plots

## Setup the parameters of the system
p  = [10.0,28.0,8/3]
u0 = [1.0, 0.0, 0.0]

## Setup the differential equation, I'll use the 'in-place' version
function lorenz!(du, u, p, t)
    # unpack states
    x, y, z = u
    # unpack parameters
    σ, ρ, β = p

    # make an in-place change to du.  Do no write du = [1,2,3] as that will not work.
    du[1] = dx = σ * (y - x)
    du[2] = dy = x * (ρ - z) - y
    du[3] = dz = x * y - β * z
end

## setup the ODE problem
tspan = (0.0, 100.0)
prob = ODEProblem(lorenz!, u0, tspan, p)
sol = solve(prob)

## Let's make some plots
plot(sol)

plot(sol, idxs=(1,2,3), xlabel="x", ylabel="y", zlabel="z")