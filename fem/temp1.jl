include("Quadrature.jl")

include("HeatTransfer2D.jl")
include("Shapefunctions.jl")

using .Shapefunctions

element_quad_rule = Quadrature.gauss_legendre_2d(2)

xe = [-1. 1. 1. -1.]
ye = [-1. -1. 1. 1.]
prop_K = 1.

ke = HeatTransfer2D.element_stiffness(xe, ye, shapefunc("quad"), 
    element_quad_rule, prop_K )

