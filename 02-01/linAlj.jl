using LinearAlgebra

A = [2 1 -1
    -3 -1 2
    -2 1 2.0]
b = [8; -11; -3.0]

## Augment the system [A b I]
B = hcat(A, b, I)

## Gaussian Elimination
B[3, :] = B[3, :] + B[1, :]
B[2, :] = B[2, :] + 3 / 2 * B[1, :]
B[3, :] = B[3, :] - 4 * B[2, :]
B[3, :] = -B[3, :]
B[2, :] = B[2, :] - 0.5 * B[3, :]
B[1, :] = B[1, :] + B[3, :]
B[2, :] = B[2, :] * 2
B[1, :] = B[1, :] - B[2, :]
B[1, :] = B[1, :] / 2

## extract the column that held b, it should be x
x = B[:,4]
Ainv = B[:,5:7]

## Let's check if it is a solution to Ax=b
norm( A*x - b )

## We can use the built-in solver to get x as well
x = A\b

## Let's check what's going on with Ainv
Ainv*A - I |> norm
A*Ainv - I |> norm

## We don't typically want Ainv, but should use the \ operator instead