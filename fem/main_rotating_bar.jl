## Rotating bar
#= 
Consider a uniform bar that is fixed to the wall at x = 0, and free 
at x= L.  It is rotating at speed $\Omega$ about its base at x = 0.
We want to find the displacement and stress along the bar.
=#

##
using Pkg
Pkg.activate(".")

include("Preprocess.jl")
include("Quadrature.jl")
include("Bar1D.jl")
include("SimpleVisualization.jl")
using GLMakie

quad_rules = Dict("line" => Quadrature.gauss_legendre_1d(2))

## Properties of the uniform body
prop = (E = 1.0, # Young's Modulus [F/m^2]
        A = 1.0, # cross-sectional area [L^2]
        L = 1.0, # length [L]
        ρ = 1.0, # mass density (per volume) [m/L^3]
        Ω = 1.0) # angular speed of rotation [rad/time]

## mesh connectivity
# IEN(e,a)
nnp = 4
nel = nnp - 1
nee = 2
IEN = Dict("line" => zeros(Int, nel, nee))
for e in 1:nel
    IEN["line"][e, :] = [e, e + 1]
end
x = LinRange(0, prop.L, nnp) |> collect

## Essential Boundary Conditions: [i,A]
BC_fix_list = zeros(Bool, 1, nnp)
BC_fix_list[1, 1] = true

# BC values
BC_g_list = zeros(1, nnp)
BC_g_list[1, 1] = 0.0

## Loading force
f(x) = prop.ρ * prop.A * prop.Ω^2 * x

## Build mesh
m = Preprocess.build_mesh(x, [], [], IEN, 1, BC_fix_list, BC_g_list)

## Assemble the global matrices
K = Bar1D.assemble_stiffness(m, prop)
F = Bar1D.assemble_rhs(m, f, quad_rules)

## Solve the system
q = zeros(m.nnp * m.ned)
q[m.free_range] = K[m.free_range, m.free_range] \ F[m.free_range]

## Plot the result
u_true(x) = prop.ρ * prop.Ω^2 / 6 / prop.E * (-x^3 + 3 * prop.L^2 * x)
fig, ax = SimpleVisualization.init_plot()
SimpleVisualization.draw_element(ax, m, q, linewidth = 3, linestyle = :dash, color = :red)
plot!(ax, LinRange(0, prop.L, 20), u_true)
fig

## Plot the stress
σ_true(x) = prop.A * prop.ρ * prop.Ω^2 / 6 * (-3 * x^2 + 3 * prop.L^2)
fig, ax = SimpleVisualization.init_plot(ylabel = "Stress")
SimpleVisualization.draw_element_stress(ax, m, q, prop)
plot!(ax, LinRange(0, prop.L, 20), σ_true)
fig