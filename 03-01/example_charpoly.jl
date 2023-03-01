using Pkg
Pkg.activate(".")
using LinearAlgebra, Polynomials

include("LaBudde.jl")
using .LaBudde

# Let's make a polynomial, and then hide it inside A
a = [1, 2, 3.]

A_original = diagm(1=>ones(2))
A_original[end,:] = -a
A_original

# Now let's hide this with a similarity transform

Q = [1 -3 1;
     0  1 1;
     -1 2 2]
A = Q\A_original*Q

# make up a B:
B = [ 1, 1, 1.]

# Now let's build the Controllability Matrix of (A,B)
CM_x = [B A*B A^2*B]
det(CM_x)

# Now we need to get back the values of a.
# option 1: eigenvalues
v = eigvals(A)
p = fromroots(v)
a_1 = coeffs(p)[1:end-1]

# option 2: La Budde's Method
# Rehman and Ipsen's paper: https://doi.org/10.48550/arXiv.1104.3769
p = fastCharPoly(A)
a_2 = p[1:end-1]

# Now build Ā and B̄
Ā = diagm(1=>ones(2))
Ā[end,:] = -a_2
B̄ = zeros(3)
B̄[end] = 1

# Now let's build the CM of (Ā,B̄)
CM_z = [B̄ Ā*B̄ Ā^2*B̄]

# So we have the transformation P:
P = CM_x*inv(CM_z)

# Now we can show P is correct since we can recover A_original
P\A*P
norm( P\A*P - A_original )

# Now we can design a controller, and then transform K back to which ever states
# we need to know the problem in.
