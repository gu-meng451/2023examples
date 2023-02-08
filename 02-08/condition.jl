using LinearAlgebra

A = [ 4.1 2.8; 9.7 6.6]

# Let's make b1 (first rhs) the first colum of A
b = A[:,1]

x = A\b
# this gave us what we expect: [1, 0]

## Let's make a small change to b
δb = [0.01; 0]
b1 = b + δb

x1 = A\b1

# we can see that this small change in b, makes a large change in x

# computing the condition number, gives something large
κ = cond(A)

# let's compare the relative change in b to the relative change in x
κ*norm(b - b1)/norm(b)
# a number greater than 1 indicates a change in all the significant digits in x

# the actual change in x:
norm(x - x1)/norm(x)

# we see that the condition number overestimated the change 
# since not all operations are worst-case in terms of rounding.
# However, we do not have a better estimate.

# In terms of how many digits are known in the solution that would be approx.
15 - log10(κ)
# since we known around 15 digits for Float64 numbers.
