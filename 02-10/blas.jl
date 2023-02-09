## BLAS Example
# [BLAS article](https://en.wikipedia.org/wiki/Basic_Linear_Algebra_Subprograms)
# [Julia Documentation](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#BLAS-functions)
# [Netlib](https://netlib.org/blas/)

## Loading the library
using LinearAlgebra
# I'll use blas as the local name for directly accessing the BLAS library
blas = LinearAlgebra.BLAS

# Let's make up some examples
A = [2 1 -1
    -3 -1 2
    -2 1 2.0]

B = [0 1 -7
    -1 1 2
    -1 1 2.0]

x = [8; -11; -3.0]
y = [1; 7; 2.0]

## Level 1: Vector operations
d = blas.dot(3, x, 1, y, 1)
d = blas.nrm2(x)

## Level 2: Matrix-Vector operations
# y <- alpha Ax + beta y
z = copy(y)
blas.gemv!('N', 1.0, A, x, 2.0, z)

## Level 3: Matrix-Matrix operations
# C <- alpha AB + beta C
C = similar(A)
C .= 1.0
blas.gemm!('N', 'N', 1.0, A, B, 2.0, C)

## LAPACK
# Note that the BLAS does not have routines for solving systems of equations
# or computing eigenvalues.  To get those, other standard packages have been
# developed. For *dense* matrices the standard library is LAPACK.
lapack = LinearAlgebra.LAPACK

# since this is in-place and overwrites A and x, I'll make copies before
# computing A\x
A1 = copy(A)
x1 = copy(x)
lapack.gesv!(A1,x1)
# now A1 is factored with LU, and x1 is the solution to A\x.