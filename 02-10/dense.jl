## Built-in dense linear algebra
using LinearAlgebra

## example matrices
A = [2 1 -1
    -3 -1 2
    -2 1 2.0]
b = [8; -11; -3.0]

## working with arrays
# if we want to slice into an array and get a row
A[2,:]
# or a column
A[:,3]
# or the upper right 2x2
A[2:3, 1:2]

# if we want to build an array of parts of other arrays we can
# use vcat and hcat to vertically or horizontally concatenate matrices
# to get B = [ A;
#              A ]
B = vcat( A, A)
# To get B = [A A]
B = hcat( A, A)

## Basics
# norms
norm(b)
norm(b,1)
norm(b,Inf)

norm(A)
norm(A,1)
norm(A,Inf)

# trace
tr(A)

# determinant
det(A)

# Transpose
transpose(A)
A'
A' |> collect

# Eigenvalues
eigvals(A)

F = eigen(A)
v = F.vectors[:,1]
λ = F.values[1]
(A - λ*I)*v

# Solving a linear system
A\b

# LU decomposition
F = lu(A)
