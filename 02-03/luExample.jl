## LU decomposition example

using LinearAlgebra

# example with no zeros on the diagonal (therefor no 'pivoting')
A = [2 1 -1
    -3 -1 2
    -2 1 2.0]
b = [8; -11; -3.0]
n = size(A,1)

# initalize L with ones on the diagonal
L = diagm( 0 => ones(n))

# step 0
A0 = copy(A)

# step 1:
col = 1
L[2,1] = A0[2,1]/A0[1,1]
L[3,1] = A0[3,1]/A0[1,1]

A1 = copy(A0)
A1[2,:] = A1[2,:] - L[2,1]*A1[1,:]
A1[3,:] = A1[3,:] - L[3,1]*A1[1,:]

# Step 2:
col = 2
L[3,2] = A1[3,2]/A1[2,2]

A2 = copy(A1)
A2[3,:] = A2[3,:] - L[3,2]*A1[2,:]

U = copy(A2)

## Check against the built-in LU:
F = lu(A, NoPivot())

F.L - L |> norm
F.U - U |> norm

## Solve Ax=b
# let L U x = b, let y = Ux, then we have
# L y = b, and we can forward solve for y:
y = zeros(n)
for i in 1:n
    y[i] = b[i] - L[i,1:i]'*y[1:i]
end

# now back solve the upper triangular matrix Ux
x = zeros(n)
for i in n:-1:1
    x[i] = ( y[i] - U[i,(i+1):n]'*x[(i+1):n] )/U[i,i]
end
x

