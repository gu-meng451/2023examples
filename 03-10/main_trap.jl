# Simple Trap Rule
using Pkg; Pkg.activate(".")
using LinearAlgebra, Plots

## Integrand:
f(x) = sin(x)
a =  0.
b =  pi

I_true = -cos(b) + cos(a)

## Trap Rule for uniform spacing
function trap( f, a, b, n_points::Int)

    n_seg = n_points - 1
    x = LinRange(a,b,n_points)
    F = f.(x)
    h = (b-a)/n_seg

    I = 0.

    I += F[1]*h/2
    I += sum( F[2:n_points-1]*h )
    I += F[n_points]*h/2
    
    return I
end

n_list = 2 .^(1:14)
I_list = [ trap(f,a,b,n) for n in n_list ]

err =@. abs(I_list - I_true) / I_true

plot( n_list, err, lw=2,
    label="Trap", 
    xlabel="n points", ylabel="Normalized Error",
    xscale=:log10, yscale=:log10 )
plot!( n-> n^-2, lw=2, label="O(n^-2)" )