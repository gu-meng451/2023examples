using Pkg; Pkg.activate(".")
# using Pkg.instantiate()
using LinearAlgebra
using Polynomials
# using DifferentialEquations

# usefule tips:
# q = fromroots([-1,-2,-3])
# coeffs(q)

A = diagm(1=>ones(3))
A[4,:] = [-4, -2, -13, -6]
A

B = [0;0;0;1]
C = [40 10 0 0]

ζ = 0.1
ωₙ = 4

##
sx1 = -ζ*ωₙ + 1im*ωₙ*sqrt(1-ζ^2)
sx2 = -ζ*ωₙ - 1im*ωₙ*sqrt(1-ζ^2)
sx3 = -5*ζ*ωₙ
sx4 = -6*ζ*ωₙ

q = fromroots([sx1,sx2,sx3,sx4])
d = coeffs(q)

a = [4, 2, 13, 6.]

K = (d[1:end-1] - a)'

## Checks:
A - B*K
eigvals(A-B*K)
